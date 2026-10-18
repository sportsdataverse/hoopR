# ibba_runtime.R -- transport for the IBBA families (Israeli Premier League), keyless.
#
# R mirror of sdv-py sportsdataverse/basketball/ibba/ibba_runtime.py (the ASMX web service,
# `ibba_*`) and ibba_segev_runtime.py (Segev Stats JSON-RPC, `ibba_segev_*`). Both go through
# the shared `.intl_response()` (at least one second per host on every attempt; 429 / 502 /
# 503 / 504 retried three times). A 500 is the hosts' deterministic error (the ASMX stack
# trace) and is NOT retried (`retry_500 = FALSE`).
#
# Refusals (fail closed, type-strict: the hosts send every value as a string, so an integer
# echo never matches):
#   ASMX   HTTP 404, an EMPTY 200 body (what an unknown id answers), an empty row list ->
#          hoopR_no_data. HTTP 400 / 422 or a malformed parameter -> hoopR_bad_request. Any
#          other non-200, a body that is not JSON (or not served as JSON), a body that is not
#          the op's single-key envelope, a row echoing another season / team / player / board
#          / game, and a box score that is not a finished two-team game -> hoopR_asset_fetch.
#   Segev  HTTP 404 and JSON-RPC code "-32000" (game not found), a finished game with no
#          actions -> hoopR_no_data. HTTP 400 / 422 or a bad game_id -> hoopR_bad_request.
#          Any other non-200, an empty or non-JSON body, another rpc error, success not
#          true, a body without the method's block, a gameId other than the one asked, an
#          unfinished game -> hoopR_asset_fetch. Segev serves its JSON as text/html.

.IBBA_HOST <- "https://basket.co.il/ws/ws.asmx"
.IBBA_SEGEV_URL <- "https://stats.segevstats.com/realtimestat_heb/api/"

#' op -> WSDL parameters in order and the single top-level list key of the body.
#' @noRd
.IBBA_OPS <- list(
  Configuration = list("cYear", "settings"),
  Boards = list("cYear", "boards"),
  BoardsEx = list(c("team_uid", "cYear"), "boards-ex"),
  Teams = list(c("board_id", "cYear"), "teams"),
  TeamById = list(c("team_id", "team_uid", "cYear"), "team"),
  Players = list(c("team_id", "team_uid", "cYear"), "players"),
  PlayerById = list(c("player_id", "cYear"), "player"),
  Coaches = list(c("team_id", "team_uid", "cYear"), "coaches"),
  Boxscore = list(c("game_id", "cYear"), "boxscore"),
  PlayerStatsById = list(c("player_id", "cYear", "isAverages", "isPlayOff"), "player"),
  StatsTypes = list(character(), "statsTypes"),
  LeaderByType = list(c("stat_type", "cYear", "team_id"), "leaders"),
  TeamStatsById = list(c("team_id", "cYear", "isAverages", "isPlayOff"), "team-stats"),
  Games = list(c("board_id", "board_round", "team_id", "team_uid", "game_id", "cYear"), "games"),
  GamesEx = list(c("board_id", "team_uid", "cYear"), "games_ex"),
  GamesByTeam = list(c("team_uid", "cYear"), "games")
)

#' op -> parameter -> the row field that echoes it (as a string). A parameter without an
#' echo (`team_uid` on the roster ops, the booleans, `stat_type`) cannot be checked.
#' @noRd
.IBBA_ECHO <- list(
  Configuration = c(cYear = "Current_Year"),
  Boards = c(cYear = "year_id"),
  Teams = c(board_id = "board", cYear = "year_id"),
  TeamById = c(team_id = "team_year_id", team_uid = "TeamUID", cYear = "year_id"),
  Players = c(team_id = "team_id", cYear = "year_id"),
  PlayerById = c(player_id = "player_id", cYear = "year_id"),
  Coaches = c(team_id = "team_id", cYear = "year_id"),
  Boxscore = c(game_id = "game_id", cYear = "year_id"),
  PlayerStatsById = c(player_id = "player_id", cYear = "year_id"),
  TeamStatsById = c(team_id = "team_id", cYear = "year_id"),
  LeaderByType = c(cYear = "Year", team_id = "team_id"),
  Games = c(board_id = "BOARD_ID", game_id = "game_id", cYear = "year_id"),
  GamesEx = c(board_id = "BOARD_ID", cYear = "year_id"),
  GamesByTeam = c(cYear = "year_id")
)

# ---------------------------------------------------------------------------
# Small JSON helpers (bodies are parsed with simplifyVector = FALSE)
# ---------------------------------------------------------------------------

#' A JSON object (a named list; `{}` parses to a named empty list).
#' @noRd
.ibba_is_dict <- function(x) is.list(x) && !is.null(names(x))

#' `x` when it is a JSON object, else an empty one.
#' @noRd
.ibba_dict <- function(x) if (.ibba_is_dict(x)) x else stats::setNames(list(), character())

#' The JSON objects of a JSON array (anything else is dropped).
#' @noRd
.ibba_dicts <- function(x) if (is.list(x) && is.null(names(x))) Filter(.ibba_is_dict, x) else list()

#' A length-one string.
#' @noRd
.ibba_is_str <- function(x) is.character(x) && length(x) == 1L && !is.na(x)

#' Python `repr()` of a scalar JSON value, for messages.
#' @noRd
.ibba_repr <- function(x) {
  if (is.null(x)) return("None")
  if (.ibba_is_str(x)) return(paste0("'", x, "'"))
  if (is.logical(x) && length(x) == 1L) return(if (isTRUE(x)) "True" else "False")
  if (is.atomic(x) && length(x) == 1L) return(as.character(x))
  "<object>"
}

# ---------------------------------------------------------------------------
# Parameters
# ---------------------------------------------------------------------------

#' One ASMX parameter as its wire string, validated (sdv-py `_normalise`).
#' @noRd
.ibba_wire <- function(op, name, v, call) {
  if (is.null(v)) .abort_bad_request("{op} needs {name}.", call = call)
  shown <- .ibba_repr(v)
  if (name %in% c("isAverages", "isPlayOff")) {
    if (!is.logical(v) || length(v) != 1L || is.na(v)) {
      .abort_bad_request("{name} must be a bool; got {shown}.", call = call)
    }
    return(if (v) "true" else "false")
  }
  if (name == "stat_type") {
    if (!.ibba_is_str(v) || !nzchar(trimws(v))) {
      .abort_bad_request("{name} must be a non-empty string; got {shown}.", call = call)
    }
    return(trimws(v))
  }
  ok <- length(v) == 1L && !is.logical(v) && !is.na(v) &&
    ((is.numeric(v) && is.finite(v) && v >= 0 && v == trunc(v)) ||
       (is.character(v) && grepl("^[0-9]+$", trimws(v))))
  if (!ok) .abort_bad_request("{name} must be a non-negative integer; got {shown}.", call = call)
  format(as.numeric(trimws(v)), scientific = FALSE, trim = TRUE)
}

#' A Segev `game_id`: a positive integer, as its wire string.
#' @noRd
.ibba_segev_game_id <- function(v, call) {
  ok <- length(v) == 1L && !is.logical(v) && !is.na(v) &&
    ((is.numeric(v) && is.finite(v) && v >= 1 && v == trunc(v)) ||
       (is.character(v) && grepl("^[0-9]+$", trimws(v)) && as.numeric(trimws(v)) >= 1))
  if (!ok) {
    shown <- .ibba_repr(v)
    .abort_bad_request("game_id must be a positive integer; got {shown}.", call = call)
  }
  format(as.numeric(trimws(v)), scientific = FALSE, trim = TRUE)
}

# ---------------------------------------------------------------------------
# ASMX
# ---------------------------------------------------------------------------

#' Why a `Boxscore` body is not a finished two-team game, or `NULL` when it looks final.
#'
#' Neither `Boxscore` nor `Games` carries a status field, so this is the sdv-py heuristic:
#' two teams, two TOTAL rows of `200 + 25 x overtimes` player-minutes, different scores.
#' @noRd
.ibba_box_final <- function(rows) {
  is_total <- vapply(rows, function(r) identical(r[["jersy"]], "TOTAL"), logical(1))
  totals <- rows[is_total]
  teams <- unique(vapply(rows, function(r) .ibba_repr(r[["team_id"]]), character(1)))
  total_teams <- unique(vapply(totals, function(r) .ibba_repr(r[["team_id"]]), character(1)))
  if (length(teams) != 2L || length(totals) != 2L || !setequal(total_teams, teams)) {
    return("not a two-team box score with two TOTAL rows")
  }
  for (t in totals) {
    m <- t[["minutes"]]
    minutes <- if (.ibba_is_str(m) && grepl("^\\s*[+-]?[0-9]+\\s*$", m)) {
      suppressWarnings(as.numeric(m))
    } else if (is.numeric(m) && length(m) == 1L && is.finite(m)) {
      trunc(m)
    } else {
      NA_real_
    }
    if (is.na(minutes)) return(sprintf("TOTAL minutes %s is not an integer", .ibba_repr(m)))
    if (minutes < 200 || minutes %% 25 != 0) {
      return(sprintf("the game is not final: TOTAL minutes %s is not 200 + 25 x overtimes",
                     format(minutes, scientific = FALSE)))
    }
  }
  if (identical(totals[[1]][["pts"]], totals[[2]][["pts"]])) {
    return(sprintf("the game is not final: tied at %s", .ibba_repr(totals[[1]][["pts"]])))
  }
  NULL
}

#' Why the rows are not the answer asked for (another season, team, ...), or `NULL`.
#' @noRd
.ibba_scope_error <- function(op, wire, rows) {
  echo <- .IBBA_ECHO[[op]]
  for (name in names(echo)) {
    if (identical(wire[[name]], "0")) next # 0 = "all" on this API
    field <- echo[[name]]
    for (r in rows) {
      if (!identical(r[[field]], wire[[name]])) {
        return(sprintf("out of scope: %s=%s, asked %s=%s", field, .ibba_repr(r[[field]]), name, wire[[name]]))
      }
    }
  }
  team <- wire[["team_id"]] %||% "0"
  if (op %in% c("Games", "GamesEx", "GamesByTeam") && team != "0") {
    has_team <- vapply(rows, function(r) {
      any(vapply(c("team1", "team2", "ig_team_1", "ig_team_2"), function(k) identical(r[[k]], team), logical(1)))
    }, logical(1))
    if (!all(has_team)) return(sprintf("out of scope: a game without team %s", team))
  }
  if (op == "Boxscore") return(.ibba_box_final(rows))
  NULL
}

#' GET one ASMX op, refuse every wrong answer, return its rows (a list of JSON objects).
#'
#' @param op The op (a name of `.IBBA_OPS`).
#' @param params Named list of the op's parameters by wire name.
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The non-empty list of row objects.
#' @noRd
.ibba_get <- function(op, params, call = rlang::caller_env()) {
  spec <- .IBBA_OPS[[op]]
  wire <- lapply(stats::setNames(spec[[1]], spec[[1]]), function(n) .ibba_wire(op, n, params[[n]], call))
  url <- paste0(.IBBA_HOST, "/", op)
  where <- .intl_where(url)
  resp <- .intl_response(url, query = wire, retry_500 = FALSE, call = call)
  .intl_check_status(resp, where = where, call = call)
  status <- httr2::resp_status(resp)
  if (status != 200L) .abort_asset_fetch("{where} answered HTTP {status}, not 200.", status = status, call = call)
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) {
    .abort_no_data("{where}: an empty 200 body (the host's answer for an unknown id).", call = call)
  }
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  if (!grepl("json", ctype, fixed = TRUE)) {
    shown <- if (nzchar(ctype)) ctype else "no content type"
    .abort_asset_fetch("{where} answered {shown}, not JSON.", call = call)
  }
  body <- tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE), error = function(e) NULL)
  if (is.null(body)) .abort_asset_fetch("{where} answered a body that is not JSON.", call = call)
  key <- spec[[2]]
  if (!.ibba_is_dict(body) || !identical(names(body), key)) {
    .abort_asset_fetch("{where}: not the {op} envelope (expected the single key '{key}').", call = call)
  }
  rows <- body[[key]]
  if (!is.list(rows) || !is.null(names(rows)) || !all(vapply(rows, .ibba_is_dict, logical(1)))) {
    .abort_asset_fetch("{where}: '{key}' is not a list of objects.", call = call)
  }
  if (!length(rows)) {
    asked <- paste(names(wire), unlist(wire), sep = "=", collapse = ", ")
    .abort_no_data("{where}: no rows for {asked}.", call = call)
  }
  why <- .ibba_scope_error(op, wire, rows)
  if (!is.null(why)) .abort_asset_fetch("{where}: {why}", call = call)
  rows
}

# ---------------------------------------------------------------------------
# Segev Stats
# ---------------------------------------------------------------------------

#' Refuse everything that is not this method's finished-game answer for `game_id`.
#' @noRd
.ibba_segev_validate <- function(method, game_id, body, where, call) {
  if (!.ibba_is_dict(body) || !all(c("result", "error") %in% names(body))) {
    .abort_asset_fetch("{where}: not a JSON-RPC envelope.", call = call)
  }
  err <- body[["error"]]
  if (!is.null(err)) {
    code <- if (.ibba_is_dict(err)) err[["code"]] else NULL
    if (identical(code, "-32000")) .abort_no_data("{where}: game {game_id} not found.", call = call)
    shown <- .ibba_repr(code)
    .abort_asset_fetch("{where}: rpc error code {shown}.", call = call)
  }
  result <- body[["result"]]
  if (!.ibba_is_dict(result) || !isTRUE(result[["success"]])) {
    .abort_asset_fetch("{where}: result.success is not true.", call = call)
  }
  if (method == "getBoxScore") {
    box <- result[["boxscore"]]
    info <- if (.ibba_is_dict(box)) box[["gameInfo"]] else NULL
    if (!.ibba_is_dict(box) || !.ibba_is_dict(box[["homeTeam"]]) || !.ibba_is_dict(box[["awayTeam"]])) {
      .abort_asset_fetch("{where}: no boxscore with two teams.", call = call)
    }
  } else {
    info <- result[["gameInfo"]]
  }
  if (!.ibba_is_dict(info)) .abort_asset_fetch("{where}: no gameInfo.", call = call)
  if (!identical(info[["gameId"]], game_id)) {
    shown <- .ibba_repr(info[["gameId"]])
    .abort_asset_fetch("{where}: out of scope: gameId={shown}, asked {game_id}.", call = call)
  }
  if (!isTRUE(info[["gameFinished"]])) {
    .abort_asset_fetch("{where}: game {game_id} is not final (gameFinished is not true).", call = call)
  }
  acts <- result[["actions"]]
  if (method == "getActions" && (is.null(acts) || !length(acts) || identical(acts, FALSE) ||
                                   identical(acts, 0L) || identical(acts, ""))) {
    .abort_no_data("{where}: game {game_id} has no actions.", call = call)
  }
  invisible(body)
}

#' GET one Segev method for one game, refuse every wrong answer, return the parsed envelope.
#'
#' @param method `"getGameInfo"`, `"getBoxScore"` or `"getActions"`.
#' @param game_id A positive integer Segev game id.
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The JSON-RPC envelope (a list).
#' @noRd
.ibba_segev_get <- function(method, game_id, call = rlang::caller_env()) {
  gid <- .ibba_segev_game_id(game_id, call)
  where <- .intl_where(.IBBA_SEGEV_URL)
  resp <- .intl_response(.IBBA_SEGEV_URL, query = list(method = method, game_id = gid), retry_500 = FALSE,
                         call = call)
  .intl_check_status(resp, where = where, call = call)
  status <- httr2::resp_status(resp)
  if (status != 200L) .abort_asset_fetch("{where} answered HTTP {status}, not 200.", status = status, call = call)
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) .abort_asset_fetch("{where} answered HTTP 200 with an empty body.", call = call)
  body <- tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE), error = function(e) NULL)
  if (is.null(body)) .abort_asset_fetch("{where} answered a body that is not JSON.", call = call)
  .ibba_segev_validate(method, gid, body, where, call)
}
