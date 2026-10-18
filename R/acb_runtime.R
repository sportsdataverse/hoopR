# acb_runtime.R -- transport, key and refusals of the ACB (Liga Endesa) wrappers.
#
# R mirror of sdv-py sportsdataverse/basketball/acb/acb_runtime.py (origin/main e3d232ebc9).
# One host (api2.acb.com), 33 JSON routes:
#   * Every request carries `X-APIKEY`, a public key from acb.com's Next.js bundle. The documented
#     value is built in, `$ACB_API_KEY` overrides it, and on a 401 the runtime re-reads the key from the
#     live bundle once (home page, then at most 60 script chunks) and retries. The key is never put in
#     a condition message.
#   * Season key: `editionId` = season START year - 1935; wrappers take the END year and send
#     `editionId = season - 1936` (the first edition, 48, is 1983-84 = season 1984).
#   * Silent wrong answers are refused (type-strict compares): echoed filters that differ from the
#     request, team rows of another edition, rows without the asked club or search term.
#   * Errors: hoopR_no_data (404, 204, a route with no rows), hoopR_bad_request (400 / 422, a bad
#     argument before any request), hoopR_asset_fetch (anything else, see `.acb_get()`).
# Transport is the shared throttled getter (R/intl_basketball_runtime.R): at least 1 s per host on
# every attempt; 429 / 5xx retried (HTTP 500 included: ACB is a retry_500 family), three attempts.

.ACB_API <- "https://api2.acb.com/api"
.ACB_SITE <- "https://www.acb.com/"
.ACB_DEFAULT_KEY <- "0dd94928-6f57-4c08-a3bd-b1b2f092976e"
.ACB_KEY_ENV <- "ACB_API_KEY"
.ACB_MAX_CHUNKS <- 60L
.ACB_EDITION_OFFSET <- 1936L
.ACB_FIRST_SEASON <- 1984L
.ACB_KEY_RE <- 'sharedServicesConfigDotnet[^{]{0,12}\\{baseUrl:"https://api2\\.acb\\.com",apiKey:"([0-9A-Za-z-]{16,64})"'
.ACB_CHUNK_RE <- "/_next/static/chunks/[A-Za-z0-9_./-]+?\\.js"
.ACB_ERROR_KEYS <- c("error", "errors", "message", "code", "detail", "status", "statusCode", "type", "title")

# the key read from the bundle (`value`), shared by every call of the session
.acb_key <- new.env(parent = emptyenv())

# route -> required params, rows path alternatives (all empty -> no_data), match must be finished,
# scope checks (body path, request key) compared type-strictly when the request key is given,
# optional params
.acb_route <- function(required = character(), rows = character(), finished = FALSE, scope = list(),
                       optional = character()) {
  list(required = required, rows = rows, finished = finished, scope = scope, optional = optional)
}
.ACB_SCOPE_FILTERS <- list(c("selectedFilters.competition", "competitionId"), c("selectedFilters.season", "editionId"))
.ACB_SEASON_OPT <- c("competitionId", "season")
.ACB_ROUTES <- list(
  "/matchdata/MatchHeader/match-header" = .acb_route("matchId", "quarterScores", scope = list(c("matchId", "matchId"))),
  "/matchdata/Result/boxscores" = .acb_route("matchId", "teamBoxscores", TRUE),
  "/matchdata/PlayByPlay/play-by-play" = .acb_route("matchId", "plays", TRUE),
  "/matchdata/MatchShots/match-shots" = .acb_route("matchId", "shotPoints", TRUE),
  "/matchdata/Overview/lead-tracker" = .acb_route("matchId", "leadTrackerInfo", TRUE),
  "/matchdata/Overview/lineup" = .acb_route("matchId", "teamLineUps", TRUE),
  "/matchdata/Overview/match-leaders" = .acb_route("matchId", "teamLeaders", TRUE),
  "/matchdata/Overview/match-team-comparison" = .acb_route("matchId", "statsPerQuarters", TRUE),
  "/matchdata/Overview/serie" = .acb_route("matchId", "matches"),
  "/matchdata/Preview/quickfacts" = .acb_route("matchId", "facts"),
  "/matchdata/Preview/season-leaders" = .acb_route("matchId", "teamLeaders"),
  "/matchdata/AdvancedStats/match-advanced-stats" = .acb_route("matchId", "homeAdvancedStats"),
  "/matchdata/AdvancedStats/player-advanced-stats" = .acb_route(c("matchId", "playerLicense"), "fourFactors"),
  "/matchdata/Menu/matchlist" = .acb_route("matchId", "matches", optional = c("roundId", "weekId")),
  "/matchdata/Menu/competition-data" = .acb_route(rows = "competitions", optional = "competitionIds"),
  "/seasondata/Competition/matches" = .acb_route(
    rows = "matches",
    scope = c(.ACB_SCOPE_FILTERS, list(c("selectedFilters.round", "roundId"), c("selectedFilters.week", "weekId"))),
    optional = c(.ACB_SEASON_OPT, "roundId", "weekId", "isRoundSelected")
  ),
  "/seasondata/Competition/standings" = .acb_route(
    rows = "standings", scope = c(.ACB_SCOPE_FILTERS, list(c("selectedFilters.round", "roundId"))),
    optional = c(.ACB_SEASON_OPT, "roundId")
  ),
  "/seasondata/Competition/bracket" = .acb_route(
    rows = c("data.quarterFinals.series", "data.semifinals.series", "data.final.series"),
    scope = .ACB_SCOPE_FILTERS, optional = .ACB_SEASON_OPT
  ),
  "/seasondata/Calendar/season-calendar" = .acb_route(rows = "rounds", scope = .ACB_SCOPE_FILTERS,
                                                      optional = .ACB_SEASON_OPT),
  "/seasondata/ShotChart/league-zones" = .acb_route(
    rows = "zones", scope = list(c("competitionId", "competitionId"), c("editionId", "editionId")),
    optional = .ACB_SEASON_OPT
  ),
  "/seasondata/TeamProfile/teams" = .acb_route(
    rows = "teams", scope = c(.ACB_SCOPE_FILTERS, list(c("teams[].selected.editionId", "editionId"))),
    optional = .ACB_SEASON_OPT
  ),
  "/seasondata/TeamProfile/team-matches" = .acb_route(
    "clubId", "matches", scope = list(c("matches[].homeTeam.editionId", "editionId")), optional = .ACB_SEASON_OPT
  ),
  "/seasondata/TeamProfile/next-matches" = .acb_route("clubId", "matches",
                                                      optional = c("numberOfMatches", .ACB_SEASON_OPT)),
  "/seasondata/TeamProfile/club-data" = .acb_route("clubId", "clubData", scope = list(c("clubData.team.clubId", "clubId"))),
  "/seasondata/TeamProfile/current-roster" = .acb_route(
    "clubId", "players", scope = list(c("players[].player.editionId", "editionId")), optional = .ACB_SEASON_OPT
  ),
  "/seasondata/TeamProfile/team-leaders" = .acb_route(c("clubId", "numberOfPlayers"), "leaders",
                                                      scope = .ACB_SCOPE_FILTERS, optional = .ACB_SEASON_OPT),
  "/seasondata/TeamProfile/team-stats" = .acb_route(
    "clubId", "players", scope = list(c("team.selected.clubId", "clubId"), c("team.selected.editionId", "editionId")),
    optional = .ACB_SEASON_OPT
  ),
  "/seasondata/TeamProfile/team-records" = .acb_route("clubId"),
  "/seasondata/PlayerProfile/player-data" = .acb_route(
    "playerLicenceId", "playerData", scope = list(c("playerData.player.id", "playerLicenceId"))
  ),
  "/seasondata/PlayerProfile/player-stats" = .acb_route(
    "playerLicenceId", "statsByTeam", scope = list(c("playerTotals.player.id", "playerLicenceId")),
    optional = .ACB_SEASON_OPT
  ),
  "/seasondata/PlayerProfile/career" = .acb_route("playerLicenceId", "stints"),
  "/seasondata/PlayerProfile/matches" = .acb_route(
    "playerLicenceId", "matches", scope = list(c("matches[].homeTeam.editionId", "editionId")), optional = "season"
  ),
  "/seasondata/Search/search" = .acb_route("searchTerm", c("players", "teams", "coaches"), optional = "limit")
)
.ACB_INT_KEYS <- c("matchId", "playerLicense", "playerLicenceId", "clubId", "competitionId", "roundId", "weekId",
                   "numberOfMatches", "numberOfPlayers", "limit", "season")

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------

#' A non-negative whole number from an integer, a whole double or a digit string; else bad_request.
#' @noRd
.acb_int <- function(value, what, call = rlang::caller_env()) {
  ok <- length(value) == 1L && !is.logical(value) && !is.na(value) && (
    (is.numeric(value) && is.finite(value) && value >= 0 && value == trunc(value) && value < .Machine$integer.max) ||
      (is.character(value) && grepl("^\\s*\\+?[0-9]+\\s*$", value) &&
         as.numeric(trimws(value)) < .Machine$integer.max)
  )
  if (!ok) {
    shown <- if (length(value) == 1L) format(value) else paste0("a vector of length ", length(value))
    .abort_bad_request("{.arg {what}} must be a non-negative whole number; got {shown}.", call = call)
  }
  as.integer(if (is.character(value)) as.numeric(trimws(value)) else value)
}

#' The ACB `editionId` of a season given by its END year (2027 -> 91).
#' @noRd
.acb_edition_id <- function(season, call = rlang::caller_env()) {
  s <- .acb_int(season, "season", call = call)
  if (s < .ACB_FIRST_SEASON) {
    .abort_bad_request("{.arg season} must be {(.ACB_FIRST_SEASON)} (1983-84, the first ACB season) or later; got {s}.",
                       call = call)
  }
  s - .ACB_EDITION_OFFSET
}

#' Validate the caller's params and convert them to the wire query (`season` becomes `editionId`).
#' @noRd
.acb_normalise <- function(path, params, call = rlang::caller_env()) {
  route <- .ACB_ROUTES[[path]]
  given <- Filter(Negate(is.null), params)
  unknown <- setdiff(names(given), c(route$required, route$optional))
  if (length(unknown)) .abort_bad_request("Unsupported parameter(s) for {path}: {.val {unknown}}.", call = call)
  missing <- setdiff(route$required, names(given))
  if (length(missing)) .abort_bad_request("{path} needs {.val {missing}}.", call = call)
  q <- list()
  for (k in names(given)) {
    v <- given[[k]]
    if (k == "season") {
      q[["editionId"]] <- .acb_edition_id(v, call = call)
    } else if (k %in% .ACB_INT_KEYS) {
      q[[k]] <- .acb_int(v, k, call = call)
    } else if (k == "isRoundSelected") {
      if (!(is.logical(v) && length(v) == 1L && !is.na(v))) {
        .abort_bad_request("{.arg is_round_selected} must be TRUE or FALSE.", call = call)
      }
      q[[k]] <- if (v) "true" else "false"
    } else if (k == "competitionIds") {
      if (!length(v) || is.list(v)) {
        .abort_bad_request("{.arg competition_ids} must be one or more whole numbers.", call = call)
      }
      q[[k]] <- vapply(v, .acb_int, integer(1), what = "competition_ids", call = call, USE.NAMES = FALSE)
    } else if (k == "searchTerm") {
      if (!(is.character(v) && length(v) == 1L && !is.na(v) && nzchar(trimws(v)))) {
        .abort_bad_request("{.arg search_term} must be a non-blank string.", call = call)
      }
      q[[k]] <- trimws(v)
    }
  }
  q
}

#' The request as the parsers read it (snake_case; `season` is the END year).
#' @noRd
.acb_stamp <- function(q) {
  names_map <- c(matchId = "match_id", playerLicense = "player_id", playerLicenceId = "player_id",
                 clubId = "club_id", competitionId = "competition_id", roundId = "round_id", weekId = "week_id",
                 searchTerm = "search_term")
  keep <- intersect(names(q), names(names_map))
  out <- stats::setNames(q[keep], unname(names_map[keep]))
  if (!is.null(q[["editionId"]])) {
    out[["edition_id"]] <- q[["editionId"]]
    out[["season"]] <- q[["editionId"]] + .ACB_EDITION_OFFSET
  }
  out
}

# ---------------------------------------------------------------------------
# Transport and key
# ---------------------------------------------------------------------------

#' One throttled, retried GET (429 / 5xx retried, 500 included); the httr2 response, unchecked.
#' @noRd
.acb_fetch <- function(url, query = list(), headers = NULL, call = rlang::caller_env()) {
  .intl_response(url, query = query, headers = headers, retry_500 = TRUE, call = call)
}

#' The key in the live acb.com bundle, or `NULL` when it cannot be read (any failure is the same answer).
#' @noRd
.acb_read_key_from_bundle <- function() {
  tryCatch({
    home <- .acb_fetch(.ACB_SITE)
    if (httr2::resp_status(home) != 200L) return(NULL)
    chunks <- unique(regmatches(.intl_body_text(home), gregexpr(.ACB_CHUNK_RE, .intl_body_text(home), perl = TRUE))[[1]])
    for (chunk in utils::head(chunks, .ACB_MAX_CHUNKS)) {
      js <- .acb_fetch(paste0(sub("/$", "", .ACB_SITE), chunk))
      if (httr2::resp_status(js) != 200L) next
      m <- regmatches(.intl_body_text(js), regexec(.ACB_KEY_RE, .intl_body_text(js), perl = TRUE))[[1]]
      if (length(m) == 2L) return(m[[2]])
    }
    NULL
  }, error = function(e) NULL)
}

#' `$ACB_API_KEY`, else the cached key, else the built-in one; `renew` re-reads the bundle.
#' @noRd
.acb_api_key <- function(renew = FALSE) {
  env <- trimws(Sys.getenv(.ACB_KEY_ENV, ""))
  if (nzchar(env)) return(env)
  if (renew) {
    .acb_key$value <- .acb_read_key_from_bundle() %||% .acb_key$value %||% .ACB_DEFAULT_KEY
  } else if (is.null(.acb_key$value)) {
    .acb_key$value <- .ACB_DEFAULT_KEY
  }
  .acb_key$value
}

#' 200 passes; 204 / 404 no_data; 400 / 422 bad_request; anything else asset_fetch.
#' @noRd
.acb_check_status <- function(resp, where, call = rlang::caller_env()) {
  status <- httr2::resp_status(resp)
  if (status == 200L) return(invisible(resp))
  if (status %in% c(204L, 404L)) {
    .abort_no_data("{where} answered HTTP {status}: nothing for this request.", status = status, call = call)
  }
  if (status %in% c(400L, 422L)) {
    .abort_bad_request("{where} rejected the request: HTTP {status}.", status = status, call = call)
  }
  .abort_asset_fetch("{where} answered HTTP {status}, not 200.", status = status,
                     transient = status %in% c(408L, 429L) || status >= 500L, call = call)
}

# ---------------------------------------------------------------------------
# Body checks
# ---------------------------------------------------------------------------

#' @noRd
.acb_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.acb_is_array <- function(x) is.list(x) && is.null(names(x))

#' Python's `_same`: type-strict equality of two JSON scalars (1L is not TRUE, "1" is not 1L, 1 is not 1L).
#' @noRd
.acb_same <- function(a, b) {
  length(a) == 1L && length(b) == 1L && !is.list(a) && !is.list(b) && typeof(a) == typeof(b) &&
    !is.na(a) && !is.na(b) && a == b
}

#' Every value at the dotted `path` (`[]` = each list element); `NULL` when a step is missing.
#' @noRd
.acb_pluck <- function(body, path) {
  vals <- list(body)
  for (part in strsplit(path, ".", fixed = TRUE)[[1]]) {
    each <- endsWith(part, "[]")
    key <- sub("\\[\\]$", "", part)
    nxt <- list()
    for (v in vals) {
      if (!.acb_is_dict(v) || !key %in% names(v)) return(NULL)
      x <- v[[key]]
      if (each) {
        if (!.acb_is_array(x) || !length(x)) return(NULL)
        nxt <- c(nxt, x)
      } else {
        nxt <- c(nxt, list(x))
      }
    }
    vals <- nxt
  }
  vals
}

#' The value at a dotted path (dicts only), or the `absent` marker when a key is missing.
#' @noRd
.acb_at <- function(body, path) {
  cur <- body
  for (k in strsplit(path, ".", fixed = TRUE)[[1]]) {
    if (!.acb_is_dict(cur) || !k %in% names(cur)) return(structure(list(), class = "acb_absent"))
    cur <- cur[[k]]
  }
  cur
}

#' @noRd
.acb_all_empty <- function(value, depth = 0L) {
  if (is.null(value) || (is.character(value) && length(value) == 1L && !nzchar(trimws(value)))) return(TRUE)
  if (is.list(value)) {
    return(depth > 50L || all(vapply(value, .acb_all_empty, logical(1), depth = depth + 1L)))
  }
  FALSE
}

#' Python's `_fold`: NFKD, combining marks dropped, lower case.
#' @noRd
.acb_fold <- function(x) {
  if (is.null(x) || is.list(x) || length(x) != 1L || is.na(x)) return("")
  x <- if (is.logical(x)) (if (x) "True" else "False") else as.character(x)
  stringi::stri_trans_tolower(stringi::stri_replace_all_regex(stringi::stri_trans_nfkd(x), "\\p{Mn}", ""))
}

#' @noRd
.acb_involves <- function(row, club, home, away) {
  at <- function(path) {
    cur <- row
    for (k in strsplit(path, ".", fixed = TRUE)[[1]]) cur <- if (.acb_is_dict(cur)) cur[[k]] else NULL
    cur
  }
  .acb_same(at(home), club) || .acb_same(at(away), club)
}

#' @noRd
.acb_rows_involve <- function(body, key, q, where, home, away, call) {
  for (r in body[[key]] %||% list()) {
    if (!(.acb_is_dict(r) && .acb_involves(r, q$clubId, home, away))) {
      .abort_asset_fetch("{where}: out of scope: a match without club {q$clubId}.", call = call)
    }
  }
}

#' @noRd
.acb_show <- function(x) {
  if (is.null(x)) return("None")
  if (is.list(x)) return("<object>")
  if (is.character(x)) return(paste0("'", x, "'"))
  format(x)
}

#' Refuse everything that is not this route's answer (sdv-py `_validate`).
#' @noRd
.acb_validate <- function(path, body, q, where, call = rlang::caller_env()) {
  route <- .ACB_ROUTES[[path]]
  if (!.acb_is_dict(body)) .abort_asset_fetch("{where}: the body is not an object.", call = call)
  if (length(body) && all(names(body) %in% .ACB_ERROR_KEYS)) {
    .abort_asset_fetch("{where}: the body is an error envelope.", call = call)
  }
  if (length(route$rows)) {
    vals <- lapply(route$rows, function(r) .acb_at(body, r))
    absent <- vapply(vals, inherits, logical(1), "acb_absent")
    rows_txt <- paste(route$rows, collapse = " / ")
    if (all(absent)) .abort_asset_fetch("{where}: not this route's shape ({rows_txt} missing).", call = call)
    filled <- vapply(vals, function(v) !inherits(v, "acb_absent") && !is.null(v) && !(is.list(v) && !length(v)),
                     logical(1))
    if (!any(filled)) .abort_no_data("{where}: the answer holds no rows ({rows_txt} is empty).", call = call)
  }
  if (.acb_all_empty(body)) .abort_asset_fetch("{where}: the body is an empty stub.", call = call)
  if (route$finished && identical(body[["matchFinished"]], FALSE)) {
    .abort_asset_fetch("{where}: the match is not finished (matchFinished is false); live data is partial.",
                       call = call)
  }
  for (sc in route$scope) {
    bpath <- sc[[1]]
    key <- sc[[2]]
    if (is.null(q[[key]])) next
    asked <- q[[key]]
    vals <- .acb_pluck(body, bpath)
    if (is.null(vals)) {
      .abort_asset_fetch("{where}: out of scope: {bpath} missing, asked for {key}={asked}.", call = call)
    }
    bad <- Filter(function(v) !.acb_same(v, asked), vals)
    if (length(bad)) {
      shown <- .acb_show(bad[[1]])
      .abort_asset_fetch("{where}: out of scope: {bpath}={shown}, asked for {key}={asked}.", call = call)
    }
  }
  if (path == "/seasondata/TeamProfile/team-matches") {
    .acb_rows_involve(body, "matches", q, where, "homeTeam.clubId", "awayTeam.clubId", call)
  } else if (path == "/seasondata/TeamProfile/next-matches") {
    .acb_rows_involve(body, "matches", q, where, "homeClubId", "awayClubId", call)
  } else if (path == "/seasondata/TeamProfile/team-records") {
    for (stat in names(body)) {
      rec <- body[[stat]]
      if (.acb_is_dict(rec) && !.acb_involves(rec, q$clubId, "localTeam.clubId", "visitorTeam.clubId")) {
        .abort_asset_fetch("{where}: out of scope: record '{stat}' is from a game without club {q$clubId}.",
                           call = call)
      }
    }
  } else if (path == "/seasondata/Search/search") {
    term <- .acb_fold(q$searchTerm)
    for (r in body[["players"]] %||% list()) {
      if (!.acb_is_dict(r)) next
      nm <- paste(vapply(c("nickname", "lastName", "firstInitialAndLastName", "firstName"),
                         function(k) .acb_fold(r[[k]]), character(1)), collapse = " ")
      if (!grepl(term, nm, fixed = TRUE)) {
        .abort_asset_fetch("{where}: out of scope: a player row does not match the search term.", call = call)
      }
    }
  } else if (path == "/matchdata/Menu/competition-data" && !is.null(q$competitionIds)) {
    ids <- unlist(lapply(body[["competitions"]] %||% list(), function(cp) {
      if (.acb_is_dict(cp) && is.integer(cp[["id"]]) && length(cp[["id"]]) == 1L) cp[["id"]]
    }))
    ids <- sort(unique(as.integer(ids)))
    wanted <- sort(unique(q$competitionIds))
    if (!all(wanted %in% ids)) {
      have <- paste(ids, collapse = ", ")
      want <- paste(wanted, collapse = ", ")
      .abort_asset_fetch("{where}: out of scope: competitions [{have}] lack the asked [{want}].", call = call)
    }
  }
  invisible(body)
}

# ---------------------------------------------------------------------------
# The getter
# ---------------------------------------------------------------------------

#' GET an ACB route, refuse every wrong answer, return the body with the request stamped.
#'
#' @param path The route under `https://api2.acb.com/api` (a key of `.ACB_ROUTES`).
#' @param params Named list of wire params (`matchId`, `clubId`, ..., `season` = END year); `NULL` dropped.
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The parsed body (a named list) with `_request` = the asked ids in snake_case.
#' @noRd
.acb_get <- function(path, params = list(), call = rlang::caller_env()) {
  if (!path %in% names(.ACB_ROUTES)) .abort_bad_request("Not an ACB route: {path}.", call = call)
  q <- .acb_normalise(path, params, call = call)
  url <- paste0(.ACB_API, path)
  where <- .intl_where(url)
  resp <- NULL
  for (renew in c(FALSE, TRUE)) { # one key re-read when the API rejects the key
    resp <- .acb_fetch(url, q, list(`X-APIKEY` = .acb_api_key(renew = renew), Accept = "application/json"),
                       call = call)
    if (httr2::resp_status(resp) != 401L || nzchar(trimws(Sys.getenv(.ACB_KEY_ENV, "")))) break
  }
  if (httr2::resp_status(resp) == 401L) {
    .abort_asset_fetch("{where} rejected the API key (HTTP 401) after a re-read of the bundle.", status = 401L,
                       call = call)
  }
  .acb_check_status(resp, where, call = call)
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  if (!grepl("json", ctype, fixed = TRUE) || grepl("problem+json", ctype, fixed = TRUE)) {
    shown <- if (nzchar(ctype)) ctype else "no content type"
    .abort_asset_fetch("{where} answered {shown}, not JSON.", call = call)
  }
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) .abort_asset_fetch("{where} answered HTTP 200 with an empty body.", call = call)
  body <- tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE), error = function(e) {
    .abort_asset_fetch("{where} answered a body that is not JSON.", call = call)
  })
  .acb_validate(path, body, q, where, call = call)
  body[["_request"]] <- .acb_stamp(q)
  body
}
