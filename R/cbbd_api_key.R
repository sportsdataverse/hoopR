#' @title
#' **College Basketball Data API Key Registration**
#' @description Save your CollegeBasketballData API key as the system environment
#'   variable `CBBD_API_KEY`.
#' @details The `cbbd_*()` functions wrap the
#'   [CollegeBasketballData API](https://api.collegebasketballdata.com), the
#'   men's college basketball sibling of CollegeFootballData. The API requires a
#'   free API key (Bearer token). Request one at
#'   [https://collegebasketballdata.com/key](https://collegebasketballdata.com/key).\cr
#' \cr
#' **Using the key:** \cr
#' Save the key for consistent usage by adding
#' `CBBD_API_KEY=XXXX-YOUR-API-KEY-HERE-XXXXX` to your `.Renviron` file (easily
#' accessed via [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html)).
#' Run [**`usethis::edit_r_environ()`**](https://usethis.r-lib.org/reference/edit.html),
#' a new script will pop open named `.Renviron`, **THEN** paste the following in
#' the new script that pops up (with**out** quotations)
#' ```r
#' CBBD_API_KEY = XXXX-YOUR-API-KEY-HERE-XXXXX
#' ```
#' Save the script and restart your R session. If set correctly, from then on you
#' should be able to use any of the `cbbd_*()` functions without any other
#' changes.
#'
#' **For less consistent usage:** \cr
#' At the beginning of every session or within an R environment, save your API
#' key as the environment variable `CBBD_API_KEY` (**with** quotations) using a
#' command like the following.
#' ```r
#' Sys.setenv(CBBD_API_KEY = "XXXX-YOUR-API-KEY-HERE-XXXXX")
#' ```
#' @name register_cbbd
NULL

#' @rdname register_cbbd
#' @return `cbbd_key()` - Returns the `CBBD_API_KEY` environment variable, or
#'   `NA_character_` if it is unset.
#' @export
cbbd_key <- function() {
  key <- Sys.getenv("CBBD_API_KEY")
  if (key == "") {
    return(NA_character_)
  } else {
    return(key)
  }
}

#' @rdname register_cbbd
#' @return `has_cbbd_key()` - Returns a logical: `TRUE` if a key is stored,
#'   `FALSE` otherwise.
#' @export
has_cbbd_key <- function() !is.na(cbbd_key())

#' @rdname register_cbbd
#' @return `check_cbbd_key()` - Called for its side effect; errors if no key is
#'   stored in the environment.
#' @export
check_cbbd_key <- function() {
  if (!has_cbbd_key()) {
    stop("api.collegebasketballdata.com requires an API key.",
         "\n       See ?register_cbbd for details.", call. = FALSE)
  }
}

# ---------------------------------------------------------------------------
# Internal: shared HTTP layer for the CollegeBasketballData API
# ---------------------------------------------------------------------------

# Base URL for every CollegeBasketballData API endpoint.
.cbbd_base_url <- "https://api.collegebasketballdata.com"

#' Internal: perform a GET against the CollegeBasketballData API
#'
#' Attaches the `Authorization: Bearer <CBBD_API_KEY>` header, routes through
#' hoopR's shared [`.retry_request()`] (which handles retries, timeouts and
#' proxy resolution), and parses the JSON body. `NULL` query values are dropped
#' automatically by [httr2::req_url_query()], so optional parameters can be
#' threaded through unconditionally.
#'
#' @param path Endpoint path beginning with `/` (e.g. `"/teams"`).
#' @param query Named list of query parameters. `NULL` elements are omitted.
#' @return The parsed JSON body (a data.frame for list endpoints).
#' @keywords internal
.cbbd_get <- function(path, query = list()) {
  check_cbbd_key()
  resp <- .retry_request(
    paste0(.cbbd_base_url, path),
    params  = query,
    headers = c(Authorization = paste("Bearer", cbbd_key()))
  )
  jsonlite::fromJSON(.resp_text(resp), flatten = TRUE)
}
