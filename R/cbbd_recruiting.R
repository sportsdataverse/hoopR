#' @title
#' **CBD Recruiting Players**
#' @description
#' **Get player recruiting rankings from the CollegeBasketballData API.**
#' @param year (*integer* optional): Recruiting class year (e.g. `2024`).
#' @param team (*character* optional): Committed team filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param position (*character* optional): Position filter.
#' @return A `hoopR_data` tibble with one row per recruit. The `hometown` and
#'   `committed_to` objects are flattened into prefixed columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab Recruit id. \cr
#'       source_id \tab character \tab Source (ESPN) recruit id. \cr
#'       position \tab character \tab Recruit position. \cr
#'       school_id \tab integer \tab High school / club id. \cr
#'       school \tab character \tab High school / club name. \cr
#'       athlete_id \tab integer \tab Athlete id (once enrolled). \cr
#'       year \tab integer \tab Recruiting class year. \cr
#'       name \tab character \tab Recruit name. \cr
#'       height_inches \tab numeric \tab Height in inches. \cr
#'       weight_pounds \tab integer \tab Weight in pounds. \cr
#'       stars \tab integer \tab Star rating. \cr
#'       rating \tab numeric \tab Numeric recruit rating. \cr
#'       ranking \tab integer \tab Overall ranking. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
#' @description
#' **Get team recruiting rankings from the CollegeBasketballData API.**
#' @param year (*integer* optional): Recruiting class year (e.g. `2024`).
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per team:
#'
#'    |col_name   |types     |description                                    |
#'    |:----------|:---------|:----------------------------------------------|
#'    |team_id    |integer   |CollegeBasketballData team id.                 |
#'    |team       |character |Team name.                                     |
#'    |conference |character |Conference name.                               |
#'    |year       |integer   |Recruiting class year.                         |
#'    |ranking    |integer   |Team recruiting ranking.                       |
#'    |rating     |numeric   |Team recruiting rating.                        |
#'
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
#' @description
#' **Get transfer portal data from the CollegeBasketballData API.**
#' @param year (*integer* optional): Transfer class year (e.g. `2024`).
#' @param source_team (*character* optional): Origin team filter.
#' @param destination_team (*character* optional): Destination team filter.
#' @param source_conference (*character* optional): Origin conference filter.
#' @param destination_conference (*character* optional): Destination conference filter.
#' @param position (*character* optional): Position filter.
#' @return A `hoopR_data` tibble with one row per transfer. The `origin` and
#'   `destination` objects are flattened into prefixed columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab Transfer id. \cr
#'       source_id \tab character \tab Source (ESPN) athlete id. \cr
#'       year \tab integer \tab Transfer class year. \cr
#'       first_name \tab character \tab Player first name. \cr
#'       last_name \tab character \tab Player last name. \cr
#'       position \tab character \tab Player position. \cr
#'       eligibility \tab character \tab Eligibility status. \cr
#'       years_remaining \tab integer \tab Years of eligibility remaining. \cr
#'       stars \tab integer \tab Star rating. \cr
#'       rating \tab numeric \tab Numeric rating. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
