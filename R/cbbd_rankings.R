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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       season_type \tab character \tab Season type. \cr
#'       week \tab integer \tab Poll week. \cr
#'       poll_date \tab character \tab Date the poll was released. \cr
#'       poll_type \tab character \tab Poll type (\code{ap} or \code{coaches}). \cr
#'       team_id \tab integer \tab CollegeBasketballData team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Conference name. \cr
#'       ranking \tab integer \tab Poll rank. \cr
#'       points \tab numeric \tab Poll points received. \cr
#'       first_place_votes \tab numeric \tab Number of first-place votes. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
