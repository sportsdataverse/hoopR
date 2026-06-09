#' @title
#' **RealGM NBA Salary Cap History**
#' @description
#' **Get the NBA salary-cap history (and projections) from
#' [RealGM](https://basketball.realgm.com).**
#'
#' One row per season with the cap, luxury-tax line, both aprons, bi-annual
#' exception and the mid-level exception tiers. Dollar figures are returned as
#' the formatted strings RealGM publishes (e.g. `"$140,588,000"`).
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per season:
#'
#'    |col_name          |types     |description                              |
#'    |:-----------------|:---------|:----------------------------------------|
#'    |season            |character |Season (e.g. `2025-2026`).               |
#'    |salary_cap        |character |Salary cap.                              |
#'    |luxury_tax        |character |Luxury-tax threshold.                    |
#'    |x1st_apron        |character |First apron.                             |
#'    |x2nd_apron        |character |Second apron.                            |
#'    |bae               |character |Bi-annual exception.                     |
#'    |non_taxpayer_mle  |character |Non-taxpayer mid-level exception.        |
#'    |taxpayer_mle      |character |Taxpayer mid-level exception.            |
#'    |team_room_mle     |character |Room mid-level exception.                |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_salary_cap())
#' }
realgm_salary_cap <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/info/salary_cap")),
                           must_have = c("season", "salary_cap"))
      if (is.null(cand)) stop("RealGM salary-cap table not found", call. = FALSE)
      df <- .realgm_finish(cand, "NBA salary cap history from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM salary-cap data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM salary cap", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Rookie Scale**
#' @description
#' **Get the current NBA rookie-scale salary table from
#' [RealGM](https://basketball.realgm.com).**
#'
#' One row per first-round pick with the four contract-year amounts and the
#' qualifying-offer percentage. Dollar figures are the formatted strings RealGM
#' publishes.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per first-round pick (`pick`,
#'   `x1st_year_salary`, `x2nd_year_salary`, `x3rd_year_option_salary`, the
#'   4th-year option increase and qualifying-offer increase).
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_rookie_scale())
#' }
realgm_rookie_scale <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/info/rookie_scale")),
                           must_have = "pick")
      if (is.null(cand)) stop("RealGM rookie-scale table not found", call. = FALSE)
      df <- .realgm_finish(cand, "NBA rookie scale from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM rookie-scale data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM rookie scale", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
