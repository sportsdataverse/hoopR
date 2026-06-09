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
#'    |col_name   |types     |description                                    |
#'    |:----------|:---------|:----------------------------------------------|
#'    |season     |integer   |Season (4-digit ending-year).                  |
#'    |team_id    |integer   |CollegeBasketballData team id.                 |
#'    |team       |character |Team name.                                     |
#'    |conference |character |Conference name.                               |
#'    |rating     |numeric   |Simple Rating System (SRS) value.              |
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

#' @title
#' **CBD Adjusted Efficiency Ratings**
#' @description
#' **Get adjusted efficiency ratings from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per team-season. `rankings_*`
#'   columns are flattened from the nested `rankings` object:
#'
#'    |col_name         |types     |description                                  |
#'    |:----------------|:---------|:--------------------------------------------|
#'    |season           |integer   |Season (4-digit ending-year).                |
#'    |team_id          |integer   |CollegeBasketballData team id.               |
#'    |team             |character |Team name.                                   |
#'    |conference       |character |Conference name.                             |
#'    |offensive_rating |numeric   |Adjusted offensive efficiency rating.        |
#'    |defensive_rating |numeric   |Adjusted defensive efficiency rating.        |
#'    |net_rating       |numeric   |Adjusted net efficiency rating.              |
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

#' @title
#' **CBD Elo Ratings**
#' @description
#' **Get Elo ratings from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per team-season:
#'
#'    |col_name   |types     |description                                    |
#'    |:----------|:---------|:----------------------------------------------|
#'    |season     |integer   |Season (4-digit ending-year).                  |
#'    |team_id    |integer   |CollegeBasketballData team id.                 |
#'    |team       |character |Team name.                                     |
#'    |conference |character |Conference name.                               |
#'    |elo        |integer   |End-of-season Elo rating.                      |
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
