#' @title
#' **CBD Teams**
#' @description
#' **Get college basketball teams from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter
#'   (e.g. `ACC`). See [cbbd_conferences()] for valid values.
#' @param season (*integer* optional): Season, in 4-digit format ending-year
#'   (e.g. `2024` for the 2023-24 season). Defaults to
#'   `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per team:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData team id. \cr
#'       source_id \tab character \tab Source (ESPN) team id. \cr
#'       school \tab character \tab School name. \cr
#'       mascot \tab character \tab Team mascot. \cr
#'       abbreviation \tab character \tab Team abbreviation. \cr
#'       display_name \tab character \tab Full team display name. \cr
#'       short_display_name \tab character \tab Short team display name. \cr
#'       primary_color \tab character \tab Primary team color (hex). \cr
#'       secondary_color \tab character \tab Secondary team color (hex). \cr
#'       current_venue_id \tab integer \tab Current home venue id. \cr
#'       current_venue \tab character \tab Current home venue name. \cr
#'       current_city \tab character \tab Current home venue city. \cr
#'       current_state \tab character \tab Current home venue state. \cr
#'       conference_id \tab integer \tab Conference id. \cr
#'       conference \tab character \tab Conference name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords CBD Teams
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Teams Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_teams(conference = "ACC"))
#' }
cbbd_teams <- function(conference = NULL, season = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/teams", query = list(conference = conference, season = season))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Teams from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no teams data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD teams", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Team Roster**
#' @description
#' **Get a college basketball team roster from the CollegeBasketballData API.**
#' @param season (*integer* required): Season, in 4-digit format ending-year
#'   (e.g. `2024`). Defaults to `most_recent_mbb_season()`.
#' @param team (*character* optional): Team name filter (e.g. `Duke`).
#' @return A `hoopR_data` tibble with one row per team. The `players` column is a
#'   nested list of roster players:
#'
#'    |col_name       |types     |description                                  |
#'    |:--------------|:---------|:--------------------------------------------|
#'    |team_id        |integer   |CollegeBasketballData team id.               |
#'    |team_source_id |character |Source (ESPN) team id.                       |
#'    |team           |character |Team name.                                   |
#'    |conference     |character |Conference name.                             |
#'    |season         |integer   |Season (4-digit ending-year).                |
#'    |players        |list      |Nested list of roster players.               |
#'
#' @keywords CBD Teams
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Teams Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_teams_roster(season = 2024, team = "Duke"))
#' }
cbbd_teams_roster <- function(season = most_recent_mbb_season(), team = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/teams/roster", query = list(season = season, team = team))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Team Roster from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no roster data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team roster", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
