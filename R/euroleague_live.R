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
#' wraps it. This
#' function mirrors sportsdataverse-py's `euroleague_game_points()`: same arguments,
#' defaults and snake_case columns, one row per sportsdataverse-py row.
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
#' @eval .returns_rd("euroleague_game_points", inline = FALSE, unit = "shot")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
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
#' @eval .returns_rd("euroleague_game_pbp", inline = FALSE, unit = "play")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
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
#' @eval .returns_rd("euroleague_game_boxscore", inline = FALSE, unit = "player, plus two team rows per side")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
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
#' wraps it. This
#' function mirrors its sportsdataverse-py twin of the same name: same arguments, defaults
#' and snake_case columns, one row per sportsdataverse-py row.
#'
#' The live API's codes are space-padded fixed-width strings
#' (`TEAM = "IST       "`); every string cell is stripped. Its "no such game"
#' answer is an **empty 200 body**, returned as a zero-row tibble with the
#' documented columns (not an error). A 404 raises `hoopR_no_data`, a 400 / 422
#' `hoopR_invalid_request`, any other failure `hoopR_fetch_error` (all inherit
#' `hoopR_error`).
#' @inheritParams euroleague_game_points
#' @eval .returns_rd("euroleague_game_header", inline = FALSE, unit = "game")
#' @concept Euroleague
#' @seealso [family_euroleague] lists every function in this family.
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
