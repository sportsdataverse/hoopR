#' @title
#' **Basketball-Reference NBA Injury Report**
#' @description
#' **Get the current NBA injury report from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' One row per injured player with team, the date the status was last updated and
#' the injury note (status + description). No API key is required.
#'
#' **Note on RotoWorld:** RotoWorld was a long-standing NBA injuries source, but
#' NBC shut it down (it now redirects to `nbcsports.com/fantasy` and the injuries
#' tool is gone). This function uses Basketball-Reference's live injury report
#' instead, which is maintained and carries the same player / team / status /
#' note fields.
#' @return A `hoopR_data` tibble with one row per injured player:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       player \tab character \tab Player name. \cr
#'       team_name \tab character \tab Team name. \cr
#'       date_update \tab character \tab Date the status was last updated. \cr
#'       note \tab character \tab Injury status and description. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_injuries())
#' }
bref_injuries <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text("/friv/injuries.fcgi")
      d <- .bref_table(html, "injuries")
      if (nrow(d) == 0) stop("Basketball-Reference injuries table not found", call. = FALSE)
      d <- d[rowSums(!is.na(d) & d != "") > 0, , drop = FALSE]
      d <- .bref_type_convert(d)
      d <- janitor::clean_names(dplyr::as_tibble(d))
      df <- make_hoopR_data(d, "NBA injury report from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No Basketball-Reference injury data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF injuries", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
