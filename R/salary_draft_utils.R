# ---------------------------------------------------------------------------
# Internal: shared HTML-scraping helpers for third-party salary / draft sources
# ---------------------------------------------------------------------------
#
# Wrappers for HoopsHype (salaries), Spotrac (team cap), and NBADraft.net (mock
# drafts). All are public HTML, no account or API key required. (RealGM is NOT
# wrapped: basketball.realgm.com returns HTTP 403 to programmatic clients.)

.ext_user_agent <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) hoopR Safari/537.36"

#' Internal: fetch a URL and return the parsed HTML document
#' @param url Full URL.
#' @return An `xml_document` (rvest).
#' @keywords internal
#' @importFrom rvest read_html
.ext_html <- function(url) {
  resp <- .retry_request(url, headers = c("User-Agent" = .ext_user_agent))
  rvest::read_html(.resp_text(resp))
}

#' Internal: coerce a currency-formatted character vector to numeric
#' @param x Character vector (e.g. `"$59,606,817"`).
#' @return Numeric vector.
#' @keywords internal
.parse_currency <- function(x) {
  suppressWarnings(as.numeric(gsub("[^0-9.\\-]", "", as.character(x))))
}
