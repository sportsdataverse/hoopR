# easl_runtime.R -- transport, season mapping and refusals of the EASL wrappers.
#
# R mirror of sdv-py sportsdataverse/basketball/easl/easl_runtime.py (origin/main e3d232ebc9).
#
# UNOFFICIAL INTERMEDIARY: https://easl.joshricha.com/api/v1 is an Express server run by an individual.
# It is not EASL's and not Sportradar's: it mirrors Sportradar DataCore (organisation b1e0z) into SQLite
# and serves it keyless. It can change or vanish without notice.
#
# * Seasons: the public argument is the END year (2027 = EASL 26-27). /metadata/seasons[].year is the
#   START year, so the runtime reads that list (once per session; .easl_clear_cache()) and maps the
#   season to the DataCore seasonId; season = NULL is the ACTIVE season. An unknown season is
#   hoopR_bad_request.
# * Errors: an unknown fixtureId is a bare HTTP 500, never retried (retry_500 = FALSE). The server's
#   HTTP 400 / 422 is hoopR_asset_fetch (the request was built here, so the answer is unknown); a
#   malformed id is hoopR_bad_request before any request.
# * Finished games only: a game route first reads /matches/{fixtureId} (CONFIRMED, two scores), then
#   checks the route body against it (box points, the play-by-play's final score and period, the
#   team totals, the period table).
# * Freshness: an ACTIVE-season fixture list is checked against /health (server clock within a day of
#   ours, no fixture still SCHEDULED a day after tip-off).
# * Scope: every body is tied to the season, team, player or fixture asked for; an empty answer is
#   hoopR_no_data.

#' @noRd
.EASL_BASE <- "https://easl.joshricha.com/api/v1"

#' DataCore organisation id of the EASL on every season, team and player row.
#' @noRd
.EASL_ORG <- "b1e0z"

#' Key the request is stamped under; the parsers read it.
#' @noRd
.EASL_REQUEST <- "_request"

#' A fixture still SCHEDULED this long after tip-off, or a server clock this far from ours, means a
#' stalled sync (seconds).
#' @noRd
.EASL_STALE_AFTER <- 86400

#' @noRd
.EASL_UUID <- "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}"

#' @noRd
.EASL_PAGER_KEYS <- c("next", "next_url", "nextPage", "totalPages", "pagination", "cursor")

# Session cache: the seasons list and the header of every finished game.
.easl_cache <- new.env(parent = emptyenv())

#' Forget the cached seasons list and game headers (sdv-py `clear_cache`).
#' @noRd
.easl_clear_cache <- function() {
  rm(list = ls(.easl_cache, all.names = TRUE), envir = .easl_cache)
  invisible(NULL)
}

#' The local clock, seconds since the epoch (UTC); a seam for the tests.
#' @noRd
.easl_now <- function() as.double(Sys.time())

# ---------------------------------------------------------------------------
# Routes
# ---------------------------------------------------------------------------

#' @noRd
.easl_routes <- function() {
  u <- paste0("(", .EASL_UUID, ")")
  list(
    list("health", "/health", character()),
    list("seasons", "/metadata/seasons", character()),
    list("matches", "/matches", character()),
    list("match", paste0("/matches/", u), "fixture_id"),
    list("boxscore", paste0("/matches/", u, "/boxscore"), "fixture_id"),
    list("playbyplay", paste0("/matches/", u, "/playbyplay"), "fixture_id"),
    list("teamstats", paste0("/matches/", u, "/teamstats"), "fixture_id"),
    list("period", paste0("/matches/", u, "/teamstats/by/period"), "fixture_id"),
    list("standings", "/standings", character()),
    list("leaders", "/leaders", character()),
    list("teams", "/teams", character()),
    list("team", paste0("/teams/", u), "team_id"),
    list("team_matches", paste0("/teams/", u, "/matches"), "team_id"),
    list("team_stats", paste0("/teams/", u, "/stats"), "team_id"),
    list("team_leaders", paste0("/teams/", u, "/leaders"), "team_id"),
    list("players", "/players", character()),
    list("player", paste0("/players/", u), "player_id"),
    list("player_stats", paste0("/players/", u, "/stats"), "player_id")
  )
}

#' @noRd
.EASL_GAME_ROUTES <- c("match", "boxscore", "playbyplay", "teamstats", "period")

#' @noRd
.EASL_SEASON_ROUTES <- c("matches", "standings", "leaders", "team_matches", "team_stats", "team_leaders")

#' The route name of `path` and its ids; `hoopR_bad_request` for a path the family does not wrap.
#' @noRd
.easl_route <- function(path, call = rlang::caller_env()) {
  for (r in .easl_routes()) {
    m <- regmatches(path, regexec(paste0("^", r[[2]], "/?$"), path, perl = TRUE))[[1]]
    if (length(m)) return(list(name = r[[1]], ids = structure(as.list(m[-1]), names = r[[3]])))
  }
  if (grepl("^/(matches|teams|players)/[^/]+(/|$)", path, perl = TRUE)) {
    .abort_bad_request("The id in {.val {path}} must be a DataCore UUID such as 10af8fd4-106e-11f1-960b-5798087c7aa3.",
                       call = call)
  }
  .abort_bad_request("Not an EASL route: {.val {path}}.", call = call)
}

# ---------------------------------------------------------------------------
# JSON helpers (bodies parsed with simplifyVector = FALSE)
# ---------------------------------------------------------------------------

#' A JSON object (a named list; `{}` is a named empty list).
#' @noRd
.easl_is_obj <- function(x) is.list(x) && !is.null(names(x))

#' A JSON array (an unnamed list).
#' @noRd
.easl_is_arr <- function(x) is.list(x) && is.null(names(x))

#' @noRd
.easl_obj <- function(x) if (.easl_is_obj(x)) x else structure(list(), names = character())

#' @noRd
.easl_rows <- function(x) if (.easl_is_arr(x)) Filter(.easl_is_obj, x) else list()

#' A single string, else `NA` (the type-strict comparisons of sdv-py `_same`).
#' @noRd
.easl_str <- function(x) if (is.character(x) && length(x) == 1L && !is.na(x)) x else NA_character_

#' Type-strict string equality (sdv-py `_same` on string ids).
#' @noRd
.easl_same <- function(got, want) identical(.easl_str(got), want)

#' An integer as sent (a JSON integer) or a digit string; `NA` otherwise (logicals are not integers).
#' @noRd
.easl_int <- function(x) {
  if (length(x) != 1L || is.logical(x) || is.na(x)) return(NA_integer_)
  if (is.integer(x)) return(x)
  if (is.character(x) && grepl("^[0-9]+$", x)) return(suppressWarnings(as.integer(x)))
  NA_integer_
}

#' A timestamp (`2026-10-13T00:16:10.324Z`, or naive = UTC) as seconds since the epoch, else `NA`.
#' @noRd
.easl_utc <- function(x) {
  x <- .easl_str(x)
  if (is.na(x)) return(NA_real_)
  re <- paste0("^([0-9]{4}-[0-9]{2}-[0-9]{2})(?:[T ]([0-9]{2}:[0-9]{2}(?::[0-9]{2}(?:\\.[0-9]{1,6})?)?))?",
               "(Z|[+-][0-9]{2}:?[0-9]{2})?$")
  m <- regmatches(x, regexec(re, x, perl = TRUE))[[1]]
  if (!length(m)) return(NA_real_)
  clock <- if (nzchar(m[[3]])) m[[3]] else "00:00"
  if (nchar(clock) == 5L) clock <- paste0(clock, ":00")
  at <- as.double(as.POSIXct(paste(m[[2]], clock), format = "%Y-%m-%d %H:%M:%OS", tz = "UTC"))
  off <- m[[4]]
  if (!is.na(at) && nzchar(off) && off != "Z") {
    digits <- gsub(":", "", substring(off, 2L), fixed = TRUE)
    secs <- as.integer(substr(digits, 1L, 2L)) * 3600 + as.integer(substr(digits, 3L, 4L)) * 60
    at <- at - if (startsWith(off, "-")) -secs else secs
  }
  at
}

#' `a <= b` in code-point order (never the locale's collation).
#' @noRd
.easl_le <- function(a, b) withr::with_collate("C", a <= b)

#' Python `str()` of a scalar for the standings' date bounds (`None` for a missing value).
#' @noRd
.easl_pystr <- function(x) if (is.character(x) && length(x) == 1L) x else if (is.null(x)) "None" else as.character(x)[1]

#' Validate a public season: an END year (a whole non-negative number or a digit string).
#' @noRd
.easl_season_arg <- function(value, call = rlang::caller_env()) {
  ok <- length(value) == 1L && !is.logical(value) && !is.na(value) && (
    (is.numeric(value) && is.finite(value) && value >= 0 && value == trunc(value)) ||
      (is.character(value) && grepl("^[0-9]+$", trimws(value)))
  )
  if (!ok) {
    shown <- if (is.null(value)) "NULL" else paste(format(value), collapse = ", ")
    .abort_bad_request("{.arg season} must be an END year such as 2026 (EASL 25-26); got {shown}.", call = call)
  }
  as.integer(if (is.character(value)) trimws(value) else value)
}

#' Validate a path id argument: one string (the route regex then checks the UUID).
#' @noRd
.easl_id_arg <- function(value, arg, call = rlang::caller_env()) {
  if (is.character(value) && length(value) == 1L && !is.na(value)) return(value)
  .abort_bad_request("{.arg {arg}} must be a DataCore UUID string such as 10af8fd4-106e-11f1-960b-5798087c7aa3.",
                     call = call)
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' Refuse an error envelope, a body with a pager key or a body that is not JSON data.
#' @noRd
.easl_check_body <- function(where, body, call = rlang::caller_env()) {
  if (!is.list(body)) {
    shown <- substr(if (is.null(body)) "None" else paste(format(body), collapse = " "), 1, 120)
    .abort_asset_fetch("{where}: expected a JSON object or list, got {shown}", call = call)
  }
  if (.easl_is_obj(body)) {
    st <- body[["status"]]
    status <- if (is.atomic(st) && length(st) == 1L && !is.na(st)) tolower(as.character(st)) else ""
    if ("error" %in% names(body) || isFALSE(body[["success"]]) || status %in% c("error", "fail", "failed")) {
      .abort_asset_fetch("{where}: answered an error envelope", call = call)
    }
    if (any(.EASL_PAGER_KEYS %in% names(body))) {
      .abort_asset_fetch("{where}: the body carries a paging key; the API is documented as unpaged", call = call)
    }
  }
  body
}

#' GET `.EASL_BASE + path` through the polite getter and parse the JSON body.
#'
#' 404 -> `hoopR_no_data`; HTTP 400 / 422 -> `hoopR_asset_fetch` (sdv-py turns the getter's
#' ValueError into AssetFetchError: the request was built here); any other non-2xx ->
#' `hoopR_asset_fetch`. 500 is not retried.
#' @noRd
.easl_fetch <- function(path, query = list(), call = rlang::caller_env()) {
  where <- paste0("easl.joshricha.com/api/v1", path)
  resp <- .intl_response(paste0(.EASL_BASE, path), query = query, headers = list(Accept = "application/json"),
                         retry_500 = FALSE, call = call)
  status <- httr2::resp_status(resp)
  if (status %in% c(400L, 422L)) {
    .abort_asset_fetch("{where} rejected the request: HTTP {status}", status = status, call = call)
  }
  .intl_check_status(resp, where = where, call = call)
  body <- .intl_json(.intl_body_text(resp), where = where, call = call)
  .easl_check_body(where, body, call = call)
}

#' @noRd
.easl_list <- function(where, body, call = rlang::caller_env()) {
  if (!.easl_is_arr(body)) .abort_asset_fetch("{where}: expected a JSON list, got an object", call = call)
  body
}

#' @noRd
.easl_wrap <- function(data, stamp) {
  out <- if (.easl_is_obj(data)) data else list(items = data)
  out[[.EASL_REQUEST]] <- stamp
  out
}

# ---------------------------------------------------------------------------
# Seasons
# ---------------------------------------------------------------------------

#' The validated `/metadata/seasons` rows (cached for the session).
#' @noRd
.easl_seasons <- function(call = rlang::caller_env()) {
  if (is.null(.easl_cache$seasons)) {
    where <- "easl.joshricha.com/api/v1/metadata/seasons"
    rows <- .easl_rows(.easl_list(where, .easl_fetch("/metadata/seasons", call = call), call = call))
    if (!length(rows)) .abort_no_data("{where}: the server lists no seasons", call = call)
    bad <- vapply(rows, function(r) !identical(r[["organizationId"]], .EASL_ORG) || is.na(.easl_str(r[["seasonId"]])),
                  logical(1))
    if (any(bad)) {
      org <- .EASL_ORG
      .abort_asset_fetch("{where}: a season row is not organisation {org} or has no seasonId", call = call)
    }
    if (!any(vapply(rows, function(r) identical(r[["status"]], "ACTIVE"), logical(1)))) {
      .abort_asset_fetch("{where}: no ACTIVE season", call = call)
    }
    .easl_cache$seasons <- rows
  }
  .easl_cache$seasons
}

#' `list(row = <season row>, end = <END year>)` of a public season (`NULL` = the ACTIVE season).
#' @noRd
.easl_season <- function(season, call = rlang::caller_env()) {
  rows <- .easl_seasons(call = call)
  if (is.null(season)) {
    active <- Filter(function(r) identical(r[["status"]], "ACTIVE"), rows)
    if (length(active) != 1L || is.na(.easl_int(active[[1]][["year"]]))) {
      .abort_asset_fetch("easl.joshricha.com/api/v1/metadata/seasons: not exactly one ACTIVE season with a year",
                         call = call)
    }
    return(list(row = active[[1]], end = .easl_int(active[[1]][["year"]]) + 1L))
  }
  end <- .easl_season_arg(season, call = call)
  for (r in rows) {
    if (identical(.easl_int(r[["year"]]), end - 1L)) return(list(row = r, end = end))
  }
  have <- sort(vapply(rows, function(r) {
    y <- .easl_int(r[["year"]])
    if (is.na(y)) 1L else y + 1L
  }, integer(1)))
  .abort_bad_request("No EASL season ending {end}; the server lists END years {.val {have}}.", call = call)
}

#' Server clock from `/health` (must say OK and be within a day of ours).
#' @noRd
.easl_fresh <- function(call = rlang::caller_env()) {
  where <- "easl.joshricha.com/api/v1/health"
  body <- .easl_obj(.easl_fetch("/health", call = call))
  server <- .easl_utc(body[["timestamp"]])
  if (!identical(body[["status"]], "OK") || is.na(server)) {
    .abort_asset_fetch("{where}: not OK or no timestamp: freshness unverified", call = call)
  }
  if (abs(.easl_now() - server) > .EASL_STALE_AFTER) {
    shown <- format(as.POSIXct(server, origin = "1970-01-01", tz = "UTC"), "%Y-%m-%d %H:%M")
    .abort_asset_fetch("{where}: the server clock {shown}Z is more than a day from ours", call = call)
  }
  server
}

#' Refuse an ACTIVE-season fixture list in which a game is still SCHEDULED a day after tip-off.
#' @noRd
.easl_no_stale <- function(rows, call = rlang::caller_env()) {
  server <- .easl_fresh(call = call)
  late <- vapply(rows, function(r) {
    at <- .easl_utc(r[["startTimeUTC"]])
    if (is.na(at)) at <- server
    identical(r[["status"]], "SCHEDULED") && at < server - .EASL_STALE_AFTER
  }, logical(1))
  if (any(late)) {
    n <- sum(late)
    .abort_asset_fetch(paste0("easl.joshricha.com/api/v1/matches: {n} fixture{?s} {?is/are} still SCHEDULED more ",
                              "than a day after tip-off: the mirror looks stalled"), call = call)
  }
  invisible(NULL)
}

# ---------------------------------------------------------------------------
# Games
# ---------------------------------------------------------------------------

#' The checked `/matches/{fid}` body plus `teams` (ids) and `scores` (named: team id -> final points).
#' @noRd
.easl_header <- function(fid, call = rlang::caller_env()) {
  key <- paste0("game:", fid)
  if (is.null(.easl_cache[[key]])) {
    where <- paste0("easl.joshricha.com/api/v1/matches/", fid)
    body <- .easl_obj(.easl_fetch(paste0("/matches/", fid), call = call))
    if (!.easl_same(body[["fixtureId"]], fid)) {
      got <- .easl_pystr(body[["fixtureId"]])
      .abort_asset_fetch("{where}: asked for {fid}, the body has fixtureId={got}", call = call)
    }
    if (!identical(body[["status"]], "CONFIRMED")) {
      got <- .easl_pystr(body[["status"]])
      .abort_asset_fetch("{where}: fixture status {got}, not CONFIRMED: only finished games are served",
                         call = call)
    }
    comps <- .easl_rows(body[["competitors"]])
    teams <- vapply(comps, function(c) .easl_str(c[["teamId"]]), character(1))
    scores <- vapply(comps, function(c) .easl_int(c[["score"]]), integer(1))
    if (length(comps) != 2L || anyNA(teams) || anyDuplicated(teams) || anyNA(scores)) {
      .abort_asset_fetch("{where}: the fixture lacks two scored competitors", call = call)
    }
    .easl_cache[[key]] <- list(body = body, teams = teams, scores = structure(scores, names = teams))
  }
  .easl_cache[[key]]
}

#' @noRd
.easl_period_keys <- function(r) {
  k <- names(r)[grepl("^period_[0-9]+$", names(r))]
  k[order(as.integer(substring(k, 8L)))]
}

#' @noRd
.easl_team_ids <- function(rows, field = "teamId", nested = NULL) {
  vapply(rows, function(r) .easl_str((if (is.null(nested)) r else .easl_obj(r[[nested]]))[[field]]), character(1))
}

#' @noRd
.easl_period_table <- function(fid, ctx, call = rlang::caller_env()) {
  where <- paste0("easl.joshricha.com/api/v1/matches/", fid, "/teamstats/by/period")
  rows <- .easl_rows(.easl_list(where, .easl_fetch(paste0("/matches/", fid, "/teamstats/by/period"), call = call),
                                call = call))
  if (length(rows) != 2L || !setequal(.easl_team_ids(rows, nested = "team"), ctx$teams)) {
    .abort_asset_fetch("{where}: the rows are not this fixture's two teams", call = call)
  }
  for (r in rows) {
    pts <- vapply(.easl_period_keys(r), function(k) .easl_int(.easl_obj(r[[k]])[["points"]]), integer(1))
    total <- sum(pts, na.rm = TRUE)
    want <- ctx$scores[[.easl_str(.easl_obj(r[["team"]])[["teamId"]])]]
    if (total != want) .abort_asset_fetch("{where}: period points {total} != the fixture score {want}", call = call)
  }
  rows
}

#' A running score equals the final one (Python `==`: an int, or a float of the same value).
#' @noRd
.easl_score_eq <- function(got, want) is.numeric(got) && length(got) == 1L && !is.na(got) && got == want

#' @noRd
.easl_game_route <- function(name, fid, call = rlang::caller_env()) {
  ctx <- .easl_header(fid, call = call)
  teams <- ctx$teams
  scores <- ctx$scores
  where <- paste0("easl.joshricha.com/api/v1/matches/", fid)
  if (name == "match") return(ctx$body)
  if (name == "boxscore") {
    body <- .easl_obj(.easl_fetch(paste0("/matches/", fid, "/boxscore"), call = call))
    rows <- .easl_rows(body[["boxScore"]])
    if (!length(rows) || !setequal(.easl_team_ids(.easl_rows(body[["teams"]])), teams)) {
      .abort_asset_fetch("{where}/boxscore: no boxScore, or teams that are not this fixture's", call = call)
    }
    ent <- .easl_team_ids(rows, "entityId")
    foreign <- !vapply(rows, function(r) .easl_same(r[["fixtureId"]], fid), logical(1)) | !(ent %in% teams)
    if (any(foreign)) {
      .abort_asset_fetch("{where}/boxscore: a row belongs to another fixture or to a team outside it", call = call)
    }
    for (t in teams) {
      mine <- rows[ent == t & vapply(rows, function(r) isTRUE(r[["isPlayer"]]), logical(1))]
      pts <- sum(vapply(mine, function(r) .easl_int(.easl_obj(r[["statistics"]])[["points"]]), integer(1)),
                 na.rm = TRUE)
      want <- scores[[t]]
      if (pts != want) {
        .abort_asset_fetch("{where}/boxscore: player points {pts} != the fixture score {want} (an incomplete box?)",
                           call = call)
      }
    }
    return(body)
  }
  if (name == "playbyplay") {
    body <- .easl_obj(.easl_fetch(paste0("/matches/", fid, "/playbyplay"), call = call))
    ev <- .easl_rows(body[["playbyplay"]])
    if (!length(ev) || !setequal(.easl_team_ids(.easl_rows(body[["teams"]])), teams)) {
      .abort_asset_fetch("{where}/playbyplay: no events, or teams that are not this fixture's", call = call)
    }
    keyed <- vapply(ev, function(e) setequal(names(.easl_obj(e[["scores"]])), teams), logical(1))
    if (!all(keyed)) {
      .abort_asset_fetch("{where}/playbyplay: an event's running score is not keyed by the fixture's two teams",
                         call = call)
    }
    last <- ev[[length(ev)]][["scores"]]
    if (!all(vapply(teams, function(t) .easl_score_eq(last[[t]], scores[[t]]), logical(1)))) {
      .abort_asset_fetch("{where}/playbyplay: the last event does not carry the final score: cut short or live",
                         call = call)
    }
    pids <- vapply(ev, function(e) if (is.integer(e[["periodId"]])) .easl_int(e[["periodId"]]) else NA_integer_,
                   integer(1))
    top <- if (anyNA(pids)) NA_integer_ else max(pids)
    if (is.na(top) || pids[[length(pids)]] != top || top < 4L) {
      got <- .easl_pystr(pids[[length(pids)]])
      .abort_asset_fetch("{where}/playbyplay: the last event is in period {got}, not the final period (4 or more)",
                         call = call)
    }
    table <- .easl_period_table(fid, ctx, call = call)
    per <- unlist(lapply(table, function(r) as.integer(substring(.easl_period_keys(r), 8L))))
    table_top <- if (length(per)) max(per) else NA_integer_
    if (!identical(table_top, top)) {
      .abort_asset_fetch("{where}/playbyplay: ends in period {top}, the period table in {table_top}", call = call)
    }
    return(body)
  }
  if (name == "teamstats") {
    rows <- .easl_rows(.easl_list(where, .easl_fetch(paste0("/matches/", fid, "/teamstats"), call = call),
                                  call = call))
    ent <- .easl_team_ids(rows, "entityId")
    same <- vapply(rows, function(r) .easl_same(r[["fixtureId"]], fid), logical(1))
    if (length(rows) != 2L || !setequal(ent, teams) || !all(same)) {
      .abort_asset_fetch("{where}/teamstats: the rows are not this fixture's two teams", call = call)
    }
    pts <- vapply(rows, function(r) .easl_int(.easl_obj(r[["statistics"]])[["points"]]), integer(1))
    if (anyNA(pts) || any(pts != unname(scores[ent]))) {
      .abort_asset_fetch("{where}/teamstats: team points differ from the fixture score", call = call)
    }
    return(rows)
  }
  .easl_period_table(fid, ctx, call = call)
}

# ---------------------------------------------------------------------------
# Seasons, teams, players
# ---------------------------------------------------------------------------

#' @noRd
.easl_season_route <- function(name, ids, wire, call = rlang::caller_env()) {
  s <- .easl_season(wire[["season"]], call = call)
  row <- s$row
  sid <- row[["seasonId"]]
  stamp <- list(season = s$end, season_id = sid)
  where <- paste0("easl.joshricha.com/api/v1/", name)
  active <- identical(row[["status"]], "ACTIVE")
  tid <- ids[["team_id"]]
  if (!is.null(tid)) stamp$team_id <- tid
  q <- list(seasonId = sid)
  if (name == "matches") {
    rows <- .easl_rows(.easl_list(where, .easl_fetch("/matches", q, call = call), call = call))
    if (!all(vapply(rows, function(r) .easl_same(r[["seasonId"]], sid), logical(1)))) {
      .abort_asset_fetch("{where}: a fixture belongs to another season", call = call)
    }
    if (length(rows) && active) .easl_no_stale(rows, call = call)
    return(list(data = rows, stamp = stamp))
  }
  if (name == "team_matches") {
    rows <- .easl_rows(.easl_list(where, .easl_fetch(paste0("/teams/", tid, "/matches"), q, call = call),
                                  call = call))
    for (r in rows) {
      own <- .easl_str(.easl_obj(r[["stage"]])[["id"]])
      ok <- if ("seasonId" %in% names(r)) .easl_same(r[["seasonId"]], sid) else !is.na(own) &&
        startsWith(own, paste0(sid, ":"))
      if (!ok) {
        .abort_asset_fetch("{where}: a fixture carries neither this season's seasonId nor a stage id of it",
                           call = call)
      }
      if (!tid %in% .easl_team_ids(.easl_rows(r[["competitors"]]))) {
        .abort_asset_fetch("{where}: a fixture does not involve team {tid}", call = call)
      }
    }
    if (length(rows) && active) .easl_no_stale(rows, call = call)
    return(list(data = rows, stamp = stamp))
  }
  if (name == "standings") {
    rows <- .easl_rows(.easl_list(where, .easl_fetch("/standings", q, call = call), call = call))
    lo <- .easl_pystr(row[["startDate"]])
    hi <- .easl_pystr(row[["endDate"]])
    for (r in rows) {
      for (m in .easl_rows(r[["lastFiveMatches"]])) {
        d <- substr(.easl_pystr(m[["startTimeUTC"]]), 1L, 10L)
        if (!(.easl_le(lo, d) && .easl_le(d, hi))) {
          .abort_asset_fetch("{where}: a last-five match is outside the season ({lo}..{hi})", call = call)
        }
      }
    }
    return(list(data = rows, stamp = stamp))
  }
  if (name == "team_stats") {
    body <- .easl_obj(.easl_fetch(paste0("/teams/", tid, "/stats"), q, call = call))
    games <- body[["games"]]
    if (!length(body) || !is.integer(games) || length(games) != 1L || is.na(games)) {
      .abort_asset_fetch("{where}: no integer games count to tie the body to team {tid}", call = call)
    }
    end <- s$end
    if (games == 0L) .abort_no_data("{where}: team {tid} played no game in season {end}", call = call)
    return(list(data = body, stamp = stamp))
  }
  # leaders and team_leaders
  body <- .easl_obj(.easl_fetch(if (is.null(tid)) "/leaders" else paste0("/teams/", tid, "/leaders"), q, call = call))
  cats <- lapply(Filter(.easl_is_arr, body), .easl_rows)
  end <- s$end
  if (!length(cats) || any(lengths(cats) == 0L)) {
    .abort_no_data("{where}: empty leader categories for season {end}", call = call)
  }
  for (r in unlist(unname(cats), recursive = FALSE)) {
    if (!.easl_same(r[["seasonId"]], sid) ||
        (!is.null(tid) && !identical(.easl_str(.easl_obj(r[["team"]])[["teamId"]]), tid))) {
      .abort_asset_fetch("{where}: a leader row belongs to another season or team", call = call)
    }
  }
  list(data = body, stamp = stamp)
}

#' @noRd
.easl_simple_route <- function(name, ids, wire, call = rlang::caller_env()) {
  where <- paste0("easl.joshricha.com/api/v1/", name)
  if (name == "health") {
    body <- .easl_obj(.easl_fetch("/health", call = call))
    if (!identical(body[["status"]], "OK")) .abort_asset_fetch("{where}: health is not OK", call = call)
    return(list(data = body, stamp = list()))
  }
  if (name == "seasons") return(list(data = .easl_seasons(call = call), stamp = list()))
  if (name == "teams") {
    rows <- .easl_rows(.easl_list(where, .easl_fetch("/teams", call = call), call = call))
    if (!all(vapply(rows, function(r) identical(r[["organizationId"]], .EASL_ORG), logical(1)))) {
      org <- .EASL_ORG
      .abort_asset_fetch("{where}: a team row is not organisation {org}", call = call)
    }
    return(list(data = rows, stamp = list()))
  }
  if (name %in% c("team", "player")) {
    id <- ids[[paste0(name, "_id")]]
    key <- paste0(name, "Id")
    body <- .easl_obj(.easl_fetch(paste0("/", name, "s/", id), call = call))
    if (!.easl_same(body[[key]], id)) {
      got <- .easl_pystr(body[[key]])
      .abort_asset_fetch("{where}: asked for {id}, the body has {key}={got}", call = call)
    }
    return(list(data = body, stamp = structure(list(id), names = paste0(name, "_id"))))
  }
  if (name == "player_stats") {
    pid <- ids[["player_id"]]
    body <- .easl_obj(.easl_fetch(paste0("/players/", pid, "/stats"), call = call))
    games <- body[["games"]]
    if (!length(body) || !is.integer(games) || length(games) != 1L || is.na(games)) {
      .abort_asset_fetch("{where}: no integer games count to tie the body to player {pid}", call = call)
    }
    if (games < 1L) {
      .abort_no_data("{where}: player {pid} has no games (an unknown id answers the same way)", call = call)
    }
    return(list(data = body, stamp = list(player_id = pid)))
  }
  # players
  q <- list()
  stamp <- list()
  if (!is.null(wire[["season"]])) {
    s <- .easl_season(wire[["season"]], call = call)
    q$seasonId <- s$row[["seasonId"]]
    stamp$season_id <- s$row[["seasonId"]]
    stamp$season <- s$end
  }
  if (!is.null(wire[["teamId"]])) {
    team <- wire[["teamId"]]
    if (!(is.character(team) && length(team) == 1L && grepl(paste0("^", .EASL_UUID, "$"), team, perl = TRUE))) {
      shown <- paste(format(team), collapse = ", ")
      .abort_bad_request("{.arg team_id} must be a DataCore team UUID; got {shown}.", call = call)
    }
    q$teamId <- team
    stamp$team_id <- team
  }
  rows <- .easl_rows(.easl_list(where, .easl_fetch("/players", q, call = call), call = call))
  if (!all(vapply(rows, function(r) !is.na(.easl_str(r[["playerId"]])) && nzchar(r[["playerId"]]), logical(1)))) {
    .abort_asset_fetch("{where}: a player row lacks playerId", call = call)
  }
  list(data = rows, stamp = stamp)
}

#' GET an EASL route, refuse the partial or out-of-scope answers and stamp the request.
#'
#' @param path The route path under `/api/v1` (ids are DataCore UUIDs).
#' @param params `season` (END year; `NULL` = the ACTIVE season) on the season routes and, with
#'   `teamId`, on `/players`; `NULL` values are dropped. The runtime sends the resolved `seasonId`.
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The body (a named list) with the request stamped under `_request`; a bare list comes back
#'   as `list(items = <rows>, _request = <stamp>)`.
#' @noRd
.easl_get <- function(path, params = list(), call = rlang::caller_env()) {
  wire <- Filter(Negate(is.null), params)
  route <- .easl_route(path, call = call)
  name <- route$name
  if (name %in% .EASL_GAME_ROUTES) {
    fid <- route$ids[["fixture_id"]]
    return(.easl_wrap(.easl_game_route(name, fid, call = call), list(fixture_id = fid)))
  }
  out <- if (name %in% .EASL_SEASON_ROUTES) {
    .easl_season_route(name, route$ids, wire, call = call)
  } else {
    .easl_simple_route(name, route$ids, wire, call = call)
  }
  if (!length(out$data)) .abort_no_data("easl.joshricha.com/api/v1/{name}: the server answered no rows", call = call)
  .easl_wrap(out$data, out$stamp)
}
