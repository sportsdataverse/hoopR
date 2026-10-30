# tpbl_runtime.R -- transport, season mapping and refusals of the TPBL wrappers.
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/tpbl/tpbl_runtime.py (origin/main e3d232ebc9).
#
# One host, keyless, no headers: the Laravel JSON API behind tpbl.basketball (https://api.tpbl.basketball/api).
#
# * Seasons: the public argument is the END year (2026 = 2025-26). The API keys a season by its own small
#   integer (1, 2, 3 = 2024-25, 2025-26, 2026-27; the event id of /events/{id}/* is the same number) and
#   labels it '2024-2025 <season in Chinese>'. The runtime reads /seasons once per session
#   (.tpbl_clear_cache()) and maps the END year to the row whose label ends in it, re-reading the list
#   once when the year is missing; a year the list lacks is hoopR_no_data.
# * HTTP 500: retried on every route (retry_500 = TRUE) EXCEPT the player game log, where an unknown
#   division_id answers 500 deterministically: that route fails after one request.
# * Finished games only: a game route first reads /games/{id} (cached) and refuses one that is not
#   COMPLETED and not live; the box score is checked against it (team ids in home / away order, final
#   scores, quarter count, player points).
# * Scope: a game list with a team of another season, a duplicate game, an inconsistent division or event
#   (and, with verify = TRUE, completed games per division that differ from the standings); a roster of
#   another team or event; a player game log of another player or division. The shot lists name no team
#   or player, so only their shape and court bounds are checked.
# * Errors: hoopR_no_data (HTTP 404, a season the API lacks, an empty list), hoopR_bad_request (a
#   non-integer id or season, HTTP 400 / 422, an invalid verify / rounds), hoopR_asset_fetch (any other
#   non-2xx, a non-JSON or error-envelope body, an unfinished game, every wrong-scope body).
# * sportsdataverse-py redacts birth-date and contact keys from the raw body it can return; no wrapper here returns a
#   raw body, and no parser reads such a key.

#' @noRd
.TPBL_API <- "https://api.tpbl.basketball/api"

#' Court bounds of a shot, in millimetres (a 28 m x 15 m court).
#' @noRd
.TPBL_COURT <- c(x = 28000L, y = 15000L)

#' @noRd
.TPBL_FINISHED <- "COMPLETED"

# Session cache: the season list and the detail of every finished game.
.tpbl_cache <- new.env(parent = emptyenv())

#' Forget the cached season list and game details.
#' @noRd
.tpbl_clear_cache <- function() {
  rm(list = ls(.tpbl_cache, all.names = TRUE), envir = .tpbl_cache)
  invisible(NULL)
}

# ---------------------------------------------------------------------------
# Shape helpers (Python isinstance semantics on jsonlite's simplifyVector = FALSE output)
# ---------------------------------------------------------------------------

#' A JSON object (a named list; `{}` included).
#' @noRd
.tpbl_is_obj <- function(x) is.list(x) && !is.null(names(x))

#' A JSON array.
#' @noRd
.tpbl_is_arr <- function(x) is.list(x) && is.null(names(x))

#' A JSON integer (never a logical, never a whole double).
#' @noRd
.tpbl_is_int <- function(x) is.integer(x) && length(x) == 1L && !is.na(x)

#' @noRd
.tpbl_at <- function(d, ...) {
  for (p in c(...)) {
    if (!.tpbl_is_obj(d)) return(NULL)
    d <- d[[p]]
  }
  d
}

#' The object rows of an array body.
#' @noRd
.tpbl_rows <- function(body) if (.tpbl_is_arr(body)) Filter(.tpbl_is_obj, body) else list()

#' Type-strict equality (TRUE is not 1L, "1" is not 1L); NULL never matches.
#' @noRd
.tpbl_same <- function(got, want) {
  !is.null(got) && !is.null(want) && length(got) == 1L && length(want) == 1L && !is.na(got) && !is.na(want) &&
    identical(typeof(got), typeof(want)) && got == want
}

#' Python repr-ish label of a JSON scalar for messages.
#' @noRd
.tpbl_show <- function(x) {
  if (is.null(x)) return("None")
  if (is.list(x)) return(if (.tpbl_is_obj(x)) "an object" else "a list")
  if (is.character(x)) return(paste0("'", x, "'"))
  as.character(x)
}

#' An id or season argument as an integer: a whole non-negative number or a digit string.
#' @noRd
.tpbl_int_arg <- function(value, what, call = rlang::caller_env()) {
  ok <- length(value) == 1L && !is.na(value) && !is.logical(value) && (
    (is.numeric(value) && value >= 0 && value == trunc(value) && value <= .Machine$integer.max) ||
      (is.character(value) && grepl("^[0-9]+$", trimws(value)) && nchar(trimws(value)) <= 9L))
  if (!isTRUE(ok)) {
    shown <- if (is.null(value)) "NULL" else paste(format(value), collapse = ", ")
    .abort_bad_request("{what} must be a positive integer; got {shown}.", call = call)
  }
  as.integer(if (is.character(value)) trimws(value) else value)
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' The parsed JSON of a route: 2xx, a JSON content type, a non-empty parseable body.
#' @noRd
.tpbl_json <- function(url, query = list(), retry_500 = TRUE, call = rlang::caller_env()) {
  resp <- .intl_response(url, query = query, retry_500 = retry_500, call = call)
  .intl_check_status(resp, call = call)
  where <- .intl_where(url)
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  if (!grepl("json", ctype, fixed = TRUE)) {
    got <- if (nzchar(ctype)) ctype else "no content type"
    .abort_asset_fetch("{where} answered {got}, not JSON.", call = call)
  }
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) .abort_asset_fetch("{where} answered HTTP 200 with an empty body.", call = call)
  .intl_json(text, where, call = call)
}

#' @noRd
.tpbl_refuse <- function(url, why, call) {
  if (!is.null(why)) {
    where <- .intl_where(url)
    .abort_asset_fetch("{where}: {why}", call = call)
  }
}

#' A JSON-array body (an object is an error envelope).
#' @noRd
.tpbl_list_body <- function(url, query = list(), retry_500 = TRUE, call = rlang::caller_env()) {
  body <- .tpbl_json(url, query, retry_500, call = call)
  if (!.tpbl_is_arr(body)) {
    where <- .intl_where(url)
    got <- if (.tpbl_is_obj(body)) "dict" else class(body)[[1]]
    .abort_asset_fetch("{where}: expected a JSON list, got {got} (error envelope?)", call = call)
  }
  body
}

#' @noRd
.tpbl_empty <- function(url, why = "the API answered an empty list", call) {
  where <- .intl_where(url)
  .abort_no_data("{where}: {why}", call = call)
}

# ---------------------------------------------------------------------------
# Seasons
# ---------------------------------------------------------------------------

#' END year of a season row from its label 'YYYY-YYYY ...' (the second year = the first + 1), or NA.
#' @noRd
.tpbl_season_end_year <- function(row) {
  name <- row[["name"]]
  if (!is.character(name) || length(name) != 1L) return(NA_integer_)
  m <- regmatches(name, regexec("^\\s*([0-9]{4})\\s*-\\s*([0-9]{4})", name, perl = TRUE))[[1]]
  if (!length(m) || as.integer(m[[3]]) != as.integer(m[[2]]) + 1L) return(NA_integer_)
  as.integer(m[[3]])
}

#' @noRd
.tpbl_seasons_error <- function(body) {
  good <- .tpbl_rows(body)
  if (!length(body) || length(good) != length(body)) return("seasons: rows are not objects")
  ids <- lapply(good, `[[`, "id")
  if (!all(vapply(ids, .tpbl_is_int, logical(1))) || anyDuplicated(unlist(ids))) {
    return("seasons: ids are not unique integers")
  }
  if (anyNA(vapply(good, .tpbl_season_end_year, integer(1))) ||
      !all(vapply(good, function(r) .tpbl_is_int(r[["gohoops_id"]]), logical(1)))) {
    return("seasons: a label is not 'YYYY-YYYY ...' or a row has no integer gohoops_id (layout drift)")
  }
  NULL
}

#' The checked /seasons body; caches its rows.
#' @noRd
.tpbl_seasons_body <- function(call) {
  url <- paste0(.TPBL_API, "/seasons")
  body <- .tpbl_list_body(url, call = call)
  .tpbl_refuse(url, .tpbl_seasons_error(body), call)
  assign("seasons", .tpbl_rows(body), envir = .tpbl_cache)
  body
}

#' The /seasons row whose label ends in `season` (re-reads the list once when it is missing).
#' @noRd
.tpbl_season_row <- function(season, call) {
  for (refresh in c(FALSE, TRUE)) {
    if (refresh || is.null(.tpbl_cache$seasons)) .tpbl_seasons_body(call)
    for (row in .tpbl_cache$seasons) {
      if (identical(.tpbl_season_end_year(row), season)) return(row)
    }
  }
  where <- .intl_where(paste0(.TPBL_API, "/seasons"))
  .abort_no_data("{where}: no TPBL season ends in {season} (2025 = 2024-25 is the first)", call = call)
}

# ---------------------------------------------------------------------------
# Season routes
# ---------------------------------------------------------------------------

#' @noRd
.tpbl_divisions_error <- function(body) {
  good <- .tpbl_rows(body)
  if (length(good) != length(body)) return("divisions: rows are not objects")
  if (anyDuplicated(lapply(good, `[[`, "id"))) return("divisions: duplicate division ids")
  if (length(unique(lapply(good, `[[`, "gohoops_event_id"))) > 1L) {
    return("divisions: rows name more than one GoHoops event")
  }
  NULL
}

#' @noRd
.tpbl_teams_error <- function(body) {
  good <- .tpbl_rows(body)
  if (length(good) != length(body) || anyDuplicated(lapply(good, `[[`, "id"))) {
    return("teams: rows are not unique objects")
  }
  NULL
}

#' @noRd
.tpbl_games_error <- function(body, season_row, team_id) {
  good <- .tpbl_rows(body)
  if (length(good) != length(body)) return("game list holds non-object rows")
  if (anyDuplicated(lapply(good, `[[`, "id"))) return("duplicate game ids")
  events <- list()
  divisions <- list()
  for (r in good) {
    gid <- .tpbl_show(r[["id"]])
    for (side in c("home_team", "away_team")) {
      if (!.tpbl_same(.tpbl_at(r, side, "gohoops_season_id"), season_row[["gohoops_id"]])) {
        return(sprintf("game %s %s is not in gohoops season %s", gid, side, season_row[["gohoops_id"]]))
      }
      events <- c(events, list(.tpbl_at(r, side, "gohoops_event_id")))
    }
    if (!.tpbl_is_int(r[["division_id"]]) || !.tpbl_is_int(r[["gohoops_division_id"]])) {
      return(sprintf("game %s has no integer division id", gid))
    }
    key <- as.character(r[["division_id"]])
    if (is.null(divisions[[key]])) divisions[[key]] <- r[["gohoops_division_id"]]
    if (divisions[[key]] != r[["gohoops_division_id"]]) {
      return(sprintf("division %s maps to two GoHoops divisions", key))
    }
    if (!is.null(team_id) && !any(vapply(c("home_team", "away_team"), function(s) {
      .tpbl_same(.tpbl_at(r, s, "id"), team_id)
    }, logical(1)))) {
      return(sprintf("game %s does not involve team %s", gid, team_id))
    }
  }
  if (length(unique(events)) > 1L) return("game list teams name more than one GoHoops event")
  NULL
}

#' @noRd
.tpbl_standings_error <- function(body) {
  good <- .tpbl_rows(body)
  if (length(good) != length(body)) return("standings hold non-object rows")
  ids <- lapply(good, function(r) .tpbl_at(r, "team", "id"))
  if (!all(vapply(ids, .tpbl_is_int, logical(1))) || anyDuplicated(unlist(ids))) {
    return("standings teams are not unique integer ids")
  }
  events <- list()
  for (r in good) {
    for (a in r[["against_result"]] %||% list()) {
      if (.tpbl_is_obj(a)) events <- c(events, list(.tpbl_at(a, "team", "gohoops_event_id")))
    }
  }
  if (length(unique(events)) > 1L) return("head-to-head teams name more than one GoHoops event")
  NULL
}

#' The checked standings rows of a division (possibly none).
#' @noRd
.tpbl_standings_rows <- function(division_id, call) {
  url <- sprintf("%s/divisions/%d/games/standings", .TPBL_API, division_id)
  body <- .tpbl_list_body(url, call = call)
  .tpbl_refuse(url, .tpbl_standings_error(body), call)
  .tpbl_rows(body)
}

#' @noRd
.tpbl_num0 <- function(x) if (is.numeric(x) && length(x) == 1L && !is.na(x)) x else 0

#' @noRd
.tpbl_played <- function(standings) {
  sum(vapply(standings, function(r) {
    .tpbl_num0(r[["score_won_matches"]]) + .tpbl_num0(r[["score_lost_matches"]]) +
      .tpbl_num0(r[["score_draw_matches"]])
  }, numeric(1)))
}

#' Completeness: every division's completed games == the matches of its own standings / 2.
#'
#' A division whose standings answer an empty list (the 2024-25 playoffs) is checked against the
#' team-filtered game lists instead: each team's games of that division must be the same ids in both.
#' @noRd
.tpbl_verify_games <- function(url, season_row, games, call) {
  sid <- season_row[["id"]]
  div_url <- sprintf("%s/events/%d/divisions", .TPBL_API, sid)
  div_body <- .tpbl_list_body(div_url, call = call)
  .tpbl_refuse(div_url, .tpbl_divisions_error(div_body), call)
  divs <- list()
  for (d in .tpbl_rows(div_body)) divs[[paste0("k", .tpbl_show(d[["id"]]))]] <- d
  keys <- vapply(games, function(g) .tpbl_show(g[["division_id"]]), character(1))
  for (key in sort(unique(keys), method = "radix")) {
    rows <- games[keys == key]
    div_id <- rows[[1]][["division_id"]]
    d <- divs[[paste0("k", key)]]
    if (is.null(d) || !.tpbl_same(d[["gohoops_id"]], rows[[1]][["gohoops_division_id"]])) {
      .tpbl_refuse(url, sprintf("games name division %s, which is not a division of season %s", key, sid), call)
    }
    standings <- .tpbl_standings_rows(div_id, call)
    if (length(standings)) {
      done <- sum(vapply(rows, function(g) identical(g[["status"]], .TPBL_FINISHED), logical(1)))
      if (.tpbl_played(standings) != 2 * done) {
        .tpbl_refuse(url, sprintf("division %s: %d completed games in the list but the standings count %s",
                                  key, done, format(.tpbl_played(standings) / 2)), call)
      }
      next
    }
    sides <- unlist(lapply(rows, function(g) list(.tpbl_at(g, "home_team", "id"), .tpbl_at(g, "away_team", "id"))))
    for (team in sort(unique(sides))) {
      tid <- .tpbl_int_arg(team, "team id", call = call)
      tl <- .tpbl_list_body(sprintf("%s/seasons/%d/games", .TPBL_API, sid), list(team_id = tid), call = call)
      theirs <- unlist(lapply(Filter(function(g) .tpbl_same(g[["division_id"]], div_id), .tpbl_rows(tl)),
                              function(g) g[["id"]]))
      ours <- unlist(lapply(Filter(function(g) {
        tid %in% unlist(list(.tpbl_at(g, "home_team", "id"), .tpbl_at(g, "away_team", "id")))
      }, rows), function(g) g[["id"]]))
      if (!setequal(theirs %||% integer(), ours %||% integer())) {
        .tpbl_refuse(url, sprintf("division %s: team %d's own game list differs from the season list", key, tid),
                     call)
      }
    }
  }
  invisible(NULL)
}

#' A season-keyed route: `kind` is "divisions", "teams" or "games".
#' @return `list(body = <rows>, req = <stamp>)`.
#' @noRd
.tpbl_season_route <- function(season, kind, team_id = NULL, verify = NULL, call) {
  season <- .tpbl_int_arg(season, "season", call = call)
  if (!is.null(team_id)) team_id <- .tpbl_int_arg(team_id, "team_id", call = call)
  if (kind == "games") { # validated before any request, the season mapping included
    if (!is.null(verify) && !(is.logical(verify) && length(verify) == 1L && !is.na(verify))) {
      .abort_bad_request("verify must be a bool; got {format(verify)}.", call = call)
    }
    if (isTRUE(verify) && !is.null(team_id)) {
      .abort_bad_request("verify = TRUE checks the whole season: it cannot be combined with team_id.", call = call)
    }
  }
  row <- .tpbl_season_row(season, call)
  sid <- row[["id"]]
  if (kind == "divisions") {
    url <- sprintf("%s/events/%d/divisions", .TPBL_API, sid)
    body <- .tpbl_list_body(url, call = call)
    .tpbl_refuse(url, .tpbl_divisions_error(body), call)
  } else if (kind == "teams") {
    url <- sprintf("%s/events/%d/teams", .TPBL_API, sid)
    body <- .tpbl_list_body(url, call = call)
    .tpbl_refuse(url, .tpbl_teams_error(body), call)
  } else {
    url <- sprintf("%s/seasons/%d/games", .TPBL_API, sid)
    body <- .tpbl_list_body(url, if (!is.null(team_id)) list(team_id = team_id) else list(), call = call)
    .tpbl_refuse(url, .tpbl_games_error(body, row, team_id), call)
    if (isTRUE(verify)) .tpbl_verify_games(url, row, .tpbl_rows(body), call)
  }
  if (!length(body)) .tpbl_empty(url, call = call)
  list(body = body, req = list(season = season, season_id = sid, gohoops_season_id = row[["gohoops_id"]]))
}

# ---------------------------------------------------------------------------
# Game routes
# ---------------------------------------------------------------------------

#' @noRd
.tpbl_game_error <- function(body, game_id) {
  if (!.tpbl_is_obj(body)) return("expected a JSON object, got list")
  if (!.tpbl_same(body[["id"]], game_id)) return(sprintf("game id %s is not %d", .tpbl_show(body[["id"]]), game_id))
  if (!identical(body[["status"]], .TPBL_FINISHED) || !identical(body[["is_live"]], FALSE)) {
    return(sprintf(paste0("game %d is not finished (status %s, is_live %s); ",
                          "TPBL game wrappers serve finished games only"),
                   game_id, .tpbl_show(body[["status"]]), .tpbl_show(body[["is_live"]])))
  }
  for (side in c("home_team", "away_team")) {
    if (!.tpbl_is_int(.tpbl_at(body, side, "id")) || !.tpbl_is_int(.tpbl_at(body, side, "won_score"))) {
      return(sprintf("%s has no integer id or final score", side))
    }
  }
  if (!.tpbl_is_int(body[["round"]]) || body[["round"]] < 4L) {
    return(sprintf("round %s is not a played game's quarter count", .tpbl_show(body[["round"]])))
  }
  NULL
}

#' The detail of a FINISHED game (cached per session); anything else raises.
#' @noRd
.tpbl_game <- function(game_id, call) {
  key <- as.character(game_id)
  games <- .tpbl_cache$games %||% list()
  if (is.null(games[[key]])) {
    url <- sprintf("%s/games/%d", .TPBL_API, game_id)
    body <- .tpbl_json(url, call = call)
    .tpbl_refuse(url, .tpbl_game_error(body, game_id), call)
    games[[key]] <- body
    assign("games", games, envir = .tpbl_cache)
  }
  games[[key]]
}

#' The final score of a box-score side: the running total of its highest-numbered quarter.
#' @noRd
.tpbl_final_score <- function(side) {
  rounds <- .tpbl_at(side, "teams", "rounds")
  if (!.tpbl_is_obj(rounds) || !length(rounds)) return(NULL)
  q <- suppressWarnings(as.integer(names(rounds)))
  if (anyNA(q) || !all(grepl("^\\s*[+-]?[0-9]+\\s*$", names(rounds)))) return(NULL)
  .tpbl_at(rounds[[which.max(q)]], "total_won_score")
}

#' @noRd
.tpbl_stats_error <- function(body, game) {
  if (!(.tpbl_is_obj(body) && .tpbl_is_obj(body[["home_team"]]) && .tpbl_is_obj(body[["away_team"]]))) {
    return("no home_team / away_team")
  }
  for (side in c("home_team", "away_team")) {
    if (!.tpbl_same(.tpbl_at(body, side, "id"), .tpbl_at(game, side, "id"))) {
      return(sprintf("%s.id %s is not the game's team %s (home/away order)", side,
                     .tpbl_show(.tpbl_at(body, side, "id")), .tpbl_show(.tpbl_at(game, side, "id"))))
    }
    final <- .tpbl_final_score(body[[side]])
    if (!.tpbl_same(final, .tpbl_at(game, side, "won_score"))) {
      return(sprintf("%s final score %s differs from the game detail %s", side, .tpbl_show(final),
                     .tpbl_show(.tpbl_at(game, side, "won_score"))))
    }
    rounds <- .tpbl_at(body, side, "teams", "rounds")
    if (!.tpbl_is_obj(rounds) || length(rounds) != game[["round"]]) {
      n <- if (.tpbl_is_obj(rounds)) length(rounds) else .tpbl_show(rounds)
      return(sprintf("%s has %s quarters, the game says %d", side, n, game[["round"]]))
    }
    players <- .tpbl_at(body, side, "players", "total")
    if (!.tpbl_is_obj(players) || !length(players)) return(sprintf("%s has no whole-game player lines", side))
    points <- sum(vapply(Filter(.tpbl_is_obj, players), function(p) .tpbl_num0(p[["score"]]), numeric(1)))
    if (points != final) {
      return(sprintf("%s players score %s points, the team final score is %s", side, format(points), final))
    }
  }
  NULL
}

#' A game route: the detail (`stats = FALSE`) or the checked box score.
#' @noRd
.tpbl_game_route <- function(game_id, stats, call) {
  game_id <- .tpbl_int_arg(game_id, "game id", call = call)
  game <- .tpbl_game(game_id, call)
  if (!stats) return(list(body = game, req = list(game_id = game_id)))
  url <- sprintf("%s/games/%d/stats", .TPBL_API, game_id)
  body <- .tpbl_json(url, call = call)
  .tpbl_refuse(url, .tpbl_stats_error(body, game), call)
  list(body = body, req = list(game_id = game_id, home_team_id = game$home_team$id,
                               away_team_id = game$away_team$id, periods = game$round))
}

# ---------------------------------------------------------------------------
# Division / player routes
# ---------------------------------------------------------------------------

#' @noRd
.tpbl_standings_route <- function(division_id, call) {
  division_id <- .tpbl_int_arg(division_id, "division id", call = call)
  rows <- .tpbl_standings_rows(division_id, call)
  if (!length(rows)) {
    .tpbl_empty(sprintf("%s/divisions/%d/games/standings", .TPBL_API, division_id),
                paste0("the division has no standings (a playoff bracket can answer an empty list); ",
                       "read its games from the season list instead"), call = call)
  }
  list(body = rows, req = list(division_id = division_id))
}

#' @noRd
.tpbl_roster_error <- function(body, team_id) {
  good <- .tpbl_rows(body)
  if (length(good) != length(body)) return("rows are not all objects")
  if (length(unique(lapply(good, `[[`, "gohoops_event_id"))) > 1L) {
    return("roster rows name more than one GoHoops event")
  }
  for (r in good) {
    if (!.tpbl_same(.tpbl_at(r, "team", "id"), team_id)) {
      return(sprintf("row %s is a player of team %s, not %d", .tpbl_show(r[["id"]]),
                     .tpbl_show(.tpbl_at(r, "team", "id")), team_id))
    }
    if (!.tpbl_same(.tpbl_at(r, "team", "gohoops_event_id"), r[["gohoops_event_id"]])) {
      return(sprintf("row %s team is not in the row's GoHoops event", .tpbl_show(r[["id"]])))
    }
  }
  NULL
}

#' @noRd
.tpbl_shots_error <- function(body) {
  for (s in body) {
    if (!.tpbl_is_obj(s) || !setequal(names(s), c("is_made", "point_x", "point_y", "offense_basket")) ||
        anyDuplicated(names(s))) {
      return("a shot row is not {is_made, point_x, point_y, offense_basket}")
    }
    ob <- s[["offense_basket"]]
    if (!(is.logical(s[["is_made"]]) && length(s[["is_made"]]) == 1L && !is.na(s[["is_made"]])) ||
        !(is.numeric(ob) && length(ob) == 1L && !is.na(ob) && ob %in% c(0, 1))) {
      return("a shot has a non-boolean is_made or an offense_basket other than 0 / 1")
    }
    x <- s[["point_x"]]
    y <- s[["point_y"]]
    if (!(.tpbl_is_int(x) && .tpbl_is_int(y) && x >= 0L && x <= .TPBL_COURT[["x"]] && y >= 0L &&
          y <= .TPBL_COURT[["y"]])) {
      return(sprintf("a shot lies outside the %d x %d mm court: (%s, %s)", .TPBL_COURT[["x"]], .TPBL_COURT[["y"]],
                     .tpbl_show(x), .tpbl_show(y)))
    }
  }
  NULL
}

#' Quarter filter: NULL, or the sorted unique quarter numbers (>= 1).
#' @noRd
.tpbl_rounds_arg <- function(value, call) {
  if (is.null(value)) return(NULL)
  items <- if (is.list(value)) value else as.list(value)
  out <- sort(unique(vapply(items, .tpbl_int_arg, integer(1), what = "rounds", call = call)))
  if (!length(out) || out[[1]] < 1L) {
    shown <- paste(format(value), collapse = ", ")
    .abort_bad_request("rounds must be quarter numbers (1 = first quarter); got {shown}.", call = call)
  }
  out
}

#' Roster ("players") or team shot list ("shooting-spots") of one team in one division.
#' @noRd
.tpbl_team_route <- function(division_id, team_id, what, rounds = NULL, call) {
  division_id <- .tpbl_int_arg(division_id, "division id", call = call)
  team_id <- .tpbl_int_arg(team_id, "team id", call = call)
  rounds <- if (what == "shooting-spots") .tpbl_rounds_arg(rounds, call) else NULL
  url <- sprintf("%s/divisions/%d/teams/%d/%s", .TPBL_API, division_id, team_id, what)
  body <- .tpbl_list_body(url, if (length(rounds)) list(`rounds[]` = rounds) else list(), call = call)
  if (what == "players") {
    .tpbl_refuse(url, .tpbl_roster_error(body, team_id), call)
    req <- list(division_id = division_id, team_id = team_id)
  } else {
    .tpbl_refuse(url, .tpbl_shots_error(body), call)
    req <- list(division_id = division_id, team_id = team_id, rounds = rounds)
  }
  if (!length(body)) .tpbl_empty(url, call = call)
  list(body = body, req = req)
}

#' @noRd
.tpbl_player_shots_route <- function(division_id, player_id, call) {
  division_id <- .tpbl_int_arg(division_id, "division id", call = call)
  player_id <- .tpbl_int_arg(player_id, "player id", call = call)
  url <- sprintf("%s/divisions/%d/players/%d/shooting-spots", .TPBL_API, division_id, player_id)
  body <- .tpbl_list_body(url, call = call)
  .tpbl_refuse(url, .tpbl_shots_error(body), call)
  if (!length(body)) .tpbl_empty(url, call = call)
  list(body = body, req = list(division_id = division_id, player_id = player_id))
}

#' @noRd
.tpbl_player_games_error <- function(body, player_id) {
  good <- .tpbl_rows(body)
  if (length(good) != length(body)) return("rows are not all objects")
  divisions <- list()
  for (r in good) {
    if (!.tpbl_same(.tpbl_at(r, "player", "id"), player_id)) {
      return(sprintf("a row is player %s, not %d", .tpbl_show(.tpbl_at(r, "player", "id")), player_id))
    }
    divisions <- c(divisions, list(.tpbl_at(r, "player", "gohoops_division_id")),
                   list(.tpbl_at(r, "game", "gohoops_division_id")))
  }
  if (length(unique(divisions)) > 1L || any(vapply(divisions, is.null, logical(1)))) {
    return("rows do not all name the same GoHoops division")
  }
  if (anyDuplicated(lapply(good, function(r) .tpbl_at(r, "game", "id")))) return("a game appears twice in the log")
  NULL
}

#' A player's game log in one division. HTTP 500 is NOT retried here: an unknown division_id answers it
#' deterministically.
#' @noRd
.tpbl_player_games_route <- function(player_id, division_id, call) {
  player_id <- .tpbl_int_arg(player_id, "player id", call = call)
  if (is.null(division_id)) {
    .abort_bad_request("tpbl_player_games needs division_id (the API answers HTTP 422 without it).", call = call)
  }
  division_id <- .tpbl_int_arg(division_id, "division_id", call = call)
  url <- sprintf("%s/players/%d/games/stats", .TPBL_API, player_id)
  body <- tryCatch(
    .tpbl_list_body(url, list(division_id = division_id), retry_500 = FALSE, call = call),
    hoopR_asset_fetch = function(e) {
      if (!identical(e$status, 500L)) rlang::cnd_signal(e)
      where <- .intl_where(url)
      .abort_asset_fetch(
        "{where}: HTTP 500 (an unknown division_id answers 500 deterministically; it is not retried)",
        status = 500L, call = call
      )
    }
  )
  .tpbl_refuse(url, .tpbl_player_games_error(body, player_id), call)
  if (!length(body)) .tpbl_empty(url, sprintf("the player has no games in division %d", division_id), call = call)
  list(body = body, req = list(player_id = player_id, division_id = division_id))
}
