# kzs_runtime.R -- transport for the KZS wrappers (Basketball Federation of Slovenia, api.kzs.si/api/v1/public).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/kzs/kzs_runtime.py (origin/main e3d232ebc9):
#
# * Throttle and retries: `.intl_get()` (>= 1 s per host on every attempt, dependency requests included). No key,
#   no proxy. HTTP 500 is retried (`retry_500 = TRUE`, the family's sportsdataverse-py policy).
# * Every answer is an envelope `{"status": "OK", "data": ...}`. `.kzs_get()` returns `data`: an object gets the
#   request stamped under `_request` (competition_id, match_id, team_id, player_id, season_id, season,
#   stats_category), which the parsers read; a bare list (playingDays) is wrapped as `list(items = <list>)`.
# * Errors are HTTP 400, never 404 (an unknown id and a bad parameter alike): a 400 for an id the caller passed
#   cannot be told from an unknown id, so it is `hoopR_asset_fetch` with the API's own message, never
#   `hoopR_bad_request`. A 200 whose `status` is not "OK" is `hoopR_asset_fetch` too.
# * Seasons are opaque ids (27 = 2026/2027). The public argument is the END year (2027), mapped with
#   `.KZS_SEASON_IDS` (the 39 rows of /seasons/) before `seasonId` is sent.
# * List routes default to 150 rows and say nothing: every list wrapper sends a large `limit`, and a page that
#   comes back full (rows >= limit) is `hoopR_asset_fetch`.
# * Scope: a body must be the one asked for, else `hoopR_asset_fetch` (never an empty frame). Competition, match,
#   team and player ids are checked type-strictly against the body; a leaderboard, a team list, the rounds and the
#   playing days are checked against the competition (its standings or phases: one extra request, cached for the
#   session); a match's play-by-play and box score against the match header (one extra request, cached once the
#   header says FINISHED): the game must be final, the match-team ids the header's two, in its home/away order.
#   /teams/{id}/general and /teamPlayers/ echo nothing to compare with, so only the list cap is enforced.
# * `hoopR_no_data`: an empty answer or list, a competition without standings, a final game with no play-by-play
#   (2007-08 and some 2020-21 games) or no box score (2007-08 answers only scores), HTTP 404.

#' @noRd
.KZS_BASE <- "https://api.kzs.si/api/v1/public"
#' @noRd
.KZS_REQUEST <- "_request"
#' END year -> opaque season id: ids 1-30 are 2000/2001 ... 2029/2030 (END = 2000 + id), ids 31-39 are
#' 1991/1992 ... 1999/2000 (END = 1961 + id). Checked against the live /seasons/ list on 2026-10-12.
#' @noRd
.KZS_SEASON_IDS <- c(stats::setNames(1:30, 2000L + 1:30), stats::setNames(31:39, 1961L + 31:39))
#' @noRd
.KZS_DEFAULT_LIMIT <- 150L
#' Leaderboard `sortBy` -> the row column that must be ordered (the only echo of sortBy / sort).
#' @noRd
.KZS_SORT_COLUMN <- c(avg = "average", sum = "sum", max = "max")
#' @noRd
.KZS_LIST_ROUTES <- c("/seasons/", "/competitions/", "/competitions/{competition_id}/playerStats",
                      "/competitions/{competition_id}/teamStats", "/matches/", "/teams/", "/teamPlayers/")
#' @noRd
.KZS_STATS_CATEGORIES <- c("PTS", "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG", "PERC_FG", "M_FT",
                           "A_FT", "PERC_FT", "R", "R_D", "R_O", "ASS", "ST", "TOV", "PF_CM", "PF_RV", "ASS_TOV",
                           "ST_TOV")

# Dependency bodies (a competition, its standings team set, a FINISHED header, a season's competition ids), cached
# for the session. Only a successful, final answer is cached.
.kzs_cache <- new.env(parent = emptyenv())

#' Forget the cached dependency bodies (sportsdataverse-py `kzs_runtime.clear_cache`).
#' @noRd
.kzs_clear_cache <- function() rm(list = ls(.kzs_cache, all.names = TRUE), envir = .kzs_cache)

#' JSON object (a named list, `{}` included) vs JSON array (an unnamed list).
#' @noRd
.kzs_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.kzs_is_array <- function(x) is.list(x) && is.null(names(x))
#' @noRd
.kzs_obj <- function(x) if (.kzs_is_dict(x)) x else stats::setNames(list(), character())
#' The object rows of a JSON array (anything else: none).
#' @noRd
.kzs_rows <- function(x) if (.kzs_is_array(x)) Filter(.kzs_is_dict, x) else list()

#' sportsdataverse-py `_same`: type-strict equality of a JSON scalar (`true` never passes for id 1, nor `579.0` for 579).
#' @noRd
.kzs_same <- function(got, want) {
  !is.null(got) && !is.null(want) && is.atomic(got) && length(got) == 1L && length(want) == 1L &&
    identical(typeof(got), typeof(want)) && !is.na(got) && !is.na(want) && got == want
}

#' A set key of a JSON scalar with Python's loose equality (`1 == 1.0 == True`); `NULL` is "None".
#' @noRd
.kzs_key <- function(v) {
  if (is.null(v) || (is.atomic(v) && length(v) == 1L && is.na(v))) return("None")
  if (!is.atomic(v) || length(v) != 1L) return(paste0("j:", jsonlite::toJSON(v, auto_unbox = TRUE)))
  if (is.character(v)) return(paste0("s:", v))
  paste0("n:", format(as.numeric(v), digits = 17))
}
#' @noRd
.kzs_keys <- function(values) vapply(values, .kzs_key, character(1), USE.NAMES = FALSE)

#' Python `str()` of a JSON scalar, for messages and string comparisons.
#' @noRd
.kzs_str <- function(v) {
  if (is.null(v) || (is.atomic(v) && length(v) == 1L && is.na(v))) return("None")
  if (is.logical(v)) return(if (v) "True" else "False")
  if (is.list(v)) return(.kzs_dumps(v))
  as.character(v)
}

#' `a < b` by code point (Python string order), never the locale's collation.
#' @noRd
.kzs_lt <- function(a, b) !identical(a, b) && order(c(a, b), method = "radix")[[1]] == 1L

#' `host/path` of a URL with the path ids replaced by their names (sportsdataverse-py `where` labels).
#' @noRd
.kzs_where <- function(route) paste0("api.kzs.si", route)

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------

#' An integer id: a whole non-negative number or a digit string (sportsdataverse-py `_int_param` / the path pattern `\d+`).
#' @noRd
.kzs_int_arg <- function(x, what, call = rlang::caller_env()) {
  ok <- length(x) == 1L && !is.logical(x) && !is.na(x) &&
    ((is.numeric(x) && x >= 0 && x == trunc(x) && x <= .Machine$integer.max) ||
       (is.character(x) && grepl("^[0-9]+$", trimws(x)) && as.numeric(trimws(x)) <= .Machine$integer.max))
  if (!ok) {
    shown <- if (length(x) == 1L && is.atomic(x)) as.character(x) else class(x)[[1]]
    .abort_bad_request("{.arg {what}} must be an integer id; got {.val {shown}}.", call = call)
  }
  as.integer(trimws(as.character(x)))
}

#' The opaque KZS season id of an END year (sportsdataverse-py `season_id`): 2027 -> 27.
#' @noRd
.kzs_season_id <- function(season, call = rlang::caller_env()) {
  ok <- length(season) == 1L && !is.logical(season) && !is.na(season) &&
    ((is.numeric(season) && season == trunc(season)) ||
       (is.character(season) && grepl("^-?[0-9]+$", trimws(season))))
  if (!ok) {
    shown <- if (length(season) == 1L && is.atomic(season)) as.character(season) else class(season)[[1]]
    .abort_bad_request("{.arg season} must be an END year such as 2027 (2026/2027); got {.val {shown}}.",
                       call = call)
  }
  end <- as.character(as.integer(trimws(as.character(season))))
  if (!end %in% names(.KZS_SEASON_IDS)) {
    .abort_bad_request("{.arg season} must be an END year between 1992 and 2030 (2027 = 2026/2027); got {end}.",
                       call = call)
  }
  .KZS_SEASON_IDS[[end]]
}

#' @noRd
.kzs_choice <- function(x, allowed, what, call = rlang::caller_env()) {
  if (!is.character(x) || length(x) != 1L || is.na(x) || !x %in% allowed) {
    .abort_bad_request("{.arg {what}} must be one of {.val {allowed}}.", call = call)
  }
  x
}

#' An optional string argument (`NULL` = not sent).
#' @noRd
.kzs_opt_str <- function(x, what, call = rlang::caller_env()) {
  if (is.null(x)) return(NULL)
  if (!is.character(x) || length(x) != 1L || is.na(x)) {
    .abort_bad_request("{.arg {what}} must be a single string.", call = call)
  }
  x
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' GET a KZS URL and unwrap the `{status, data}` envelope (sportsdataverse-py `_fetch`).
#' @noRd
.kzs_fetch <- function(url, query = list(), call = rlang::caller_env()) {
  where <- .intl_where(url)
  text <- tryCatch(
    .intl_get(url, query = query, retry_500 = TRUE, call = call),
    hoopR_bad_request = function(e) {
      # HTTP 400 / 422: the API's only error status, for unknown ids and bad parameters alike
      msg <- conditionMessage(e)
      .abort_asset_fetch("{msg}", status = e$status, call = call)
    }
  )
  body <- .intl_json(text, where = where, call = call)
  if (!.kzs_is_dict(body)) {
    kind <- if (is.list(body)) "list" else class(body)[[1]]
    .abort_asset_fetch("{where} answered a {kind}, not an envelope.", call = call)
  }
  if (!.kzs_same(body[["status"]], "OK") || !"data" %in% names(body)) {
    status <- substr(.kzs_str(body[["status"]]), 1, 40)
    .abort_asset_fetch("{where} answered status {.val {status}}, not OK.", call = call)
  }
  body[["data"]]
}

# --- dependencies (one extra, cached request each) ------------------------------------------------------------------

#' @noRd
.kzs_competition <- function(competition_id, call) {
  key <- paste0("competition:", competition_id)
  if (is.null(.kzs_cache[[key]])) {
    data <- .kzs_obj(.kzs_fetch(paste0(.KZS_BASE, "/competitions/", competition_id), call = call))
    if (!.kzs_same(data[["id"]], competition_id)) {
      got <- .kzs_str(data[["id"]])
      .abort_asset_fetch("competition {competition_id}: the header answered id {got}.", call = call)
    }
    .kzs_cache[[key]] <- data
  }
  .kzs_cache[[key]]
}

#' Team ids (set keys) in the standings of a competition (its entrants).
#' @noRd
.kzs_team_ids <- function(competition_id, call) {
  key <- paste0("teams:", competition_id)
  if (is.null(.kzs_cache[[key]])) {
    data <- .kzs_obj(.kzs_fetch(paste0(.KZS_BASE, "/matches/standings"), list(competitionId = competition_id),
                                call = call))
    if (!.kzs_same(.kzs_obj(data[["competition"]])[["id"]], competition_id)) {
      .abort_asset_fetch("competition {competition_id}: the standings dependency is another competition.",
                         call = call)
    }
    ids <- character()
    for (ph in .kzs_rows(data[["phases"]])) {
      for (block in c(list(ph), .kzs_rows(ph[["groups"]]))) {
        ids <- c(ids, .kzs_keys(lapply(.kzs_rows(block[["standings"]]), function(r) r[["teamId"]])))
      }
    }
    .kzs_cache[[key]] <- unique(ids)
  }
  .kzs_cache[[key]]
}

#' The match header, which must be FINISHED (cached once it is).
#' @noRd
.kzs_header <- function(match_id, call) {
  key <- paste0("header:", match_id)
  if (is.null(.kzs_cache[[key]])) {
    head <- .kzs_obj(.kzs_fetch(paste0(.KZS_BASE, "/matches/", match_id), call = call))
    if (!.kzs_same(head[["id"]], match_id)) {
      got <- .kzs_str(head[["id"]])
      .abort_asset_fetch("match {match_id}: the header answered id {got}.", call = call)
    }
    if (!.kzs_same(head[["status"]], "FINISHED")) {
      status <- .kzs_str(head[["status"]])
      .abort_asset_fetch("match {match_id}: the game is not final (status={status}).", call = call)
    }
    .kzs_cache[[key]] <- head
  }
  .kzs_cache[[key]]
}

#' Competition ids (set keys) of one season.
#' @noRd
.kzs_season_competitions <- function(sid, call) {
  key <- paste0("season:", sid)
  if (is.null(.kzs_cache[[key]])) {
    data <- .kzs_obj(.kzs_fetch(paste0(.KZS_BASE, "/competitions/"), list(seasonId = sid, limit = 10000L),
                                call = call))
    items <- .kzs_rows(data[["items"]])
    .kzs_whole(paste("competitions of season", sid), items, 10000L, call)
    mine <- Filter(function(c) .kzs_same(.kzs_obj(c[["season"]])[["id"]], sid), items)
    .kzs_cache[[key]] <- unique(.kzs_keys(lapply(mine, function(c) c[["id"]])))
  }
  .kzs_cache[[key]]
}

# --- checks ---------------------------------------------------------------------------------------------------------

#' A page that comes back full was cut: the API gives no other sign.
#' @noRd
.kzs_whole <- function(where, items, limit, call) {
  cap <- limit %||% .KZS_DEFAULT_LIMIT
  n <- length(items)
  if (n >= cap) {
    .abort_asset_fetch("{where}: truncated page ({n} rows at limit={cap}); ask for a larger limit.", call = call)
  }
}

#' @noRd
.kzs_id <- function(where, data, want, what, call) {
  got <- .kzs_obj(data)[["id"]]
  if (!.kzs_same(got, want)) {
    shown <- .kzs_str(got)
    .abort_asset_fetch("{where}: asked for {what} {want}, the body has id={shown}.", call = call)
  }
}

#' @noRd
.kzs_check_leaderboard <- function(where, cid, query, rows, call) {
  teams <- .kzs_team_ids(cid, call)
  bad <- Filter(function(r) !.kzs_key(r[["teamId"]]) %in% teams, rows)
  if (length(bad)) {
    shown <- paste(vapply(utils::head(bad, 5), function(r) .kzs_str(r[["teamId"]]), ""), collapse = ", ")
    .abort_asset_fetch("{where}: team ids [{shown}] are not in competition {cid}.", call = call)
  }
  col <- unname(.KZS_SORT_COLUMN[.kzs_str(query[["sortBy"]])])
  direction <- query[["sort"]]
  if (is.na(col) || is.null(direction) || !direction %in% c("ASC", "DESC")) return(invisible())
  vals <- vapply(rows, function(r) {
    v <- r[[col]]
    if (!is.numeric(v) || length(v) != 1L || is.na(v)) {
      .abort_asset_fetch("{where}: leaderboard rows without a numeric {col}.", call = call)
    }
    as.double(v)
  }, double(1))
  if (is.unsorted(if (direction == "DESC") rev(vals) else vals)) {
    .abort_asset_fetch("{where}: rows are not ordered {direction} by {col}: sortBy/sort ignored?", call = call)
  }
}

#' @noRd
.kzs_check_matches <- function(where, query, rows, call) {
  cid <- query[["competitionId"]]
  lo <- query[["from"]]
  hi <- query[["to"]]
  for (m in rows) {
    mid <- .kzs_str(m[["id"]])
    if (!is.null(cid) && !any(vapply(.kzs_rows(m[["competitions"]]),
                                     function(c) .kzs_same(c[["competitionId"]], cid), logical(1)))) {
      .abort_asset_fetch("{where}: match {mid} is not in competition {cid}.", call = call)
    }
    stamp <- m[["dateTime"]]
    is_str <- is.character(stamp) && length(stamp) == 1L && !is.na(stamp)
    if ((!is.null(lo) || !is.null(hi)) && !is_str) {
      .abort_asset_fetch("{where}: match {mid} has no dateTime to check against from/to.", call = call)
    }
    if (is_str) {
      at <- substr(stamp, 1, 19)
      if ((!is.null(lo) && .kzs_lt(at, substr(lo, 1, 19))) || (!is.null(hi) && .kzs_lt(substr(hi, 1, 19), at))) {
        .abort_asset_fetch("{where}: match {mid} at {stamp} is outside {lo %||% 'None'}..{hi %||% 'None'}.",
                           call = call)
      }
    }
  }
}

#' @noRd
.kzs_check_pbp <- function(where, mid, data, call) {
  head <- .kzs_header(mid, call)
  home <- .kzs_obj(head[["firstTeam"]])[["id"]]
  away <- .kzs_obj(head[["secondTeam"]])[["id"]]
  sides <- .kzs_keys(list(home, away))
  acts <- .kzs_rows(.kzs_obj(data)[["actions"]])
  if (!length(acts)) {
    .abort_no_data("{where}: the game has no play-by-play (a coverage gap: 2007-08 and some later games).",
                   call = call)
  }
  ids <- function(key) .kzs_keys(lapply(.kzs_rows(.kzs_obj(data)[[key]]), function(p) p[["id"]]))
  first <- ids("firstTeamPlayers")
  second <- ids("secondTeamPlayers")
  seen <- character()
  for (a in acts) {
    team <- a[["matchTeamId"]]
    if (is.null(team)) next
    tk <- .kzs_key(team)
    if (!tk %in% sides) {
      shown <- .kzs_str(team)
      h <- .kzs_str(home)
      w <- .kzs_str(away)
      .abort_asset_fetch("{where}: action matchTeamId {shown} is not match {mid}'s ({h}, {w}).", call = call)
    }
    pid <- a[["playerId"]]
    if (!is.null(pid)) {
      pk <- .kzs_key(pid)
      if ((pk %in% first && tk != sides[[1]]) || (pk %in% second && tk != sides[[2]])) {
        shown <- .kzs_str(pid)
        tshown <- .kzs_str(team)
        .abort_asset_fetch("{where}: player {shown} acts for matchTeamId {tshown}: home/away order is wrong.",
                           call = call)
      }
    }
    seen <- union(seen, tk)
  }
  if (!setequal(seen, unique(sides))) {
    .abort_asset_fetch("{where}: actions carry matchTeamIds that are not both of match {mid}'s.", call = call)
  }
}

#' @noRd
.kzs_check_box <- function(where, mid, data, call) {
  body <- .kzs_obj(data)
  if (!.kzs_same(body[["matchId"]], mid)) {
    shown <- .kzs_str(body[["matchId"]])
    .abort_asset_fetch("{where}: asked for match {mid}, the body has matchId={shown}.", call = call)
  }
  head <- .kzs_header(mid, call)
  for (side in c("firstTeam", "secondTeam")) {
    block <- .kzs_obj(body[[side]])
    if (length(block) && !.kzs_same(block[["teamId"]], .kzs_obj(head[[side]])[["teamId"]])) {
      shown <- .kzs_str(block[["teamId"]])
      .abort_asset_fetch("{where}: {side}.teamId {shown} is not the header's (home/away order).", call = call)
    }
  }
  lines <- vapply(c("firstTeam", "secondTeam"),
                  function(s) length(.kzs_rows(.kzs_obj(body[[s]])[["playerStats"]])) > 0L, logical(1))
  if (!all(lines)) {
    .abort_no_data("{where}: the game has no box score (2007-08 answers only per-minute scores).", call = call)
  }
}

#' @noRd
.kzs_check_days <- function(where, cid, data, call) {
  days <- .kzs_rows(.kzs_obj(data)[["items"]])
  if (!length(days)) .abort_no_data("{where}: no playing days.", call = call)
  phases <- .kzs_rows(.kzs_competition(cid, call)[["phases"]])
  cut <- function(p, key) substr(if (is.character(p[[key]]) && nzchar(p[[key]])) p[[key]] else "", 1, 10)
  starts <- vapply(phases, cut, "", key = "startDate")
  ends <- vapply(phases, cut, "", key = "endDate")
  lo <- if (length(starts)) sort(starts, method = "radix")[[1]] else ""
  hi <- if (length(ends)) sort(ends, method = "radix", decreasing = TRUE)[[1]] else ""
  bad <- Filter(function(d) {
    date <- .kzs_str(d[["date"]])
    !(nzchar(lo) && !.kzs_lt(date, lo) && !.kzs_lt(hi, date))
  }, days)
  if (length(bad)) {
    shown <- paste(vapply(utils::head(bad, 3), function(d) .kzs_str(d[["date"]]), ""), collapse = ", ")
    lo_s <- if (nzchar(lo)) lo else "?"
    hi_s <- if (nzchar(hi)) hi else "?"
    .abort_asset_fetch("{where}: days [{shown}] are outside competition {cid}'s {lo_s}..{hi_s}.", call = call)
  }
}

#' Raise `hoopR_no_data` for a row-less body, `hoopR_asset_fetch` for a partial or out-of-scope one.
#' @noRd
.kzs_check <- function(route, ids, query, data, call) {
  where <- .kzs_where(route)
  if (route %in% .KZS_LIST_ROUTES) {
    items <- .kzs_obj(data)[["items"]]
    if (!.kzs_is_array(items)) .abort_asset_fetch("{where}: a list route answered no items[].", call = call)
    .kzs_whole(where, items, query[["limit"]], call)
    if (!length(items)) .abort_no_data("{where}: the API answered no rows.", call = call)
  }
  if (route == "/competitions/" && !is.null(query[["seasonId"]])) {
    sid <- query[["seasonId"]]
    for (c in .kzs_rows(data[["items"]])) {
      if (!.kzs_same(.kzs_obj(c[["season"]])[["id"]], sid)) {
        shown <- .kzs_str(c[["id"]])
        .abort_asset_fetch("{where}: asked for seasonId={sid}, got competition {shown}.", call = call)
      }
    }
  } else if (route == "/competitions/{competition_id}") {
    .kzs_id(where, data, ids[["competition_id"]], "competition", call)
  } else if (route == "/competitions/{competition_id}/rounds") {
    phase_ids <- function(x) unique(.kzs_keys(lapply(.kzs_rows(x), function(p) p[["id"]])))
    want <- phase_ids(.kzs_competition(ids[["competition_id"]], call)[["phases"]])
    got <- phase_ids(.kzs_obj(data)[["phases"]])
    if (!length(got)) .abort_no_data("{where}: no rounds.", call = call)
    if (!setequal(got, want)) {
      .abort_asset_fetch("{where}: the phases are not the competition's ({length(want)} phase{?s}).", call = call)
    }
  } else if (route %in% c("/competitions/{competition_id}/playerStats", "/competitions/{competition_id}/teamStats")) {
    .kzs_check_leaderboard(where, ids[["competition_id"]], query, .kzs_rows(data[["items"]]), call)
  } else if (route == "/matches/") {
    .kzs_check_matches(where, query, .kzs_rows(data[["items"]]), call)
  } else if (route == "/matches/{match_id}") {
    .kzs_id(where, data, ids[["match_id"]], "match", call)
  } else if (route == "/matches/{match_id}/playByPlay") {
    .kzs_check_pbp(where, ids[["match_id"]], data, call)
  } else if (route == "/matches/{match_id}/stats") {
    .kzs_check_box(where, ids[["match_id"]], data, call)
  } else if (route == "/matches/standings") {
    cid <- query[["competitionId"]]
    if (!.kzs_same(.kzs_obj(.kzs_obj(data)[["competition"]])[["id"]], cid)) {
      .abort_asset_fetch("{where}: asked for competitionId={cid %||% 'None'}, got another.", call = call)
    }
    filled <- vapply(.kzs_rows(.kzs_obj(data)[["phases"]]), function(p) {
      st <- p[["standings"]]
      (!is.null(st) && length(st) > 0L && !identical(st, FALSE) && !identical(st, "")) ||
        any(vapply(.kzs_rows(p[["groups"]]), function(g) length(.kzs_rows(g[["standings"]])) > 0L, logical(1)))
    }, logical(1))
    if (!any(filled)) .abort_no_data("{where}: the competition has no standings rows.", call = call)
  } else if (route == "/matches/{competition_id}/playingDays") {
    .kzs_check_days(where, ids[["competition_id"]], data, call)
  } else if (route == "/teams/") {
    cid <- query[["competitionId"]]
    teams <- .kzs_team_ids(cid, call)
    bad <- Filter(function(r) !.kzs_key(r[["id"]]) %in% teams, .kzs_rows(data[["items"]]))
    if (length(bad)) {
      shown <- paste(vapply(utils::head(bad, 5), function(r) .kzs_str(r[["id"]]), ""), collapse = ", ")
      .abort_asset_fetch("{where}: team ids [{shown}] are not in competition {cid}.", call = call)
    }
  } else if (route == "/teams/{team_id}") {
    .kzs_id(where, data, ids[["team_id"]], "team", call)
  } else if (route == "/players/{player_id}") {
    .kzs_id(where, data, ids[["player_id"]], "player", call)
  } else if (route == "/players/{player_id}/stats") {
    sid <- query[["seasonId"]]
    rows <- .kzs_rows(.kzs_obj(data)[["competitionStats"]])
    if (!length(rows)) {
      .abort_no_data("{where}: the player has no competition rows in season {sid %||% 'None'}.", call = call)
    }
    comps <- .kzs_season_competitions(sid, call)
    bad <- Filter(function(r) !.kzs_key(r[["competitionId"]]) %in% comps, rows)
    if (length(bad)) {
      shown <- paste(vapply(bad, function(r) .kzs_str(r[["competitionId"]]), ""), collapse = ", ")
      .abort_asset_fetch("{where}: competitions [{shown}] are not in season {sid}.", call = call)
    }
  }
  invisible()
}

# ---------------------------------------------------------------------------
# The getter
# ---------------------------------------------------------------------------

#' The request stamp the parsers read (sportsdataverse-py `_context`).
#' @noRd
.kzs_context <- function(ids, query) {
  ctx <- as.list(ids)
  if (!is.null(query[["competitionId"]])) ctx[["competition_id"]] <- query[["competitionId"]]
  if (!is.null(query[["teamId"]])) ctx[["team_id"]] <- query[["teamId"]]
  if (!is.null(query[["seasonId"]])) {
    ctx[["season_id"]] <- query[["seasonId"]]
    end <- names(.KZS_SEASON_IDS)[.KZS_SEASON_IDS == query[["seasonId"]]]
    if (length(end)) ctx[["season"]] <- as.integer(end)
  }
  if (!is.null(query[["statsCategory"]])) ctx[["stats_category"]] <- query[["statsCategory"]]
  ctx
}

#' GET a KZS route, unwrap the envelope, refuse the partial or out-of-scope answers and stamp the request.
#'
#' @param route The route template (`"/matches/{match_id}"`), a name in `.KZS_LIST_ROUTES` or the scope checks.
#' @param ids Named list of the path ids (integers), in the order they fill the template.
#' @param query Named list of query parameters (`NULL` dropped). `season` (the END year) is sent as the opaque
#'   `seasonId`.
#' @param call The exported wrapper's frame.
#' @return `data` of the envelope as a named list, with the request stamp under `_request` (a bare list comes back
#'   as `list(items = <list>, _request = ...)`).
#' @noRd
.kzs_get <- function(route, ids = list(), query = list(), call = rlang::caller_env()) {
  query <- Filter(Negate(is.null), query)
  if ("season" %in% names(query)) {
    sid <- .kzs_season_id(query[["season"]], call = call)
    query[["season"]] <- NULL
    query[["seasonId"]] <- sid
  }
  for (key in intersect(c("competitionId", "teamId", "seasonId", "limit"), names(query))) {
    query[[key]] <- .kzs_int_arg(query[[key]], key, call = call)
  }
  if (route %in% c("/competitions/{competition_id}/playerStats", "/competitions/{competition_id}/teamStats") &&
      is.null(query[["competitionId"]])) {
    query[["competitionId"]] <- ids[["competition_id"]] # the API wants it in the query as well as the path
  }
  path <- route
  for (n in names(ids)) path <- sub(paste0("{", n, "}"), ids[[n]], path, fixed = TRUE)
  url <- paste0(.KZS_BASE, path)
  data <- .kzs_fetch(url, query, call = call)
  if (is.null(data) || (is.list(data) && !length(data))) {
    where <- .intl_where(url)
    .abort_no_data("{where}: the API answered no data.", call = call)
  }
  shaped <- if (.kzs_is_dict(data)) data else list(items = data)
  .kzs_check(route, ids, query, shaped, call)
  shaped[[.KZS_REQUEST]] <- .kzs_context(ids, query)
  shaped
}
