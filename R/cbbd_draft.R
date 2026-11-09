#' @title
#' **CBD Draft Teams**
#' @rdname cbbd_draft_picks
#' @description
#' **Get NBA draft teams from the CollegeBasketballData API.**
#' @eval .returns_rd("cbbd_draft_teams", inline = FALSE, unit = "NBA team")
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
#' @rdname cbbd_draft_picks
#' @description
#' **Get NBA draft positions from the CollegeBasketballData API.**
#' @eval .returns_rd("cbbd_draft_positions", inline = FALSE, unit = "draft position")
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
#' @eval .returns_rd("cbbd_draft_picks", inline = FALSE, unit = "draft pick")
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
