# .retry_request() turns off httr2's status errors, so the shared helpers check
# the status themselves (.stop_for_http_status()): an error response must reach
# the wrapper's error handler as a reported cause, never come back as data.

local_status_response <- function(status, body, type = "application/json",
                                  env = parent.frame()) {
  withr::local_envvar(CBBD_API_KEY = "offline", .local_envir = env)
  httr2::local_mocked_responses(function(req) {
    httr2::response(
      status_code = status, url = req$url,
      # Retry-After: 0 keeps req_retry() from backing off on a 429 / 503
      headers = list(`Content-Type` = type, `Retry-After` = "0"),
      body = charToRaw(body)
    )
  }, env = env)
}

test_that("a CBBD error response is reported with its status and message, not returned as a row", {
  skip_on_cran()
  cases <- list(
    list(status = 401L, body = '{"message":"Patreon Tier 2 access or higher is required"}',
         expect = "HTTP 401 Unauthorized from https://api.collegebasketballdata.com/ratings/history: Patreon Tier 2"),
    list(status = 429L, body = '{"message":"Monthly call limit reached"}',
         expect = "HTTP 429 Too Many Requests .*: Monthly call limit reached"),
    list(status = 500L, body = "<html><body>Internal Server Error</body></html>",
         expect = "HTTP 500 Internal Server Error from https://api.collegebasketballdata.com/ratings/history$")
  )
  for (case in cases) {
    local({
      local_status_response(case$status, case$body,
                            type = if (case$status == 500L) "text/html" else "application/json")
      msgs <- NULL
      x <- withCallingHandlers(
        cbbd_ratings_history(season = 2025, team = "Duke"),
        message = function(m) {
          msgs <<- c(msgs, conditionMessage(m))
          invokeRestart("muffleMessage")
        }
      )
      expect_false(inherits(x, "hoopR_data"))
      expect_equal(nrow(x), 0L)
      expect_true(any(grepl(case$expect, trimws(msgs))), info = paste(msgs, collapse = "\n"))
    })
  }
})

test_that("a CBBD 200 [] still gives an empty hoopR_data frame", {
  skip_on_cran()
  local_status_response(200L, "[]")
  x <- cbbd_ratings_history(season = 2026, date = "2025-07-01")
  expect_s3_class(x, "hoopR_data")
  expect_equal(nrow(x), 0L)
})

test_that(".stop_for_http_status() raises a classed error carrying the status", {
  ok <- httr2::response(status_code = 204L, url = "https://example.com/x")
  expect_identical(hoopR:::.stop_for_http_status(ok), ok)

  bad <- httr2::response(
    status_code = 403L, url = "https://example.com/x?season=2025",
    headers = list(`Content-Type` = "application/json"), body = charToRaw('{"error":"Forbidden here"}')
  )
  err <- expect_error(hoopR:::.stop_for_http_status(bad), class = "hoopR_http_error")
  expect_s3_class(err, "hoopR_fetch_error")
  expect_s3_class(err, "hoopR_error")
  expect_identical(err$status, 403L)
  expect_identical(conditionMessage(err), "HTTP 403 Forbidden from https://example.com/x: Forbidden here")
})

test_that("the other shared request helpers stop on an error status before parsing", {
  skip_on_cran()
  local_status_response(503L, "<html>busy</html>", type = "text/html")
  expect_error(hoopR:::.torvik_text("/trank.php"), "HTTP 503", class = "hoopR_http_error")
  expect_error(hoopR:::.bref_text("/leagues/"), "HTTP 503", class = "hoopR_http_error")
  expect_error(hoopR:::.ext_html("https://www.spotrac.com/nba/cap/"), "HTTP 503", class = "hoopR_http_error")
  expect_error(hoopR:::request_with_proxy("https://stats.nba.com/stats/x", params = list()),
               "HTTP 503", class = "hoopR_http_error")
})
