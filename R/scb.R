# scb.R -- BBL and DBBL (Germany) wrappers over the SCB API, at parity with sdv-py
# sportsdataverse/basketball/scb (origin/main e3d232e). One API on two hosts:
# api.basketball-bundesliga.de (BBL, men) and api-1.dbbl.scb.world (DBBL, women); `league`
# picks the host. Transport and refusals: R/scb_runtime.R; frames: R/scb_parsers.R.

# The @details of every scb topic that shares the scb_seasons() notes (roxygen @eval .intl_details()).
.scb_seasons_details <- c(
  "* Unofficial use of a public source: these wrappers read the front-end API of the German Bundesliga sites",
  "  (easycredit-bbl.de, toyota-dbbl.de), run by SCB; payloads are not redistributed as release assets.",
  "* Legal notice: the BBL Impressum forbids storing BBL content (`Inhalte`) in an information system without",
  "  BBL's written permission. That is a copyright term, not a robots rule (the API host has no robots.txt).",
  "  The owner reviewed it and accepted the intake (2026-10-12 ruling); keep requests slow (the runtime waits",
  "  at least 1 s per host) and raise any published data release with the owner. The DBBL host is the same",
  "  operator and API; its site notice was not separately reviewed.",
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
#' @return
#' A `hoopR_data` tibble: Seasons, newest first, with the active flag (BBL back to 1966, DBBL 2024 on). An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
#' | is_active | logical | True for the season in progress. |
#' @eval .intl_details(.scb_seasons_details)
#' @examples
#' \donttest{
#'   try(scb_seasons())
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Every player registered in a season: the id crosswalk (season_player_id,
#'   real_player_id, season_team_id). An empty valid answer raises `hoopR_no_data`; the columns are always
#'   these, in this order (sdv-py `scb_season_players`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
#' | real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_season_players(season = 2026))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Every team of a season: club id, season-team id, name and three-letter code. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_season_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
#' | team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | team_name | character | Team name as listed that season (sponsor names included). |
#' | tlc | character | Three-letter club code. |
#' | logo_url | character | Logo image URL (per season). |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_season_teams(season = 2026))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Playoff bracket of a season: one row per series (quarter-finals, semi-finals,
#'   finals). An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order
#'   (sdv-py `scb_playoff_series`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | round | character | Round of the bracket: `quarter_finals`, `semi_finals` or `finals`. |
#' | series | integer | 1-based position of the series within its round, in the order the API lists them. |
#' | match_winner_id | character | Season-team id of the series winner, a string (the playoff tree sends an integer). |
#' | is_match_finished | logical | The series is decided. |
#' | team_a_id | character | Season-team id of series team A (the higher seed is A), a string (the playoff tree sends it as an integer); equals the club team id. |
#' | team_a_name | character | Name of series team A (the higher seed is A) as listed that season. |
#' | team_a_tlc | character | Three-letter club code of series team A (the higher seed is A). |
#' | team_a_rank | integer | Regular-season table position (the seed) of series team A (the higher seed is A). |
#' | team_a_victories | integer | Series wins of team A. |
#' | team_b_id | character | Season-team id of series team B (the higher seed is A), a string (the playoff tree sends it as an integer); equals the club team id. |
#' | team_b_name | character | Name of series team B (the higher seed is A) as listed that season. |
#' | team_b_tlc | character | Three-letter club code of series team B (the higher seed is A). |
#' | team_b_rank | integer | Regular-season table position (the seed) of series team B (the higher seed is A). |
#' | team_b_victories | integer | Series wins of team B. |
#' | games | integer | Games of the series. |
#' @eval .intl_details(.scb_seasons_details, "scb_playoff_series(season = 2026)")
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Every playoff game of a season with its series and the points of each series team.
#'   An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_playoff_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
#' | round | character | Round of the bracket: `quarter_finals`, `semi_finals` or `finals`. |
#' | series | integer | 1-based position of the game's series within its round, in the order the API lists them. |
#' | game_id | character | Game id, a string (the playoff tree sends an integer); joins `scb_games.game_id`. |
#' | scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
#' | timestamp | integer | Tip-off, Unix seconds. |
#' | game_winner_id | character | Season-team id of the game winner, a string (the playoff tree sends an integer). |
#' | home_team_id | character | Season-team id of the home team, a string (the playoff tree sends an integer). |
#' | guest_team_id | character | Season-team id of the guest (away) team, a string (the playoff tree sends an integer). |
#' | team_a_id | character | Season-team id of the series' team A (the higher seed); `points_team_a` is its score, whichever side hosted. |
#' | team_b_id | character | Season-team id of the series' team B; `points_team_b` is its score, whichever side hosted. |
#' | points_team_a | integer | Team A's points in the game. |
#' | points_team_b | integer | Team B's points in the game. |
#' @eval .intl_details(.scb_seasons_details, "scb_playoff_games(season = 2026)")
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Season player stat table: totals and per-game values, one row per player and stat
#'   block. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_player_statistics`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | display_type | character | Which games the table covers, echoed from the request (MAIN_ROUND, PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS or CUP). |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
#' | real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | shirt_number | character | Jersey number of the player, kept as text so a `00` jersey survives. |
#' | position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
#' | team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | team_tlc | character | Three-letter club code. |
#' | season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
#' | round_code | integer | Provider round code; 1 for MAIN_ROUND in every sample (mapping unverified). |
#' | competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
#' | seconds_played | integer | The player's season total playing time in SECONDS over displayType. |
#' | points | integer | The player's season total points over displayType. |
#' | two_point_shots_made | integer | The player's season total 2-point field goals made over displayType. |
#' | two_point_shots_attempted | integer | The player's season total 2-point field goals attempted over displayType. |
#' | two_point_shot_success_percent | double | The player's season total 2-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | three_point_shots_made | integer | The player's season total 3-point field goals made over displayType. |
#' | three_point_shots_attempted | integer | The player's season total 3-point field goals attempted over displayType. |
#' | three_point_shot_success_percent | double | The player's season total 3-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | field_goals_made | integer | The player's season total field goals made over displayType. |
#' | field_goals_attempted | integer | The player's season total field goals attempted over displayType. |
#' | field_goals_success_percent | double | The player's season total field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | free_throws_made | integer | The player's season total free throws made over displayType. |
#' | free_throws_attempted | integer | The player's season total free throws attempted over displayType. |
#' | free_throws_success_percent | double | The player's season total free-throw percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | offensive_rebounds | integer | The player's season total offensive rebounds over displayType. |
#' | defensive_rebounds | integer | The player's season total defensive rebounds over displayType. |
#' | total_rebounds | integer | The player's season total rebounds (offensive + defensive) over displayType. |
#' | assists | integer | The player's season total assists over displayType. |
#' | steals | integer | The player's season total steals over displayType. |
#' | turnovers | integer | The player's season total turnovers over displayType. |
#' | blocks | integer | The player's season total blocked shots over displayType. |
#' | fouls_committed | integer | The player's season total fouls committed over displayType. |
#' | efficiency | integer | The player's season total efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) over displayType. |
#' | plus_minus | integer | The player's season total plus-minus over displaytype. |
#' | games_played | integer | The player's season total games played over displayType. |
#' | seconds_per_game | double | Per-game average of seconds, seconds. |
#' | points_per_game | double | Per-game average of points. |
#' | two_point_shots_made_per_game | double | Per-game average of 2-point field goals made. |
#' | two_point_shots_attempted_per_game | double | Per-game average of 2-point field goals attempted. |
#' | three_point_shots_made_per_game | double | Per-game average of 3-point field goals made. |
#' | three_point_shots_attempted_per_game | double | Per-game average of 3-point field goals attempted. |
#' | field_goals_made_per_game | double | Per-game average of field goals made. |
#' | field_goals_attempted_per_game | double | Per-game average of field goals attempted. |
#' | field_goals_success_percent_per_game | double | Per-game average of field-goal percentage (0 in every sample: unusable). |
#' | free_throws_made_per_game | double | Per-game average of free throws made. |
#' | free_throws_attempted_per_game | double | Per-game average of free throws attempted. |
#' | defensive_rebounds_per_game | double | Per-game average of defensive rebounds. |
#' | offensive_rebounds_per_game | double | Per-game average of offensive rebounds. |
#' | total_rebounds_per_game | double | Per-game average of rebounds (offensive + defensive). |
#' | assists_per_game | double | Per-game average of assists. |
#' | steals_per_game | double | Per-game average of steals. |
#' | turnovers_per_game | double | Per-game average of turnovers. |
#' | blocks_per_game | double | Per-game average of blocked shots. |
#' | fouls_committed_per_game | double | Per-game average of fouls committed. |
#' | efficiency_per_game | double | Per-game average of efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score). |
#' | plus_minus_per_game | double | Per-game average of plus-minus (point margin while on court). |
#' | double_double | integer | The player's season total double-doubles over displayType. |
#' | double_double_per_game | double | Per-game average of double-doubles. |
#' | games_started | integer | The player's season total games started over displayType. |
#' | triple_double | integer | The player's season total triple-doubles over displayType. |
#' | triple_double_per_game | double | Per-game average of triple-doubles. |
#' | fouls_received | integer | The player's season total fouls drawn over displayType. |
#' | fouls_received_per_game | double | Per-game average of fouls drawn. |
#' | overall | logical | False in every sample (meaning unverified). |
#' | stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
#' | aggregation | character | Aggregation label as sent: STAGE in player tables, MAIN_ROUND in team tables. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_player_statistics(season = 2026))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Season team stat table: totals and per-game values, one row per team and stat block.
#'   An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_team_statistics`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | display_type | character | Which games the table covers, echoed from the request (MAIN_ROUND, PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS or CUP). |
#' | team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | team_tlc | character | Three-letter club code. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | round_code | integer | Provider round code; 1 for MAIN_ROUND in every sample (mapping unverified). |
#' | competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
#' | aggregation | character | Aggregation label as sent: STAGE in player tables, MAIN_ROUND in team tables. |
#' | seconds_played | integer | The team's season total playing time in SECONDS over displayType. |
#' | points | integer | The team's season total points over displayType. |
#' | two_point_shots_made | integer | The team's season total 2-point field goals made over displayType. |
#' | two_point_shots_attempted | integer | The team's season total 2-point field goals attempted over displayType. |
#' | two_point_shot_success_percent | double | The team's season total 2-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | three_point_shots_made | integer | The team's season total 3-point field goals made over displayType. |
#' | three_point_shots_attempted | integer | The team's season total 3-point field goals attempted over displayType. |
#' | three_point_shot_success_percent | double | The team's season total 3-point field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | field_goals_made | integer | The team's season total field goals made over displayType. |
#' | field_goals_attempted | integer | The team's season total field goals attempted over displayType. |
#' | field_goals_success_percent | double | The team's season total field-goal percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | free_throws_made | integer | The team's season total free throws made over displayType. |
#' | free_throws_attempted | integer | The team's season total free throws attempted over displayType. |
#' | free_throws_success_percent | double | The team's season total free-throw percentage over displaytype, 0-100 (one decimal); 0 when no attempts. |
#' | offensive_rebounds | integer | The team's season total offensive rebounds over displayType. |
#' | defensive_rebounds | integer | The team's season total defensive rebounds over displayType. |
#' | total_rebounds | integer | The team's season total rebounds (offensive + defensive) over displayType. |
#' | assists | integer | The team's season total assists over displayType. |
#' | steals | integer | The team's season total steals over displayType. |
#' | turnovers | integer | The team's season total turnovers over displayType. |
#' | blocks | integer | The team's season total blocked shots over displayType. |
#' | fouls_committed | integer | The team's season total fouls committed over displayType. |
#' | efficiency | integer | The team's season total efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) over displayType. |
#' | plus_minus | integer | The team's season total plus-minus over displaytype. |
#' | games_played | integer | The team's season total games played over displayType. |
#' | seconds_per_game | double | Per-game average of seconds, seconds. |
#' | points_per_game | double | Per-game average of points. |
#' | two_point_shots_made_per_game | double | Per-game average of 2-point field goals made. |
#' | two_point_shots_attempted_per_game | double | Per-game average of 2-point field goals attempted. |
#' | three_point_shots_made_per_game | double | Per-game average of 3-point field goals made. |
#' | three_point_shots_attempted_per_game | double | Per-game average of 3-point field goals attempted. |
#' | field_goals_made_per_game | double | Per-game average of field goals made. |
#' | field_goals_attempted_per_game | double | Per-game average of field goals attempted. |
#' | field_goals_success_percent_per_game | double | Per-game average of field-goal percentage (0 in every sample: unusable). |
#' | free_throws_made_per_game | double | Per-game average of free throws made. |
#' | free_throws_attempted_per_game | double | Per-game average of free throws attempted. |
#' | defensive_rebounds_per_game | double | Per-game average of defensive rebounds. |
#' | offensive_rebounds_per_game | double | Per-game average of offensive rebounds. |
#' | total_rebounds_per_game | double | Per-game average of rebounds (offensive + defensive). |
#' | assists_per_game | double | Per-game average of assists. |
#' | steals_per_game | double | Per-game average of steals. |
#' | turnovers_per_game | double | Per-game average of turnovers. |
#' | blocks_per_game | double | Per-game average of blocked shots. |
#' | fouls_committed_per_game | double | Per-game average of fouls committed. |
#' | efficiency_per_game | double | Per-game average of efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score). |
#' | plus_minus_per_game | double | Per-game average of plus-minus (point margin while on court). |
#' | double_double | integer | The team's season total double-doubles over displayType. |
#' | double_double_per_game | double | Per-game average of double-doubles. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_team_statistics(season = 2026))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Games of a season (the whole season in one page): teams, score by period, officials,
#'   venue and top scorer. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this
#'   order (sdv-py `scb_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | game_id | character | Game id, a string; unique within a league only (BBL and DBBL overlap), and not chronological. |
#' | competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
#' | stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
#' | status | character | Game status: PRE (scheduled), LIVE, POST (ended, not yet official), OFFICIAL (final). |
#' | scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
#' | match_day | integer | Round number within the stage (Spieltag). |
#' | is_tbd | logical | Date or time not yet fixed. |
#' | is_hidden | logical | True when the API hides the game (0/1 on /games, a boolean on the header). |
#' | home_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | home_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | home_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | home_tlc | character | Three-letter club code. |
#' | home_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
#' | home_rank | integer | The team's current table position. |
#' | home_streak | character | Current streak: W or L; empty when none. |
#' | home_streak_count | integer | Length of the current streak. |
#' | home_last10_victories | integer | Wins in the last 10 games. |
#' | home_last10_losses | integer | Losses in the last 10 games. |
#' | home_total_games | integer | Games the home team has played so far (the API sends it as a string). |
#' | guest_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | guest_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | guest_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | guest_tlc | character | Three-letter club code. |
#' | guest_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
#' | guest_rank | integer | The team's current table position. |
#' | guest_streak | character | Current streak: W or L; empty when none. |
#' | guest_streak_count | integer | Length of the current streak. |
#' | guest_last10_victories | integer | Wins in the last 10 games. |
#' | guest_last10_losses | integer | Losses in the last 10 games. |
#' | guest_total_games | integer | Games the guest team has played so far (the API sends it as a string). |
#' | home_score | integer | Home team final score. |
#' | guest_score | integer | Guest team final score. |
#' | latest_period | integer | Number of the last period played (4 = Q4, 5 = OT1, ...); the API sends `Q4` on /games and 4 on /games/recent. Null before the game. |
#' | spectators | integer | Attendance; 0 when not recorded. |
#' | home_q1_score | integer | Home team points in quarter 1; 0 when quarter scores were not recorded. |
#' | home_q2_score | integer | Home team points in quarter 2; 0 when quarter scores were not recorded. |
#' | home_q3_score | integer | Home team points in quarter 3; 0 when quarter scores were not recorded. |
#' | home_q4_score | integer | Home team points in quarter 4; 0 when quarter scores were not recorded. |
#' | home_ot1_score | integer | Home team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot2_score | integer | Home team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot3_score | integer | Home team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot4_score | integer | Home team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot5_score | integer | Home team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot6_score | integer | Home team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot7_score | integer | Home team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot8_score | integer | Home team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot9_score | integer | Home team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
#' | guest_q1_score | integer | Guest team points in quarter 1; 0 when quarter scores were not recorded. |
#' | guest_q2_score | integer | Guest team points in quarter 2; 0 when quarter scores were not recorded. |
#' | guest_q3_score | integer | Guest team points in quarter 3; 0 when quarter scores were not recorded. |
#' | guest_q4_score | integer | Guest team points in quarter 4; 0 when quarter scores were not recorded. |
#' | guest_ot1_score | integer | Guest team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot2_score | integer | Guest team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot3_score | integer | Guest team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot4_score | integer | Guest team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot5_score | integer | Guest team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot6_score | integer | Guest team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot7_score | integer | Guest team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot8_score | integer | Guest team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot9_score | integer | Guest team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
#' | referee1_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee1_first_name | character | Official's given name. |
#' | referee1_last_name | character | Official's family name. |
#' | referee2_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee2_first_name | character | Official's given name. |
#' | referee2_last_name | character | Official's family name. |
#' | referee3_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee3_first_name | character | Official's given name. |
#' | referee3_last_name | character | Official's family name. |
#' | commissioner_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | commissioner_first_name | character | Official's given name. |
#' | commissioner_last_name | character | Official's family name. |
#' | venue_id | character | Arena id, stable across seasons (Uber Arena = 2 in both 2025-26 and 2026-27); a different key space from /teams `seasonVenues.id`, and no captured route is keyed by it. A string in /games and `/games/{gameId}`, an integer in /games/recent. |
#' | venue_name | character | Name of the arena the game is played in; `venue_id` is its stable arena id. |
#' | venue_address | character | Postal address, German. |
#' | venue_capacity | integer | Arena capacity, spectators. |
#' | venue_is_main | logical | The club's main arena. |
#' | tv_channel | character | TV channel(s) showing the game, comma-joined (a list on some routes, an empty string when none). |
#' | tv_type | character | TV coverage type; empty or null in every sample. |
#' | is_free_tv | logical | Shown on free-to-air TV. |
#' | live_stream_url | character | Live-stream link (DBBL games link YouTube); empty when none. |
#' | top_score | integer | Points of the game's top scorer; null before the game. |
#' | top_scorer_season_player_id | character | Season-player id. BBL: a string equal to `id`. DBBL: an INTEGER that matches `/seasons/{seasonId}` `seasonPlayerId` (5 of 5 rows checked, 2026-27). Joins to `/season-players/{seasonPlayerId}`. |
#' | top_scorer_real_player_id | character | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | top_scorer_first_name | character | Player's given name. |
#' | top_scorer_last_name | character | Player's family name. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_games())
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Recent, live and upcoming games, one row per game with its past / present / future
#'   bucket. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_games_recent`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | game_id | character | Game id, a string; unique within a league only (BBL and DBBL overlap), and not chronological. |
#' | competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
#' | stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
#' | status | character | Game status: PRE (scheduled), LIVE, POST (ended, not yet official), OFFICIAL (final). |
#' | bucket | character | Which list of `/games/recent` the game came from: `past` (finished), `present` (today or live) or `future` (scheduled). |
#' | game_progress | character | Live progress code: E (ended), empty or null before the game. Meaning inferred. |
#' | scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
#' | match_day | integer | Round number within the stage (Spieltag). |
#' | is_tbd | logical | Date or time not yet fixed. |
#' | is_hidden | logical | True when the API hides the game (0/1 on /games, a boolean on the header). |
#' | home_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | home_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | home_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | home_tlc | character | Three-letter club code. |
#' | home_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
#' | home_rank | integer | The team's current table position. |
#' | home_streak | character | Current streak: W or L; empty when none. |
#' | home_streak_count | integer | Length of the current streak. |
#' | home_last10_victories | integer | Wins in the last 10 games. |
#' | home_last10_losses | integer | Losses in the last 10 games. |
#' | home_total_games | integer | Games the home team has played so far (the API sends it as a string). |
#' | guest_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | guest_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | guest_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | guest_tlc | character | Three-letter club code. |
#' | guest_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
#' | guest_rank | integer | The team's current table position. |
#' | guest_streak | character | Current streak: W or L; empty when none. |
#' | guest_streak_count | integer | Length of the current streak. |
#' | guest_last10_victories | integer | Wins in the last 10 games. |
#' | guest_last10_losses | integer | Losses in the last 10 games. |
#' | guest_total_games | integer | Games the guest team has played so far (the API sends it as a string). |
#' | home_score | integer | Home team final score. |
#' | guest_score | integer | Guest team final score. |
#' | latest_period | integer | Number of the last period played (4 = Q4, 5 = OT1, ...); the API sends `Q4` on /games and 4 on /games/recent. Null before the game. |
#' | spectators | integer | Attendance; 0 when not recorded. |
#' | home_q1_score | integer | Home team points in quarter 1; 0 when quarter scores were not recorded. |
#' | home_q2_score | integer | Home team points in quarter 2; 0 when quarter scores were not recorded. |
#' | home_q3_score | integer | Home team points in quarter 3; 0 when quarter scores were not recorded. |
#' | home_q4_score | integer | Home team points in quarter 4; 0 when quarter scores were not recorded. |
#' | home_ot1_score | integer | Home team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot2_score | integer | Home team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot3_score | integer | Home team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot4_score | integer | Home team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot5_score | integer | Home team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot6_score | integer | Home team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot7_score | integer | Home team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot8_score | integer | Home team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot9_score | integer | Home team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
#' | guest_q1_score | integer | Guest team points in quarter 1; 0 when quarter scores were not recorded. |
#' | guest_q2_score | integer | Guest team points in quarter 2; 0 when quarter scores were not recorded. |
#' | guest_q3_score | integer | Guest team points in quarter 3; 0 when quarter scores were not recorded. |
#' | guest_q4_score | integer | Guest team points in quarter 4; 0 when quarter scores were not recorded. |
#' | guest_ot1_score | integer | Guest team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot2_score | integer | Guest team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot3_score | integer | Guest team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot4_score | integer | Guest team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot5_score | integer | Guest team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot6_score | integer | Guest team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot7_score | integer | Guest team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot8_score | integer | Guest team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot9_score | integer | Guest team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
#' | referee1_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee1_first_name | character | Official's given name. |
#' | referee1_last_name | character | Official's family name. |
#' | referee2_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee2_first_name | character | Official's given name. |
#' | referee2_last_name | character | Official's family name. |
#' | referee3_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee3_first_name | character | Official's given name. |
#' | referee3_last_name | character | Official's family name. |
#' | commissioner_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | commissioner_first_name | character | Official's given name. |
#' | commissioner_last_name | character | Official's family name. |
#' | venue_id | character | Arena id, stable across seasons (Uber Arena = 2 in both 2025-26 and 2026-27); a different key space from /teams `seasonVenues.id`, and no captured route is keyed by it. A string in /games and `/games/{gameId}`, an integer in /games/recent. |
#' | venue_name | character | Name of the arena the game is played in; `venue_id` is its stable arena id. |
#' | venue_address | character | Postal address, German. |
#' | venue_capacity | integer | Arena capacity, spectators. |
#' | venue_is_main | logical | The club's main arena. |
#' | tv_channel | character | TV channel(s) showing the game, comma-joined (a list on some routes, an empty string when none). |
#' | tv_type | character | TV coverage type; empty or null in every sample. |
#' | is_free_tv | logical | Shown on free-to-air TV. |
#' | live_stream_url | character | Live-stream link (DBBL games link YouTube); empty when none. |
#' | top_score | integer | Points of the game's top scorer; null before the game. |
#' | top_scorer_season_player_id | character | Season-player id. BBL: a string equal to `id`. DBBL: an INTEGER that matches `/seasons/{seasonId}` `seasonPlayerId` (5 of 5 rows checked, 2026-27). Joins to `/season-players/{seasonPlayerId}`. |
#' | top_scorer_real_player_id | character | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | top_scorer_first_name | character | Player's given name. |
#' | top_scorer_last_name | character | Player's family name. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_games_recent())
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: One game header: teams, score by period, officials, venue and top scorer. An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `scb_game`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | game_id | character | Game id, a string; unique within a league only (BBL and DBBL overlap), and not chronological. |
#' | competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
#' | stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
#' | status | character | Game status: PRE (scheduled), LIVE, POST (ended, not yet official), OFFICIAL (final). |
#' | stat_status | character | Live-stats feed status code. Observed: E (ended; German Ende), N (not started), 1 (old games), empty string. Meaning inferred. |
#' | game_progress | character | Live progress code: E (ended), empty or null before the game. Meaning inferred. |
#' | scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
#' | match_day | integer | Round number within the stage (Spieltag). |
#' | is_tbd | logical | Date or time not yet fixed. |
#' | is_hidden | logical | True when the API hides the game (0/1 on /games, a boolean on the header). |
#' | home_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | home_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | home_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | home_tlc | character | Three-letter club code. |
#' | home_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
#' | home_rank | integer | The team's current table position. |
#' | home_streak | character | Current streak: W or L; empty when none. |
#' | home_streak_count | integer | Length of the current streak. |
#' | home_last10_victories | integer | Wins in the last 10 games. |
#' | home_last10_losses | integer | Losses in the last 10 games. |
#' | home_total_games | integer | Games the home team has played so far (the API sends it as a string). |
#' | guest_team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | guest_season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | guest_team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | guest_tlc | character | Three-letter club code. |
#' | guest_is_foreign | logical | The team is not in this league (cup opponents from the ProA / ProB). |
#' | guest_rank | integer | The team's current table position. |
#' | guest_streak | character | Current streak: W or L; empty when none. |
#' | guest_streak_count | integer | Length of the current streak. |
#' | guest_last10_victories | integer | Wins in the last 10 games. |
#' | guest_last10_losses | integer | Losses in the last 10 games. |
#' | guest_total_games | integer | Games the guest team has played so far (the API sends it as a string). |
#' | home_score | integer | Home team final score. |
#' | guest_score | integer | Guest team final score. |
#' | latest_period | integer | Number of the last period played (4 = Q4, 5 = OT1, ...); the API sends `Q4` on /games and 4 on /games/recent. Null before the game. |
#' | spectators | integer | Attendance; 0 when not recorded. |
#' | home_q1_score | integer | Home team points in quarter 1; 0 when quarter scores were not recorded. |
#' | home_q2_score | integer | Home team points in quarter 2; 0 when quarter scores were not recorded. |
#' | home_q3_score | integer | Home team points in quarter 3; 0 when quarter scores were not recorded. |
#' | home_q4_score | integer | Home team points in quarter 4; 0 when quarter scores were not recorded. |
#' | home_ot1_score | integer | Home team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot2_score | integer | Home team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot3_score | integer | Home team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot4_score | integer | Home team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot5_score | integer | Home team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot6_score | integer | Home team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot7_score | integer | Home team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot8_score | integer | Home team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
#' | home_ot9_score | integer | Home team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
#' | guest_q1_score | integer | Guest team points in quarter 1; 0 when quarter scores were not recorded. |
#' | guest_q2_score | integer | Guest team points in quarter 2; 0 when quarter scores were not recorded. |
#' | guest_q3_score | integer | Guest team points in quarter 3; 0 when quarter scores were not recorded. |
#' | guest_q4_score | integer | Guest team points in quarter 4; 0 when quarter scores were not recorded. |
#' | guest_ot1_score | integer | Guest team points in overtime 1; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot2_score | integer | Guest team points in overtime 2; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot3_score | integer | Guest team points in overtime 3; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot4_score | integer | Guest team points in overtime 4; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot5_score | integer | Guest team points in overtime 5; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot6_score | integer | Guest team points in overtime 6; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot7_score | integer | Guest team points in overtime 7; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot8_score | integer | Guest team points in overtime 8; 0 when not played (null from OT5 on in old seasons). |
#' | guest_ot9_score | integer | Guest team points in overtime 9; 0 when not played (null from OT5 on in old seasons). |
#' | referee1_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee1_first_name | character | Official's given name. |
#' | referee1_last_name | character | Official's family name. |
#' | referee2_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee2_first_name | character | Official's given name. |
#' | referee2_last_name | character | Official's family name. |
#' | referee3_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | referee3_first_name | character | Official's given name. |
#' | referee3_last_name | character | Official's family name. |
#' | commissioner_id | character | Official id; joins to /referees `refId` (= its `id`). /referees lists only the current officials (44), so older games' officials can be missing there: all 40 of 2026-27's matched, 6 of 10 of 2008-09's. |
#' | commissioner_first_name | character | Official's given name. |
#' | commissioner_last_name | character | Official's family name. |
#' | venue_id | character | Arena id, stable across seasons (Uber Arena = 2 in both 2025-26 and 2026-27); a different key space from /teams `seasonVenues.id`, and no captured route is keyed by it. A string in /games and `/games/{gameId}`, an integer in /games/recent. |
#' | venue_name | character | Name of the arena the game is played in; `venue_id` is its stable arena id. |
#' | venue_address | character | Postal address, German. |
#' | venue_capacity | integer | Arena capacity, spectators. |
#' | venue_is_main | logical | The club's main arena. |
#' | tv_channel | character | TV channel(s) showing the game, comma-joined (a list on some routes, an empty string when none). |
#' | tv_type | character | TV coverage type; empty or null in every sample. |
#' | is_free_tv | logical | Shown on free-to-air TV. |
#' | live_stream_url | character | Live-stream link (DBBL games link YouTube); empty when none. |
#' | top_score | integer | Points of the game's top scorer; null before the game. |
#' | top_scorer_season_player_id | character | Season-player id. BBL: a string equal to `id`. DBBL: an INTEGER that matches `/seasons/{seasonId}` `seasonPlayerId` (5 of 5 rows checked, 2026-27). Joins to `/season-players/{seasonPlayerId}`. |
#' | top_scorer_real_player_id | character | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | top_scorer_first_name | character | Player's given name. |
#' | top_scorer_last_name | character | Player's family name. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_game(game_id = "2006920"))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Box score of a finished game: one row per player line of both teams (2002-03 on). An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_game_players`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | game_id | character | Game id, a string. Joins to `/games/{gameId}`. |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | side | character | `home` or `guest` (the away side), for the team the row belongs to. |
#' | team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
#' | real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | shirt_number | character | Jersey number. A number or a numeric string across rows. |
#' | position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | team_tlc | character | Three-letter club code. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | seconds_played | integer | The player's playing time in SECONDS in the game. |
#' | points | integer | The player's points in the game. |
#' | two_point_shots_made | integer | The player's 2-point field goals made in the game. |
#' | two_point_shots_attempted | integer | The player's 2-point field goals attempted in the game. |
#' | two_point_shot_success_percent | double | The player's 2-point field-goal percentage in the game, 0-100 (one decimal); 0 when no attempts. |
#' | three_point_shots_made | integer | The player's 3-point field goals made in the game. |
#' | three_point_shots_attempted | integer | The player's 3-point field goals attempted in the game. |
#' | three_point_shot_success_percent | double | The player's 3-point field-goal percentage in the game, 0-100 (one decimal); 0 when no attempts. |
#' | field_goals_made | integer | The player's field goals made in the game. |
#' | field_goals_attempted | integer | The player's field goals attempted in the game. |
#' | field_goals_success_percent | double | The player's field-goal percentage in the game, 0-100 (one decimal); 0 when no attempts. |
#' | free_throws_made | integer | The player's free throws made in the game. |
#' | free_throws_attempted | integer | The player's free throws attempted in the game. |
#' | free_throws_success_percent | double | The player's free-throw percentage in the game, 0-100 (one decimal); 0 when no attempts. |
#' | offensive_rebounds | integer | The player's offensive rebounds in the game. |
#' | defensive_rebounds | integer | The player's defensive rebounds in the game. |
#' | total_rebounds | integer | The player's rebounds (offensive + defensive) in the game. |
#' | assists | integer | The player's assists in the game. |
#' | steals | integer | The player's steals in the game. |
#' | turnovers | integer | The player's turnovers in the game. |
#' | blocks | integer | The player's blocked shots in the game. |
#' | fouls_committed | integer | The player's fouls committed in the game. |
#' | efficiency | integer | The player's efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) in the game. |
#' | plus_minus | integer | The player's plus-minus (point margin while on court); null when the API sends an empty string (2005-06). |
#' | is_starting_five | logical | Started the game. |
#' | double_double | integer | The player's double-doubles in the game. |
#' | triple_double | integer | The player's triple-doubles in the game. |
#' | fouls_received | integer | The player's fouls drawn in the game. |
#' | opponent_team_name | character | Opponent's name. |
#' | field_goals_recomputed | logical | True when the API's field-goal totals disagreed with its 2-point plus 3-point parts (2005-06 box scores) and were recomputed from the parts. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_game_players(game_id = "2006920"))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Box score of a finished game: one row per team, with the head coach and the team
#'   line. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_game_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | game_id | character | Game id, a string. Joins to `/games/{gameId}`. |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | side | character | `home` or `guest` (the away side), for the team the row belongs to. |
#' | team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | head_coach_name | character | Name of the team's head coach. |
#' | status | character | Game status: PRE (scheduled), LIVE, POST (ended, not yet official) or OFFICIAL (final). |
#' | scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | team_name | character | Team name as listed that season (sponsor names included, e.g. 'EWE Baskets Oldenburg'). |
#' | team_tlc | character | Three-letter club code. |
#' | competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
#' | stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
#' | seconds_played | integer | The team's playing time in SECONDS in the game (players plus the team line) (12000 = 5 x 40 min). |
#' | points | integer | The team's points in the game (players plus the team line). |
#' | two_point_shots_made | integer | The team's 2-point field goals made in the game (players plus the team line). |
#' | two_point_shots_attempted | integer | The team's 2-point field goals attempted in the game (players plus the team line). |
#' | two_point_shot_success_percent | double | The team's 2-point field-goal percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
#' | three_point_shots_made | integer | The team's 3-point field goals made in the game (players plus the team line). |
#' | three_point_shots_attempted | integer | The team's 3-point field goals attempted in the game (players plus the team line). |
#' | three_point_shot_success_percent | double | The team's 3-point field-goal percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
#' | field_goals_made | integer | The team's field goals made in the game (players plus the team line). |
#' | field_goals_attempted | integer | The team's field goals attempted in the game (players plus the team line). |
#' | field_goals_success_percent | double | The team's field-goal percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
#' | free_throws_made | integer | The team's free throws made in the game (players plus the team line). |
#' | free_throws_attempted | integer | The team's free throws attempted in the game (players plus the team line). |
#' | free_throws_success_percent | double | The team's free-throw percentage in the game (players plus the team line), 0-100 (one decimal); 0 when no attempts. |
#' | offensive_rebounds | integer | The team's offensive rebounds in the game (players plus the team line). |
#' | defensive_rebounds | integer | The team's defensive rebounds in the game (players plus the team line). |
#' | total_rebounds | integer | The team's rebounds (offensive + defensive) in the game (players plus the team line). |
#' | assists | integer | The team's assists in the game (players plus the team line). |
#' | steals | integer | The team's steals in the game (players plus the team line). |
#' | turnovers | integer | The team's turnovers in the game (players plus the team line). |
#' | blocks | integer | The team's blocked shots in the game (players plus the team line). |
#' | fouls_committed | integer | The team's fouls committed in the game (players plus the team line). |
#' | efficiency | integer | The team's efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) in the game (players plus the team line). |
#' | plus_minus | integer | The team's point margin in the game. |
#' | team_line_seconds_played | integer | Team-line playing time in SECONDS (not credited to a player). |
#' | team_line_points | integer | Team-line points (not credited to a player). |
#' | team_line_two_point_shots_made | integer | Team-line 2-point field goals made (not credited to a player). |
#' | team_line_two_point_shots_attempted | integer | Team-line 2-point field goals attempted (not credited to a player). |
#' | team_line_two_point_shot_success_percent | double | Team-line 2-point field-goal percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
#' | team_line_three_point_shots_made | integer | Team-line 3-point field goals made (not credited to a player). |
#' | team_line_three_point_shots_attempted | integer | Team-line 3-point field goals attempted (not credited to a player). |
#' | team_line_three_point_shot_success_percent | double | Team-line 3-point field-goal percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
#' | team_line_field_goals_made | integer | Team-line field goals made (not credited to a player). |
#' | team_line_field_goals_attempted | integer | Team-line field goals attempted (not credited to a player). |
#' | team_line_field_goals_success_percent | double | Team-line field-goal percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
#' | team_line_free_throws_made | integer | Team-line free throws made (not credited to a player). |
#' | team_line_free_throws_attempted | integer | Team-line free throws attempted (not credited to a player). |
#' | team_line_free_throws_success_percent | double | Team-line free-throw percentage (not credited to a player), 0-100 (one decimal); 0 when no attempts. |
#' | team_line_offensive_rebounds | integer | Team-line offensive rebounds (not credited to a player). |
#' | team_line_defensive_rebounds | integer | Team-line defensive rebounds (not credited to a player). |
#' | team_line_total_rebounds | integer | Team-line rebounds (offensive + defensive) (not credited to a player). |
#' | team_line_assists | integer | Team-line assists (not credited to a player). |
#' | team_line_steals | integer | Team-line steals (not credited to a player). |
#' | team_line_turnovers | integer | Team-line turnovers (not credited to a player). |
#' | team_line_blocks | integer | Team-line blocked shots (not credited to a player). |
#' | team_line_fouls_committed | integer | Team-line fouls committed (not credited to a player). |
#' | team_line_efficiency | integer | Team-line efficiency (EFF = PTS + REB + AST + STL + BLK - missed FG - missed FT - TO; checked on a 2026 box score) (not credited to a player). |
#' | team_line_plus_minus | integer | Team-line plus-minus: the team line has no court time, so this is not a margin. |
#' | field_goals_recomputed | logical | True when the API's field-goal totals disagreed with its 2-point plus 3-point parts (2005-06 box scores) and were recomputed from the parts. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_game_teams(game_id = "2006920"))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Play-by-play of a finished game with shot x/y (BBL 2008-09 on, DBBL 2024-25 on). An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_game_actions`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | game_id | character | Game id, a string; unique within a league only (BBL and DBBL overlap), and not chronological. |
#' | action_id | integer | Action id, an integer unique across games of a league. |
#' | order_id | integer | Chronological sequence of the action within the game. |
#' | action_identifier | character | Provider action key `<n>:<seq>` (opaque; the first part is not the period). |
#' | period | integer | Period: 1-4 quarters, 5+ overtimes. |
#' | game_time | character | Game clock as HH:MM:SS: in an action, the time LEFT in the period (00:10:00 at the start of a 10-minute quarter); in a game header, 00:00:00 in every sample. |
#' | seconds_left | integer | Seconds left in the period at the action: `game_time` as seconds. |
#' | real_time | character | Wall-clock time of the action, ISO 8601 UTC. Pre-2011 games carry a placeholder: local midnight of the game day (23:00 UTC the day before) on every row. |
#' | type | character | Action type; see the action-type table. Records and videos use their own `type` (see those routes). |
#' | qualifiers | character | Action qualifiers (shot kind, rebound side, foul kind, turnover kind); see the qualifier table. |
#' | is_successful | logical | Made / successful (shots, free throws); for other types see the action-type table. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | side | character | `home` or `guest` (the away side), for the team the row belongs to. |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. Null on team and period rows. |
#' | assisting_season_player_id | character | Season-player id of the assisting player; only on assisted made shots. Joins to box-score `seasonPlayer.id` and action `seasonPlayerId`. |
#' | shot_x | integer | Shot x on the site's half-court chart (0-280 across, 140 through the rim); null without a location. Scale and orientation unverified. |
#' | shot_y | integer | Shot y along the court from behind the baseline (rim near 45, arc top near 147); null without a location. Scale and orientation unverified. |
#' | home_team_points | integer | Home score after this action; only on scoring actions. |
#' | guest_team_points | integer | Guest score after this action; only on scoring actions. |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_game_actions(game_id = "2006920"))
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: League table of a season: record, home / away split, streaks and tie-break detail
#'   (2005-06 on). An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order
#'   (sdv-py `scb_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | standing_id | character | Opaque id of the standings row, a string. |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). An integer here. |
#' | team_id | character | Club id; equal to `seasonTeamId` in every sample. Joins to `/teams/{teamId}`. |
#' | team_name | character | Team name; null on some rows. |
#' | team_tlc | character | Three-letter club code. |
#' | team_name_short | character | Short team name (null on DBBL). |
#' | has_reached_playoffs | logical | Clinched a playoff place. |
#' | has_reached_playins | logical | Clinched at least the play-ins. |
#' | is_relegation_certain | logical | Relegated for certain. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | competition | character | Competition: BBL, BBL_CUP (Pokal), ALLSTAR, CHAMPIONS_CUP on the BBL host; DBBL, DBBL_CUP on the DBBL host. |
#' | stage | character | Stage: MAIN_ROUND (Hauptrunde, regular season), PLAYINS, FIRST_ROUND, SECOND_ROUND, ROUND_OF_16 (Achtelfinale), ROUND_OF_8 (Viertelfinale), SEMI_FINALS, FINALS, THIRD_PLACE_GAME, QUALIFICATION, GROUP_STAGE. |
#' | rank | integer | Table position. |
#' | streak | character | Current streak: W or L; empty when none. |
#' | streak_count | integer | Length of the current streak. |
#' | point_corrections | character | Table-point deductions; [] in every sample. |
#' | home_victories | integer | Home games: wins. |
#' | home_losses | integer | Home games: number of losses in the table. |
#' | home_victory_percentage | double | Home games: win percentage, 0-100. |
#' | away_victories | integer | Away games: wins. |
#' | away_losses | integer | Away games: number of losses in the table. |
#' | away_victory_percentage | double | Away games: win percentage, 0-100. |
#' | table_points | integer | Table points scored (2 per win), from the API's `totalPointsMade`; the provider's notes call its 'Points' fields table points. |
#' | table_points_against | integer | Table points conceded (2 per loss), from the API's `totalPointsAgainst`; per the provider's notes, table points. |
#' | total_victory_percentage | double | All games: win percentage, 0-100. |
#' | total_games | integer | Games played in the table (home and away together). |
#' | total_victories | integer | All games: wins. |
#' | total_losses | integer | Losses in the table over all games. |
#' | last10_victories | integer | Wins in the last 10 games. |
#' | last10_losses | integer | Losses in the last 10 games. |
#' | last10_percentage | double | Win percentage over the last 10 games, 0-100. |
#' | last10_outcomes | character | Results of the last games, newest first: W or L. |
#' | home_last10_victories | integer | Home games: last 10 games, wins. |
#' | home_last10_losses | integer | Home games: last 10 games, losses. |
#' | home_last10_victory_percentage | double | Home games: last 10 games, win percentage, 0-100. |
#' | home_streak | character | Home games: current streak, W or L. |
#' | home_streak_count | integer | Home games: length of the current streak. |
#' | away_last10_victories | integer | Away games: last 10 games, wins. |
#' | away_last10_losses | integer | Away games: last 10 games, losses. |
#' | away_last10_victory_percentage | double | Away games: last 10 games, win percentage, 0-100. |
#' | away_streak | character | Away games: current streak, W or L. |
#' | away_streak_count | integer | Away games: length of the current streak. |
#' | updated_date | character | Last update of the row, ISO 8601 UTC. |
#' | ranking_comparison_info | character | Tie-break detail among teams level on record. |
#' | home_points_for | integer | Home games: basketball points scored (the API's football-style `GoalsMade`). |
#' | away_points_for | integer | Away games: basketball points scored (the API's football-style `GoalsMade`). |
#' | total_points_for | integer | All games: basketball points scored (the API's football-style `GoalsMade`). |
#' | home_points_against | integer | Home games: basketball points allowed (the API's football-style `GoalsAgainst`). |
#' | away_points_against | integer | Away games: basketball points allowed (the API's football-style `GoalsAgainst`). |
#' | total_points_against | integer | All games: basketball points allowed (the API's football-style `GoalsAgainst`). |
#' | home_point_difference | integer | Home games: point differential, scored minus allowed (the API's `GoalDifference`). |
#' | away_point_difference | integer | Away games: point differential, scored minus allowed (the API's `GoalDifference`). |
#' | total_point_difference | integer | All games: point differential, scored minus allowed (the API's `GoalDifference`). |
#' @inherit scb_seasons details
#' @examples
#' \donttest{
#'   try(scb_standings())
#' }
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Player profile by season-player id: bio, position, club and previous clubs. An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_season_player`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
#' | real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | active_season_player_id | character | The player's current season-player id (his latest club engagement). Joins to `/season-players/{seasonPlayerId}`. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | birth_date | character | Date of birth, YYYY-MM-DD. |
#' | position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
#' | shirt_number | character | Jersey number. A number or a numeric string across rows. |
#' | height | double | Height in metres (float32 noise: 1.77 arrives as 1.7699999809265137). |
#' | weight | integer | Weight in kg; 0 when unknown. |
#' | nationalities | character | Nationalities, ISO 3166-1 alpha-2 codes. |
#' | is_all_star | logical | All-Star selection flag. |
#' | is_young | logical | Young-player flag (German-trained youth rule; inferred). |
#' | has_changed_teams | logical | Moved clubs during the season. |
#' | bbl_games_played | integer | Career league games played (BBL host; 0 on DBBL). |
#' | team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
#' | team_name | character | Team name as listed that season (sponsor names included). |
#' | previous_teams | character | Former clubs, free text (German names). |
#' | season_ids | character | Seasons (start years) with this player or club. |
#' @eval .intl_details(.scb_seasons_details, 'scb_season_player(season_player_id = "56414")')
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Club profile: names, code, home page, ticket shop, year joined and honours. An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `scb_team`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
#' | tlc | character | Three-letter club code. |
#' | name_full | character | Full club name as the API lists it today. |
#' | name_short | character | Short name (often the city); null on DBBL. |
#' | mascot | character | Club mascot name (null when none). |
#' | homepage_url | character | Club website address as sent (it can lack the scheme). |
#' | ticket_url | character | Ticket shop URL. |
#' | year_joined_bbl | integer | Year the club joined the league. |
#' | order_id | integer | Display order of the club on the site; null on some clubs. |
#' | best_achievements | character | Honours, German free text (Deutscher Meister = German champion, Pokalsieger = cup winner, Vizepokalsieger = cup runner-up). |
#' @eval .intl_details(.scb_seasons_details, 'scb_team(team_id = "413")')
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Every season a club played: its name that season and its championship and cup
#'   titles. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_team_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | season_team_id | character | Season-team id, a string; equal to the club `team_id` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | team_name | character | Team name as listed that season (sponsor names included). |
#' | is_championship_winner | logical | Won the championship that season. |
#' | is_cup_winner | logical | Won the cup that season. |
#' @eval .intl_details(.scb_seasons_details, 'scb_team_seasons(team_id = "413")')
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Current referees and commissioners (BBL only). An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `scb_referees`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | referee_id | character | Official id (`refId`, equal to the API's `id`); joins `referee1_id` .. `commissioner_id` of `scb_games`. |
#' | first_name | character | Official's given name. |
#' | last_name | character | Official's family name. |
#' | official_function | character | REFEREE or COMMISSIONER. |
#' | participations | integer | League games officiated. |
#' | year_joined_bbl | integer | Year the official joined the league. |
#' @eval .intl_details(.scb_seasons_details, "scb_referees()")
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Latest transfers, one row per move (BBL only). An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `scb_transfers`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | transfer_date | character | Date of the transfer, YYYY-MM-DD (the API's `sortingDate`). |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
#' | real_player_id | integer | Global person id (integer): the same player across clubs and seasons. Join players across seasons on this. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
#' | source_team_id | character | Club id the player left; null when the source is not a league club. |
#' | source_team_name | character | Name of the club the player left (the free-text field, else the short club name). |
#' | destination_team_id | character | Club id the player joined; null when the destination is not a league club. |
#' | destination_team_name | character | Name of the club the player joined (the free-text field, else the short club name). |
#' @eval .intl_details(.scb_seasons_details, "scb_transfers()")
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Per club, the players joining and leaving, one row per move with its direction (BBL
#'   only). An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_transfers_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
#' | direction | character | `joining` or `leaving`: whether `team_id` is the destination or the source of the move. |
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | transfer_date | character | Date of the transfer, YYYY-MM-DD (the API's `sortingDate`). |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
#' | real_player_id | integer | Global person id (integer): the same player across clubs and seasons. Join players across seasons on this. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
#' | source_team_id | character | Club id the player left; null when the source is not a league club. |
#' | source_team_name | character | Name of the club the player left (the free-text field, else the short club name). |
#' | destination_team_id | character | Club id the player joined; null when the destination is not a league club. |
#' | destination_team_name | character | Name of the club the player joined (the free-text field, else the short club name). |
#' @eval .intl_details(.scb_seasons_details, "scb_transfers_teams()")
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Per club, the current roster, one row per player (BBL only). An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `scb_team_rosters`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
#' | real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | birth_date | character | Date of birth, YYYY-MM-DD. |
#' | position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
#' | shirt_number | character | Jersey number as sent (a string: it can be `00`). |
#' | height | double | Height in metres (float32 noise: 1.77 arrives as 1.7699999809265137). |
#' | weight | integer | Weight in kg; 0 when unknown. |
#' | nationalities | character | Nationalities, ISO 3166-1 alpha-2 codes. |
#' | is_all_star | logical | All-Star selection flag. |
#' | is_young | logical | Young-player flag (German-trained youth rule; inferred). |
#' @eval .intl_details(.scb_seasons_details, "scb_team_rosters()")
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: Single-game records: the season's and the all-time ones, one row per record. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_records_per_game`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | The API's own season key, the START year (2025 = 2025-26); `season` minus one. |
#' | scope | character | `season` for the requested season's records, `all_time` for the all-time list. |
#' | stat | character | The record's stat: points, rebounds, assists, steals, blocks, turnovers, efficiency, free_throws_made, three_point_shots_made or free_throws_success_percentage. |
#' | place | integer | Rank within the list (1 = best); 0 on some rows. |
#' | all_time_place | integer | Rank on the all-time list; null when not on it. |
#' | order_id | integer | Sort order within the list. |
#' | all_time_order_id | integer | Sort order on the all-time list; null when not on it. |
#' | value | double | The record value. A STRING in /records/per-game ('52'); a number in /records/season-averages. |
#' | ratio | double | \[made, attempted\] as strings, on percentage records only; null otherwise. |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
#' | real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | team_name | character | Team name as listed that season (sponsor names included). |
#' | team_tlc | character | The player's team code. |
#' | home_tlc | character | Three-letter code of the home team of the record game. |
#' | guest_tlc | character | Three-letter code of the guest team of the record game. |
#' | game_id | character | Game id, a string. Joins to `/games/{gameId}`. |
#' | scheduled_time | character | Scheduled tip-off, ISO 8601 UTC. |
#' @eval .intl_details(.scb_seasons_details, "scb_records_per_game(season = 2026)")
#' @export
#' @family SCB Functions
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
#' @return
#' A `hoopR_data` tibble: All-time season-average records (points, rebounds, assists, ...), one row per
#'   record. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `scb_records_season_averages`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
#' | stat | character | The record's stat list: assist_average, block_average, efficiency_average, foul_average, free_throws_success_percentage, points_average, rebound_average, steal_average, three_point_shot_average or turnover_average. |
#' | season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
#' | season_id | integer | Season, START year (2026 = 2026-27). |
#' | place | integer | Rank within the list (1 = best); 0 on some rows. |
#' | order_id | integer | Sort order within the list. |
#' | value | double | The record value. A STRING in /records/per-game ('52'); a number in /records/season-averages. |
#' | ratio | double | \[made, attempted\] as strings, on percentage records only; null otherwise. |
#' | season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move; see README). Joins to box-score `seasonPlayer.id`, action `seasonPlayerId` and `/season-players/{seasonPlayerId}`. |
#' | real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
#' | first_name | character | Player's given name. |
#' | last_name | character | Player's family name. |
#' | team_name | character | Team name as listed that season (sponsor names included). |
#' | team_tlc | character | The player's team code. |
#' @eval .intl_details(.scb_seasons_details, "scb_records_season_averages()")
#' @export
#' @family SCB Functions
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
