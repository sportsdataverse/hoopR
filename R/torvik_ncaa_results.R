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
#'    |col_name      |types     |description                                          |
#'    |:-------------|:---------|:----------------------------------------------------|
#'    |rk            |integer   |Rank within the queried split.                       |
#'    |team          |character |Team / coach / conference / seed (per `type`).       |
#'    |pake          |numeric   |Performance above KenPom expectation (wins).         |
#'    |pase          |numeric   |Performance above seed expectation (wins).           |
#'    |wins          |integer   |Total tournament wins.                               |
#'    |loss          |integer   |Total tournament losses.                             |
#'    |w_percent     |numeric   |Tournament win percentage.                           |
#'    |r64           |integer   |Round of 64 appearances.                             |
#'    |r32           |integer   |Round of 32 appearances.                             |
#'    |s16           |integer   |Sweet 16 appearances.                                |
#'    |e8            |integer   |Elite 8 appearances.                                 |
#'    |f4            |integer   |Final 4 appearances.                                 |
#'    |f2            |integer   |Championship-game appearances.                       |
#'    |champ         |integer   |National championships.                              |
#'    |top2          |integer   |Top-2 (runner-up or champion) finishes.              |
#'    |f4_percent    |numeric   |Final 4 rate.                                        |
#'    |champ_percent |numeric   |Championship rate.                                   |
#'    |min_year      |integer   |Minimum year queried (echoes `min_year`).            |
#'    |max_year      |integer   |Maximum year queried (echoes `max_year`).            |
#'    |type          |character |Aggregation level queried (echoes `type`).           |
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
