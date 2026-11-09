# ibba_segev.R -- the exported Segev Stats wrappers (the live stats behind basket.co.il).
# Generated from the sportsdataverse-py endpoint YAML and manual_column_descriptions.yaml, then kept by hand.

# The @details of every ibba topic that shares the ibba_segev_game_info() notes (roxygen @eval .intl_details()).
.ibba_segev_game_info_details <- c(
  "The `ibba_segev_*()` wrappers read Segev Stats, the live-stats vendor behind basket.co.il's",
  "game pages (`stats.segevstats.com/realtimestat_heb/api/`, a JSON-RPC API served as",
  "text/html): the game header, rosters, box score, period scores and play-by-play with shot",
  "coordinates, from 2025-26. They mirror sportsdataverse-py's `ibba_segev_*` wrappers of the same names:",
  "same arguments, the same snake_case columns and types, one row per sportsdataverse-py row.",
  "",
  "**Unofficial and unsupported.** The API is keyless, unofficial and not documented for",
  "outside use. Requests are spaced at least one second apart per host (429 / 502 / 503 / 504",
  "are retried three times, a 500 is not); only finished games are read.",
  "",
  "**Games and ids.** `game_id` is one flat Segev id space across seasons AND competitions",
  "(men's Winner League, Winner Cup, women's, Leumit, youth, school and pre-season games), so",
  "read `competition` from [ibba_segev_game_info()]. There is no game list: league game ids",
  "come from [ibba_games()] `segev_game_id` (2025-26 on; see [ibba_segev_game_crosswalk()]).",
  "Segev team and player ids are stable across seasons (Jaylen Hoard = player 1000 in games 50",
  "and 419), unlike the IBBA season registrations, and are not IBBA ids.",
  "",
  "**Play-by-play.** Actions name the player by Segev id and by JERSEY number, `score` reads",
  "away-home, and shot `x` / `y` are one half-court frame (x 0-1470 across, basket near 735;",
  "y out from the baseline, rim near 112-140); which sideline is x = 0 and the metric scale",
  "are unverified. Segev renamed its team game stats between 2025-26 and 2026-27; the frames",
  "unify them. `start_time` is the scheduled tip-off in Israel local time (POSIXct, tz",
  "Asia/Jerusalem; the feed carries no offset).",
  "",
  "**Errors** are classed conditions, never a warning plus an empty frame: `hoopR_no_data`",
  '(HTTP 404, "game not found", a finished game with no actions), `hoopR_bad_request` (HTTP',
  "400 / 422, or a `game_id` that is not a positive integer) and `hoopR_asset_fetch` (any",
  "other failure: another status, a transport error, an empty or non-JSON body, an error or",
  "changed envelope, a body for another game, a game that is not final). All inherit",
  "`hoopR_error`."
)

#' @title
#' **IBBA Segev Game Info**
#' @description
#' **Game header: tip-off, competition, both teams and the game state (scores are in the box
#'   score).**
#'
#' Endpoint: `GET https://stats.segevstats.com/realtimestat_heb/api/?method=getGameInfo`
#' @param game_id (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs Maccabi Tel
#'   Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.
#' @eval .intl_details(.ibba_segev_game_info_details, full = TRUE)
#' @eval .returns_rd("ibba_segev_game_info", inline = FALSE, unit = "game")
#' @family IBBA Segev Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_segev_game_info(game_id = 50))
#' }
ibba_segev_game_info <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .ibba_segev_get("getGameInfo", game_id, call = rlang::current_env())
  .ibba_segev_game_info_frame(raw)
}

#' @title
#' **IBBA Segev Rosters**
#' @description
#' **Both teams' game rosters with Segev player ids and names in English and Hebrew.**
#'
#' Endpoint: `GET https://stats.segevstats.com/realtimestat_heb/api/?method=getGameInfo`
#' @param game_id (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs Maccabi Tel
#'   Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.
#' @eval .intl_details(.ibba_segev_game_info_details, "ibba_segev_rosters(game_id = 50)")
#' @eval .returns_rd("ibba_segev_rosters", inline = FALSE, unit = "player on a game roster")
#' @family IBBA Segev Functions
#' @export
ibba_segev_rosters <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .ibba_segev_get("getGameInfo", game_id, call = rlang::current_env())
  .ibba_segev_rosters_frame(raw)
}

#' @title
#' **IBBA Segev Player Box**
#' @description
#' **Per-player box score of a finished game, plus a team-credited line per side.**
#'
#' Endpoint: `GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`
#' @param game_id (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs Maccabi Tel
#'   Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.
#' @eval .intl_details(.ibba_segev_game_info_details)
#' @eval .returns_rd("ibba_segev_player_box", inline = FALSE, unit = "player in the game")
#' @family IBBA Segev Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_segev_player_box(game_id = 50))
#' }
ibba_segev_player_box <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .ibba_segev_get("getBoxScore", game_id, call = rlang::current_env())
  .ibba_segev_player_box_frame(raw)
}

#' @title
#' **IBBA Segev Team Box**
#' @description
#' **Team totals of both sides: final score, timeouts, lead stats, shooting, rebounds and team game
#'   stats.**
#'
#' Endpoint: `GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`
#' @param game_id (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs Maccabi Tel
#'   Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.
#' @eval .intl_details(.ibba_segev_game_info_details)
#' @eval .returns_rd("ibba_segev_team_box", inline = FALSE, unit = "team in the game")
#' @family IBBA Segev Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_segev_team_box(game_id = 50))
#' }
ibba_segev_team_box <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .ibba_segev_get("getBoxScore", game_id, call = rlang::current_env())
  .ibba_segev_team_box_frame(raw)
}

#' @title
#' **IBBA Segev Period Scores**
#' @description
#' **Points and team fouls in each period of a finished game.**
#'
#' Endpoint: `GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`
#' @param game_id (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs Maccabi Tel
#'   Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.
#' @eval .intl_details(.ibba_segev_game_info_details, "ibba_segev_period_scores(game_id = 50)")
#' @eval .returns_rd("ibba_segev_period_scores", inline = FALSE, unit = "team and period")
#' @family IBBA Segev Functions
#' @export
ibba_segev_period_scores <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .ibba_segev_get("getBoxScore", game_id, call = rlang::current_env())
  .ibba_segev_period_scores_frame(raw)
}

#' @title
#' **IBBA Segev Play-by-Play**
#' @description
#' **Play-by-play of a finished game: every action with shot coordinates, running scores and jersey
#'   numbers.**
#'
#' Endpoint: `GET https://stats.segevstats.com/realtimestat_heb/api/?method=getActions`
#' @param game_id (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs Maccabi Tel
#'   Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.
#' @eval .intl_details(.ibba_segev_game_info_details)
#' @eval .returns_rd("ibba_segev_pbp", inline = FALSE, unit = "play-by-play event")
#' @family IBBA Segev Functions
#' @export
#' @examples
#' \donttest{
#'   try(ibba_segev_pbp(game_id = 50))
#' }
ibba_segev_pbp <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .ibba_segev_get("getActions", game_id, call = rlang::current_env())
  .ibba_segev_pbp_frame(raw)
}
