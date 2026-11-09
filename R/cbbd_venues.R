#' @title
#' **CBD Venues**
#' @description
#' **Get college basketball venues from the CollegeBasketballData API.**
#' @eval .returns_rd("cbbd_venues", inline = FALSE, unit = "venue")
#' @keywords CBD Venues
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Venues Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_venues())
#' }
cbbd_venues <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/venues")
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Venues from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no venues data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD venues", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
