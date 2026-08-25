#' @title
#' **CBD Team Lineups**
#' @rdname cbbd_lineups_game
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_id \tab integer \tab Team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Conference name. \cr
#'       id_hash \tab character \tab Unique hash identifying the lineup. \cr
#'       athletes \tab list \tab List of athletes in the lineup. \cr
#'       total_seconds \tab numeric \tab Total seconds the lineup played. \cr
#'       pace \tab numeric \tab Lineup pace (possessions). \cr
#'       offense_rating \tab numeric \tab Lineup offensive rating. \cr
#'       defense_rating \tab numeric \tab Lineup defensive rating. \cr
#'       net_rating \tab numeric \tab Lineup net rating. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
