#' @title
#' **CBD Team Lineups**
#' @description
#' **Get lineup statistics for a team-season from the CollegeBasketballData API.**
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* required): Team name (e.g. `Duke`).
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @return A `hoopR_data` tibble with one row per lineup. The `athletes` column
#'   is a list of lineup members; `team_stats`/`opponent_stats` are flattened
#'   into prefixed columns. Key identifying columns:
#'
#'    |col_name       |types     |description                                  |
#'    |:--------------|:---------|:--------------------------------------------|
#'    |team_id        |integer   |Team id.                                      |
#'    |team           |character |Team name.                                    |
#'    |conference     |character |Conference name.                              |
#'    |id_hash        |character |Unique hash identifying the lineup.           |
#'    |athletes       |list      |List of athletes in the lineup.               |
#'    |total_seconds  |numeric   |Total seconds the lineup played.              |
#'    |pace           |numeric   |Lineup pace (possessions).                    |
#'    |offense_rating |numeric   |Lineup offensive rating.                      |
#'    |defense_rating |numeric   |Lineup defensive rating.                      |
#'    |net_rating     |numeric   |Lineup net rating.                            |
#'
#' @keywords CBD Lineups
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Lineups Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_lineups_team(season = 2024, team = "Duke"))
#' }
cbbd_lineups_team <- function(season = most_recent_mbb_season(), team,
                              start_date_range = NULL, end_date_range = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/lineups/team", query = list(
        season = season, team = team, startDateRange = start_date_range, endDateRange = end_date_range))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Team Lineups from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no lineup data available for {team}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team lineups for {team}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Game Lineups**
#' @description
#' **Get lineup statistics for a single game from the CollegeBasketballData API.**
#' @param game_id (*integer* required): CollegeBasketballData game id. See
#'   [cbbd_games()].
#' @return A `hoopR_data` tibble with one row per lineup (same columns as
#'   [cbbd_lineups_team()]).
#' @keywords CBD Lineups
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Lineups Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_lineups_game(game_id = 5881))
#' }
cbbd_lineups_game <- function(game_id) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get(paste0("/lineups/game/", game_id))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Game Lineups from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no lineup data available for {game_id}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD game lineups for {game_id}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
