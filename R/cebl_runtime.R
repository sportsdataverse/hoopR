# cebl_runtime.R -- transport for the CEBL wrappers (api.data.cebl.ca, the CEBL Stats Hub's backend).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/cebl/cebl_runtime.py (origin/main e3d232ebc9):
#
# * Header key: every route needs `X-Api-Key` (401 without it). The key is the Stats Hub's own, shipped to
#   every browser in its league-leaders page chunk. It is read from there once per R session (two
#   requests; accepted only if it is 20-64 letters / digits), with `.CEBL_FALLBACK_KEY` (the value of
#   2026-10-13) when the bundle cannot be read. On a 401 the bundle is re-read once; if it still holds the
#   refused key, or the new key is refused too, `hoopR_asset_fetch` with a "key rotated?" hint. The key is
#   never printed, logged or put in a condition (`.cebl_scrub()`), and since every API request carries it,
#   no request follows a redirect (`follow_redirects = FALSE`).
# * Throttle and retries: `.intl_response()` (>= 1 s per host on every attempt, the bundle reads included).
#   HTTP 500 is the API's answer to a bad id, so it is not retried (`retry_500 = FALSE`).
# * Season: the calendar year (May to August) = the END year, so there is no mapping; it must be a 4-digit
#   year.
# * Refusals: 404, an empty list, leaders with no rows, an all-null profile -> `hoopR_no_data`; a bad
#   argument, 400 / 422 -> `hoopR_bad_request`; a refused key, any other non-200, a non-JSON or empty body,
#   an error envelope, a changed envelope and a body for another season, team or player than the one asked
#   (game dates, team filters, player ids, leader keys, the career row, the team table's one league row)
#   -> `hoopR_asset_fetch`.
# * Contact fields (e-mail, phone, address) are dropped from every body; the API serves none today.
# * Stamped request: `.cebl_get()` returns `list(rows = <body>, `_request` = <request>)`; the parsers turn
#   the request into the season / mode / competition / ... columns.

#' @noRd
.CEBL_HUB <- "https://cebl-stats-hub.web.app"
#' @noRd
.CEBL_API <- "https://api.data.cebl.ca"
#' The Stats Hub's public key, read from its page chunk on 2026-10-13 (sportsdataverse-py `FALLBACK_KEY`).
#' @noRd
.CEBL_FALLBACK_KEY <- "800chyzv2hvur3z0ogh39cve2zok0c"
#' @noRd
.CEBL_REQUEST <- "_request"
#' @noRd
.CEBL_MODES <- c("TOTALS", "PER_GAME")
#' @noRd
.CEBL_COMPETITIONS <- c("REGULAR", "FINALS")
#' @noRd
.CEBL_SEGMENTS <- c("HOME", "AWAY", "L7D", "L5G", "L10G", "MAY", "JUNE", "JULY", "AUGUST")
#' @noRd
.CEBL_CONFERENCES <- c("EAST", "WEST")
#' @noRd
.CEBL_ERROR_KEYS <- c("error", "errors", "message", "exception", "trace", "detail")
#' Contact keys, dropped from every body (matched case-insensitively).
#' @noRd
.CEBL_PERSONAL <- "(e_?mail|phone|mobile|^tel$|address|passport|salary)"

# the header key in use and where it came from ("bundle" / "fallback"), once per session
.cebl_key <- new.env(parent = emptyenv())

#' JSON object (a named list, `{}` included) vs JSON array (an unnamed list).
#' @noRd
.cebl_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.cebl_is_array <- function(x) is.list(x) && is.null(names(x))

# ---------------------------------------------------------------------------
# Secrets
# ---------------------------------------------------------------------------

#' `text` with the key in use and the documented fallback replaced by `<key>`.
#' @noRd
.cebl_scrub <- function(text) {
  text <- paste(as.character(text), collapse = " ")
  for (k in unique(c(.cebl_key$value, .CEBL_FALLBACK_KEY))) {
    if (nzchar(k)) text <- gsub(k, "<key>", text, fixed = TRUE)
  }
  text
}

#' `hoopR_asset_fetch` with a scrubbed message (`msg` is plain text, never a cli template).
#' @noRd
.cebl_fail <- function(msg, ..., call) {
  msg <- .cebl_scrub(msg)
  .abort_asset_fetch("{msg}", ..., call = call)
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' Throttled GET, no redirects, 500 not retried; the response unchecked. A connection failure that
#' outlives the retries names only the cause class (never the URL's query or a header).
#' @noRd
.cebl_fetch <- function(url, query = list(), headers = NULL, call = rlang::caller_env()) {
  tryCatch(
    .intl_response(url, query = query, headers = headers, retry_500 = FALSE, follow_redirects = FALSE, call = call),
    hoopR_asset_fetch = function(e) {
      cause <- class(e$parent %||% e)[[1]]
      .cebl_fail(paste0(.intl_where(url), ": fetch failed after 3 attempts: ", cause), transient = TRUE, call = call)
    }
  )
}

#' The `X-Api-Key`: the hub bundle's, else the documented fallback. Cached per session.
#' @noRd
.cebl_read_key <- function(renew = FALSE, call = rlang::caller_env()) {
  if (!is.null(.cebl_key$value) && !renew) return(.cebl_key$value)
  found <- tryCatch({
    page <- .cebl_fetch(paste0(.CEBL_HUB, "/league-leaders"), call = call)
    html <- if (httr2::resp_status(page) == 200L) .intl_body_text(page) else ""
    chunk <- regmatches(html, regexpr("static/chunks/app/league-leaders/page-[0-9a-f]+\\.js", html, perl = TRUE))
    key <- NULL
    if (length(chunk)) {
      js <- .cebl_fetch(paste0(.CEBL_HUB, "/_next/", chunk), call = call)
      text <- if (httr2::resp_status(js) == 200L) .intl_body_text(js) else ""
      m <- regmatches(text, regexec('"X-Api-Key"\\s*:\\s*"([^"]{1,80})"', text, perl = TRUE))[[1]]
      if (length(m) == 2L && grepl("^[A-Za-z0-9]{20,64}$", m[[2]], perl = TRUE)) key <- m[[2]]
    }
    key
  }, hoopR_error = function(e) NULL) # the documented fallback answers any failure to read the bundle
  .cebl_key$value <- found %||% .CEBL_FALLBACK_KEY
  .cebl_key$source <- if (is.null(found)) "fallback" else "bundle"
  .cebl_key$value
}

#' GET `.CEBL_API + path` with the key (one key renewal on a 401); the parsed JSON body.
#' @noRd
.cebl_call <- function(path, query = list(), call = rlang::caller_env()) {
  url <- paste0(.CEBL_API, path)
  where <- .intl_where(url)
  used <- NULL
  for (renew in c(FALSE, TRUE)) {
    key <- .cebl_read_key(renew = renew, call = call)
    if (renew && identical(key, used)) break # the bundle still holds the key the API just refused
    used <- key
    headers <- list(`X-Api-Key` = key, Origin = .CEBL_HUB, Referer = paste0(.CEBL_HUB, "/"),
                    Accept = "application/json")
    resp <- .cebl_fetch(url, query, headers, call = call)
    if (httr2::resp_status(resp) != 401L) break
  }
  status <- httr2::resp_status(resp)
  if (status == 401L) {
    .cebl_fail(paste0(
      where, " answered HTTP 401: the X-Api-Key was rejected (key rotated? re-read it from the ",
      "app/league-leaders page chunk linked from ", .CEBL_HUB, "/league-leaders and update the fallback key)"
    ), status = status, call = call)
  }
  if (status == 404L) .abort_no_data("{where} answered HTTP 404", status = status, call = call)
  if (status %in% c(400L, 422L)) {
    .abort_bad_request("{where} rejected the request: HTTP {status}", status = status, call = call)
  }
  if (status != 200L) {
    .cebl_fail(paste0(where, " answered HTTP ", status, ", not 200"), status = status,
               transient = status %in% c(408L, 429L) || status >= 500L, call = call)
  }
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  text <- .intl_body_text(resp)
  if (!grepl("json", ctype, fixed = TRUE)) {
    .cebl_fail(paste0(where, " answered ", if (nzchar(ctype)) ctype else "no content type", ", not JSON"),
               call = call)
  }
  if (!nzchar(trimws(text))) .cebl_fail(paste0(where, " answered HTTP 200 with an empty body"), call = call)
  tryCatch(
    jsonlite::parse_json(text, simplifyVector = FALSE),
    error = function(e) .cebl_fail(paste0(where, " answered a body that is not JSON"), call = call)
  )
}

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------

#' A whole number (or a digit string) as an integer.
#' @noRd
.cebl_int_arg <- function(x, what, call = rlang::caller_env()) {
  ok <- length(x) == 1L && !is.logical(x) && !is.na(x) &&
    ((is.numeric(x) && x >= 0 && x == trunc(x) && x <= .Machine$integer.max) ||
       (is.character(x) && grepl("^[0-9]+$", trimws(x)) && as.numeric(trimws(x)) <= .Machine$integer.max))
  if (!ok) {
    shown <- if (length(x) == 1L && is.atomic(x)) as.character(x) else class(x)[[1]]
    .abort_bad_request("{.arg {what}} must be an integer; got {.val {shown}}.", call = call)
  }
  as.integer(trimws(as.character(x)))
}

#' The season: a 4-digit calendar year, which is the END year (no mapping).
#' @noRd
.cebl_season_arg <- function(x, call = rlang::caller_env()) {
  season <- .cebl_int_arg(x, "season", call = call)
  if (season < 1000L || season > 9999L) {
    .abort_bad_request("{.arg season} must be a 4-digit calendar year; got {.val {season}}.", call = call)
  }
  season
}

#' @noRd
.cebl_choice <- function(x, allowed, what, call = rlang::caller_env()) {
  if (is.null(x)) return(NULL)
  if (!is.character(x) || length(x) != 1L || is.na(x) || !x %in% allowed) {
    .abort_bad_request("{.arg {what}} must be one of {.val {allowed}}.", call = call)
  }
  x
}

# ---------------------------------------------------------------------------
# Shape checks
# ---------------------------------------------------------------------------

#' `obj` without contact keys, at every depth.
#' @noRd
.cebl_scrub_personal <- function(obj) {
  if (!is.list(obj)) return(obj)
  if (.cebl_is_dict(obj)) {
    obj <- obj[!grepl(.CEBL_PERSONAL, names(obj), ignore.case = TRUE, perl = TRUE)]
  }
  for (i in seq_along(obj)) if (is.list(obj[[i]])) obj[[i]] <- .cebl_scrub_personal(obj[[i]])
  obj
}

#' A numeric scalar equal to `want` (Python `==` between JSON numbers; a string never matches).
#' @noRd
.cebl_eq <- function(got, want) {
  is.numeric(got) && length(got) == 1L && !is.na(got) && !is.null(want) && got == want
}

#' The year of an ISO stamp (`"2025-05-11T..."`), else `NA`.
#' @noRd
.cebl_year <- function(stamp) {
  if (!is.character(stamp) || length(stamp) != 1L || !grepl("^[0-9]{4}-", stamp)) return(NA_integer_)
  as.integer(substr(stamp, 1L, 4L))
}

#' @noRd
.cebl_has_error_keys <- function(body) .cebl_is_dict(body) && any(names(body) %in% .CEBL_ERROR_KEYS)

#' Refuse unless every row passes `ok`.
#' @noRd
.cebl_each <- function(rows, ok, where, what, call) {
  if (!all(vapply(rows, ok, logical(1)))) {
    .cebl_fail(paste0(where, ": a row is for another ", what, " than the one asked for"), call = call)
  }
  invisible()
}

#' `body` as a non-empty list of objects.
#' @noRd
.cebl_rows <- function(body, where, call) {
  if (.cebl_has_error_keys(body)) .cebl_fail(paste0(where, ": the body is an error envelope"), call = call)
  if (!.cebl_is_array(body)) .cebl_fail(paste0(where, ": not a list of rows"), call = call)
  if (!length(body)) {
    .abort_no_data("{where}: no rows (an unknown season, team or player, or nothing played yet)", call = call)
  }
  if (!all(vapply(body, .cebl_is_dict, logical(1)))) .cebl_fail(paste0(where, ": a row is not an object"), call = call)
  body
}

#' @noRd
.cebl_team_ok <- function(team_id) {
  if (is.null(team_id)) function(r) TRUE else function(r) .cebl_eq(r[["team_id"]], team_id)
}

# ---------------------------------------------------------------------------
# Request
# ---------------------------------------------------------------------------

#' GET a CEBL route: check the arguments, refuse every wrong answer, stamp the request.
#'
#' @param kind Route: seasons, teams, standings, roster, team_stats, games, player_stats, leaders,
#'   player_seasons, player, gamelog or news.
#' @param season,team_id,player_id,mode,competition,segment,vs_team_id,vs_conference,statistics,career_only,language,team_source_id
#'   The wrapper's arguments (each route reads its own).
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return `list(rows = <body>, `_request` = <request>)`; `body` is the API's list (leaders: its object keyed
#'   by statistic; player: one object) with contact fields dropped.
#' @noRd
.cebl_get <- function(kind, season = NULL, team_id = NULL, player_id = NULL, mode = NULL, competition = NULL,
                      segment = NULL, vs_team_id = NULL, vs_conference = NULL, statistics = NULL,
                      career_only = NULL, language = NULL, team_source_id = NULL, call = rlang::caller_env()) {
  stamp <- list(kind = kind)
  send <- list()
  filter_team <- NULL
  if (kind %in% c("standings", "roster", "games")) {
    stamp$season <- .cebl_season_arg(season, call = call)
  } else if (!is.null(season)) {
    stamp$season <- send$season <- .cebl_season_arg(season, call = call)
  }
  if (kind == "roster") {
    stamp$team_id <- .cebl_int_arg(team_id, "team_id", call = call)
  } else if (!is.null(team_id)) {
    filter_team <- stamp$team_id <- send$team_id <- .cebl_int_arg(team_id, "team_id", call = call)
  }
  if (kind %in% c("player_seasons", "player", "gamelog")) {
    player_id <- stamp$player_id <- .cebl_int_arg(player_id, "player_id", call = call)
  }
  if (kind %in% c("team_stats", "player_stats", "leaders", "player_seasons")) {
    stamp$mode <- send$mode <- .cebl_choice(mode, .CEBL_MODES, "mode", call = call)
    if (is.null(mode)) .abort_bad_request("{.arg mode} is required: TOTALS or PER_GAME.", call = call)
  }
  if (kind %in% c("team_stats", "player_stats", "leaders", "player_seasons", "gamelog")) {
    stamp$competition <- send$competition <- .cebl_choice(competition, .CEBL_COMPETITIONS, "competition", call = call)
  }
  if (kind %in% c("team_stats", "player_stats")) {
    stamp$segment <- send$segment <- .cebl_choice(segment, .CEBL_SEGMENTS, "segment", call = call)
  }
  if (kind == "team_stats") {
    stamp$vs_conference <- send$vs_conference <- .cebl_choice(vs_conference, .CEBL_CONFERENCES, "vs_conference",
                                                              call = call)
    if (!is.null(vs_team_id)) stamp$vs_team_id <- send$vs_team_id <- .cebl_int_arg(vs_team_id, "vs_team_id", call = call)
  }
  if (kind == "leaders") {
    names_ <- if (is.character(statistics) && length(statistics) == 1L && !is.na(statistics)) {
      trimws(strsplit(statistics, ",", fixed = TRUE)[[1]])
    } else {
      character()
    }
    names_ <- names_[nzchar(names_)]
    if (!length(names_)) {
      .abort_bad_request("{.arg statistics} is required: a comma-separated list such as 'POINTS,REBOUNDS'.", call = call)
    }
    stamp$statistics <- send$statistics <- paste(names_, collapse = ",")
  }
  if (kind == "player_seasons") {
    if (!is.logical(career_only) || length(career_only) != 1L || is.na(career_only)) {
      .abort_bad_request("{.arg career_only} must be TRUE or FALSE.", call = call)
    }
    stamp$career_only <- career_only
    send$career_only <- if (career_only) "true" else "false"
  }
  if (kind == "news") {
    if (!is.character(language) || length(language) != 1L || !grepl("^[A-Za-z_-]+$", language)) {
      .abort_bad_request("{.arg language} must be a language code such as {.val en}: not a CEBL route.", call = call)
    }
    stamp$language <- language
    if (!is.null(team_source_id)) {
      stamp$team_source_id <- send$team_source_id <- .cebl_int_arg(team_source_id, "team_source_id", call = call)
    }
  }
  path <- switch(kind,
    seasons = "/seasons/",
    teams = "/teams/",
    standings = paste0("/teams/", stamp$season, "/"),
    roster = paste0("/teams/", stamp$team_id, "/roster/", stamp$season, "/"),
    team_stats = "/teams/statistics/aggregated/",
    games = paste0("/games/", stamp$season, "/"),
    player_stats = "/players/statistics/aggregated/",
    leaders = "/players/statistics/leaders/",
    player_seasons = paste0("/players/", player_id, "/statistics/"),
    player = paste0("/players/", player_id, "/"),
    gamelog = paste0("/players/", player_id, "/gamelog/"),
    news = paste0("/news/articles/", language, "/"),
    .abort_bad_request("Not a CEBL route: {.val {kind}}.", call = call)
  )
  where <- .intl_where(paste0(.CEBL_API, path))
  body <- .cebl_scrub_personal(.cebl_call(path, send, call = call))
  out <- function(rows) stats::setNames(list(rows, stamp), c("rows", .CEBL_REQUEST))

  if (kind == "leaders") {
    if (.cebl_has_error_keys(body)) .cebl_fail(paste0(where, ": the body is an error envelope"), call = call)
    if (!.cebl_is_dict(body) || !setequal(names(body), strsplit(stamp$statistics, ",", fixed = TRUE)[[1]])) {
      .cebl_fail(paste0(where, ": the body is not an object keyed by the statistics asked for"), call = call)
    }
    if (!all(vapply(body, function(v) .cebl_is_array(v) && all(vapply(v, .cebl_is_dict, logical(1))), logical(1)))) {
      .cebl_fail(paste0(where, ": a statistic is not a list of rows"), call = call)
    }
    if (!any(lengths(body) > 0L)) {
      .abort_no_data("{where}: no leaders (an unknown season or team, or a statistic name the API lacks)", call = call)
    }
    for (rows in body) .cebl_each(rows, .cebl_team_ok(filter_team), where, "team", call)
    return(out(body))
  }
  if (kind == "player") {
    if (.cebl_has_error_keys(body)) .cebl_fail(paste0(where, ": the body is an error envelope"), call = call)
    if (!.cebl_is_dict(body)) .cebl_fail(paste0(where, ": not a player object"), call = call)
    if (is.null(body[["id"]]) && all(vapply(body, is.null, logical(1)))) {
      .abort_no_data("{where}: an all-null profile (an unknown player id)", call = call)
    }
    if (!.cebl_eq(body[["id"]], player_id)) {
      .cebl_fail(paste0(where, ": the profile is for another player than the one asked for"), call = call)
    }
    return(out(body))
  }
  rows <- .cebl_rows(body, where, call)
  season <- stamp$season
  if (kind == "seasons") {
    .cebl_each(rows, function(r) is.integer(r[["year"]]) && length(r[["year"]]) == 1L, where, "season", call)
  } else if (kind == "games") {
    .cebl_each(rows, function(r) identical(.cebl_year(r[["start_time_utc"]]), season), where, "season", call)
    if (!is.null(filter_team)) {
      .cebl_each(rows, function(r) .cebl_eq(r[["home_team_id"]], filter_team) || .cebl_eq(r[["away_team_id"]], filter_team),
                 where, "team", call)
    }
  } else if (kind == "gamelog" && !is.null(season)) {
    .cebl_each(rows, function(r) identical(.cebl_year(r[["game_date"]]), season), where, "season", call)
  } else if (kind == "team_stats") {
    if (sum(vapply(rows, function(r) is.null(r[["id"]]), logical(1))) != 1L) {
      .cebl_fail(paste0(where, ": a team table must hold exactly one league row"), call = call)
    }
  } else if (kind == "player_stats") {
    .cebl_each(rows, .cebl_team_ok(filter_team), where, "team", call)
  } else if (kind == "player_seasons") {
    .cebl_each(rows, function(r) .cebl_eq(r[["id"]], player_id), where, "player", call)
    if (isTRUE(stamp$career_only) && !(length(rows) == 1L && is.null(rows[[1]][["season"]]))) {
      .cebl_fail(paste0(where, ": career_only must answer the one career row"), call = call)
    }
  }
  out(rows)
}
