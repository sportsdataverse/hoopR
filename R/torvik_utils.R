# ---------------------------------------------------------------------------
# Internal: shared HTTP layer for Bart Torvik (barttorvik.com) scrapers
# ---------------------------------------------------------------------------
#
# The `torvik_*()` functions pull publicly available men's college basketball
# data directly from Bart Torvik's site (barttorvik.com). No account or API key
# is required -- these are the auth-free, self-describing data files
# (`{year}_team_results.csv`, `{year}_fffinal.csv`, `{year}_super_sked.json`)
# and the tournament-results CGI endpoint. (The interactive `.php` pages such as
# `trank.php` sit behind a JavaScript browser check and are intentionally not
# used here.)

# Base URL for every barttorvik.com endpoint.
.torvik_base_url <- "https://barttorvik.com"

# A polite browser-like User-Agent. barttorvik.com rejects some default
# programmatic agents, so we mirror cbbdata's approach of presenting a browser
# UA (here identifying hoopR).
.torvik_user_agent <- "Mozilla/5.0 (hoopR; +https://hoopR.sportsdataverse.org)"

#' Internal: GET a barttorvik.com resource and return the response body text
#'
#' Routes through hoopR's shared [`.retry_request()`] (retries, timeouts, proxy
#' resolution) with a browser User-Agent, and returns the raw response body as a
#' string for downstream CSV / JSON / HTML parsing.
#'
#' @param path Endpoint path beginning with `/` (e.g. `"/2024_team_results.csv"`).
#' @return The response body as a character string.
#' @keywords internal
.torvik_text <- function(path) {
  resp <- .retry_request(
    paste0(.torvik_base_url, path),
    headers = c("User-Agent" = .torvik_user_agent)
  )
  .resp_text(resp)
}
