#' @title
#' **Bart Torvik NCAA Tournament Results**
#' @description
#' **Get historical NCAA tournament performance from
#' [barttorvik.com](https://barttorvik.com), by team, coach, conference or seed.**
#'
#' Returns raw and adjusted NCAA tournament results, including PASE (performance
#' above seed expectation) and PAKE (performance above KenPom expectation) plus
#' round-by-round appearance counts. No API key is required. Data runs from 2000
#' to present.
#' @param min_year (*integer* required): Minimum tournament year (4-digit, e.g. `2010`).
#' @param max_year (*integer* required): Maximum tournament year (4-digit, e.g. `2024`).
#' @param type (*character* optional): Aggregation level. One of `team` (default),
#'   `coach`, `conf`, or `seed`.
#' @eval .returns_rd("torvik_ncaa_results", inline = FALSE, unit = "team")
#' @keywords Torvik
#' @importFrom rvest read_html html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @importFrom purrr pluck
#' @importFrom cli cli_abort
#' @family Torvik Functions
#' @export
#' @examples
#' \donttest{
#'   try(torvik_ncaa_results(min_year = 2010, max_year = 2024, type = "conf"))
#' }
torvik_ncaa_results <- function(min_year, max_year, type = "team") {
  .args <- .capture_args()

  if (!type %in% c("team", "coach", "conf", "seed")) {
    cli::cli_abort(c(
      "Unsupported {.arg type}.",
      "i" = "{.arg type} must be one of: team, coach, conf, or seed.",
      "x" = "You called {.code type = {.val {type}}}."
    ))
  }

  df <- data.frame()

  tryCatch(
    expr = {
      url <- paste0(.torvik_base_url, "/cgi-bin/ncaat.cgi?yrlow=", min_year,
                    "&yrhigh=", max_year, "&type=", type)
      resp <- .retry_request(url, headers = c("User-Agent" = .torvik_user_agent))
      df <- .resp_text(resp) %>%
        rvest::read_html() %>%
        rvest::html_table() %>%
        purrr::pluck(1) %>%
        janitor::clean_names() %>%
        dplyr::as_tibble()
      df[["min_year"]] <- as.integer(min_year)
      df[["max_year"]] <- as.integer(max_year)
      df[["type"]] <- type
      df <- make_hoopR_data(df, "Bart Torvik NCAA tournament results from barttorvik.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no NCAA tournament results available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching NCAA tournament results", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
