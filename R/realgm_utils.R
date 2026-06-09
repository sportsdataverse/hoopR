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
