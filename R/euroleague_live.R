#' @title
#' **EuroLeague Game Points (shot chart)**
#' @description
#' **Get the shot chart of one game from the live API: one row per made / missed
#' field goal and per made free throw, with `coord_x` / `coord_y` in centimeters
#' from the hoop.**
#'
#' Endpoint: `GET https://live.euroleague.net/api/Points?gamecode={game_code}&seasoncode={season_code}`
#'
#' `Points` is the shot-chart source: one row per field-goal attempt
#' (`id_action` `2FGM` / `2FGA` / `3FGM` / `3FGA`) and per made free throw
#' (`FTM`), with `coord_x` / `coord_y`, `zone`, the `fastbreak` /
#' `second_chance` / `points_off_turnover` flags, the running score
#' (`points_a` / `points_b`), `minute`, the game clock (`console`) and a `utc`
#' timestamp. Team A is the home side as measured on one game.
#' @details
#' Unofficial, keyless API, not supported by Euroleague Basketball; hoopR only
#' wraps it (wrap-only: payloads are not redistributed as release assets). This
#' function mirrors sdv-py's `euroleague_game_points()`: same arguments,
#' defaults and snake_case columns, one row per sdv-py row.
#'
#' **Coordinate frame**, as measured in the reference capture (E2025 game 1,
#' 158 rows; U2025 game 1, 176 rows):
#'
#' * **Units: integer centimeters. Origin: the hoop.** 2FG radii run 8-512 cm,
#'   3FG radii 722-925 cm (the FIBA arc is 675 cm), zone `A` (rim) sits at
#'   radius 8-33 cm.
#' * **Both teams are mapped onto one basket; `coord_y` grows away from the
#'   baseline toward the court** (-6 to 865 cm for every team on the E game,
#'   -69 to 1028 on the U game; 3FG rows sit at y 414-865). Negative y is
#'   behind the hoop (the U game has a few rows up to 69 cm behind it, i.e.
#'   under or behind the backboard).
#' * `coord_x` is signed left / right of the hoop (-683 to 696 cm); 3-point
#'   zone `H` is x < 0 and `I` is x > 0. Which sideline is positive (from the
#'   shooter's view or from the scorer's table) is **UNVERIFIED** from the data
#'   alone.
#' * **Free throws are not located**: `FTM` rows carry `coord_x = coord_y = -1`
#'   and `zone = ""` (a sentinel, not a spot 1 cm from the hoop). Filter them
#'   out before plotting.
#' * `zone` letters A-I: A rim, B / C close left / right, D / E mid, F / G long
#'   two, H / I three.
#'
#' The live API's codes are space-padded fixed-width strings
#' (`TEAM = "IST       "`); every string cell is stripped. Its "no such game"
#' answer is an **empty 200 body**, returned as a zero-row tibble with the
#' documented columns (not an error). A 404 raises `hoopR_no_data`, a 400 / 422
#' `hoopR_invalid_request`, any other failure `hoopR_fetch_error` (all inherit
#' `hoopR_error`).
#' @param game_code (*integer* required): Game number within the season (1-based;
#'   the `game_code` column of [euroleague_games()]).
#' @param season_code (*character* required): Competition code + start year:
#'   `E2025` (EuroLeague 2025-26), `U2025` (EuroCup).
#' @return A `hoopR_data` tibble with one row per shot:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       num_anot \tab integer \tab Sequence number of the scoring annotation within the game. \cr
#'       team \tab character \tab EuroLeague club code of the team (Utf8 join key; space padding stripped). \cr
#'       id_player \tab character \tab EuroLeague player code (Utf8 join key; space padding stripped). \cr
#'       player \tab character \tab Player display name (SURNAME, GIVEN NAME). \cr
#'       id_action \tab character \tab Shot type code: 2FGM / 2FGA / 3FGM / 3FGA (made / attempted field goal) or FTM (made free throw). \cr
#'       action \tab character \tab Shot type label (Two Pointer, Three Pointer, Free Throw In, ...). \cr
#'       points \tab integer \tab Points the shot is worth (1, 2 or 3). \cr
#'       coord_x \tab integer \tab Shot x in integer centimeters from the hoop, signed left/right of it (-683 to 696 cm measured): both teams are mapped onto one basket; 3-point zone H is x < 0 and I is x > 0; which sideline is positive (from the shooter's view or from the scorer's table) is UNVERIFIED from the data alone. Made free throws (FTM) carry the -1 sentinel. \cr
#'       coord_y \tab integer \tab Shot y in integer centimeters from the hoop, growing away from the baseline toward the court (-6 to 865 cm measured; 3FG rows at 414-865): both teams are mapped onto one basket, negative y is behind the hoop. Made free throws (FTM) carry the -1 sentinel. \cr
#'       zone \tab character \tab Court zone letter: A rim, B/C close left/right, D/E mid, F/G long two, H/I three; blank on free throws. \cr
#'       fastbreak \tab character \tab Whether the shot came on a fast break (0 / 1 as a string). \cr
#'       second_chance \tab character \tab Whether the shot was a second-chance attempt (0 / 1 as a string). \cr
#'       points_off_turnover \tab character \tab Whether the shot came off a turnover (0 / 1 as a string). \cr
#'       minute \tab integer \tab Game minute of the event (1-based; 41+ in overtime). \cr
#'       console \tab character \tab Game clock at the event (mm:ss remaining in the period). \cr
#'       points_a \tab integer \tab Running score of team A (= the home side, measured on one game) after the event. \cr
#'       points_b \tab integer \tab Running score of team B (= the away side, measured on one game) after the event. \cr
#'       utc \tab character \tab UTC timestamp of the event (yyyymmddHHMMSS). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
#' @export
#' @examples
#' \donttest{
#'   try({
#'     shots <- euroleague_game_points(game_code = 1, season_code = "E2025")
#'     shots[shots$id_action != "FTM", c("team", "id_action", "coord_x", "coord_y", "zone")]
#'   })
#' }
euroleague_game_points <- function(game_code, season_code) {
  raw <- euroleague_api("/Points", params = list(gamecode = game_code, seasoncode = season_code), host = "live")
  .euroleague_data(.euroleague_points(raw), "game points (shot chart)", "live.euroleague.net")
}

#' @title
#' **EuroLeague Game Play-by-Play**
#' @description
#' **Get the play-by-play of one game from the live API, one row per play.**
#'
#' Endpoint: `GET https://live.euroleague.net/api/PlayByPlay?gamecode={game_code}&seasoncode={season_code}`
#'
#' The body carries one array per period (`FirstQuarter`, `SecondQuarter`,
#' `ThirdQuarter`, `ForthQuarter` (sic), `ExtraTime`) beside the two team names
#' and codes. The arrays are unrolled in game order with a leading `quarter`
#' column (1-4; 5 for every overtime period, which the body does not split
#' further) and the `team_a` / `team_b` / `code_team_a` / `code_team_b` header
#' fields repeated on every row. Team A is the home side as measured on one
#' game.
#' @inherit euroleague_game_header details
#' @inheritParams euroleague_game_points
#' @return A `hoopR_data` tibble with one row per play:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       quarter \tab integer \tab Period of the play: 1-4, or 5 for every overtime period. \cr
#'       team_a \tab character \tab Display name of team A (= the home side, measured on one game). \cr
#'       team_b \tab character \tab Display name of team B (= the away side, measured on one game). \cr
#'       code_team_a \tab character \tab EuroLeague club code of team A (= the home side, measured on one game); Utf8 join key. \cr
#'       code_team_b \tab character \tab EuroLeague club code of team B (= the away side, measured on one game); Utf8 join key. \cr
#'       type \tab integer \tab Play type (engine integer). \cr
#'       numberofplay \tab integer \tab Sequence number of the play within the game. \cr
#'       codeteam \tab character \tab EuroLeague club code of the team on the play (Utf8 join key; blank on administrative plays). \cr
#'       player_id \tab character \tab EuroLeague player code (Utf8 join key; space padding stripped; blank on team rows). \cr
#'       playtype \tab character \tab Play type code (BP = begin period, 2FGM, 3FGA, FTM, AS = assist, TO, RV, CM, ...). \cr
#'       player \tab character \tab Player display name (SURNAME, GIVEN NAME). \cr
#'       team \tab character \tab Display name of the team on the play (null on administrative plays). \cr
#'       dorsal \tab character \tab Jersey number as displayed. \cr
#'       minute \tab integer \tab Game minute of the event (1-based; 41+ in overtime). \cr
#'       markertime \tab character \tab Game clock at the play (mm:ss remaining in the period). \cr
#'       points_a \tab integer \tab Running score of team A (= the home side, measured on one game) after the event. \cr
#'       points_b \tab integer \tab Running score of team B (= the away side, measured on one game) after the event. \cr
#'       comment \tab character \tab Free-text annotation of the play. \cr
#'       playinfo \tab character \tab Play description. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
#' @export
#' @examples
#' \donttest{
#'   try({
#'     pbp <- euroleague_game_pbp(game_code = 1, season_code = "E2025")
#'     table(pbp$codeteam[pbp$playtype %in% c("2FGM", "3FGM", "FTM")])
#'   })
#' }
euroleague_game_pbp <- function(game_code, season_code) {
  raw <- euroleague_api("/PlayByPlay", params = list(gamecode = game_code, seasoncode = season_code), host = "live")
  .euroleague_data(.euroleague_pbp(raw), "game play-by-play", "live.euroleague.net")
}

#' @title
#' **EuroLeague Game Box Score (live API)**
#' @description
#' **Get the box score of one game from the live API: one row per player plus
#' each side's team-only and totals rows, with by-quarter scores, referees and
#' attendance repeated on every row.**
#'
#' Endpoint: `GET https://live.euroleague.net/api/Boxscore?gamecode={game_code}&seasoncode={season_code}`
#'
#' `Stats` holds one object per side (`Team`, `Coach`, `PlayersStats`, `tmr` =
#' team-only rebounds, `totr` = totals). Each side's players become rows tagged
#' `row_type = "player"`, followed by the side's `"team"` and `"total"` rows.
#' Every row also carries the game's `attendance` and `referees` and, for the
#' row's side, `team_name`, `coach`, the points scored per quarter
#' (`by_quarter_q1` ...) and the cumulative score at the end of each quarter
#' (`end_of_quarter_q1` ...).
#' @inherit euroleague_game_header details
#' @inheritParams euroleague_game_points
#' @return A `hoopR_data` tibble with one row per player plus two per side:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       row_type \tab character \tab Row kind: player, team (team-only rebounds) or total (side totals). \cr
#'       team_name \tab character \tab Club display name. \cr
#'       coach \tab character \tab Head coach name. \cr
#'       attendance \tab character \tab Attendance, as reported by the box score (repeated on every row). \cr
#'       referees \tab character \tab Referees of the game, comma-separated SURNAME, GIVEN NAME (repeated on every row). \cr
#'       by_quarter_q1 \tab integer \tab Points the row's team scored in quarter 1 (from the box score's ByQuarter block). \cr
#'       by_quarter_q2 \tab integer \tab Points the row's team scored in quarter 2 (from the box score's ByQuarter block). \cr
#'       by_quarter_q3 \tab integer \tab Points the row's team scored in quarter 3 (from the box score's ByQuarter block). \cr
#'       by_quarter_q4 \tab integer \tab Points the row's team scored in quarter 4 (from the box score's ByQuarter block). \cr
#'       end_of_quarter_q1 \tab integer \tab Score of the row's team at the end of quarter 1 (cumulative; from the box score's EndOfQuarter block). \cr
#'       end_of_quarter_q2 \tab integer \tab Score of the row's team at the end of quarter 2 (cumulative; from the box score's EndOfQuarter block). \cr
#'       end_of_quarter_q3 \tab integer \tab Score of the row's team at the end of quarter 3 (cumulative; from the box score's EndOfQuarter block). \cr
#'       end_of_quarter_q4 \tab integer \tab Score of the row's team at the end of quarter 4 (cumulative; from the box score's EndOfQuarter block). \cr
#'       player_id \tab character \tab EuroLeague player code (Utf8 join key; space padding stripped; blank on team rows). \cr
#'       is_starter \tab integer \tab Whether the player started (1 / 0). \cr
#'       is_playing \tab integer \tab Whether the player appeared in the game (1 / 0). \cr
#'       team \tab character \tab EuroLeague club code of the team (Utf8 join key; space padding stripped). \cr
#'       dorsal \tab character \tab Jersey number as displayed. \cr
#'       player \tab character \tab Player display name (SURNAME, GIVEN NAME). \cr
#'       minutes \tab character \tab Minutes played (mm:ss). \cr
#'       points \tab integer \tab Points. \cr
#'       field_goals_made2 \tab integer \tab Two-point field goals made. \cr
#'       field_goals_attempted2 \tab integer \tab Two-point field goals attempted. \cr
#'       field_goals_made3 \tab integer \tab Three-point field goals made. \cr
#'       field_goals_attempted3 \tab integer \tab Three-point field goals attempted. \cr
#'       free_throws_made \tab integer \tab Free throws made. \cr
#'       free_throws_attempted \tab integer \tab Free throws attempted. \cr
#'       offensive_rebounds \tab integer \tab Offensive rebounds. \cr
#'       defensive_rebounds \tab integer \tab Defensive rebounds. \cr
#'       total_rebounds \tab integer \tab Total rebounds. \cr
#'       assistances \tab integer \tab Assists. \cr
#'       steals \tab integer \tab Steals. \cr
#'       turnovers \tab integer \tab Turnovers. \cr
#'       blocks_favour \tab integer \tab Blocks made. \cr
#'       blocks_against \tab integer \tab Shots blocked by the opponent. \cr
#'       fouls_commited \tab integer \tab Personal fouls committed. \cr
#'       fouls_received \tab integer \tab Fouls drawn. \cr
#'       valuation \tab integer \tab Performance index rating (PIR). \cr
#'       plusminus \tab numeric \tab Plus/minus. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
#' @export
#' @examples
#' \donttest{
#'   try({
#'     box <- euroleague_game_boxscore(game_code = 1, season_code = "E2025")
#'     box[box$row_type == "player", c("team", "player", "minutes", "points", "valuation")]
#'   })
#' }
euroleague_game_boxscore <- function(game_code, season_code) {
  raw <- euroleague_api("/Boxscore", params = list(gamecode = game_code, seasoncode = season_code), host = "live")
  .euroleague_data(.euroleague_boxscore(raw), "game box score", "live.euroleague.net")
}

#' @title
#' **EuroLeague Game Header**
#' @description
#' **Get the header of one game from the live API: teams, codes, coaches, score
#' by quarter, venue, referees, one row.**
#'
#' Endpoint: `GET https://live.euroleague.net/api/Header?gamecode={game_code}&seasoncode={season_code}`
#'
#' The header is a flat object: teams, codes, coaches, the score and the
#' **cumulative** score at the end of each quarter (`score_quarter1_a` ...),
#' venue, capacity (as reported; its semantics are unverified) and referees.
#' Team A is the home side as measured on one game.
#' @details
#' Unofficial, keyless API, not supported by Euroleague Basketball; hoopR only
#' wraps it (wrap-only: payloads are not redistributed as release assets). This
#' function mirrors its sdv-py twin of the same name: same arguments, defaults
#' and snake_case columns, one row per sdv-py row.
#'
#' The live API's codes are space-padded fixed-width strings
#' (`TEAM = "IST       "`); every string cell is stripped. Its "no such game"
#' answer is an **empty 200 body**, returned as a zero-row tibble with the
#' documented columns (not an error). A 404 raises `hoopR_no_data`, a 400 / 422
#' `hoopR_invalid_request`, any other failure `hoopR_fetch_error` (all inherit
#' `hoopR_error`).
#' @inheritParams euroleague_game_points
#' @return A `hoopR_data` tibble with one row (the game):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       live \tab logical \tab Whether the game is in progress. \cr
#'       round \tab character \tab Round label (e.g. Round 1). \cr
#'       date \tab character \tab Game date (venue local, dd/mm/yyyy). \cr
#'       hour \tab character \tab Scheduled tip-off time (venue local, HH:MM). \cr
#'       stadium \tab character \tab Venue name. \cr
#'       capacity \tab character \tab Capacity as reported by the API (equals the box score's attendance on the captured game; semantics unverified). \cr
#'       team_a \tab character \tab Display name of team A (= the home side, measured on one game). \cr
#'       team_b \tab character \tab Display name of team B (= the away side, measured on one game). \cr
#'       code_team_a \tab character \tab EuroLeague club code of team A (= the home side, measured on one game); Utf8 join key. \cr
#'       tv_code_a \tab character \tab Three-letter broadcast abbreviation of team A. \cr
#'       code_team_b \tab character \tab EuroLeague club code of team B (= the away side, measured on one game); Utf8 join key. \cr
#'       tv_code_b \tab character \tab Three-letter broadcast abbreviation of team B. \cr
#'       im_a \tab character \tab Crest image file name of team A. \cr
#'       im_b \tab character \tab Crest image file name of team B. \cr
#'       score_a \tab character \tab Score of team A (= the home side, measured on one game). \cr
#'       score_b \tab character \tab Score of team B (= the away side, measured on one game). \cr
#'       coach_a \tab character \tab Head coach of team A. \cr
#'       coach_b \tab character \tab Head coach of team B. \cr
#'       game_time \tab character \tab Elapsed game time (mm:ss). \cr
#'       remaining_partial_time \tab character \tab Time remaining in the current period (mm:ss). \cr
#'       wid \tab character \tab Live-feed widget identifier of the game. \cr
#'       quarter \tab character \tab Current period of the game. \cr
#'       foults_a \tab character \tab Team fouls of team A in the current period (sic: the API spells it this way). \cr
#'       foults_b \tab character \tab Team fouls of team B in the current period (sic: the API spells it this way). \cr
#'       timeouts_a \tab character \tab Timeouts used by team A. \cr
#'       timeouts_b \tab character \tab Timeouts used by team B. \cr
#'       score_quarter1_a \tab integer \tab Score of team A at the end of quarter 1 (cumulative). \cr
#'       score_quarter2_a \tab integer \tab Score of team A at the end of quarter 2 (cumulative). \cr
#'       score_quarter3_a \tab integer \tab Score of team A at the end of quarter 3 (cumulative). \cr
#'       score_quarter4_a \tab integer \tab Score of team A at the end of quarter 4 (cumulative). \cr
#'       score_extra_time_a \tab integer \tab Points scored by team A in overtime (0 when none). \cr
#'       score_quarter1_b \tab integer \tab Score of team B at the end of quarter 1 (cumulative). \cr
#'       score_quarter2_b \tab integer \tab Score of team B at the end of quarter 2 (cumulative). \cr
#'       score_quarter3_b \tab integer \tab Score of team B at the end of quarter 3 (cumulative). \cr
#'       score_quarter4_b \tab integer \tab Score of team B at the end of quarter 4 (cumulative). \cr
#'       score_extra_time_b \tab integer \tab Points scored by team B in overtime (0 when none). \cr
#'       phase \tab character \tab Phase name (Regular Season, Playoffs, ...). \cr
#'       phase_reduced_name \tab character \tab Short phase name. \cr
#'       competition \tab character \tab Competition name. \cr
#'       competition_reduced_name \tab character \tab Short competition name. \cr
#'       pcom \tab character \tab Competition code of the live feed (E = EuroLeague, U = EuroCup). \cr
#'       referee1 \tab character \tab First referee. \cr
#'       referee2 \tab character \tab Second referee. \cr
#'       referee3 \tab character \tab Third referee. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @family Euroleague
#' @export
#' @examples
#' \donttest{
#'   try({
#'     euroleague_game_header(game_code = 1, season_code = "E2025")
#'   })
#' }
euroleague_game_header <- function(game_code, season_code) {
  raw <- euroleague_api("/Header", params = list(gamecode = game_code, seasoncode = season_code), host = "live")
  .euroleague_data(.euroleague_header(raw), "game header", "live.euroleague.net")
}
