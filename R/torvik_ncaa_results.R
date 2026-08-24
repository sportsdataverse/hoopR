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
#' @return A `hoopR_data` tibble with one row per team/coach/conference/seed:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       rk \tab integer \tab Rank within the queried split. \cr
#'       team \tab character \tab Team / coach / conference / seed (per \code{type}). \cr
#'       pake \tab numeric \tab Performance above KenPom expectation (wins). \cr
#'       pase \tab numeric \tab Performance above seed expectation (wins). \cr
#'       wins \tab integer \tab Total tournament wins. \cr
#'       loss \tab integer \tab Total tournament losses. \cr
#'       w_percent \tab numeric \tab Tournament win percentage. \cr
#'       r64 \tab integer \tab Round of 64 appearances. \cr
#'       r32 \tab integer \tab Round of 32 appearances. \cr
#'       s16 \tab integer \tab Sweet 16 appearances. \cr
#'       e8 \tab integer \tab Elite 8 appearances. \cr
#'       f4 \tab integer \tab Final 4 appearances. \cr
#'       f2 \tab integer \tab Championship-game appearances. \cr
#'       champ \tab integer \tab National championships. \cr
#'       top2 \tab integer \tab Top-2 (runner-up or champion) finishes. \cr
#'       f4_percent \tab numeric \tab Final 4 rate. \cr
#'       champ_percent \tab numeric \tab Championship rate. \cr
#'       min_year \tab integer \tab Minimum year queried (echoes \code{min_year}). \cr
#'       max_year \tab integer \tab Maximum year queried (echoes \code{max_year}). \cr
#'       type \tab character \tab Aggregation level queried (echoes \code{type}). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
