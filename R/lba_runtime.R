# lba_runtime.R -- transport for the Lega Basket Serie A wrappers (www.legabasket.it/api, keyless JSON).
#
# R mirror of sdv-py sportsdataverse/basketball/lba/lba_runtime.py (origin/main e3d232ebc9):
#
# * Politeness: 2 s between two requests (the Crawl-delay of the site's robots.txt), on every attempt, retries
#   included (`.intl_perform(min_interval = 2)`).
# * Seasons are START years on the wire (`s` / `year`: 2026 = 2026-27). The public argument is the sdv END year,
#   so `s` and `year` go out as END - 1, and the END year asked for is stamped into the body under `_request`
#   (`list(season = 2027L)`) for the parsers. A season that is not an END year in 1950-2100 is
#   `hoopR_bad_request` before any request.
# * An unknown id is HTTP 500 text/plain, every time, so a 500 is not retried (`retry_500 = FALSE`) and raises
#   `hoopR_asset_fetch` at once.
# * Old seasons answer 200 with an empty payload (a play-by-play before 2017-18, a finished championship's
#   standings without a round, an unknown season): `hoopR_no_data`.
# * Scope: a body must be the one asked for, else `hoopR_asset_fetch`: the season, the championship, game, team or
#   player id, the round and the leaderboard category are all checked, type-strictly, on every row. Standings must
#   sit on one round, with no team past that many games played. The box score, play-by-play and shot routes refuse
#   a game that is not final (`game_status` other than "2"); a whole-season list page shorter than
#   `pagination.count` is truncated; an error envelope is refused.

#' @noRd
.LBA_HOST <- "https://www.legabasket.it/api"
#' Seconds between two requests to legabasket.it (robots.txt `Crawl-delay: 2`).
#' @noRd
.LBA_INTERVAL <- 2
#' @noRd
.LBA_REQUEST <- "_request"
#' The one game status that means final (0 scheduled, 1 live, 2 final).
#' @noRd
.LBA_FINAL <- "2"
#' @noRd
.LBA_SEASON_PARAMS <- c("s", "year")
#' @noRd
.LBA_ERROR_KEYS <- c("error", "errors", "message", "status", "statusCode", "code", "detail")

#' Route -> the dotted path that must hold at least one row.
#' @noRd
.LBA_ROWS <- c(
  "/championships/get-championships" = "competitions",
  "/championships/get-championships-calendar-by-id" = "matches",
  "/championships/get-championships-matches-by-id" = "match",
  "/championships/get-championships-matches-scores-by-id" = "scores.ht.rows",
  "/championships/get-championships-matches-play-by-play" = "pbp.actions",
  "/matches/get-championship-matches-shots-by-id" = "shots.ht",
  "/championships/get-championship-ranking" = "standings",
  "/teams/get-teams" = "teams",
  "/teams/get-team-roster" = "players",
  "/teams/get-team-players-stats" = "players",
  "/players/get-players" = "players",
  "/players/get-player-by-id" = "player",
  "/players/get-player-stats" = "stats.data.sum",
  "/players/get-player-matches" = "matches_stats.data",
  "/statistics/get-players-statistics" = "stats",
  "/statistics/get-teams-statistics-by-type" = "stats"
)

#' Route -> c(dotted path = request parameter): the body echoes the parameter, on every row (`a[].b`).
#' @noRd
.LBA_SCOPE <- list(
  "/championships/get-championships" = c("competitions[].year" = "s"),
  "/championships/get-championships-calendar-by-id" = c("competition.id" = "id", "matches[].championship_id" = "id",
                                                         "matches[].number" = "d"),
  "/championships/get-championships-matches-by-id" = c("match.id" = "id"),
  "/championships/get-championships-matches-scores-by-id" = c("match.id" = "id"),
  "/championships/get-championships-matches-play-by-play" = c("match.id" = "id"),
  "/matches/get-championship-matches-shots-by-id" = c("match.id" = "id"),
  "/championships/get-championship-ranking" = c("competition.id" = "id"),
  "/teams/get-teams" = c("teams[].year" = "year"),
  "/teams/get-team-roster" = c("team.id" = "id"),
  "/teams/get-team-players-stats" = c("team.id" = "id", "players[].player_season" = "s"),
  "/players/get-players" = c("players[].year" = "year"),
  "/players/get-player-by-id" = c("player.id" = "id"),
  "/players/get-player-stats" = c("player.id" = "id"),
  "/players/get-player-matches" = c("player.id" = "id", "matches_stats.data[].player_id" = "id"),
  "/statistics/get-players-statistics" = c("stats[].year" = "s", "stats[].category" = "cat"),
  "/statistics/get-teams-statistics-by-type" = c("stats[].year" = "s")
)

#' Routes whose rows carry the START year in a string prefix (`2026|TVU`).
#' @noRd
.LBA_PREFIX <- list("/players/get-player-matches" = c("matches_stats.data[].player_team_code" = "s"))

#' @noRd
.LBA_FINAL_ONLY <- c("/championships/get-championships-matches-scores-by-id",
                     "/championships/get-championships-matches-play-by-play",
                     "/matches/get-championship-matches-shots-by-id")

#' List routes that ask for a whole season at once.
#' @noRd
.LBA_WHOLE <- c("/championships/get-championships", "/teams/get-teams")

# a step that is not there (fails closed)
.LBA_MISSING <- structure(list(), class = "lba_missing")

#' @noRd
.lba_is_missing <- function(x) inherits(x, "lba_missing")
#' JSON object (a named list, `{}` included) vs JSON array (an unnamed list).
#' @noRd
.lba_is_dict <- function(x) is.list(x) && !is.null(names(x)) && !.lba_is_missing(x)
#' @noRd
.lba_is_array <- function(x) is.list(x) && is.null(names(x)) && !.lba_is_missing(x)

#' Values at a dotted path; `name[]` fans out over a list; a missing step is `.LBA_MISSING`.
#' @noRd
.lba_values <- function(body, path) {
  nodes <- list(body)
  for (part in strsplit(path, ".", fixed = TRUE)[[1]]) {
    many <- endsWith(part, "[]")
    key <- if (many) substr(part, 1L, nchar(part) - 2L) else part
    out <- list()
    for (node in nodes) {
      value <- if (.lba_is_dict(node) && key %in% names(node)) node[[key]] else .LBA_MISSING
      if (many) {
        if (!.lba_is_array(value) || !length(value)) out <- c(out, list(.LBA_MISSING)) else out <- c(out, value)
      } else {
        out <- c(out, list(value))
      }
    }
    nodes <- out
  }
  nodes
}

#' Type-strict equality: an integer id must arrive as a JSON integer, a category as a string.
#' @noRd
.lba_same <- function(got, want) {
  if (is.null(got) || .lba_is_missing(got) || length(got) != 1L || is.list(got)) return(FALSE)
  if (is.character(want)) return(is.character(got) && identical(got, want))
  is.integer(got) && !is.na(got) && got == want
}

#' `x` printed the way the sdv-py messages print it.
#' @noRd
.lba_show <- function(x) {
  if (is.null(x)) return("null")
  if (.lba_is_missing(x)) return("None")
  if (is.list(x)) return(substr(.lba_pyjson(x), 1L, 60L))
  if (is.character(x)) return(paste0("'", x, "'"))
  as.character(x)
}

#' Map the public END-year `s` / `year` to the wire START year; `list(season = END)` when one was sent.
#' @noRd
.lba_to_start <- function(query, call = rlang::caller_env()) {
  sent <- list()
  for (key in intersect(.LBA_SEASON_PARAMS, names(query))) {
    value <- query[[key]]
    if (is.null(value)) next
    shown <- paste(format(value), collapse = ", ")
    ok <- length(value) == 1L && !is.logical(value) && !is.na(value) &&
      ((is.numeric(value) && value == trunc(value)) || (is.character(value) && grepl("^\\s*-?[0-9]+\\s*$", value)))
    if (!ok) {
      .abort_bad_request("season must be an END year such as 2027 (2026-27); got {shown}", call = call)
    }
    end <- as.integer(value)
    if (end < 1950L || end > 2100L) {
      .abort_bad_request("season must be an END year such as 2027 (2026-27); got {end}", call = call)
    }
    query[[key]] <- end - 1L
    sent$season <- end
  }
  list(query = query, sent = sent)
}

#' Refuse a non-object body or an error envelope.
#' @noRd
.lba_error <- function(where, body, call) {
  if (!.lba_is_dict(body)) {
    kind <- if (is.list(body)) "list" else class(body)[[1]]
    .abort_asset_fetch("{where} answered a {kind}, not an object", call = call)
  }
  if (length(body) && all(names(body) %in% .LBA_ERROR_KEYS)) {
    excerpt <- substr(.lba_pyjson(body), 1L, 120L)
    .abort_asset_fetch("{where} answered an error envelope: {excerpt}", call = call)
  }
}

#' sdv-py `_is_empty`: a list / object with no value other than null, "", [] or {}; a scalar only when null.
#' @noRd
.lba_is_empty <- function(value) {
  if (is.null(value)) return(TRUE)
  if (!is.list(value)) return(FALSE)
  !any(vapply(value, function(v) !(is.null(v) || identical(v, "") || (is.list(v) && !length(v))), logical(1)))
}

#' Raise `hoopR_no_data` for a row-less body, `hoopR_asset_fetch` for a partial or out-of-scope one.
#' @noRd
.lba_check <- function(where, route, query, body, call) {
  path <- .LBA_ROWS[route]
  if (!is.na(path)) {
    got <- .lba_values(body, path)[[1]]
    if (.lba_is_missing(got) || .lba_is_empty(got)) {
      .abort_no_data("{where}: the site answered no rows at '{path}'", call = call)
    }
  }
  scope <- .LBA_SCOPE[[route]]
  for (dotted in names(scope)) {
    key <- scope[[dotted]]
    if (is.null(query[[key]])) next
    want <- if (key == "cat") as.character(query[[key]]) else suppressWarnings(as.integer(query[[key]]))
    for (got in .lba_values(body, dotted)) {
      if (!.lba_same(got, want)) {
        shown_want <- .lba_show(want)
        shown <- .lba_show(got)
        .abort_asset_fetch("{where}: asked for {key}={shown_want}, the body has {dotted}={shown}", call = call)
      }
    }
  }
  prefix <- .LBA_PREFIX[[route]]
  for (dotted in names(prefix)) {
    key <- prefix[[dotted]]
    if (is.null(query[[key]])) next
    want <- paste0(query[[key]], "|")
    for (got in .lba_values(body, dotted)) {
      if (!is.character(got) || length(got) != 1L || !startsWith(got, want)) {
        season <- query[[key]]
        shown <- .lba_show(got)
        .abort_asset_fetch("{where}: asked for season {season}, the body has {dotted}={shown}", call = call)
      }
    }
  }
  if (route == "/championships/get-championship-ranking" && !is.null(query$d)) {
    .lba_round(where, body, as.integer(query$d), call)
  }
  if (route %in% .LBA_FINAL_ONLY) {
    status <- .lba_values(body, "match.game_status")[[1]]
    if (!identical(status, .LBA_FINAL)) {
      shown <- .lba_show(status)
      .abort_asset_fetch("{where}: the game is not final (game_status={shown})", call = call)
    }
  }
  if (route %in% .LBA_WHOLE && is.null(query$page)) {
    rows <- .lba_values(body, .LBA_ROWS[[route]])[[1]]
    pg <- body$pagination
    count <- if (.lba_is_dict(pg)) pg$count else NULL
    n <- length(rows)
    if (!is.integer(count) || length(count) != 1L || count > n) {
      shown <- .lba_show(count)
      .abort_asset_fetch("{where}: truncated page ({n} rows of {shown}); pass a larger page size", call = call)
    }
  }
  invisible(body)
}

#' Standings on one round: one `championships_day_id` on every row and no team past `day` games played.
#' @noRd
.lba_round <- function(where, body, day, call) {
  rows <- Filter(.lba_is_dict, if (is.list(body$standings)) body$standings else list())
  days <- lapply(rows, function(r) if ("championships_day_id" %in% names(r)) r$championships_day_id %||% NA else .LBA_MISSING)
  if (any(vapply(days, .lba_is_missing, logical(1))) || length(unique(days)) != 1L) {
    .abort_asset_fetch("{where}: the standings span several rounds", call = call)
  }
  played <- lapply(rows, function(r) r$game_played)
  counts <- Filter(function(g) is.integer(g) && length(g) == 1L, played)
  # not `==`: a postponed game leaves a team one short
  if (length(counts) != length(played) || max(unlist(counts)) > day) {
    shown <- paste0("[", paste(vapply(played, .lba_show, ""), collapse = ", "), "]")
    .abort_asset_fetch("{where}: games played {shown} are past round {day}", call = call)
  }
}

#' GET a legabasket.it route as JSON: map the season, refuse the empty / partial / out-of-scope answers, stamp
#' the END-year season under `_request`.
#'
#' @param path Route path under `.LBA_HOST` (e.g. `"/teams/get-teams"`).
#' @param query Named list of query parameters (`NULL` dropped; `s` / `year` are END years).
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The parsed body (a named list).
#' @noRd
.lba_get <- function(path, query = list(), call = rlang::caller_env()) {
  url <- paste0(.LBA_HOST, path)
  where <- .intl_where(url)
  query <- Filter(Negate(is.null), query)
  mapped <- .lba_to_start(query, call = call)
  query <- mapped$query
  req <- .intl_request(url, query = query)
  resp <- .intl_perform(req, retry_500 = FALSE, min_interval = .LBA_INTERVAL, call = call)
  .intl_check_status(resp, where = where, call = call)
  body <- .intl_json(.intl_body_text(resp), where = where, call = call)
  .lba_error(where, body, call)
  .lba_check(where, path, query, body, call)
  if (length(mapped$sent)) body[[.LBA_REQUEST]] <- mapped$sent
  body
}

#' Fetch one route and parse it into the `hoopR_data` tibble of its wrapper.
#' @noRd
.lba_call <- function(short, query, call = rlang::caller_env()) {
  route <- .LBA_ROUTES[[short]]
  body <- .lba_get(route$path, c(route$fixed, query), call = call)
  make_hoopR_data(.lba_parse(short, body), paste("LBA", route$title, "from legabasket.it"), Sys.time())
}

#' `value` must be one of `choices` (sdv-py raises ValueError naming the argument).
#' @noRd
.lba_choice <- function(value, choices, arg, call = rlang::caller_env()) {
  if (!is.character(value) || length(value) != 1L || !value %in% choices) {
    shown <- paste(format(value), collapse = ", ")
    .abort_bad_request("{arg} must be one of {.val {choices}}; got {shown}", call = call)
  }
  invisible(value)
}
