#' @title
#' **CBD SRS Ratings**
#' @description
#' **Get Simple Rating System (SRS) ratings from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* optional): Team name filter (e.g. `Duke`).
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per team-season:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       team_id \tab integer \tab CollegeBasketballData team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Conference name. \cr
#'       rating \tab numeric \tab Simple Rating System (SRS) value. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords CBD Ratings
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Ratings Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_ratings_srs(season = 2024))
#' }
cbbd_ratings_srs <- function(season = most_recent_mbb_season(), team = NULL, conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/ratings/srs", query = list(season = season, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD SRS Ratings from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no SRS ratings available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD SRS ratings", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @rdname cbbd_ratings_srs
#' @title
#' **CBD Adjusted Efficiency Ratings**
#' @description
#' **Get adjusted efficiency ratings from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per team-season. `rankings_*`
#'   columns are flattened from the nested `rankings` object:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       team_id \tab integer \tab CollegeBasketballData team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Conference name. \cr
#'       offensive_rating \tab numeric \tab Adjusted offensive efficiency rating. \cr
#'       defensive_rating \tab numeric \tab Adjusted defensive efficiency rating. \cr
#'       net_rating \tab numeric \tab Adjusted net efficiency rating. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords CBD Ratings
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Ratings Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_ratings_adjusted(season = 2024))
#' }
cbbd_ratings_adjusted <- function(season = most_recent_mbb_season(), team = NULL, conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/ratings/adjusted", query = list(season = season, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Adjusted Efficiency Ratings from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no adjusted ratings available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD adjusted ratings", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @rdname cbbd_ratings_srs
#' @title
#' **CBD Elo Ratings**
#' @description
#' **Get Elo ratings from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per team-season:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       team_id \tab integer \tab CollegeBasketballData team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Conference name. \cr
#'       elo \tab integer \tab End-of-season Elo rating. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords CBD Ratings
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Ratings Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_ratings_elo(season = 2024))
#' }
cbbd_ratings_elo <- function(season = most_recent_mbb_season(), team = NULL, conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/ratings/elo", query = list(season = season, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Elo Ratings from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no Elo ratings available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD Elo ratings", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
