# ---------------------------------------------------------------------------
# Internal: headless-browser access layer for RealGM (basketball.realgm.com)
# ---------------------------------------------------------------------------
#
# RealGM sits behind Cloudflare's "Just a moment..." JavaScript challenge
# (`cf-mitigated: challenge`). Every libcurl-based client (httr2 / httr / rvest)
# receives an HTTP 403 challenge interstitial regardless of headers, because
# Cloudflare fingerprints the TLS handshake (JA3) *and* requires a JavaScript
# proof-of-work to mint the `cf_clearance` cookie. The only reliable way through
# is a real browser engine, so the `realgm_*()` functions drive headless Chrome
# via the optional {chromote} package (Chrome solves the challenge natively in
# ~2 seconds). {chromote} + Google Chrome are therefore a Suggests-level
# requirement for the RealGM family only.

.realgm_base_url <- "https://basketball.realgm.com"
.realgm_user_agent <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

#' Internal: fetch a RealGM page through headless Chrome (clears Cloudflare)
#'
#' Navigates headless Chrome to the page, waits for the Cloudflare challenge to
#' resolve (the page title stops being "Just a moment..."), and returns the
#' fully rendered HTML for `rvest` parsing.
#'
#' @param path Page path beginning with `/` (e.g. `"/nba/players"`).
#' @param wait Maximum seconds to wait for the challenge to clear.
#' @return The rendered page HTML as a character string.
#' @keywords internal
.realgm_html <- function(path, wait = 25) {
  if (!requireNamespace("chromote", quietly = TRUE)) {
    cli::cli_abort(c(
      "RealGM is protected by a Cloudflare browser challenge and cannot be read with a plain HTTP client.",
      "i" = "Install the {.pkg chromote} package and Google Chrome to access the {.code realgm_*()} functions.",
      "i" = "{.run install.packages(\"chromote\")}"
    ))
  }

  b <- chromote::ChromoteSession$new()
  on.exit(try(b$close(), silent = TRUE), add = TRUE)

  # present as a normal (non-headless) Chrome
  try(b$Network$setUserAgentOverride(userAgent = .realgm_user_agent), silent = TRUE)
  b$Page$navigate(paste0(.realgm_base_url, path))

  deadline <- Sys.time() + wait
  repeat {
    Sys.sleep(1.5)
    title <- tryCatch(b$Runtime$evaluate("document.title")$result$value,
                      error = function(e) "")
    if (nzchar(title) && !grepl("just a moment|attention required|checking your browser",
                                title, ignore.case = TRUE)) {
      break
    }
    if (Sys.time() > deadline) break
  }

  b$Runtime$evaluate("document.documentElement.outerHTML")$result$value
}

#' Internal: fetch a RealGM page and parse it into an `xml_document`
#'
#' @param path Page path beginning with `/`.
#' @param wait Maximum seconds to wait for the Cloudflare challenge to clear.
#' @return An `xml_document` (from `rvest::read_html()`).
#' @keywords internal
.realgm_doc <- function(path, wait = 25) {
  rvest::read_html(.realgm_html(path, wait = wait))
}

#' Internal: extract every parseable HTML table from a RealGM document
#'
#' RealGM pages usually carry a small nav / filter / legend table ahead of the
#' real data table. This returns all tables that parse and clear `min_rows`,
#' `janitor::clean_names()`-ed, so a caller can pick or combine them.
#'
#' @param doc An `xml_document` from [.realgm_doc()].
#' @param min_rows Minimum row count for a table to be kept (drops nav/legend).
#' @return A list of cleaned `data.frame`s.
#' @keywords internal
.realgm_tables <- function(doc, min_rows = 1) {
  tbs <- rvest::html_elements(doc, "table")
  out <- lapply(tbs, function(t) {
    tryCatch(janitor::clean_names(rvest::html_table(t)), error = function(e) NULL)
  })
  out <- out[!vapply(out, is.null, logical(1))]
  Filter(function(t) nrow(t) >= min_rows, out)
}

#' Internal: pick the best data table from a list of RealGM tables
#'
#' Chooses the table containing all `must_have` columns (when supplied) with the
#' most rows; otherwise the table with the most rows.
#'
#' @param tables A list of `data.frame`s, e.g. from [.realgm_tables()].
#' @param must_have Optional character vector of required column names.
#' @return A single `data.frame`, or `NULL` if `tables` is empty.
#' @keywords internal
.realgm_pick <- function(tables, must_have = NULL) {
  if (!length(tables)) return(NULL)
  if (!is.null(must_have)) {
    ok <- Filter(function(t) all(must_have %in% colnames(t)), tables)
    if (length(ok)) tables <- ok
  }
  tables[[which.max(vapply(tables, nrow, integer(1)))]]
}

#' Internal: finalize a RealGM table as a `hoopR_data` tibble
#'
#' Coerces numeric-looking columns (via [.bref_type_convert()]), converts to a
#' tibble, and attaches the `hoopR_data` class + metadata.
#'
#' @param df A parsed RealGM `data.frame`.
#' @param description Provenance string stored on the result.
#' @return A `hoopR_data` tibble.
#' @keywords internal
.realgm_finish <- function(df, description) {
  df <- .bref_type_convert(as.data.frame(df))
  make_hoopR_data(dplyr::as_tibble(df), description, Sys.time())
}
