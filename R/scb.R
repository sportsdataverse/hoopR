# scb.R -- BBL and DBBL (Germany) wrappers over the SCB API, at parity with sportsdataverse-py
# sportsdataverse/basketball/scb (origin/main e3d232e). One API on two hosts:
# api.basketball-bundesliga.de (BBL, men) and api-1.dbbl.scb.world (DBBL, women); `league`
# picks the host. Transport and refusals: R/scb_runtime.R; frames: R/scb_parsers.R.

# The @details of every scb topic that shares the scb_seasons() notes (roxygen @eval .intl_details()).
.scb_seasons_details <- c(
  "* Unofficial use of a public source: these wrappers read the front-end API of the German Bundesliga sites",
  "  (easycredit-bbl.de, toyota-dbbl.de), run by SCB.",
  "* Legal notice: the BBL Impressum forbids storing BBL content (`Inhalte`) in an information system without",
  "  BBL's written permission. That is a copyright term, not a robots rule (the API host has no robots.txt).",
  "  Check it before you store or republish the data, and keep requests slow (the runtime waits at least 1 s per",
  "  host). The DBBL host is the same operator and API.",
  "* Both hosts need two headers: a constant `x-api-key` and an `x-api-secret` that rotates. The runtime",
  "  derives the secret on first use from the key embedded in an easycredit-bbl.de page (reversed, `:` turned",
  "  into `-`) and never logs or returns it. The derivation was reverse-engineered from observed requests and",
  "  responses and has not been checked against the site's own front-end code; if the site changes how it",
  "  signs requests, every call fails with `hoopR_asset_fetch`.",
  "* Id key spaces: seasonId is the START year (2025 = 2025-26), so a wrapper's END-year `season` is sent as",
  "  `season - 1`. Teams are keyed by teamId (seasonTeamId equals it in every sample). seasonPlayerId is per",
  "  player per season and per club (a player traded mid-season has two); realPlayerId is the person. playerId",
  "  is ambiguous (the seasonPlayerId in box scores, records and /season-players; the person in /transfers).",
  "  Game ids are strings.",
  '* Errors are classed conditions: `hoopR_no_data` (404, 204, a 400 "not a valid" id, no rows, a box score of',
  "  a game not yet started), `hoopR_bad_request` (a bad argument, another 400 / 422) and `hoopR_asset_fetch`",
  "  (a refused secret after one re-derive, any other non-2xx, an HTML / non-JSON / error-shaped body, a",
  "  truncated page, a body for another game, season, club or league, a box score still in play), all",
  "  inheriting `hoopR_error`. Wrappers raise; they never return an empty frame."
)

#' @title
#' **Get BBL / DBBL Seasons**
#' @description
#' Seasons, newest first, with the active flag (BBL back to 1966, DBBL 2024 on).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/seasons` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.scb_seasons_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(scb_seasons())
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_seasons <- function(league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/seasons"),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_seasons(raw, .scb_columns$seasons), "BBL/DBBL Seasons from the SCB API")
}

#' @title
#' **Get BBL / DBBL Season Players**
#' @description
#' Every player registered in a season: the id crosswalk (season_player_id, real_player_id, season_team_id).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param season (required) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its START-year
#'   seasonId (season - 1).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_season_players", inline = FALSE, unit = "player")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_season_players(season = 2026))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_season_players <- function(season, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/seasons/", .scb_season_id(season)),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_season_players(raw, .scb_columns$season_players), "BBL/DBBL Season Players from the SCB API")
}

#' @title
#' **Get BBL / DBBL Season Teams**
#' @description
#' Every team of a season: club id, season-team id, name and three-letter code.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param season (required) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its START-year
#'   seasonId (season - 1).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_season_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_season_teams(season = 2026))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_season_teams <- function(season, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/seasons/", .scb_season_id(season)),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_season_teams(raw, .scb_columns$season_teams), "BBL/DBBL Season Teams from the SCB API")
}

#' @title
#' **Get BBL / DBBL Playoff Series**
#' @description
#' Playoff bracket of a season: one row per series (quarter-finals, semi-finals, finals).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}/playoff-tree` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param season (required) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its START-year
#'   seasonId (season - 1).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_playoff_series", inline = FALSE, unit = "series")
#' @eval .intl_details(.scb_seasons_details, "scb_playoff_series(season = 2026)")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_playoff_series <- function(season, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/seasons/", .scb_season_id(season), "/playoff-tree"),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_playoff_series(raw, .scb_columns$playoff_series), "BBL/DBBL Playoff Series from the SCB API")
}

#' @title
#' **Get BBL / DBBL Playoff Games**
#' @description
#' Every playoff game of a season with its series and the points of each series team.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}/playoff-tree` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param season (required) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its START-year
#'   seasonId (season - 1).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_playoff_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.scb_seasons_details, "scb_playoff_games(season = 2026)")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_playoff_games <- function(season, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/seasons/", .scb_season_id(season), "/playoff-tree"),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_playoff_games(raw, .scb_columns$playoff_games), "BBL/DBBL Playoff Games from the SCB API")
}

#' @title
#' **Get BBL / DBBL Season Player Statistics**
#' @description
#' Season player stat table: totals and per-game values, one row per player and stat block.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}/player-statistics` (DBBL: the same
#'   route on `https://api-1.dbbl.scb.world`).
#' @param season (required) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its START-year
#'   seasonId (season - 1).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @param display_type (default `"MAIN_ROUND"`) Which games the table covers: MAIN_ROUND (regular season),
#'   PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS or CUP.
#' @eval .returns_rd("scb_player_statistics", inline = FALSE, unit = "player and stat block")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_player_statistics(season = 2026))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_player_statistics <- function(season, league = "bbl", display_type = "MAIN_ROUND") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  .scb_check_choice(display_type, .SCB_DISPLAY_TYPES, "display_type")
  raw <- .scb_get(
    paste0(.SCB_BASE, "/seasons/", .scb_season_id(season), "/player-statistics"),
    list(league = league, displayType = display_type),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_player_statistics(raw, .scb_columns$player_statistics), "BBL/DBBL Season Player Statistics from the SCB API")
}

#' @title
#' **Get BBL / DBBL Season Team Statistics**
#' @description
#' Season team stat table: totals and per-game values, one row per team and stat block.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}/team-statistics` (DBBL: the same route
#'   on `https://api-1.dbbl.scb.world`).
#' @param season (required) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its START-year
#'   seasonId (season - 1).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @param display_type (default `"MAIN_ROUND"`) Which games the table covers: MAIN_ROUND (regular season),
#'   PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS or CUP.
#' @eval .returns_rd("scb_team_statistics", inline = FALSE, unit = "team and stat block")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_team_statistics(season = 2026))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_team_statistics <- function(season, league = "bbl", display_type = "MAIN_ROUND") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  .scb_check_choice(display_type, .SCB_DISPLAY_TYPES, "display_type")
  raw <- .scb_get(
    paste0(.SCB_BASE, "/seasons/", .scb_season_id(season), "/team-statistics"),
    list(league = league, displayType = display_type),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_team_statistics(raw, .scb_columns$team_statistics), "BBL/DBBL Season Team Statistics from the SCB API")
}

#' @title
#' **Get BBL / DBBL Games**
#' @description
#' Games of a season (the whole season in one page): teams, score by period, officials, venue and top scorer.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/games` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @param season (default `NULL`) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its
#'   START-year seasonId (season - 1). Omitted = the season in progress.
#' @param competition (default `NULL`) Competition filter: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the
#'   BBL host; DBBL, DBBL_CUP on the DBBL host. Omitted = all. The other host's competition answers an empty
#'   page.
#' @param game_type (default `NULL`) Finished, scheduled or all games. Omitted = all.
#' @param team_id (default `NULL`) Only the games of this team, home or guest (the club id equals the
#'   season-team id).
#' @param page_size (default `500`) Rows per page. The wrapper reads page 1 and refuses a result that needs
#'   more pages, so keep it large enough for the whole result (500 covers a season).
#' @eval .returns_rd("scb_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_games())
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_games <- function(league = "bbl", season = NULL, competition = NULL, game_type = NULL, team_id = NULL,
                      page_size = 500) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  .scb_check_choice(game_type, c("finished", "scheduled", "all"), "game_type", null_ok = TRUE)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/games"),
    list(
      currentPage = 1L, league = league, seasonId = .scb_season_id(season),
      competition = competition, gameType = game_type, seasonTeamId = team_id, pageSize = page_size
    ),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_games(raw, .scb_columns$games), "BBL/DBBL Games from the SCB API")
}

#' @title
#' **Get BBL / DBBL Recent Games**
#' @description
#' Recent, live and upcoming games, one row per game with its past / present / future bucket.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/games/recent` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @param slot_size (default `NULL`) Games per bucket (past, present, future); the API's default is 9.
#' @eval .returns_rd("scb_games_recent", inline = FALSE, unit = "game")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_games_recent())
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_games_recent <- function(league = "bbl", slot_size = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/games/recent"),
    list(league = league, slotSize = slot_size),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_games_recent(raw, .scb_columns$games_recent), "BBL/DBBL Recent Games from the SCB API")
}

#' @title
#' **Get BBL / DBBL Game**
#' @description
#' One game header: teams, score by period, officials, venue and top scorer.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/games/{game_id}` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param game_id (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or 10130 (DBBL). One
#'   sequence per league.
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_game", inline = FALSE, unit = "game")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_game(game_id = "2006920"))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_game <- function(game_id, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/games/", .scb_id(game_id, "game_id")),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_games(raw, .scb_columns$game), "BBL/DBBL Game from the SCB API")
}

#' @title
#' **Get BBL / DBBL Game Player Box Score**
#' @description
#' Box score of a finished game: one row per player line of both teams (2002-03 on).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param game_id (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or 10130 (DBBL). One
#'   sequence per league.
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_game_players", inline = FALSE, unit = "player line of both teams")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_game_players(game_id = "2006920"))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_game_players <- function(game_id, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/games/", .scb_id(game_id, "game_id"), "/stats"),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_game_players(raw, .scb_columns$game_players), "BBL/DBBL Game Player Box Score from the SCB API")
}

#' @title
#' **Get BBL / DBBL Game Team Box Score**
#' @description
#' Box score of a finished game: one row per team, with the head coach and the team line.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param game_id (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or 10130 (DBBL). One
#'   sequence per league.
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_game_teams", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_game_teams(game_id = "2006920"))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_game_teams <- function(game_id, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/games/", .scb_id(game_id, "game_id"), "/stats"),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_game_teams(raw, .scb_columns$game_teams), "BBL/DBBL Game Team Box Score from the SCB API")
}

#' @title
#' **Get BBL / DBBL Game Play-by-Play**
#' @description
#' Play-by-play of a finished game with shot x/y (BBL 2008-09 on, DBBL 2024-25 on).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param game_id (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or 10130 (DBBL). One
#'   sequence per league.
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_game_actions", inline = FALSE, unit = "play-by-play event")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_game_actions(game_id = "2006920"))
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_game_actions <- function(game_id, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/games/", .scb_id(game_id, "game_id"), "/stats"),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_game_actions(raw, .scb_columns$game_actions), "BBL/DBBL Game Play-by-Play from the SCB API")
}

#' @title
#' **Get BBL / DBBL Standings**
#' @description
#' League table of a season: record, home / away split, streaks and tie-break detail (2005-06 on).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/standings` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @param season (default `NULL`) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its
#'   START-year seasonId (season - 1). Omitted = the season in progress. Seasons before about 2000 answer an
#'   empty table.
#' @param competition (default `NULL`) Competition: BBL, BBL_CUP, ALLSTAR, CHAMPIONS_CUP (BBL host) or DBBL,
#'   DBBL_CUP (DBBL host). BBL_CUP answers an empty table.
#' @eval .returns_rd("scb_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_standings())
#' }
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_standings <- function(league = "bbl", season = NULL, competition = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/standings"),
    list(league = league, seasonId = .scb_season_id(season), competition = competition),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_standings(raw, .scb_columns$standings), "BBL/DBBL Standings from the SCB API")
}

#' @title
#' **Get BBL / DBBL Season Player Profile**
#' @description
#' Player profile by season-player id: bio, position, club and previous clubs.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/season-players/{season_player_id}` (DBBL: the same
#'   route on `https://api-1.dbbl.scb.world`).
#' @param season_player_id (required) Season-player id (`season_player_id` in a box score, an action or
#'   `scb_season_players`): one player's engagement with one club.
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_season_player", inline = FALSE, unit = "season-player")
#' @eval .intl_details(.scb_seasons_details, 'scb_season_player(season_player_id = "56414")')
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_season_player <- function(season_player_id, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/season-players/", .scb_id(season_player_id, "season_player_id")),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_season_player(raw, .scb_columns$season_player), "BBL/DBBL Season Player Profile from the SCB API")
}

#' @title
#' **Get BBL / DBBL Team Profile**
#' @description
#' Club profile: names, code, home page, ticket shop, year joined and honours.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/teams/{team_id}` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param team_id (required) Club id (`team_id` in `scb_season_teams`), e.g. 413 (ALBA BERLIN).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_team", inline = FALSE, unit = "club")
#' @eval .intl_details(.scb_seasons_details, 'scb_team(team_id = "413")')
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_team <- function(team_id, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/teams/", .scb_id(team_id, "team_id")),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_team(raw, .scb_columns$team), "BBL/DBBL Team Profile from the SCB API")
}

#' @title
#' **Get BBL / DBBL Team Seasons**
#' @description
#' Every season a club played: its name that season and its championship and cup titles.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/teams/{team_id}` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param team_id (required) Club id (`team_id` in `scb_season_teams`), e.g. 413 (ALBA BERLIN).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_team_seasons", inline = FALSE, unit = "team-season")
#' @eval .intl_details(.scb_seasons_details, 'scb_team_seasons(team_id = "413")')
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_team_seasons <- function(team_id, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/teams/", .scb_id(team_id, "team_id")),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_team_seasons(raw, .scb_columns$team_seasons), "BBL/DBBL Team Seasons from the SCB API")
}

#' @title
#' **Get BBL Referees**
#' @description
#' Current referees and commissioners (BBL only).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/referees`
#' @param page_size (default `100`) Rows per page. 100 returns all current officials in one page; a result
#'   that needs more pages is refused.
#' @eval .returns_rd("scb_referees", inline = FALSE, unit = "official")
#' @eval .intl_details(.scb_seasons_details, "scb_referees()")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_referees <- function(page_size = 100) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .scb_get(
    paste0(.SCB_BASE, "/referees"),
    list(currentPage = 1L, pageSize = page_size),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_referees(raw, .scb_columns$referees), "BBL/DBBL Referees from the SCB API")
}

#' @title
#' **Get BBL Transfers**
#' @description
#' Latest transfers, one row per move (BBL only).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/transfers`
#' @eval .returns_rd("scb_transfers", inline = FALSE, unit = "move")
#' @eval .intl_details(.scb_seasons_details, "scb_transfers()")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_transfers <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .scb_get(
    paste0(.SCB_BASE, "/transfers"),
    list(),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_transfers(raw, .scb_columns$transfers), "BBL/DBBL Transfers from the SCB API")
}

#' @title
#' **Get BBL Team Transfers**
#' @description
#' Per club, the players joining and leaving, one row per move with its direction (BBL only).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/transfers/teams`
#' @eval .returns_rd("scb_transfers_teams", inline = FALSE, unit = "move with its direction")
#' @eval .intl_details(.scb_seasons_details, "scb_transfers_teams()")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_transfers_teams <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .scb_get(
    paste0(.SCB_BASE, "/transfers/teams"),
    list(),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_transfers_teams(raw, .scb_columns$transfers_teams), "BBL/DBBL Team Transfers from the SCB API")
}

#' @title
#' **Get BBL Team Rosters**
#' @description
#' Per club, the current roster, one row per player (BBL only).
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/transfers/teams`
#' @eval .returns_rd("scb_team_rosters", inline = FALSE, unit = "player")
#' @eval .intl_details(.scb_seasons_details, "scb_team_rosters()")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_team_rosters <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .scb_get(
    paste0(.SCB_BASE, "/transfers/teams"),
    list(),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_team_rosters(raw, .scb_columns$team_rosters), "BBL/DBBL Team Rosters from the SCB API")
}

#' @title
#' **Get BBL / DBBL Single-Game Records**
#' @description
#' Single-game records: the season's and the all-time ones, one row per record.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/records/per-game/{season}` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param season (required) Season END year (2026 = 2025-26, the sdv key). Sent to the API as its START-year
#'   seasonId (season - 1).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_records_per_game", inline = FALSE, unit = "single-game record")
#' @eval .intl_details(.scb_seasons_details, "scb_records_per_game(season = 2026)")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_records_per_game <- function(season, league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/records/per-game/", .scb_season_id(season)),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_records_per_game(raw, .scb_columns$records_per_game), "BBL/DBBL Single-Game Records from the SCB API")
}

#' @title
#' **Get BBL / DBBL Season-Average Records**
#' @description
#' All-time season-average records (points, rebounds, assists, ...), one row per record.
#'
#' Endpoint: `GET https://api.basketball-bundesliga.de/records/season-averages` (DBBL: the same route on
#'   `https://api-1.dbbl.scb.world`).
#' @param league (default `"bbl"`) League: `bbl` (men, easyCredit Basketball Bundesliga,
#'   api.basketball-bundesliga.de) or `dbbl` (women, Toyota Damen-Basketball-Bundesliga,
#'   api-1.dbbl.scb.world). The two share one API; game ids overlap, so a game is (league, game_id).
#' @eval .returns_rd("scb_records_season_averages", inline = FALSE, unit = "season-average record")
#' @eval .intl_details(.scb_seasons_details, "scb_records_season_averages()")
#' @export
#' @concept SCB Functions
#' @seealso [family_scb] lists every function in this family.
scb_records_season_averages <- function(league = "bbl") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .scb_check_league(league)
  raw <- .scb_get(
    paste0(.SCB_BASE, "/records/season-averages"),
    list(league = league),
    call = rlang::current_env()
  )
  .scb_out(.scb_parse_records_season_averages(raw, .scb_columns$records_season_averages), "BBL/DBBL Season-Average Records from the SCB API")
}
