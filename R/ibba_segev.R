# ibba_segev.R -- the exported Segev Stats wrappers (the live stats behind basket.co.il).
# Generated from the sdv-py endpoint YAML and manual_column_descriptions.yaml, then kept by hand.

#' @title
#' **IBBA Segev Game Info**
#' @description
#' **Game header: tip-off, competition, both teams and the game state (scores are in the box
#'   score).**
#'
#' Endpoint: `GET https://stats.segevstats.com/realtimestat_heb/api/?method=getGameInfo`
#' @param game_id (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs Maccabi Tel
#'   Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.
#' @details
#' The `ibba_segev_*()` wrappers read Segev Stats, the live-stats vendor behind basket.co.il's
#' game pages (`stats.segevstats.com/realtimestat_heb/api/`, a JSON-RPC API served as
#' text/html): the game header, rosters, box score, period scores and play-by-play with shot
#' coordinates, from 2025-26. They mirror sdv-py's `ibba_segev_*` wrappers of the same names:
#' same arguments, the same snake_case columns and types, one row per sdv-py row.
#'
#' **Unofficial and unsupported.** The API is keyless, unofficial and not documented for
#' outside use. Requests are spaced at least one second apart per host (429 / 502 / 503 / 504
#' are retried three times, a 500 is not); only finished games are read.
#'
#' **Games and ids.** `game_id` is one flat Segev id space across seasons AND competitions
#' (men's Winner League, Winner Cup, women's, Leumit, youth, school and pre-season games), so
#' read `competition` from [ibba_segev_game_info()]. There is no game list: league game ids
#' come from [ibba_games()] `segev_game_id` (2025-26 on; see [ibba_segev_game_crosswalk()]).
#' Segev team and player ids are stable across seasons (Jaylen Hoard = player 1000 in games 50
#' and 419), unlike the IBBA season registrations, and are not IBBA ids.
#'
#' **Play-by-play.** Actions name the player by Segev id and by JERSEY number, `score` reads
#' away-home, and shot `x` / `y` are one half-court frame (x 0-1470 across, basket near 735;
#' y out from the baseline, rim near 112-140); which sideline is x = 0 and the metric scale
#' are unverified. Segev renamed its team game stats between 2025-26 and 2026-27; the frames
#' unify them. `start_time` is the scheduled tip-off in Israel local time (POSIXct, tz
#' Asia/Jerusalem; the feed carries no offset).
#'
#' **Errors** are classed conditions, never a warning plus an empty frame: `hoopR_no_data`
#' (HTTP 404, "game not found", a finished game with no actions), `hoopR_bad_request` (HTTP
#' 400 / 422, or a `game_id` that is not a positive integer) and `hoopR_asset_fetch` (any
#' other failure: another status, a transport error, an empty or non-JSON body, an error or
#' changed envelope, a body for another game, a game that is not final). All inherit
#' `hoopR_error`.
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
#' | start_time | POSIXct | Scheduled tip-off in Israel local time as a naive datetime (the feed has no offset; it can differ from the IBBA tip_off by minutes). |
#' | competition | character | Competition name ('Winner League', 'Winner Cup', 'Women', 'Leumit', 'Noar', 'School', 'Preparation Games'): the reliable men's / women's discriminator. |
#' | home_team_id | integer | Home Segev team id (key space: Segev teams, stable across seasons and competitions; Maccabi Tel Aviv = 2). Not an IBBA team-season id. |
#' | home_team | character | Home team name in English, upper case; some women's teams end in ' (W)', not all. |
#' | home_team_local | character | Home team name in Hebrew (Latin sponsor words kept). |
#' | home_short_name | character | Home team short name in English, upper case. |
#' | away_team_id | integer | Away Segev team id (key space: Segev teams, stable across seasons and competitions). |
#' | away_team | character | Away team name in English, upper case. |
#' | away_team_local | character | Away team name in Hebrew (Latin sponsor words kept). |
#' | away_short_name | character | Away team short name in English, upper case. |
#' | periods | integer | Regulation periods in the game (4). |
#' | finished | logical | True once the game is final (the wrappers read finished games only). |
#' | current_period | integer | Current period, the last one played for a finished game (5+ means overtime). |
#' | clock | character | Game clock remaining as 'mm:ss' ('00:00' for a finished game). |
#' @family IBBA Segev
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
#' @inherit ibba_segev_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
#' | team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
#' | team_id | integer | Segev team id of the roster's side (stable across seasons). |
#' | player_id | integer | Segev player id (key space: Segev players, stable across seasons: Jaylen Hoard = 1000 in games 50 and 419); null on team lines and on actions without a player. Not an IBBA player-season id. |
#' | jersey_number | integer | Jersey number as an integer. |
#' | first_name | character | First name in English, upper case. |
#' | last_name | character | Last name in English, upper case. |
#' | first_name_local | character | First name in Hebrew. |
#' | last_name_local | character | Last name in Hebrew. |
#' | in_roster | integer | Roster flag, 0 or 2 in the samples; meaning unverified. |
#' | api_id | integer | External player id as an integer: null or equal to the Segev player_id (both occur within one game); its source is unverified. |
#' @family IBBA Segev
#' @export
#' @examples
#' \donttest{
#'   try(ibba_segev_rosters(game_id = 50))
#' }
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
#' @inherit ibba_segev_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
#' | team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
#' | team_id | integer | Segev team id of the side (key space: Segev teams, stable across seasons). Not an IBBA team-season id; null on game-level actions. |
#' | row_type | character | player (one player's line) or team (actions credited to the team and no player, such as team rebounds and turnovers). |
#' | player_id | integer | Segev player id (key space: Segev players, stable across seasons: Jaylen Hoard = 1000 in games 50 and 419); null on team lines and on actions without a player. Not an IBBA player-season id. |
#' | jersey_number | integer | Jersey number as an integer. |
#' | starter | logical | True when the player was in the starting five. |
#' | on_court | logical | True when the player was on court at the final buzzer or the feed's last state. |
#' | minutes | character | Time played as 'mm:ss'. |
#' | seconds_played | integer | Time played in seconds, derived from minutes. |
#' | plus_minus | integer | Plus-minus while the player was on court, signed. |
#' | fg2m | integer | Two-point field goals made. |
#' | fg2_missed | integer | Two-point field goals MISSED (not attempted; attempts = made + missed, verified against the IBBA box score). |
#' | fg3m | integer | Three-point field goals made. |
#' | fg3_missed | integer | Three-point field goals MISSED (not attempted). |
#' | ftm | integer | Free throws made. |
#' | ft_missed | integer | Free throws MISSED (not attempted). |
#' | dreb | integer | Defensive rebounds. |
#' | oreb | integer | Offensive rebounds. |
#' | fouls | integer | Fouls committed (the feed's f; equals the IBBA fouls). |
#' | fouls_drawn | integer | Fouls drawn (the feed's f_drawn; equals the IBBA fouls_drawn). |
#' | steals | integer | Steals made by the player or team. |
#' | turnovers | integer | Turnovers committed by the player or team. |
#' | assists | integer | Assists credited to the player or team. |
#' | blocks | integer | Shots the player or team blocked. |
#' | blocks_against | integer | Own shots that were blocked. |
#' | fast_break_pts | integer | Fast-break points; for a team total it equals the P of the feed's 'P of N' fast-break stat. |
#' | second_chance_pts | integer | Second-chance points (scored after an offensive rebound). |
#' | pts | integer | Points scored by the player or side (free throws included). |
#' | val | integer | Efficiency rating (the feed's rate; equals the IBBA VAL). |
#' | deflections | integer | Deflections (count of deflection actions). |
#' | recoveries | integer | The feed's rec count; unverified, probably loose-ball recoveries. |
#' | dunks | integer | Dunks made by the player or side. |
#' | offensive_fouls_drawn | integer | Offensive fouls drawn (charges taken); inferred. |
#' | and_ones | integer | And-one plays (a made basket plus a foul); inferred. |
#' | vps | double | The feed's vps ratio with two decimals; its definition is unverified (it matches neither points per shot nor rate per minute). |
#' | fg2a | integer | Two-point field goals attempted, derived as made + missed. |
#' | fg3a | integer | Three-point field goals attempted, derived as made + missed. |
#' | fta | integer | Free throws attempted, derived as made + missed. |
#' @family IBBA Segev
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
#' @inherit ibba_segev_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
#' | team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
#' | team_id | integer | Segev team id of the side (key space: Segev teams, stable across seasons). Not an IBBA team-season id; null on game-level actions. |
#' | score | integer | Final score of the side (homeScore / awayScore). |
#' | timeouts | integer | Timeouts the side took (the feed's homeTimeOut / awayTimeOut). |
#' | time_leading | character | Time the side led as 'mm:ss'. |
#' | biggest_lead | integer | The side's biggest lead in points. |
#' | times_tied | integer | Times the score was tied (same value for both sides). |
#' | lead_changes | integer | Lead changes (same value for both sides). |
#' | fg2m | integer | Two-point field goals made. |
#' | fg2_missed | integer | Two-point field goals MISSED (not attempted; attempts = made + missed, verified against the IBBA box score). |
#' | fg3m | integer | Three-point field goals made. |
#' | fg3_missed | integer | Three-point field goals MISSED (not attempted). |
#' | ftm | integer | Free throws made. |
#' | ft_missed | integer | Free throws MISSED (not attempted). |
#' | dreb | integer | Defensive rebounds. |
#' | oreb | integer | Offensive rebounds. |
#' | fouls | integer | Fouls committed (the feed's f; equals the IBBA fouls). |
#' | fouls_drawn | integer | Fouls drawn (the feed's f_drawn; equals the IBBA fouls_drawn). |
#' | steals | integer | Steals made by the player or team. |
#' | turnovers | integer | Turnovers committed by the player or team. |
#' | assists | integer | Assists credited to the player or team. |
#' | blocks | integer | Shots the player or team blocked. |
#' | blocks_against | integer | Own shots that were blocked. |
#' | fast_break_pts | integer | Fast-break points; for a team total it equals the P of the feed's 'P of N' fast-break stat. |
#' | second_chance_pts | integer | Second-chance points (scored after an offensive rebound). |
#' | pts | integer | Points scored by the player or side (free throws included). |
#' | val | integer | Efficiency rating (the feed's rate; equals the IBBA VAL). |
#' | deflections | integer | Deflections (count of deflection actions). |
#' | recoveries | integer | The feed's rec count; unverified, probably loose-ball recoveries. |
#' | dunks | integer | Dunks made by the player or side. |
#' | offensive_fouls_drawn | integer | Offensive fouls drawn (charges taken); inferred. |
#' | and_ones | integer | And-one plays (a made basket plus a foul); inferred. |
#' | vps | double | The feed's vps ratio with two decimals; its definition is unverified (it matches neither points per shot nor rate per minute). |
#' | fg2a | integer | Two-point field goals attempted, derived as made + missed. |
#' | fg3a | integer | Three-point field goals attempted, derived as made + missed. |
#' | fta | integer | Free throws attempted, derived as made + missed. |
#' | pts_from_turnovers | integer | Points scored off opponent turnovers (the feed renamed the key in 2026-27). |
#' | pts_in_paint | integer | Points scored in the paint (the feed renamed the key in 2026-27). |
#' | starting_points | integer | Points scored by the starting five. |
#' | bench_points | integer | Points scored by the bench. |
#' | fast_break_possessions | integer | The N of the feed's 'P of N' fast-break stat (fast-break possessions or attempts); unverified. Null before 2026-27 where the key differs. |
#' | defensive_stops | integer | Defensive stops; the feed adds it in 2026-27, null before. |
#' | biggest_scoring_run | character | Biggest scoring run as the feed prints it ('23-0 (36-6)'); 2026-27 on, null before. |
#' @family IBBA Segev
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
#' @inherit ibba_segev_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
#' | period | integer | Period number (1-4 regulation, 5+ overtime). |
#' | home_points | integer | Points the home side scored IN this period (not cumulative). |
#' | away_points | integer | Points the away side scored IN this period (not cumulative). |
#' | home_fouls | integer | Team fouls the home side committed in this period. |
#' | away_fouls | integer | Team fouls the away side committed in this period. |
#' @family IBBA Segev
#' @export
#' @examples
#' \donttest{
#'   try(ibba_segev_period_scores(game_id = 50))
#' }
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
#' @inherit ibba_segev_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Segev game id (key space: one flat sequence across seasons and competitions); equals the IBBA ibba_games segev_game_id from 2025-26. Not an IBBA game id. |
#' | action_id | integer | Action id (key space: Segev actions; unique and increasing within one game, 500001 ... for game 50). |
#' | parent_action_id | integer | Id of the action this one follows from (rebound -> missed shot, steal -> turnover, assist or block -> shot); null when none. |
#' | period | integer | Period number (1-4 regulation, 5+ overtime). |
#' | clock | character | Game clock remaining in the period as 'mm:ss', counting down from 10:00. |
#' | user_time_utc | character | Wall-clock time the scorer logged the action, 'HH:MM:SS', UTC (inferred: game 50 tipped at 18:40 Israel time and its first tick reads 15:42). |
#' | type | character | Action type: game, quarter, clock, substitution, shot, freeThrow, rebound, assist, steal, turnover, block, deflection, foul, foul-drawn or timeout. |
#' | subtype | character | Subtype by type: shot jump-shot / lay-up / dunk; rebound offensive / defensive; turnover bad-pass, ball-handling, travelling, ...; foul personal / technical / unsportsmanlike; start-of-game, end-of-quarter, ... |
#' | team_id | integer | Segev team id of the acting side (stable across seasons); null on game-level actions. |
#' | player_id | integer | Segev player id (key space: Segev players, stable across seasons: Jaylen Hoard = 1000 in games 50 and 419); null on team lines and on actions without a player. Not an IBBA player-season id. |
#' | team_side | character | Side of the game: home or away (the feed's homeTeam / awayTeam; an action's parameters.team 1 = home, 2 = away). |
#' | jersey | character | Jersey number (a string, not an id) of the acting player; null when none (team rebound, timeout). |
#' | score_away | integer | Away running score after a scoring action (the feed's score reads away-home); null otherwise. |
#' | score_home | integer | Home running score after a scoring action; null otherwise. |
#' | player_points | integer | The scorer's running points after a scoring action; null otherwise. |
#' | points | integer | Shot value, 2 or 3; null on other actions. |
#' | made | character | Shot or free-throw result: made, missed, or blocked (shots only). |
#' | x | double | Shot x: across the half court, sideline to sideline, 0-1470, basket near 735; which sideline is 0 and the metric scale are unverified. |
#' | y | double | Shot y: distance out from the baseline, rim near 112-140, deepest observed 1176; metric scale unverified. |
#' | fast_break | logical | True when the shot or free throw came on a fast break. |
#' | second_chance | logical | True when the attempt followed an offensive rebound. |
#' | points_from_turnover | logical | True when the attempt came off an opponent turnover. |
#' | free_throw_number | integer | Which free throw of the set (1, 2, 3). |
#' | free_throws_awarded | integer | Free throws in the set. |
#' | foul_kind | character | Foul kind, shooting or offensive; absent on some fouls. 'shooting' also appears on technical and offensive-unsportsmanlike fouls, so it does not prove a shooting foul. |
#' | fouled_on_jersey | character | Jersey number (string) of the fouled player. |
#' | foul_free_throws | integer | Free throws the foul awards (the feed sends a string when non-zero, 0 otherwise). |
#' | is_coach_foul | logical | True on a foul charged to the coach or bench (player_id null); null otherwise. |
#' | player_in_jersey | character | Substitution: jersey of the player coming in; null on the row that records the player going out. |
#' | player_out_jersey | character | Substitution: jersey of the player going out; null on the row that records the player coming in. |
#' @family IBBA Segev
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
