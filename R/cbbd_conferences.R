#' @title
#' **CBD Conferences**
#' @description
#' **Get college basketball conferences from the CollegeBasketballData API.**
#' @return A `hoopR_data` tibble with one row per conference:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData conference id. \cr
#'       source_id \tab character \tab Source (ESPN) conference id. \cr
#'       name \tab character \tab Conference name (e.g. \verb{Big Ten}). \cr
#'       abbreviation \tab character \tab Conference abbreviation (e.g. \code{B1G}). \cr
#'       short_name \tab character \tab Conference short name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname cbbd_conferences
#' @description
#' **Get historical conference membership from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter
#'   (e.g. `B1G`). See [cbbd_conferences()] for valid values.
#' @return A `hoopR_data` tibble with one row per conference. The `teams` column
#'   is a nested list of per-team membership spans:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData conference id. \cr
#'       source_id \tab character \tab Source (ESPN) conference id. \cr
#'       name \tab character \tab Conference name. \cr
#'       abbreviation \tab character \tab Conference abbreviation. \cr
#'       short_name \tab character \tab Conference short name. \cr
#'       teams \tab list \tab Nested list of member-team membership spans. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
