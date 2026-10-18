# Offline tests of the shared international basketball transport
# (R/intl_basketball_runtime.R). Every request is mocked; sleeps are recorded,
# never slept.

# a fake clock: .intl_sleep() records the wait and advances .intl_now()
local_intl <- function(env = parent.frame()) {
  sleeps <- new.env()
  sleeps$s <- numeric()
  sleeps$now <- 1000
  rm(list = ls(.intl_clock), envir = .intl_clock)
  local_mocked_bindings(
    .intl_sleep = function(seconds) {
      sleeps$s <- c(sleeps$s, seconds)
      sleeps$now <- sleeps$now + seconds
    },
    .intl_now = function() sleeps$now,
    .env = env
  )
  sleeps
}

# a mock answering `statuses` in turn (the last one repeats), counting calls
seq_mock <- function(statuses, headers = list(), body = charToRaw("{}")) {
  calls <- new.env()
  calls$n <- 0L
  calls$fn <- function(req) {
    calls$n <- calls$n + 1L
    calls$req <- req
    st <- statuses[[min(calls$n, length(statuses))]]
    httr2::response(st, headers = headers, body = body)
  }
  calls
}

url <- "https://api.example.org/v1/games?key=abc"

test_that("2xx returns the body text; 404/400/422/other map to the classed conditions", {
  local_intl()
  httr2::local_mocked_responses(function(req) httr2::response(200, body = charToRaw('{"a":1}')))
  expect_identical(.intl_get(url), '{"a":1}')

  for (case in list(list(404L, "hoopR_no_data"), list(400L, "hoopR_bad_request"),
                    list(422L, "hoopR_bad_request"), list(403L, "hoopR_asset_fetch"),
                    list(302L, "hoopR_asset_fetch"))) {
    m <- seq_mock(case[[1]])
    httr2::local_mocked_responses(m$fn)
    cnd <- expect_error(.intl_get(url), class = case[[2]])
    expect_s3_class(cnd, "hoopR_error")
    expect_identical(cnd$status, case[[1]])
    expect_identical(m$n, 1L)
    expect_false(grepl("key=abc", conditionMessage(cnd), fixed = TRUE)) # never the query string
  }
  cnd <- tryCatch(.intl_get(url), hoopR_asset_fetch = function(e) e)
  expect_false(cnd$transient) # a 3xx / 403 is a definitive refusal
})

test_that("408/429/502/503/504 are retried 3 times and end transient", {
  for (st in c(408L, 429L, 502L, 503L, 504L)) {
    local_intl()
    m <- seq_mock(st)
    httr2::local_mocked_responses(m$fn)
    cnd <- expect_error(.intl_get(url), class = "hoopR_asset_fetch")
    expect_true(cnd$transient)
    expect_identical(m$n, 3L)
  }
})

test_that("a retried status that recovers returns the body", {
  local_intl()
  m <- seq_mock(c(503L, 200L))
  httr2::local_mocked_responses(m$fn)
  expect_identical(.intl_get(url), "{}")
  expect_identical(m$n, 2L)
})

test_that("HTTP 500 is not retried by default, and is with retry_500 = TRUE", {
  local_intl()
  m <- seq_mock(500L)
  httr2::local_mocked_responses(m$fn)
  cnd <- expect_error(.intl_get(url), class = "hoopR_asset_fetch")
  expect_identical(m$n, 1L)
  expect_true(cnd$transient)

  local_intl()
  m <- seq_mock(c(500L, 500L, 200L))
  httr2::local_mocked_responses(m$fn)
  expect_identical(.intl_get(url, retry_500 = TRUE), "{}")
  expect_identical(m$n, 3L)
})

test_that("Retry-After is honoured (capped at 120 s) and backoff grows", {
  sl <- local_intl()
  m <- seq_mock(c(429L, 200L), headers = list("Retry-After" = "7"))
  httr2::local_mocked_responses(m$fn)
  .intl_get(url)
  expect_length(sl$s, 1L)
  expect_identical(sl$s, 7)

  sl <- local_intl()
  m <- seq_mock(429L, headers = list("Retry-After" = "9999"))
  httr2::local_mocked_responses(m$fn)
  expect_error(.intl_get(url), class = "hoopR_asset_fetch")
  expect_identical(sl$s, c(120, 120))

  sl <- local_intl()
  m <- seq_mock(503L)
  httr2::local_mocked_responses(m$fn)
  expect_error(.intl_get(url), class = "hoopR_asset_fetch")
  expect_identical(sl$s, c(1, 2)) # waits before attempts 2 and 3
})

test_that("the throttle spaces requests to one host by at least 1 s, not other hosts", {
  sl <- local_intl()
  httr2::local_mocked_responses(function(req) httr2::response(200, body = charToRaw("ok")))
  .intl_get("https://a.example.org/x")
  .intl_get("https://b.example.org/x")
  expect_length(sl$s, 0L)
  .intl_get("https://a.example.org/y")
  expect_identical(sl$s, 1)
})

test_that("a transport failure after retries is a transient asset_fetch", {
  local_intl()
  n <- 0L
  httr2::local_mocked_responses(function(req) {
    n <<- n + 1L
    stop("Could not resolve host: api.example.org")
  })
  cnd <- expect_error(.intl_get(url), class = "hoopR_asset_fetch")
  expect_true(cnd$transient)
  expect_identical(n, 3L)
  expect_match(conditionMessage(cnd), "Could not resolve host", fixed = TRUE)
})

test_that("form and JSON bodies are POSTed; a body without a type is refused", {
  local_intl()
  seen <- list()
  httr2::local_mocked_responses(function(req) {
    seen[[length(seen) + 1L]] <<- list(method = httr2::req_get_method(req), type = httr2::req_get_body_type(req))
    httr2::response(200, body = charToRaw("{}"))
  })
  .intl_get(url, body = list(a = 1), body_type = "form")
  .intl_get(url, body = list(a = 1), body_type = "json")
  .intl_get(url)
  expect_identical(seen[[1]], list(method = "POST", type = "form"))
  expect_identical(seen[[2]], list(method = "POST", type = "json"))
  expect_identical(seen[[3]]$method, "GET")
  expect_error(.intl_get(url, body = list(a = 1)), class = "hoopR_bad_request")
})

test_that("query NULLs are dropped and vectors repeat the key", {
  local_intl()
  got <- NULL
  httr2::local_mocked_responses(function(req) {
    got <<- req$url
    httr2::response(200, body = charToRaw("{}"))
  })
  .intl_get("https://api.example.org/q", query = list(a = 1, b = NULL, c = c("x", "y")))
  expect_identical(got, "https://api.example.org/q?a=1&c=x&c=y")
})

test_that("the body is read as UTF-8 when no charset is declared", {
  local_intl()
  txt <- "\u00c9quipe \u0395\u03bb\u03bb\u03ac\u03b4\u03b1 \u5317\u4eac"
  httr2::local_mocked_responses(function(req) {
    httr2::response(200, headers = list("Content-Type" = "text/html"), body = charToRaw(enc2utf8(txt)))
  })
  out <- .intl_get(url)
  expect_identical(out, enc2utf8(txt))
  expect_identical(Encoding(out), "UTF-8")

  # a declared charset is honoured
  latin <- iconv("Soci\u00e9t\u00e9", from = "UTF-8", to = "latin1", toRaw = TRUE)[[1]]
  httr2::local_mocked_responses(function(req) {
    httr2::response(200, headers = list("Content-Type" = "text/html; charset=ISO-8859-1"), body = latin)
  })
  expect_identical(.intl_get(url), enc2utf8("Soci\u00e9t\u00e9"))

  # bytes that are not UTF-8, with no charset, fall back to ISO-8859-1
  httr2::local_mocked_responses(function(req) {
    httr2::response(200, headers = list("Content-Type" = "text/html"), body = latin)
  })
  expect_identical(.intl_get(url), enc2utf8("Soci\u00e9t\u00e9"))

  httr2::local_mocked_responses(function(req) httr2::response(204))
  expect_identical(.intl_get(url), "")
})

test_that("the proxy resolves argument > option > env, and is never printed", {
  local_intl()
  secret <- "http://user:s3cr3t@proxy.example.net:8080"
  withr::local_envvar(INTL_TEST_PROXY = secret)
  withr::local_options(hoopR.proxy = NULL)
  used <- NULL
  httr2::local_mocked_responses(function(req) {
    used <<- req$options$proxy
    stop(paste("Failed to connect to proxy.example.net port 8080 via", secret))
  })
  cnd <- expect_error(.intl_get(url, proxy_env = "INTL_TEST_PROXY"), class = "hoopR_asset_fetch")
  expect_identical(used, secret)
  expect_true(cnd$transient)
  printed <- paste(conditionMessage(cnd), paste(format(cnd), collapse = "\n"),
                   paste(utils::capture.output(print(cnd)), collapse = "\n"))
  expect_false(grepl("s3cr3t", printed, fixed = TRUE))
  expect_false(grepl("proxy.example.net", printed, fixed = TRUE))
  expect_match(conditionMessage(cnd), "INTL_TEST_PROXY", fixed = TRUE) # names the variable only
  expect_null(cnd$parent)

  withr::local_options(hoopR.proxy = "http://opt.example.net:1")
  expect_identical(.intl_proxy(proxy_env = "INTL_TEST_PROXY")$value, "http://opt.example.net:1")
  expect_identical(.intl_proxy("http://arg.example.net:2", "INTL_TEST_PROXY")$value, "http://arg.example.net:2")
  withr::local_options(hoopR.proxy = NULL)
  withr::local_envvar(INTL_TEST_PROXY = " ")
  expect_null(.intl_proxy(proxy_env = "INTL_TEST_PROXY"))
})

test_that(".intl_json parses, and refuses an empty or non-JSON body", {
  expect_identical(.intl_json('{"a":[1,2]}'), list(a = list(1L, 2L)))
  expect_error(.intl_json("  "), class = "hoopR_asset_fetch")
  expect_error(.intl_json("<html>blocked</html>"), class = "hoopR_asset_fetch")
})

test_that("the abort helpers carry their classes and the transient field", {
  expect_error(.abort_no_data("x"), class = "hoopR_no_data")
  expect_error(.abort_bad_request("x"), class = "hoopR_bad_request")
  cnd <- expect_error(.abort_asset_fetch("x"), class = "hoopR_asset_fetch")
  expect_false(cnd$transient)
  cnd <- expect_error(.abort_asset_fetch("x", transient = TRUE), class = "hoopR_error")
  expect_true(cnd$transient)
})

test_that(".empty_tibble builds a zero-row tibble with the documented types", {
  x <- .empty_tibble(c(game_id = "integer", team = "character", pts = "double", home = "logical",
                       date = "Date", tip = "POSIXct"))
  expect_s3_class(x, "tbl_df")
  expect_identical(nrow(x), 0L)
  expect_identical(names(x), c("game_id", "team", "pts", "home", "date", "tip"))
  expect_identical(unname(vapply(x, function(c) class(c)[[1]], "")),
                   c("integer", "character", "numeric", "logical", "Date", "POSIXct"))
  expect_error(.empty_tibble(c(a = "int64")), class = "hoopR_bad_request")
})

test_that(".intl_clean_names is sdv-py's underscore()", {
  expect_identical(.intl_clean_names(c("DeviceType", "IOError", "playerID2", "kebab-case", "already_snake")),
                   c("device_type", "io_error", "player_id2", "kebab_case", "already_snake"))
})

test_that("the competition registry keeps this package's genders only", {
  reg <- .intl_basketball_competitions
  expect_named(reg, c("fiba", "genius", "atrium"))
  for (eng in reg) {
    for (e in eng) {
      expect_true(all(c("key", "prefix", "label", "ids", "gender", "season_rule") %in% names(e)))
      expect_true(e$gender %in% c("men", "both"))
    }
  }
  expect_identical(lengths(reg), c(fiba = 9L, genius = 6L, atrium = 5L))
})
