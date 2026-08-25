# Internal: shared parser for a RealGM staff-members listing.
.realgm_staff <- function(path, description, args) {
  df <- data.frame()
  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc(path)),
                           must_have = c("staff", "team"))
      if (is.null(cand)) stop("RealGM staff table not found", call. = FALSE)
      df <- .realgm_finish(cand, description)
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM staff data available!", args = args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM staff", args = args)
    },
    finally = {
    }
  )
  df
}

#' @title
#' **RealGM NBA Head Coaches**
#' @description
#' **Get the current NBA head coaches from
#' [RealGM](https://basketball.realgm.com).**
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per coach:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       staff \tab character \tab Coach name. \cr
#'       team \tab character \tab Team name. \cr
#'       start_season \tab character \tab Season the coach started with the team. \cr
#'       years_in_role \tab integer \tab Seasons in the role. \cr
#'       birth_date \tab character \tab Birth date (when listed). \cr
#'       nationality \tab character \tab Nationality. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_coaches())
#' }
realgm_coaches <- function() {
  .args <- .capture_args()
  .realgm_staff("/nba/staff-members/20/Head-Coach/Current",
                "NBA head coaches from basketball.realgm.com", .args)
}

#' @title
#' **RealGM NBA General Managers**
#' @description
#' **Get the current NBA general managers from
#' [RealGM](https://basketball.realgm.com).**
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per general manager (`staff`,
#'   `team`, `start_season`, `years_in_role`, `birth_date`, `nationality`).
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_gms())
#' }
realgm_gms <- function() {
  .args <- .capture_args()
  .realgm_staff("/nba/staff-members/16/General-Manager/Current",
                "NBA general managers from basketball.realgm.com", .args)
}
