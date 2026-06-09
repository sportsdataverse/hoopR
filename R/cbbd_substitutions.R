#' @title
#' **CBD Substitutions by Game**
#' @description
#' **Get substitution data for a single game from the CollegeBasketballData API.**
#' @param game_id (*integer* required): CollegeBasketballData game id. See
#'   [cbbd_games()].
#' @return A `hoopR_data` tibble with one row per substitution. `sub_in` and
#'   `sub_out` objects are flattened to `sub_in_*` / `sub_out_*` columns:
#'
#'    |col_name            |types     |description                             |
#'    |:-------------------|:---------|:---------------------------------------|
#'    |game_id             |integer   |Game id.                                |
#'    |start_date          |character |Game start date (ISO 8601).             |
#'    |team_id             |integer   |Team id.                                |
#'    |team                |character |Team name.                              |
#'    |conference          |character |Team conference.                        |
#'    |athlete_id          |integer   |Athlete id.                             |
#'    |athlete             |character |Athlete name.                           |
#'    |position            |character |Athlete position.                       |
#'    |opponent_id         |integer   |Opponent team id.                       |
#'    |opponent            |character |Opponent team name.                     |
#'    |opponent_conference |character |Opponent conference.                    |
#'
#' @keywords CBD Substitutions
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Substitutions Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_substitutions_game(game_id = 5881))
#' }
cbbd_substitutions_game <- function(game_id) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get(paste0("/substitutions/game/", game_id))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Substitutions by Game from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no substitution data available for {game_id}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD substitutions for game {game_id}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Substitutions by Player**
#' @description
#' **Get substitution data for a single player from the CollegeBasketballData API.**
#' @param player_id (*integer* required): Athlete id.
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per substitution (same columns as
#'   [cbbd_substitutions_game()]).
#' @keywords CBD Substitutions
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Substitutions Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_substitutions_player(player_id = 160, season = 2024))
#' }
cbbd_substitutions_player <- function(player_id, season = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get(paste0("/substitutions/player/", player_id), query = list(season = season))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Substitutions by Player from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no substitution data available for player {player_id}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD substitutions for player {player_id}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Substitutions by Team**
#' @description
#' **Get substitution data for a team-season from the CollegeBasketballData API.**
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* required): Team name (e.g. `Duke`).
#' @return A `hoopR_data` tibble with one row per substitution (same columns as
#'   [cbbd_substitutions_game()]).
#' @keywords CBD Substitutions
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Substitutions Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_substitutions_team(season = 2024, team = "Duke"))
#' }
cbbd_substitutions_team <- function(season = most_recent_mbb_season(), team) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/substitutions/team", query = list(season = season, team = team))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Substitutions by Team from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no substitution data available for {team}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD substitutions for team {team}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
