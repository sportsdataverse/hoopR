#' @title
#' **CBD Conferences**
#' @description
#' **Get college basketball conferences from the CollegeBasketballData API.**
#' @return A `hoopR_data` tibble with one row per conference:
#'
#'    |col_name     |types     |description                                        |
#'    |:------------|:---------|:--------------------------------------------------|
#'    |id           |integer   |CollegeBasketballData conference id.               |
#'    |source_id    |character |Source (ESPN) conference id.                       |
#'    |name         |character |Conference name (e.g. `Big Ten`).                  |
#'    |abbreviation |character |Conference abbreviation (e.g. `B1G`).              |
#'    |short_name   |character |Conference short name.                             |
#'
#' @keywords CBD Conferences
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Conferences Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_conferences())
#' }
cbbd_conferences <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/conferences")
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Conferences from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no conferences data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD conferences", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Conference Membership History**
#' @description
#' **Get historical conference membership from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter
#'   (e.g. `B1G`). See [cbbd_conferences()] for valid values.
#' @return A `hoopR_data` tibble with one row per conference. The `teams` column
#'   is a nested list of per-team membership spans:
#'
#'    |col_name     |types     |description                                        |
#'    |:------------|:---------|:--------------------------------------------------|
#'    |id           |integer   |CollegeBasketballData conference id.               |
#'    |source_id    |character |Source (ESPN) conference id.                       |
#'    |name         |character |Conference name.                                   |
#'    |abbreviation |character |Conference abbreviation.                           |
#'    |short_name   |character |Conference short name.                             |
#'    |teams        |list      |Nested list of member-team membership spans.       |
#'
#' @keywords CBD Conferences
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Conferences Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_conferences_history(conference = "B1G"))
#' }
cbbd_conferences_history <- function(conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/conferences/history", query = list(conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Conference History from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no conference history available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD conference history", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
