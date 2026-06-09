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
#'    |col_name           |types     |description                                |
#'    |:------------------|:---------|:------------------------------------------|
#'    |id                 |integer   |CollegeBasketballData team id.             |
#'    |source_id          |character |Source (ESPN) team id.                     |
#'    |school             |character |School name.                               |
#'    |mascot             |character |Team mascot.                               |
#'    |abbreviation       |character |Team abbreviation.                         |
#'    |display_name       |character |Full team display name.                    |
#'    |short_display_name |character |Short team display name.                   |
#'    |primary_color      |character |Primary team color (hex).                  |
#'    |secondary_color    |character |Secondary team color (hex).                |
#'    |current_venue_id   |integer   |Current home venue id.                     |
#'    |current_venue      |character |Current home venue name.                   |
#'    |current_city       |character |Current home venue city.                   |
#'    |current_state      |character |Current home venue state.                  |
#'    |conference_id      |integer   |Conference id.                             |
#'    |conference         |character |Conference name.                           |
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
