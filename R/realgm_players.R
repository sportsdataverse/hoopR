#' @title
#' **RealGM NBA Player Index**
#' @description
#' **Get the active NBA player index from
#' [RealGM](https://basketball.realgm.com).**
#'
#' Returns RealGM's roster of active NBA players, including position, listed
#' height/weight, age, current team, years of service and pre-draft team -- the
#' pre-draft / international detail RealGM is known for.
#'
#' **Requires a headless browser.** RealGM is behind a Cloudflare JavaScript
#' challenge, so the `realgm_*()` functions drive headless Chrome via the
#' optional \pkg{chromote} package (install it and Google Chrome). A plain HTTP
#' client receives an HTTP 403 challenge page.
#' @return A `hoopR_data` tibble with one row per active player:
#'
#'    |col_name       |types     |description                                     |
#'    |:--------------|:---------|:-----------------------------------------------|
#'    |number         |integer   |Row number.                                     |
#'    |player         |character |Player name.                                    |
#'    |pos            |character |Position.                                       |
#'    |ht             |character |Listed height.                                  |
#'    |wt             |integer   |Listed weight (lbs).                            |
#'    |age            |numeric   |Age.                                            |
#'    |current_team   |character |Current NBA team.                               |
#'    |yos            |integer   |Years of service.                              |
#'    |pre_draft_team |character |Pre-draft team / school.                        |
#'    |draft_status   |character |Draft pick / undrafted status.                  |
#'    |nationality    |character |Player nationality.                             |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \donttest{
#'   try(realgm_players())
#' }
realgm_players <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .realgm_html("/nba/players")
      tbs <- rvest::html_elements(rvest::read_html(html), "table")
      # pick the table whose header includes a Player column
      cand <- NULL
      for (t in tbs) {
        tt <- janitor::clean_names(rvest::html_table(t))
        if ("player" %in% colnames(tt) && nrow(tt) > 0) { cand <- tt; break }
      }
      if (is.null(cand)) stop("RealGM player table not found", call. = FALSE)
      df <- .bref_type_convert(as.data.frame(cand))
      df <- dplyr::as_tibble(df)
      df <- make_hoopR_data(df, "NBA player index from basketball.realgm.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no RealGM player data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM players", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
