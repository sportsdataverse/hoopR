# ---------------------------------------------------------------------------
# Internal: shared HTTP + parsing layer for Basketball-Reference scrapers
# ---------------------------------------------------------------------------
#
# The `bref_*()` functions scrape publicly available NBA data from
# Basketball-Reference (basketball-reference.com). No account or API key is
# required. Two Sports-Reference quirks are handled centrally here:
#   1. Secondary tables are hidden inside HTML comments (`<!-- ... -->`) to defer
#      rendering -- we strip the comment markers so every table is reachable.
#   2. Tables use multi-row "over-headers"; column names are read from each
#      cell's `data-stat` attribute (stable canonical keys) rather than the
#      rendered header, which avoids the mangled `x`, `x_2`, ... names that
#      `rvest::html_table()` would produce.
#
# NOTE ON RATE LIMITS: Basketball-Reference rate-limits aggressive clients
# (roughly 20 requests/minute). Callers should space repeated requests; the
# package tests insert `Sys.sleep()` between calls.

# Base URL for every Basketball-Reference endpoint.
.bref_base_url <- "https://www.basketball-reference.com"

# A browser-like User-Agent.
.bref_user_agent <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) hoopR Safari/537.36"

#' Internal: GET a Basketball-Reference page and return the response body text
#'
#' @param path Page path beginning with `/` (e.g. `"/leagues/NBA_2024_per_game.html"`).
#' @return The response body as a character string.
#' @keywords internal
.bref_text <- function(path) {
  resp <- .retry_request(
    paste0(.bref_base_url, path),
    headers = c("User-Agent" = .bref_user_agent)
  )
  .resp_text(resp)
}

#' Internal: parse a Basketball-Reference HTML table by id using data-stat keys
#'
#' Un-comments the page (so comment-hidden tables are reachable), selects the
#' table (by `id`, or the first table when `table_id` is `NULL`), drops mid-table
#' header-repeat rows, and builds a data.frame whose columns are the cells'
#' `data-stat` attributes.
#'
#' @param html Raw page HTML (character).
#' @param table_id Optional table `id` (e.g. `"per_game_stats"`); `NULL` = first table.
#' @return A data.frame (character columns), or an empty data.frame if not found.
#' @keywords internal
#' @importFrom rvest read_html html_element html_elements html_attr html_text2
#' @importFrom data.table rbindlist
.bref_table <- function(html, table_id = NULL) {
  html <- gsub("<!--", "", html, fixed = TRUE)
  html <- gsub("-->", "", html, fixed = TRUE)
  doc <- rvest::read_html(html)

  node <- if (is.null(table_id)) {
    rvest::html_element(doc, "table")
  } else {
    rvest::html_element(doc, paste0("table#", table_id))
  }
  if (inherits(node, "xml_missing")) return(data.frame())

  rows <- rvest::html_elements(node, "tbody > tr")
  if (length(rows) == 0) return(data.frame())

  # drop mid-table header-repeat rows (class attribute contains 'thead')
  cls <- rvest::html_attr(rows, "class")
  cls[is.na(cls)] <- ""
  rows <- rows[!grepl("thead", cls, fixed = TRUE)]

  lst <- lapply(rows, function(r) {
    cells <- rvest::html_elements(r, "th, td")
    stats <- rvest::html_attr(cells, "data-stat")
    vals  <- rvest::html_text2(cells)
    keep  <- !is.na(stats)
    stats::setNames(as.list(vals[keep]), stats[keep])
  })

  df <- data.table::rbindlist(lst, use.names = TRUE, fill = TRUE)
  as.data.frame(df)
}

# Convert character columns that are fully numeric to numeric, leaving the rest
# (player names, team codes, positions) as character.
.bref_type_convert <- function(df) {
  num <- vapply(df, function(col) {
    col <- col[!is.na(col) & col != ""]
    length(col) > 0 && !any(is.na(suppressWarnings(as.numeric(col))))
  }, logical(1))
  for (j in which(num)) df[[j]] <- suppressWarnings(as.numeric(df[[j]]))
  df
}
