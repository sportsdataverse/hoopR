#' @title
#' **CBD Recruiting Players**
#' @description
#' **Get player recruiting rankings from the CollegeBasketballData API.**
#' @param year (*integer* optional): Recruiting class year (e.g. `2024`).
#' @param team (*character* optional): Committed team filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param position (*character* optional): Position filter.
#' @eval .returns_rd("cbbd_recruiting_players", inline = FALSE, unit = "recruit")
#' @keywords CBD Recruiting
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Recruiting Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_recruiting_players(year = 2024))
#' }
cbbd_recruiting_players <- function(year = NULL, team = NULL, conference = NULL, position = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/recruiting/players", query = list(
        year = year, team = team, conference = conference, position = position))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Recruiting Players from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no recruiting players available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD recruiting players", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Recruiting Team Rankings**
#' @rdname cbbd_recruiting_players
#' @description
#' **Get team recruiting rankings from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter.
#' @eval .returns_rd("cbbd_recruiting_teams", inline = FALSE, unit = "team")
#' @keywords CBD Recruiting
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Recruiting Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_recruiting_teams(year = 2024))
#' }
cbbd_recruiting_teams <- function(year = NULL, team = NULL, conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/recruiting/teams", query = list(year = year, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Recruiting Team Rankings from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team recruiting rankings available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team recruiting rankings", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Transfer Portal**
#' @rdname cbbd_recruiting_players
#' @description
#' **Get transfer portal data from the CollegeBasketballData API.**
#' @param source_team (*character* optional): Origin team filter.
#' @param destination_team (*character* optional): Destination team filter.
#' @param source_conference (*character* optional): Origin conference filter.
#' @param destination_conference (*character* optional): Destination conference filter.
#' @param position (*character* optional): Position filter.
#' @eval .returns_rd("cbbd_recruiting_portal", inline = FALSE, unit = "transfer")
#' @keywords CBD Recruiting
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Recruiting Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_recruiting_portal(year = 2024))
#' }
cbbd_recruiting_portal <- function(year = NULL, source_team = NULL, destination_team = NULL,
                                   source_conference = NULL, destination_conference = NULL, position = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/recruiting/portal", query = list(
        year = year, sourceTeam = source_team, destinationTeam = destination_team,
        sourceConference = source_conference, destinationConference = destination_conference,
        position = position))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Transfer Portal from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no transfer portal data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD transfer portal", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
