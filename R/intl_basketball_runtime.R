# intl_basketball_runtime.R -- shared transport for the international basketball families.
#
# R mirror of sdv-py sportsdataverse/basketball/basketball_runtime.py (plus the
# shared _codegen_runtime status vocabulary and genius_runtime._body_text). Every
# provider is wrapped politely: at least one second between two requests to the
# same host, on EVERY attempt, retries included. httr2::req_throttle() cannot do
# that (httr2 throttles once, before its retry loop, and not at all for mocked
# responses), so the per-host clock lives here and .intl_perform() runs the
# retry loop itself.
#
#   .intl_get(url, ...)                  the plain getter: GET, or POST a form / JSON
#                                        body; returns the 2xx body text (UTF-8)
#   .intl_json(text)                     parse that text as JSON
#   .intl_response(url, ...)             same request, the httr2 response unchecked
#                                        (a family that reads a non-2xx body first,
#                                        e.g. Genius' 403 / 500 pages), then
#   .intl_check_status(resp)             the status vocabulary below
#   .intl_request() + httr2 verbs        a family with its own transport (cookies,
#     + .intl_perform(req)               signed headers); still throttled + retried
#   .intl_wait(url)                      the clock itself, for anything else
#
# Error vocabulary (classed conditions, all inherit "hoopR_error"):
#   hoopR_no_data      sdv-py NoDataError: HTTP 404, an empty valid answer the
#                      family treats as "nothing here".
#   hoopR_bad_request  sdv-py ValueError: HTTP 400 / 422, a bad argument.
#   hoopR_asset_fetch  sdv-py AssetFetchError: any other non-2xx (a 3xx when
#                      redirects are off), a transport failure after retries, an
#                      empty or non-JSON body, an error envelope, a wrong-scope body.
#                      Field `transient`: TRUE for 408 / 429 / 5xx and transport
#                      failures (retry later), FALSE for a definitive refusal.
#
# HTTP 500 policy (sdv-py basketball_runtime docstring): 408 / 429 / 502 / 503 /
# 504 are always retried; 500 only with `retry_500 = TRUE`. Families whose
# providers answer 500 deterministically (cba, cebl, easl, fiba_hub, genius,
# ibba, kbl, lba, dbl/sportality, plg, tbf; tpbl's player game log) keep the
# default FALSE; aba, acb, bleague, bnxt, feb, lkl, scb, tpbl (other routes),
# atrium, kzs, nbl_au, vtb and wjbl pass TRUE.
#
# Proxies: the `proxy` argument, then getOption("hoopR.proxy"), then the
# environment variable named by `proxy_env` (GENIUS_PROXY, CBA_PROXY). A proxy
# URL can carry credentials: it is never printed, logged or put in a condition.

#' Minimum seconds between two requests to one host.
#' @noRd
.INTL_MIN_INTERVAL <- 1

#' Statuses always retried; 500 joins them only with `retry_500 = TRUE`.
#' @noRd
.INTL_RETRY_STATUSES <- c(408L, 429L, 502L, 503L, 504L)

#' Cap on a server's `Retry-After`, in seconds (sdv-py `dl_utils._MAX_RETRY_AFTER`).
#' @noRd
.INTL_MAX_RETRY_AFTER <- 120

# host -> elapsed-clock time of its last reserved request slot
.intl_clock <- new.env(parent = emptyenv())

#' `Sys.sleep()` and the elapsed clock, behind bindings the tests can mock.
#' @noRd
.intl_sleep <- function(seconds) Sys.sleep(seconds)
#' @noRd
.intl_now <- function() proc.time()[["elapsed"]]

#' Sleep until `min_interval` seconds have passed since the last request to
#' `url`'s host, and reserve this request's slot.
#'
#' @param url The URL about to be requested; only its host (and port) is used.
#' @param min_interval Spacing to enforce, in seconds.
#' @return The seconds slept, invisibly.
#' @noRd
.intl_wait <- function(url, min_interval = .INTL_MIN_INTERVAL) {
  parts <- httr2::url_parse(url)
  host <- paste0(parts$hostname, if (!is.null(parts$port)) paste0(":", parts$port))
  now <- .intl_now()
  slot <- max(now, (.intl_clock[[host]] %||% -Inf) + min_interval)
  .intl_clock[[host]] <- slot
  if (slot > now) .intl_sleep(slot - now)
  invisible(slot - now)
}

#' Full-width digits (U+FF10..U+FF19) as ASCII, so `[0-9]` and `as.integer()` read them as sdv-py's `\d` and
#' `int()` do; anything but a character vector comes back as it is.
#' @noRd
.intl_ascii_digits <- function(x) {
  if (is.character(x)) chartr("\uff10\uff11\uff12\uff13\uff14\uff15\uff16\uff17\uff18\uff19", "0123456789", x) else x
}

#' `host/path` of a URL, never its query string (which may carry a key).
#' @noRd
.intl_where <- function(url) sub("^[a-z]+://([^@/]*@)?", "", sub("[?#].*$", "", url))

# ---------------------------------------------------------------------------
# Classed conditions
# ---------------------------------------------------------------------------
# `message` is a cli format string, interpolated in the caller's frame. Extra
# named arguments become condition fields (e.g. `status = 503L`, `parent = e`).
# Catch one kind or the whole family:
#   tryCatch(x, hoopR_no_data = function(e) NULL)
#   tryCatch(x, hoopR_asset_fetch = function(e) if (isTRUE(e$transient)) retry())

#' @noRd
.abort_no_data <- function(message, ..., call = rlang::caller_env(), .envir = parent.frame()) {
  cli::cli_abort(message, ..., class = c("hoopR_no_data", "hoopR_error"), call = call, .envir = .envir)
}

#' @noRd
.abort_asset_fetch <- function(message, ..., transient = FALSE, call = rlang::caller_env(),
                               .envir = parent.frame()) {
  cli::cli_abort(message, ..., transient = isTRUE(transient),
                 class = c("hoopR_asset_fetch", "hoopR_error"), call = call, .envir = .envir)
}

#' @noRd
.abort_bad_request <- function(message, ..., call = rlang::caller_env(), .envir = parent.frame()) {
  cli::cli_abort(message, ..., class = c("hoopR_bad_request", "hoopR_error"), call = call, .envir = .envir)
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' Resolve the proxy: argument, then `getOption("hoopR.proxy")`, then `$proxy_env`.
#'
#' @return `NULL`, or `list(value = <proxy>, source = <label naming where it came
#'   from, never the value>)`.
#' @noRd
.intl_proxy <- function(proxy = NULL, proxy_env = NULL) {
  if (!is.null(proxy)) return(list(value = proxy, source = "the proxy argument"))
  opt <- getOption("hoopR.proxy", default = NULL)
  if (!is.null(opt)) return(list(value = opt, source = "option hoopR.proxy"))
  if (!is.null(proxy_env)) {
    env <- trimws(Sys.getenv(proxy_env, ""))
    if (nzchar(env)) return(list(value = env, source = proxy_env))
  }
  NULL
}

#' Build an httr2 request (no retry, no error policy: `.intl_perform()` owns those).
#'
#' @param url Fully built request URL.
#' @param query Named list of query parameters; `NULL` entries are dropped, a
#'   vector value repeats the key (as `requests` does).
#' @param body Named list: the form fields or the JSON object. Requires `body_type`.
#' @param body_type `"none"` (GET), `"form"` (POST urlencoded) or `"json"` (POST JSON).
#' @param headers Named list or character vector of request headers.
#' @param proxy A proxy URL string, or a named list spread into [httr2::req_proxy()].
#' @param timeout Seconds.
#' @param follow_redirects `FALSE` for a request carrying a credential header: a
#'   3xx is returned (and maps to `hoopR_asset_fetch`), never followed.
#' @return An httr2 request.
#' @noRd
.intl_request <- function(url, query = list(), body = NULL, body_type = c("none", "form", "json"),
                          headers = NULL, proxy = NULL, timeout = 60, follow_redirects = TRUE) {
  body_type <- match.arg(body_type)
  req <- httr2::request(url)
  query <- Filter(Negate(is.null), as.list(query))
  if (length(query)) req <- httr2::req_url_query(req, !!!query, .multi = "explode")
  if (length(headers)) req <- httr2::req_headers(req, !!!as.list(headers))
  if (body_type == "none" && !is.null(body)) {
    .abort_bad_request("{.arg body} needs {.arg body_type} = {.val form} or {.val json}.")
  }
  if (body_type == "form") req <- httr2::req_body_form(req, !!!as.list(body))
  if (body_type == "json") req <- httr2::req_body_json(req, body)
  if (!is.null(proxy)) {
    req <- if (is.list(proxy)) do.call(httr2::req_proxy, c(list(req = req), proxy)) else httr2::req_proxy(req, url = proxy)
  }
  if (!isTRUE(follow_redirects)) req <- httr2::req_options(req, followlocation = 0L)
  httr2::req_timeout(req, timeout)
}

#' Perform an httr2 request, throttled per host on every attempt.
#'
#' Retries 408/429/502/503/504 (and 500 when `retry_500`) or a transport failure,
#' up to `max_tries` attempts; any other status is returned at once. After failed
#' attempt k the next waits at least `max(min_interval, 2^(k - 1))` seconds after
#' the host's last request, or the server's `Retry-After` (capped at 120 s) when
#' longer. Non-2xx responses are returned, not raised: pass them to
#' `.intl_check_status()`. A transport failure after the last attempt raises
#' `hoopR_asset_fetch` (`transient = TRUE`); through a proxy the message names the
#' proxy's source and the cause class only.
#'
#' @param req An httr2 request; any `req_retry()` / `req_error()` policy is replaced.
#' @param retry_500 Retry HTTP 500 too (the per-family policy, see the file header).
#' @param statuses Extra statuses to retry (integer vector), on top of the defaults
#'   (e.g. LBA's transient 403).
#' @param max_tries Maximum attempts.
#' @param min_interval Spacing between requests to one host, in seconds.
#' @param proxy_label Where the proxy came from (for messages), if the caller knows.
#' @param call The frame named in a raised condition.
#' @return An httr2 response.
#' @noRd
.intl_perform <- function(req, retry_500 = FALSE, max_tries = 3, min_interval = .INTL_MIN_INTERVAL,
                          proxy_label = NULL, statuses = NULL, call = rlang::caller_env()) {
  statuses <- c(.INTL_RETRY_STATUSES, if (isTRUE(retry_500)) 500L, as.integer(statuses))
  req <- req |>
    httr2::req_retry(max_tries = 1) |>
    httr2::req_error(is_error = function(resp) FALSE)
  interval <- min_interval
  for (i in seq_len(max_tries)) {
    .intl_wait(req$url, interval)
    resp <- tryCatch(.intl_req_perform(req), error = function(e) e)
    failed <- inherits(resp, "error")
    if (!failed && !httr2::resp_status(resp) %in% statuses) return(resp)
    if (i == max_tries) break
    interval <- max(min_interval, 2^(i - 1))
    if (!failed) {
      ra <- suppressWarnings(httr2::resp_retry_after(resp))
      if (length(ra) == 1L && !is.na(ra)) interval <- max(interval, min(ra, .INTL_MAX_RETRY_AFTER))
    }
  }
  if (!failed) return(resp)
  where <- .intl_where(req$url)
  if (!is.null(req$options$proxy)) {
    # the transport message can quote the proxy URL (credentials included): class only, no parent
    via <- proxy_label %||% "a proxy"
    cause <- class(resp)[[1]]
    .abort_asset_fetch("{where}: the fetch through {via} failed after {max_tries} attempt{?s} ({cause}).",
                       transient = TRUE, call = call)
  }
  msg <- conditionMessage(resp)
  .abort_asset_fetch("{where}: fetch failed after {max_tries} attempt{?s}: {msg}",
                     transient = TRUE, parent = resp, call = call)
}

#' `httr2::req_perform()` with the response headers parsed bytewise.
#'
#' httr2 splits the raw header block with `curl::parse_headers()`; one byte that
#' is not valid UTF-8 (basket.co.il's 0xA0 in `Set-Cookie`) makes that warn in a
#' UTF-8 session and leaves the response with NO headers. Parsing under the C
#' character locale splits bytes; a header value that is still not valid UTF-8
#' is then read as ISO-8859-1 (as `.intl_body_text()` does for a body).
#' @noRd
.intl_req_perform <- function(req) {
  resp <- withr::with_locale(c(LC_CTYPE = "C"), httr2::req_perform(req))
  bad <- vapply(resp$headers, function(v) is.character(v) && !all(validUTF8(v)), logical(1))
  resp$headers[bad] <- lapply(resp$headers[bad], iconv, from = "latin1", to = "UTF-8")
  resp
}

#' The response body as text, read as UTF-8 when the server names no charset.
#'
#' Mirrors sdv-py `genius_runtime._body_text`: a declared charset is honoured;
#' without one the bytes are read as UTF-8, and bytes that are not valid UTF-8
#' fall back to ISO-8859-1 (what `requests` would have given). No body is `""`.
#'
#' @param resp An httr2 response.
#' @return A UTF-8 character string.
#' @noRd
.intl_body_text <- function(resp) {
  if (!httr2::resp_has_body(resp)) return("")
  raw <- httr2::resp_body_raw(resp)
  if (!length(raw)) return("")
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  charset <- regmatches(ctype, regexpr("(?<=charset=)[^;[:space:]]+", ctype, perl = TRUE))
  charset <- gsub("[\"']", "", charset)
  if (length(charset) == 1L && nzchar(charset)) {
    txt <- tryCatch(iconv(list(raw), from = charset, to = "UTF-8", sub = "\uFFFD"), error = function(e) NA_character_)
    if (!is.na(txt)) return(enc2utf8(txt))
  }
  txt <- rawToChar(raw)
  if (validUTF8(txt)) {
    Encoding(txt) <- "UTF-8"
    return(txt)
  }
  iconv(txt, from = "latin1", to = "UTF-8")
}

#' Raise unless the response is 2xx (the sdv-py `_check_status` vocabulary).
#'
#' 404 -> `hoopR_no_data`; 400 / 422 -> `hoopR_bad_request`; any other non-2xx ->
#' `hoopR_asset_fetch`, `transient` for 408 / 429 / 5xx. Every condition carries
#' the `status` field.
#'
#' @param resp An httr2 response.
#' @param where Label for messages; defaults to the request's `host/path`.
#' @param call The frame named in a raised condition.
#' @return `resp`, invisibly, when it is 2xx.
#' @noRd
.intl_check_status <- function(resp, where = .intl_where(resp$url), call = rlang::caller_env()) {
  status <- httr2::resp_status(resp)
  if (status >= 200 && status < 300) return(invisible(resp))
  excerpt <- substr(gsub("\\s+", " ", tryCatch(.intl_body_text(resp), error = function(e) "")), 1, 200)
  if (status == 404) .abort_no_data("{where} answered HTTP 404.", status = status, call = call)
  if (status %in% c(400L, 422L)) {
    .abort_bad_request("{where} rejected the request: HTTP {status}: {excerpt}", status = status, call = call)
  }
  .abort_asset_fetch("{where} answered HTTP {status}: {excerpt}", status = status,
                     transient = status %in% c(408L, 429L) || status >= 500, call = call)
}

#' Throttled request, the httr2 response unchecked (see `.intl_get()` for the arguments).
#' @noRd
.intl_response <- function(url, query = list(), body = NULL, body_type = c("none", "form", "json"),
                           headers = NULL, proxy_env = NULL, retry_500 = FALSE, timeout = 60,
                           proxy = NULL, follow_redirects = TRUE, statuses = NULL,
                           call = rlang::caller_env()) {
  px <- .intl_proxy(proxy, proxy_env)
  req <- .intl_request(url, query = query, body = body, body_type = body_type, headers = headers,
                       proxy = px$value, timeout = timeout, follow_redirects = follow_redirects)
  .intl_perform(req, retry_500 = retry_500, proxy_label = px$source, statuses = statuses, call = call)
}

#' The international basketball getter: throttled, retried, status-checked.
#'
#' @param url Fully built request URL.
#' @param query Named list of query parameters; `NULL` entries are dropped.
#' @param body Named list: form fields or the JSON object (POST).
#' @param body_type `"none"` (GET), `"form"` or `"json"`.
#' @param headers Named list or character vector of request headers.
#' @param proxy_env NAME of an environment variable holding a proxy URL
#'   (`"GENIUS_PROXY"`, `"CBA_PROXY"`); read last, after `proxy` and
#'   `getOption("hoopR.proxy")`.
#' @param retry_500 Retry HTTP 500 (the per-family policy; default `FALSE`).
#' @param timeout Seconds per attempt.
#' @param proxy Explicit proxy (URL string or a [httr2::req_proxy()] argument list).
#' @param follow_redirects `FALSE` when a credential header must not leave the host.
#' @param statuses Extra statuses to retry, on top of 408/429/502/503/504 (and 500).
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The 2xx body as a UTF-8 string (`""` for an empty body).
#' @noRd
.intl_get <- function(url, query = list(), body = NULL, body_type = c("none", "form", "json"),
                      headers = NULL, proxy_env = NULL, retry_500 = FALSE, timeout = 60,
                      proxy = NULL, follow_redirects = TRUE, statuses = NULL,
                      call = rlang::caller_env()) {
  resp <- .intl_response(url, query = query, body = body, body_type = body_type, headers = headers,
                         proxy_env = proxy_env, retry_500 = retry_500, timeout = timeout,
                         proxy = proxy, follow_redirects = follow_redirects, statuses = statuses,
                         call = call)
  .intl_check_status(resp, call = call)
  .intl_body_text(resp)
}

#' Parse a body as JSON; an empty or non-JSON body is `hoopR_asset_fetch`.
#'
#' An empty 2xx body is a block or a rejected parameter, not "nothing": a family
#' whose provider answers "no such game" with an empty body checks
#' `nzchar(trimws(text))` itself before calling this.
#'
#' @param text Body text (from `.intl_get()`).
#' @param where Label for messages.
#' @param simplifyVector Passed to [jsonlite::parse_json()]; `FALSE` keeps the
#'   nested-list shape the sdv-py parsers walk.
#' @param ... Passed to [jsonlite::parse_json()].
#' @param call The frame named in a raised condition.
#' @return The parsed body.
#' @noRd
.intl_json <- function(text, where = "the response", simplifyVector = FALSE, ..., call = rlang::caller_env()) {
  if (length(text) != 1L || is.na(text) || !nzchar(trimws(text))) {
    .abort_asset_fetch("{where} answered an empty body.", call = call)
  }
  tryCatch(
    jsonlite::parse_json(text, simplifyVector = simplifyVector, ...),
    error = function(e) {
      excerpt <- substr(gsub("\\s+", " ", text), 1, 200)
      .abort_asset_fetch("{where} answered a non-JSON body: {excerpt}", call = call)
    }
  )
}

# ---------------------------------------------------------------------------
# Frames
# ---------------------------------------------------------------------------

#' Zero-row tibble with the documented columns and types.
#'
#' What a wrapper returns for an empty valid answer (sdv-py's `_PARSER_COLUMNS`
#' contract), so callers can chain without a null check.
#'
#' @param cols_types Named character vector, column name -> type: one of
#'   `"character"`, `"integer"`, `"double"`, `"numeric"`, `"logical"`, `"Date"`,
#'   `"POSIXct"` (UTC), `"list"`.
#' @return A zero-row tibble.
#' @noRd
.empty_tibble <- function(cols_types) {
  proto <- list(
    character = character(), integer = integer(), double = double(), numeric = double(),
    logical = logical(), Date = as.Date(character()), POSIXct = as.POSIXct(character(), tz = "UTC"),
    list = list()
  )
  bad <- setdiff(unname(cols_types), names(proto))
  if (length(bad)) .abort_bad_request("Unknown column type{?s}: {.val {bad}}.")
  out <- proto[unname(cols_types)]
  names(out) <- names(cols_types)
  dplyr::as_tibble(out)
}

#' sdv-py `dl_utils.underscore()`: CamelCase / UPPER_CASE / kebab -> snake_case.
#'
#' The exact port (not `janitor::make_clean_names()`, which differs on digits,
#' dots and duplicates), for the 13 families whose sdv-py parsers name columns with
#' it: acb, atrium, cba, dbl, easl, fiba_hub, ibba, kbl, kzs, lba, nbl_au, scb, vtb.
#'
#' @param x Character vector of names.
#' @return Character vector.
#' @noRd
.intl_clean_names <- function(x) {
  x <- gsub("([A-Z]+)([A-Z][a-z])", "\\1_\\2", x, perl = TRUE)
  x <- gsub("([a-z0-9])([A-Z])", "\\1_\\2", x, perl = TRUE)
  tolower(gsub("-", "_", x, fixed = TRUE))
}

#' Roxygen lines of one topic's `@details` (roxygen `@eval`): a family's shared notes, then, for a
#' function whose example is not run, the call as a code block (the NBA Stats house style). A topic
#' that defines `@details` inherits none, so the notes are held once in a `.<primary>_details`
#' vector instead of `@inherit <primary> details`.
#'
#' @param notes Character vector of roxygen markdown lines.
#' @param example Character vector of code lines, or `NULL` for none.
#' @return Character vector of roxygen lines.
#' @noRd
.intl_details <- function(notes, example = NULL) {
  c("@details", notes, if (length(example)) c("", "```r", paste0(" ", example), "```"))
}
