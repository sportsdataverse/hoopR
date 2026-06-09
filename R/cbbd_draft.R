#' @title
#' **CBD Draft Teams**
#' @description
#' **Get NBA draft teams from the CollegeBasketballData API.**
#' @return A `hoopR_data` tibble with one row per NBA team:
#'
#'    |col_name     |types     |description                                  |
#'    |:------------|:---------|:--------------------------------------------|
#'    |id           |integer   |NBA team id.                                 |
#'    |source_id    |character |Source (ESPN) team id.                       |
#'    |location     |character |Team location (city).                        |
#'    |name         |character |Team name.                                   |
#'    |display_name |character |Full team display name.                      |
#'    |abbreviation |character |Team abbreviation.                           |
#'
#' @keywords CBD Draft
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Draft Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_draft_teams())
#' }
cbbd_draft_teams <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/draft/teams")
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Draft Teams from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no draft teams available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD draft teams", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Draft Positions**
#' @description
#' **Get NBA draft positions from the CollegeBasketballData API.**
#' @return A `hoopR_data` tibble with one row per draft position:
#'
#'    |col_name     |types     |description                                  |
#'    |:------------|:---------|:--------------------------------------------|
#'    |name         |character |Position name.                               |
#'    |abbreviation |character |Position abbreviation.                       |
#'
#' @keywords CBD Draft
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Draft Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_draft_positions())
#' }
cbbd_draft_positions <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/draft/positions")
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Draft Positions from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no draft positions available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD draft positions", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Draft Picks**
#' @description
#' **Get NBA draft picks from the CollegeBasketballData API.**
#' @param year (*integer* optional): Draft year (e.g. `2024`).
#' @param draft_team (*character* optional): NBA team filter.
#' @param source_team (*character* optional): College team filter.
#' @param position (*character* optional): Position filter.
#' @return A `hoopR_data` tibble with one row per draft pick:
#'
#'    |col_name                     |types     |description                       |
#'    |:----------------------------|:---------|:---------------------------------|
#'    |athlete_id                   |integer   |Athlete id.                       |
#'    |source_team_id               |integer   |College team id.                  |
#'    |source_team_location         |character |College team location.            |
#'    |source_team_name             |character |College team name.                |
#'    |source_team_league_affiliation|character|College team league affiliation.  |
#'    |source_team_college_id       |numeric   |College id.                       |
#'    |draft_team_id                |numeric   |NBA team id.                      |
#'    |draft_team                   |character |NBA team name.                    |
#'    |year                         |integer   |Draft year.                       |
#'    |overall                      |integer   |Overall pick number.              |
#'    |round                        |integer   |Draft round.                      |
#'    |pick                         |integer   |Pick number within the round.     |
#'    |name                         |character |Player name.                      |
#'    |overall_rank                 |integer   |Pre-draft overall rank.           |
#'    |position_rank                |integer   |Pre-draft position rank.          |
#'    |height                       |numeric   |Player height.                    |
#'    |weight                       |integer   |Player weight (lbs).              |
#'
#' @keywords CBD Draft
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Draft Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_draft_picks(year = 2024))
#' }
cbbd_draft_picks <- function(year = NULL, draft_team = NULL, source_team = NULL, position = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/draft/picks", query = list(
        year = year, draftTeam = draft_team, sourceTeam = source_team, position = position))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Draft Picks from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no draft picks available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD draft picks", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
