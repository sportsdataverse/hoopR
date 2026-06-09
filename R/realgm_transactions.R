#' @title
#' **RealGM NBA Transactions Log**
#' @description
#' **Get the NBA league transactions log from
#' [RealGM](https://basketball.realgm.com).**
#'
#' One row per transaction (signings, waivers, two-way conversions, G-League
#' assignments/recalls, trades), each tagged with its date. RealGM publishes the
#' transactions as a dated narrative list rather than a table, so this parses the
#' page DOM directly.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per transaction:
#'
#'    |col_name    |types     |description                                    |
#'    |:-----------|:---------|:----------------------------------------------|
#'    |date        |Date      |Transaction date.                              |
#'    |transaction |character |Transaction description.                       |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_element html_elements html_text2
#' @importFrom dplyr as_tibble bind_rows
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_transactions())
#' }
realgm_transactions <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      doc <- .realgm_doc("/nba/transactions/league")
      blocks <- rvest::html_elements(doc, "div.transByMonth div.portal.widget.fullpage")
      if (!length(blocks)) {
        blocks <- rvest::html_elements(doc, "div.portal.widget.fullpage")
      }
      rows <- list()
      for (blk in blocks) {
        date_txt <- rvest::html_text2(rvest::html_element(blk, "h3"))
        d <- suppressWarnings(as.Date(trimws(date_txt %||% NA_character_), format = "%b %d, %Y"))
        if (is.na(d)) next
        items <- rvest::html_text2(rvest::html_elements(blk, "ul li"))
        items <- trimws(items)
        items <- items[nzchar(items)]
        if (!length(items)) next
        rows[[length(rows) + 1]] <- data.frame(
          date = d, transaction = items, stringsAsFactors = FALSE
        )
      }
      if (!length(rows)) stop("RealGM transactions not found", call. = FALSE)
      out <- dplyr::as_tibble(dplyr::bind_rows(rows))
      df <- make_hoopR_data(out, "NBA transactions log from basketball.realgm.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM transactions data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM transactions", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
