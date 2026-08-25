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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab integer \tab CollegeBasketballData game id. \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       season_type \tab character \tab Season type. \cr
#'       start_date \tab character \tab Game start date (ISO 8601). \cr
#'       home_team_id \tab integer \tab Home team id. \cr
#'       home_team \tab character \tab Home team name. \cr
#'       home_conference \tab character \tab Home team conference. \cr
#'       home_score \tab numeric \tab Home team final score. \cr
#'       away_team_id \tab integer \tab Away team id. \cr
#'       away_team \tab character \tab Away team name. \cr
#'       away_conference \tab character \tab Away team conference. \cr
#'       away_score \tab numeric \tab Away team final score. \cr
#'       lines \tab list \tab Nested list of per-provider betting lines. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname cbbd_lines
#' @description
#' **Get betting line providers from the CollegeBasketballData API.**
#' @return A `hoopR_data` tibble with one row per line provider:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab Line provider id. \cr
#'       name \tab character \tab Line provider name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
