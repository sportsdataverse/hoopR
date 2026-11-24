#' @title
#' **CBD SRS Ratings**
#' @description
#' **Get Simple Rating System (SRS) ratings from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* optional): Team name filter (e.g. `Duke`).
#' @param conference (*character* optional): Conference abbreviation filter.
#' @eval .returns_rd("cbbd_ratings_srs", inline = FALSE, unit = "team-season")
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
    expr = .hoopR_with_warnings("cbbd_ratings_srs", {
      data <- .cbbd_get("/ratings/srs", query = list(season = season, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD SRS Ratings from collegebasketballdata.com", Sys.time())
    }),
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no SRS ratings available!", args = .args)
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
#' @eval .returns_rd("cbbd_ratings_adjusted", inline = FALSE, unit = "team-season")
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
    expr = .hoopR_with_warnings("cbbd_ratings_adjusted", {
      data <- .cbbd_get("/ratings/adjusted", query = list(season = season, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Adjusted Efficiency Ratings from collegebasketballdata.com", Sys.time())
    }),
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no adjusted ratings available!", args = .args)
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
#' @eval .returns_rd("cbbd_ratings_elo", inline = FALSE, unit = "team-season")
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
    expr = .hoopR_with_warnings("cbbd_ratings_elo", {
      data <- .cbbd_get("/ratings/elo", query = list(season = season, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Elo Ratings from collegebasketballdata.com", Sys.time())
    }),
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no Elo ratings available!", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Rating History**
#' @description
#' **Get daily snapshots of adjusted efficiency and SRS ratings from the CollegeBasketballData API.**
#'
#' Give at least one of `date` or `team`. The endpoint needs a Patreon Tier 2
#' API key or higher, and seasons before the current one need Tier 3 or higher.
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2025`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param date (*character* optional): UTC rating date, `YYYY-MM-DD`
#'   (e.g. `"2025-02-01"`). Required when `team` is not given.
#' @param team (*character* optional): Team name filter (e.g. `Duke`). Required
#'   when `date` is not given.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @eval .returns_rd("cbbd_ratings_history", inline = FALSE, unit = "team-date")
#' @keywords CBD Ratings
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Ratings Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_ratings_history(season = 2025, team = "Duke"))
#' }
cbbd_ratings_history <- function(season = most_recent_mbb_season(), date = NULL, team = NULL, conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = .hoopR_with_warnings("cbbd_ratings_history", {
      data <- .cbbd_get("/ratings/history", query = list(season = season, date = date, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Rating History from collegebasketballdata.com", Sys.time())
    }),
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no rating history available!", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
