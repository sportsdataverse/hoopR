# Record the stats.nba.com responses replayed by tests/testthat/test-nba_stats_offline.R.
#
# stats.nba.com hangs on datacenter / cloud IPs and throttles scrapers, so the
# general recorder (record_fixtures.R) never requests it. This one does, slowly,
# from a residential connection, one request at a time. Run from the package root:
#
#   PYTHONUNBUFFERED=1 Rscript data-raw/http_fixtures/record_nba_stats.R [calls.txt] \
#     >> data-raw/http_fixtures/record_nba_stats.log 2>&1; echo EXIT=$?
#
# * Calls come from data-raw/http_fixtures/nba_stats_calls.txt (or the file given),
#   one per line. Pass every season / game id explicitly so URLs never drift.
# * Pacing is env-only: at most STATS_RATE_HITS requests per STATS_RATE_WINDOW
#   seconds (default 1 per 3 s) and at most STATS_RATE_MAX network requests per
#   run (default 150). Each request gets STATS_TIMEOUT seconds (default 20) and no
#   retries.
# * It stops at the first 403 / 429, or after two timeouts in a row, rather than
#   push on: exit status 2. Do not re-run straight away after that.
# * Resumable: index.json is rewritten after every call and a URL already in it is
#   replayed, not refetched, so a re-run (after Ctrl-C or a stop) only requests
#   what is still missing. Delete an entry, or the directory, to record it again.
# * resultSets rowSet arrays and V3 object arrays (players, actions, ...) are cut to
#   5 rows before the wrapper sees them; headers and the result-set list itself are
#   kept whole. A call ending in "# keep" is recorded uncut.
# Then: Rscript data-raw/http_fixtures/generate_nba_stats_tests.R

suppressMessages(devtools::load_all(".", quiet = TRUE))
`%||%` <- function(a, b) if (is.null(a)) b else a
# cat() to stderr, not message(): the calls run under suppressMessages().
log_line <- function(...) cat(format(Sys.time(), "%Y-%m-%d %H:%M:%S"), " ", ..., "\n", sep = "", file = stderr())

env_num <- function(name, default) {
  v <- suppressWarnings(as.numeric(Sys.getenv(name, "")))
  if (is.na(v)) default else v
}
rate_hits   <- env_num("STATS_RATE_HITS", 1)
rate_window <- env_num("STATS_RATE_WINDOW", 3)
rate_max    <- env_num("STATS_RATE_MAX", 150)
timeout_s   <- env_num("STATS_TIMEOUT", 20)

fix_dir   <- file.path("tests", "testthat", "fixtures", "nba_stats")
args      <- commandArgs(trailingOnly = TRUE)
calls_txt <- if (length(args)) args[[1]] else file.path("data-raw", "http_fixtures", "nba_stats_calls.txt")
max_items <- 5L
dir.create(fix_dir, recursive = TRUE, showWarnings = FALSE)
index_json <- file.path(fix_dir, "index.json")
index <- if (file.exists(index_json)) jsonlite::read_json(index_json) else list()
write_index <- function() {
  jsonlite::write_json(index[order(names(index))], index_json, auto_unbox = TRUE, pretty = TRUE)
}

keep_whole <- c("resultSets", "resultSet", "headers")
trim <- TRUE
trim_json <- function(x, key = "") {
  if (!is.list(x) || length(x) == 0) return(x)
  rows <- is.null(names(x)) && all(vapply(x, is.list, TRUE))
  if (trim && rows && !key %in% keep_whole && length(x) > max_items) x <- x[seq_len(max_items)]
  nm <- names(x) %||% rep(key, length(x))
  for (i in seq_along(x)) x[i] <- list(trim_json(x[[i]], if (nzchar(nm[[i]])) nm[[i]] else key))
  x
}

saved_response <- function(url) {
  hit <- index[[url]]
  path <- file.path(fix_dir, hit$file)
  httr2::response(
    status_code = hit$status, url = url,
    headers = list(`Content-Type` = hit$type),
    body = memDecompress(readBin(path, "raw", file.size(path)), "gzip")
  )
}

stop_run <- function(why) {
  write_index()
  log_line("STOP: ", why, " -- index saved (", length(index), " responses); re-run later to resume")
  quit(save = "no", status = 2)
}

stamps <- numeric()
n_requests <- 0L
timeouts_in_row <- 0L
pace <- function() {
  repeat {
    now <- as.numeric(Sys.time())
    stamps <<- stamps[stamps > now - rate_window]
    if (length(stamps) < rate_hits) break
    Sys.sleep(max(0.1, min(stamps) + rate_window - now))
  }
  stamps <<- c(stamps, as.numeric(Sys.time()))
}

recorder <- function(req) {
  url <- req$url
  if (!is.null(index[[url]]) && !(isTRUE(index[[url]]$trimmed) && !trim)) return(saved_response(url))
  if (!grepl("^https://stats\\.nba\\.com/", url)) {
    log_line("  not stats.nba.com, not recorded: ", url)
    return(httr2::response(status_code = 599L, url = url))
  }
  if (n_requests >= rate_max) stop_run(sprintf("STATS_RATE_MAX (%d requests) reached", as.integer(rate_max)))
  pace()
  n_requests <<- n_requests + 1L
  t0 <- Sys.time()
  resp <- tryCatch(
    req |> httr2::req_timeout(timeout_s) |> httr2::req_retry(max_tries = 1) |>
      httr2::req_error(is_error = function(resp) FALSE) |> httr2::req_perform(mock = NULL),
    error = function(e) e
  )
  secs <- round(as.numeric(difftime(Sys.time(), t0, units = "secs")), 1)
  if (inherits(resp, "error")) {
    timeouts_in_row <<- timeouts_in_row + 1L
    log_line("  request ", n_requests, " FAILED after ", secs, "s: ", conditionMessage(resp))
    if (timeouts_in_row >= 2L) stop_run("two failed / hung requests in a row")
    return(httr2::response(status_code = 599L, url = url))
  }
  timeouts_in_row <<- 0L
  status <- httr2::resp_status(resp)
  log_line("  request ", n_requests, " -> ", status, " in ", secs, "s ", sub("^https://stats\\.nba\\.com", "", url))
  if (status %in% c(403L, 429L)) stop_run(paste("HTTP", status, "from stats.nba.com"))
  if (status != 200L) return(resp)
  type <- httr2::resp_header(resp, "content-type") %||% "application/json"
  body <- httr2::resp_body_raw(resp)
  j <- tryCatch(jsonlite::fromJSON(rawToChar(body), simplifyVector = FALSE), error = function(e) NULL)
  if (!is.null(j)) {
    body <- charToRaw(enc2utf8(as.character(jsonlite::toJSON(
      trim_json(j), auto_unbox = TRUE, null = "null", na = "null", digits = NA
    ))))
  }
  file <- index[[url]]$file %||% paste0(substr(rlang::hash(url), 1, 16), ".gz")
  writeBin(memCompress(body, "gzip"), file.path(fix_dir, file))
  index[[url]] <<- list(file = file, status = status, type = type, trimmed = trim)
  saved_response(url)
}

has_data <- function(out) {
  if (inherits(out, "error") || is.null(out)) return(FALSE)
  if (is.data.frame(out)) return(nrow(out) > 0)
  any(vapply(out, function(d) is.data.frame(d) && nrow(d) > 0, TRUE))
}

calls <- readLines(calls_txt)
calls <- calls[nzchar(trimws(calls)) & !startsWith(trimws(calls), "#")]
log_line("recording ", length(calls), " calls from ", calls_txt, "; pace ", rate_hits, " per ",
         rate_window, "s, max ", rate_max, " requests, timeout ", timeout_s, "s")
n_ok <- 0L
for (i in seq_along(calls)) {
  trim <- !grepl("#\\s*keep\\s*$", calls[[i]])
  out <- httr2::with_mocked_responses(recorder, tryCatch(
    suppressMessages(suppressWarnings(eval(parse(text = calls[[i]])))),
    error = function(e) e
  ))
  ok <- has_data(out)
  n_ok <- n_ok + ok
  write_index()
  log_line(sprintf("[%d/%d] %s %s", i, length(calls), if (ok) "ok  " else "FAIL", calls[[i]]))
}
log_line(n_ok, " of ", length(calls), " calls returned data; ", length(index), " responses in ",
         index_json, "; ", n_requests, " network requests this run")
