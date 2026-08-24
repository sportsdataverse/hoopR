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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       athlete_id \tab integer \tab Athlete id. \cr
#'       source_team_id \tab integer \tab College team id. \cr
#'       source_team_location \tab character \tab College team location. \cr
#'       source_team_name \tab character \tab College team name. \cr
#'       source_team_league_affiliation \tab character \tab College team league affiliation. \cr
#'       source_team_college_id \tab numeric \tab College id. \cr
#'       draft_team_id \tab numeric \tab NBA team id. \cr
#'       draft_team \tab character \tab NBA team name. \cr
#'       year \tab integer \tab Draft year. \cr
#'       overall \tab integer \tab Overall pick number. \cr
#'       round \tab integer \tab Draft round. \cr
#'       pick \tab integer \tab Pick number within the round. \cr
#'       name \tab character \tab Player name. \cr
#'       overall_rank \tab integer \tab Pre-draft overall rank. \cr
#'       position_rank \tab integer \tab Pre-draft position rank. \cr
#'       height \tab numeric \tab Player height. \cr
#'       weight \tab integer \tab Player weight (lbs). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
