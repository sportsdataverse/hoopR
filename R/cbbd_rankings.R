#' @title
#' **CBD Rankings**
#' @description
#' **Get poll rankings (AP / Coaches) from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param season_type (*character* optional): One of `regular`, `postseason`,
#'   `preseason`.
#' @param week (*integer* optional): Poll week filter.
#' @param poll_type (*character* optional): One of `ap`, `coaches`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per ranked team per poll:
#'
#'    |col_name          |types     |description                                 |
#'    |:-----------------|:---------|:-------------------------------------------|
#'    |season            |integer   |Season (4-digit ending-year).               |
#'    |season_type       |character |Season type.                                |
#'    |week              |integer   |Poll week.                                  |
#'    |poll_date         |character |Date the poll was released.                 |
#'    |poll_type         |character |Poll type (`ap` or `coaches`).              |
#'    |team_id           |integer   |CollegeBasketballData team id.              |
#'    |team              |character |Team name.                                  |
#'    |conference        |character |Conference name.                            |
#'    |ranking           |integer   |Poll rank.                                  |
#'    |points            |numeric   |Poll points received.                       |
#'    |first_place_votes |numeric   |Number of first-place votes.                |
#'
#' @keywords CBD Rankings
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Rankings Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_rankings(season = 2024, poll_type = "ap"))
#' }
cbbd_rankings <- function(season = most_recent_mbb_season(), season_type = NULL,
                          week = NULL, poll_type = NULL, team = NULL, conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/rankings", query = list(
        season = season, seasonType = season_type, week = week,
        pollType = poll_type, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Rankings from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no rankings data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD rankings", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
