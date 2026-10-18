# scb_runtime.R -- transport for the BBL / DBBL wrappers (the SCB API on two hosts, one set of routes).
#
# R mirror of sdv-py sportsdataverse/basketball/scb/scb_runtime.py (origin/main e3d232e):
#
# * Two headers on every request: `x-api-key: publicWebUser` (a constant) and `x-api-secret`, the
#   `"key":"..."` value embedded in an https://www.easycredit-bbl.de/ page, reversed, with every `:`
#   turned into `-`. The key rotates, so it is scraped once per R session and again after a 401 / 403
#   (at most one re-derive per request). Neither value is ever printed, logged, returned or put in a
#   condition; an echo of either in a body is replaced with `<redacted>` before the body is read. A
#   page value that is not 32-256 characters of `[A-Za-z0-9:_-]` is not the API key (a React `key`).
#   API requests carry the secret, so they never follow a redirect (`follow_redirects = FALSE`).
# * Throttle and retries: `.intl_response()` (>= 1 s per host on every attempt, the key page
#   included); scb retries HTTP 500 (`retry_500 = TRUE`, the sdv-py policy). 403 is not retried by
#   the transport: here it is a refused secret, handled by the re-derive.
# * Seasons: the API's `seasonId` is the START year; the public `season` is the END year, mapped by
#   `.scb_season_id()` (`season - 1`).
# * Paging: `/games` and `/referees` are read as page 1 with a large `pageSize`; a body whose
#   `totalPages` is not exactly 1 is refused (`hoopR_asset_fetch`: raise `page_size`).
# * Refusals: 404, 204, a 400 "not a valid ..." id, `[]`, a page with no items, an empty bracket or
#   recent-games set -> `hoopR_no_data`; any other 400 / 422 or a bad argument -> `hoopR_bad_request`;
#   401 / 403 after one re-derive, any other non-2xx, an HTML / non-JSON body, an error envelope, a
#   truncated page, a wrong-scope body (another game, season, club, or a competition of the other
#   host) and a box score still in play (`LIVE`) -> `hoopR_asset_fetch`. A box score of a game not
#   yet started (`PRE`) is `hoopR_no_data`.
# * Stamped request: bodies do not all say which host or season they answer, so the request is added
#   under `_request` (`list(league =, season =, display_type =)`; on each row of a list body, at the
#   top of an object body), and the parsers turn it into `league` / `season` columns.

#' @noRd
.SCB_HOSTS <- c(bbl = "https://api.basketball-bundesliga.de", dbbl = "https://api-1.dbbl.scb.world")
#' @noRd
.SCB_BASE <- .SCB_HOSTS[["bbl"]]
#' The competitions each host may answer with; the other host's competition is a wrong-scope body.
#' @noRd
.SCB_HOST_COMPETITIONS <- list(
  bbl = c("BBL", "BBL_CUP", "ALLSTAR", "CHAMPIONS_CUP"),
  dbbl = c("DBBL", "DBBL_CUP")
)
#' @noRd
.SCB_KEY_PAGE <- "https://www.easycredit-bbl.de/"
#' @noRd
.SCB_API_KEY <- "publicWebUser"
#' @noRd
.SCB_REQUEST <- "_request"
#' @noRd
.SCB_REDACTED <- "<redacted>"
#' @noRd
.SCB_DISPLAY_TYPES <- c("MAIN_ROUND", "PLAYOFFS", "PLAYOFFS_TOTAL", "MAIN_ROUND_AND_PLAY_OFFS", "CUP")

# the page key and the derived secret, once per session
.scb_auth <- new.env(parent = emptyenv())

#' JSON object (a named list, `{}` included) vs JSON array (an unnamed list).
#' @noRd
.scb_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.scb_is_array <- function(x) is.list(x) && is.null(names(x))

#' Python truthiness of a parsed JSON value (`None`, `[]`, `{}`, `""`, `0`, `False` are false).
#' @noRd
.scb_truthy <- function(x) {
  if (is.null(x) || !length(x)) return(FALSE)
  if (is.atomic(x) && length(x) == 1L) {
    if (is.na(x)) return(FALSE)
    if (is.logical(x)) return(x)
    if (is.character(x)) return(nzchar(x))
    if (is.numeric(x)) return(x != 0)
  }
  TRUE
}

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------

#' @noRd
.scb_check_league <- function(league, call = rlang::caller_env()) {
  if (!is.character(league) || length(league) != 1L || is.na(league) || !league %in% names(.SCB_HOSTS)) {
    shown <- if (is.character(league) && length(league) == 1L) league else class(league)[[1]]
    .abort_bad_request("{.arg league} must be one of {.val bbl} or {.val dbbl}; got {.val {shown}}.", call = call)
  }
  invisible(league)
}

#' @noRd
.scb_check_choice <- function(x, choices, arg, null_ok = FALSE, call = rlang::caller_env()) {
  if (null_ok && is.null(x)) return(invisible(x))
  if (!is.character(x) || length(x) != 1L || is.na(x) || !x %in% choices) {
    .abort_bad_request("{.arg {arg}} must be one of {.val {choices}}.", call = call)
  }
  invisible(x)
}

#' The API's `seasonId` (START year) for an END-year `season`; `NULL` stays `NULL`.
#'
#' sdv-py `scb_runtime.season_id()`: `season - 1` (2026 -> 2025, the 2025-26 season).
#' @param season END year: a whole positive number or a digit string.
#' @return Integer, or `NULL`.
#' @noRd
.scb_season_id <- function(season, call = rlang::caller_env()) {
  if (is.null(season)) return(NULL)
  ok <- length(season) == 1L && !is.na(season) && !is.logical(season) &&
    ((is.numeric(season) && season == trunc(season) && season >= 1) ||
       (is.character(season) && grepl("^[0-9]+$", season) && as.numeric(season) >= 1))
  if (!ok) {
    .abort_bad_request("{.arg season} must be an END year such as 2026 (2025-26).", call = call)
  }
  as.integer(season) - 1L
}

#' A path id (game, club, season-player) as text.
#' @noRd
.scb_id <- function(x, arg, call = rlang::caller_env()) {
  if (length(x) != 1L || is.na(x) || !(is.character(x) || is.numeric(x)) || !nzchar(as.character(x))) {
    .abort_bad_request("{.arg {arg}} must be one id, such as {.val 2006920}.", call = call)
  }
  as.character(x)
}

# ---------------------------------------------------------------------------
# Credentials
# ---------------------------------------------------------------------------

#' The `x-api-secret` for a page key: reversed, every `:` turned into `-`.
#' @noRd
.scb_derive_secret <- function(key, call = rlang::caller_env()) {
  if (!is.character(key) || length(key) != 1L || !grepl("^[A-Za-z0-9:_-]{32,256}$", key, perl = TRUE)) {
    .abort_asset_fetch("The easycredit-bbl.de page key has an unexpected length or character set.", call = call)
  }
  gsub(":", "-", paste(rev(strsplit(key, "", fixed = TRUE)[[1]]), collapse = ""), fixed = TRUE)
}

#' The first `"key":"..."` value on the page that looks like the API key (not a React `key`).
#'
#' The page is matched with a regex after one unescape pass (`\"` -> `"`), so a key inside a
#' JSON-escaped script payload is found too.
#' @noRd
.scb_page_key <- function(html, call = rlang::caller_env()) {
  html <- gsub('\\"', '"', html %||% "", fixed = TRUE)
  hits <- regmatches(html, gregexpr('"key":"[^"]+"', html, perl = TRUE))[[1]]
  vals <- substr(hits, 8L, nchar(hits) - 1L)
  vals <- vals[grepl("^[A-Za-z0-9:_-]{32,256}$", vals, perl = TRUE)]
  if (!length(vals)) {
    page <- .SCB_KEY_PAGE
    .abort_asset_fetch("No API-shaped page key on {page}: the page layout changed.", call = call)
  }
  vals[[1]]
}

#' Scrape the page key (throttled like any other request; it carries no credential header).
#' @noRd
.scb_fetch_key <- function(call = rlang::caller_env()) {
  resp <- .intl_response(.SCB_KEY_PAGE, headers = list(Accept = "text/html"), retry_500 = TRUE, call = call)
  status <- httr2::resp_status(resp)
  if (status < 200 || status >= 300) {
    where <- .intl_where(.SCB_KEY_PAGE)
    .abort_asset_fetch("{where} answered HTTP {status}: the API key could not be read.", status = status,
                       transient = status %in% c(408L, 429L) || status >= 500, call = call)
  }
  .scb_page_key(.intl_body_text(resp), call = call)
}

#' The two auth headers; the key is scraped once per session, and again when `refresh`.
#' @noRd
.scb_headers <- function(refresh = FALSE, call = rlang::caller_env()) {
  if (refresh || is.null(.scb_auth$secret)) {
    key <- .scb_fetch_key(call = call)
    secret <- .scb_derive_secret(key, call = call)
    .scb_auth$key <- key
    .scb_auth$secret <- secret
  }
  list(`x-api-key` = .SCB_API_KEY, `x-api-secret` = .scb_auth$secret, Accept = "application/json")
}

#' `text` with the page key and the derived secret (if known) replaced by `<redacted>`.
#' @noRd
.scb_redact <- function(text) {
  for (value in c(.scb_auth$key, .scb_auth$secret)) {
    if (nzchar(value)) text <- gsub(value, .SCB_REDACTED, text, fixed = TRUE)
  }
  text
}

# ---------------------------------------------------------------------------
# Request
# ---------------------------------------------------------------------------

#' @noRd
.SCB_ROUTES <- c(
  games_recent = "^/games/recent/?$",
  game_stats = "^/games/([^/]+)/stats/?$",
  game = "^/games/([^/]+)/?$",
  games = "^/games/?$",
  playoff_tree = "^/seasons/([0-9]+)/playoff-tree/?$",
  player_statistics = "^/seasons/([0-9]+)/player-statistics/?$",
  team_statistics = "^/seasons/([0-9]+)/team-statistics/?$",
  season = "^/seasons/([0-9]+)/?$",
  seasons = "^/seasons/?$",
  standings = "^/standings/?$",
  season_player = "^/season-players/([^/]+)/?$",
  team = "^/teams/([^/]+)/?$",
  referees = "^/referees/?$",
  transfers_teams = "^/transfers/teams/?$",
  transfers = "^/transfers/?$",
  records_per_game = "^/records/per-game/([0-9]+)/?$",
  records_season_averages = "^/records/season-averages/?$"
)

#' `list(route, id)` of a request URL; `list("", NULL)` for a path outside the table.
#' @noRd
.scb_route <- function(url) {
  path <- httr2::url_parse(url)$path
  for (name in names(.SCB_ROUTES)) {
    m <- regmatches(path, regexec(.SCB_ROUTES[[name]], path, perl = TRUE))[[1]]
    if (length(m)) return(list(route = name, id = if (length(m) > 1L) m[[2]] else NULL))
  }
  list(route = "", id = NULL)
}

#' GET with the auth headers; one re-derive of the secret when the host refuses it.
#' @noRd
.scb_send <- function(url, query, call) {
  for (attempt in 1:2) {
    resp <- .intl_response(url, query = query, headers = .scb_headers(refresh = attempt == 2L, call = call),
                           retry_500 = TRUE, follow_redirects = FALSE, call = call)
    status <- httr2::resp_status(resp)
    if (!status %in% c(401L, 403L)) return(resp)
  }
  where <- .intl_where(url)
  .abort_asset_fetch(
    "{where} refused the derived x-api-secret (HTTP {status}) after a re-derive: the page key may have rotated, or the host blocks this address.",
    status = status, call = call
  )
}

#' Every `competition` string in a body; the walk stops at depth 50.
#' @noRd
.scb_competitions <- function(node, depth = 0L) {
  if (depth > 50L || !is.list(node)) return(character())
  own <- node[["competition"]]
  own <- if (.scb_is_dict(node) && is.character(own) && length(own) == 1L) own else character()
  c(own, unlist(lapply(unname(node), .scb_competitions, depth = depth + 1L), use.names = FALSE))
}

#' Type-strict equality: an integer is compared to an integer, a string to a string.
#' @noRd
.scb_is <- function(got, want) {
  !is.null(got) && !is.null(want) && identical(class(got), class(want)) && length(got) == 1L &&
    !is.na(got) && got == want
}

#' @noRd
.scb_repr <- function(x) {
  if (is.null(x)) return("NULL")
  if (is.character(x) && length(x) == 1L) return(paste0("'", x, "'"))
  if (is.atomic(x) && length(x) == 1L) return(as.character(x))
  "<object>"
}

#' Raise on one of the API's 200-with-an-error shapes.
#' @noRd
.scb_error <- function(where, body, call) {
  if (is.character(body)) {
    excerpt <- substr(body[[1]], 1L, 80L)
    .abort_asset_fetch("{where} answered an error string: {excerpt}", call = call)
  }
  if (.scb_is_dict(body) &&
      (identical(body[["status"]], "error") ||
         (length(body) && all(names(body) %in% c("status", "error", "message", "statusCode"))))) {
    excerpt <- substr(as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null")), 1L, 120L)
    .abort_asset_fetch("{where} answered an error envelope: {excerpt}", call = call)
  }
  invisible()
}

#' No rows: `[]`, a page without items, a bracket or recent-games set with nothing in it, a null object.
#' @noRd
.scb_is_empty <- function(route, body) {
  if (.scb_is_array(body)) return(!length(body))
  if (!.scb_is_dict(body) || !length(body)) return(TRUE)
  if ("items" %in% names(body)) return(!.scb_truthy(body[["items"]]))
  if (route == "games_recent") {
    return(!any(vapply(c("present", "future", "past"), function(k) .scb_truthy(body[[k]]), logical(1))))
  }
  if (route == "playoff_tree") {
    return(!(.scb_truthy(body[["quarterFinals"]]) || .scb_truthy(body[["semiFinals"]]) ||
               .scb_truthy(body[["finals"]])))
  }
  FALSE
}

#' Refuse a paged body that is not the whole result (`totalPages` must be exactly 1).
#' @noRd
.scb_truncated <- function(where, body, call) {
  if (.scb_is_dict(body) && "items" %in% names(body) && !.scb_is(body[["totalPages"]], 1L)) {
    pages <- .scb_repr(body[["totalPages"]])
    current <- .scb_repr(body[["currentPage"]])
    .abort_asset_fetch(
      "{where}: truncated page (totalPages={pages}, currentPage={current}); raise page_size so the whole result fits one page.",
      call = call
    )
  }
  invisible()
}

#' Raise unless a body that names its scope answers the request.
#' @noRd
.scb_scope <- function(where, route, path_id, query, league, body, call) {
  seen <- unique(.scb_competitions(body))
  foreign <- sort(setdiff(seen, .SCB_HOST_COMPETITIONS[[league]]))
  if (length(foreign)) {
    .abort_asset_fetch("{where}: out of scope: competition {.val {foreign}} on the {league} host.", call = call)
  }
  if (route %in% c("games", "game", "game_stats", "standings") && !length(seen)) {
    .abort_asset_fetch("{where}: out of scope: no competition field to check against the {league} host.", call = call)
  }
  rows <- if (.scb_is_dict(body) && "items" %in% names(body)) body[["items"]] else if (.scb_is_array(body)) body else list(body)
  field <- function(r, key) if (.scb_is_dict(r)) r[[key]] else NULL
  start <- if (!is.null(query[["seasonId"]])) as.integer(query[["seasonId"]]) else NULL
  name <- NULL
  if (route %in% c("games", "standings") && !is.null(start)) {
    name <- "seasonId"; want <- start; got <- lapply(rows, field, "seasonId")
  } else if (route %in% c("game", "season_player", "team")) {
    name <- "id"; want <- path_id; got <- lapply(rows, field, "id")
  } else if (route == "game_stats") {
    name <- "gameId"; want <- path_id; got <- lapply(rows, field, "gameId")
  } else if (route %in% c("season", "playoff_tree")) {
    name <- if (route == "season") "id" else "seasonId"
    want <- as.integer(path_id %||% 0L); got <- lapply(rows, field, name)
  } else if (route == "team_statistics") {
    name <- "seasonTeam.seasonId"; want <- as.integer(path_id %||% 0L)
    got <- lapply(rows, function(r) field(field(r, "seasonTeam"), "seasonId"))
  } else if (route == "records_per_game") {
    name <- "seasonId"; want <- path_id; got <- lapply(rows, field, "seasonId")
  }
  for (g in if (is.null(name)) list() else got) {
    if (!.scb_is(g, want)) {
      shown <- .scb_repr(g)
      asked <- .scb_repr(want)
      .abort_asset_fetch("{where}: out of scope: {name}={shown}, asked for {asked}.", call = call)
    }
  }
  invisible()
}

#' A box score exists only once the game is over: PRE has nothing yet, LIVE is not final.
#' @noRd
.scb_status_gate <- function(where, route, body, call) {
  if (route != "game_stats" || !.scb_is_dict(body)) return(invisible())
  status <- body[["status"]]
  if (identical(status, "PRE")) {
    .abort_no_data("{where}: the game has not started (status PRE), so it has no box score yet.", call = call)
  }
  if (identical(status, "LIVE")) {
    .abort_asset_fetch("{where}: the game is in play (status LIVE); its box score is not final.", call = call)
  }
  invisible()
}

#' Add the request under `_request` (on each row of a list body, at the top of an object).
#' @noRd
.scb_stamp <- function(body, request) {
  if (.scb_is_dict(body)) {
    body[[.SCB_REQUEST]] <- request
  } else if (is.list(body)) {
    body <- lapply(body, function(r) {
      if (.scb_is_dict(r)) r[[.SCB_REQUEST]] <- request
      r
    })
  }
  body
}

#' GET a BBL / DBBL route as parsed JSON: authenticate, refuse the empty / error / out-of-scope
#' answers, stamp the request.
#'
#' @param url Request URL built against the BBL host; `query$league = "dbbl"` swaps the host.
#' @param query Named list of query parameters; `NULL` entries are dropped. `league` (`"bbl"` default
#'   or `"dbbl"`) picks the host and is never sent.
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The parsed body (`jsonlite::parse_json(simplifyVector = FALSE)`), stamped under `_request`.
#' @noRd
.scb_get <- function(url, query = list(), call = rlang::caller_env()) {
  query <- Filter(Negate(is.null), query)
  league <- query[["league"]] %||% "bbl"
  query[["league"]] <- NULL
  .scb_check_league(league, call = call)
  if (startsWith(url, .SCB_BASE)) url <- paste0(.SCB_HOSTS[[league]], substring(url, nchar(.SCB_BASE) + 1L))
  where <- .intl_where(url)
  rt <- .scb_route(url)
  resp <- .scb_send(url, query, call)
  status <- httr2::resp_status(resp)
  text <- .scb_redact(.intl_body_text(resp))
  if (status == 204L) .abort_no_data("{where} answered HTTP 204: no content for this id.", status = status, call = call)
  if (status == 400L && grepl("not a valid", text, fixed = TRUE)) {
    excerpt <- substr(trimws(text), 1L, 60L)
    .abort_no_data("{where} answered 400 {excerpt}: no such record.", status = status, call = call)
  }
  if (status == 404L) .abort_no_data("{where} answered HTTP 404.", status = status, call = call)
  excerpt <- substr(gsub("\\s+", " ", text), 1L, 200L)
  if (status %in% c(400L, 422L)) {
    .abort_bad_request("{where} rejected the request: HTTP {status}: {excerpt}", status = status, call = call)
  }
  if (status < 200 || status >= 300) {
    .abort_asset_fetch("{where} answered HTTP {status}: {excerpt}", status = status,
                       transient = status %in% c(408L, 429L) || status >= 500, call = call)
  }
  body <- if (status == 205L) stats::setNames(list(), character()) else .intl_json(text, where, call = call)
  .scb_error(where, body, call)
  if (.scb_is_empty(rt$route, body)) .abort_no_data("{where}: the API answered no rows.", call = call)
  .scb_truncated(where, body, call)
  .scb_scope(where, rt$route, rt$id, query, league, body, call)
  .scb_status_gate(where, rt$route, body, call)
  request <- list(league = league)
  start <- query[["seasonId"]] %||%
    (if (rt$route %in% c("playoff_tree", "player_statistics", "team_statistics", "season", "records_per_game")) rt$id)
  if (!is.null(start)) request$season <- as.integer(start) + 1L
  if (!is.null(query[["displayType"]])) request$display_type <- query[["displayType"]]
  .scb_stamp(body, request)
}
