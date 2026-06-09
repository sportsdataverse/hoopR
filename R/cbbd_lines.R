#' @title
#' **CBD Betting Lines**
#' @description
#' **Get game betting lines from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @return A `hoopR_data` tibble with one row per game. The `lines` column is a
#'   nested list of per-provider lines:
#'
#'    |col_name        |types     |description                                 |
#'    |:---------------|:---------|:-------------------------------------------|
#'    |game_id         |integer   |CollegeBasketballData game id.              |
#'    |season          |integer   |Season (4-digit ending-year).               |
#'    |season_type     |character |Season type.                                |
#'    |start_date      |character |Game start date (ISO 8601).                 |
#'    |home_team_id    |integer   |Home team id.                               |
#'    |home_team       |character |Home team name.                             |
#'    |home_conference |character |Home team conference.                       |
#'    |home_score      |numeric   |Home team final score.                      |
#'    |away_team_id    |integer   |Away team id.                               |
#'    |away_team       |character |Away team name.                             |
#'    |away_conference |character |Away team conference.                       |
#'    |away_score      |numeric   |Away team final score.                      |
#'    |lines           |list      |Nested list of per-provider betting lines.  |
#'
#' @keywords CBD Lines
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Lines Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_lines(season = 2024, team = "Duke"))
#' }
cbbd_lines <- function(season = most_recent_mbb_season(), team = NULL, conference = NULL,
                       start_date_range = NULL, end_date_range = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/lines", query = list(
        season = season, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Betting Lines from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no betting lines available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD betting lines", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Line Providers**
#' @description
#' **Get betting line providers from the CollegeBasketballData API.**
#' @return A `hoopR_data` tibble with one row per line provider:
#'
#'    |col_name |types     |description                                       |
#'    |:--------|:---------|:-------------------------------------------------|
#'    |id       |integer   |Line provider id.                                 |
#'    |name     |character |Line provider name.                               |
#'
#' @keywords CBD Lines
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Lines Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_lines_providers())
#' }
cbbd_lines_providers <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/lines/providers")
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Line Providers from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no line providers available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD line providers", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
