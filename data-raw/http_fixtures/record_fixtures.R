# Record the HTTP responses replayed by the tests/testthat/test-*_offline.R files.
#
# Run from the package root (needs network):
#   Rscript data-raw/http_fixtures/record_fixtures.R [candidates.txt]
#
# Each call in data-raw/http_fixtures/calls.txt (plus an optional candidates file)
# is run once against the live source. Every httr2 request is performed for real,
# with the request's own user agent and headers (so FanGraphs' okhttp UA and the
# Fox Origin header still apply), and the response is saved gzipped under
# tests/testthat/fixtures/http/, listed in index.json by URL. JSON arrays longer
# than `max_items` are trimmed (recursively) *before* the function sees them, so the
# recording run proves the function works on the trimmed fixture; a call ending in
# "# keep" is recorded whole. Calls that return data are written back to calls.txt;
# then run data-raw/http_fixtures/generate_tests.R.
# Pass season / date arguments explicitly so URLs don't drift with the calendar.
# Do not add stats.ncaa.org calls: that site IP-bans scrapers.
# Run it with no live-test toggles set (an empty R_ENVIRON_USER is safest) but with
# CBBD_API_KEY, or every cbbd_*() call fails its key check and is dropped. Do not
# edit this script while it runs: Rscript reads it as it goes.

suppressMessages(devtools::load_all(".", quiet = TRUE))
`%||%` <- function(a, b) if (is.null(a)) b else a

fix_dir   <- file.path("tests", "testthat", "fixtures", "http")
calls_txt <- file.path("data-raw", "http_fixtures", "calls.txt")
max_items <- 5L
args <- commandArgs(trailingOnly = TRUE)

# Incremental: responses already in index.json are replayed, not refetched, so
# adding calls only hits the network for new URLs. Delete the directory (or an
# entry) to record again from scratch.
dir.create(fix_dir, recursive = TRUE, showWarnings = FALSE)
index_json <- file.path(fix_dir, "index.json")

# Hosts that ban scrapers or sit behind a paid login are never requested, even
# when a recorded wrapper reaches them indirectly (e.g. a crosswalk calling
# nba_teams()); the call gets a 599 and fails to record.
never_record <- paste0(
  "(stats\\.nba\\.com|stats\\.wnba\\.com|stats\\.gleague\\.nba\\.com|stats\\.ncaa\\.org|",
  "sports-reference\\.com|basketball-reference\\.com|kenpom\\.com)"
)

trim <- TRUE
trim_json <- function(x) {
  if (!is.list(x) || length(x) == 0) return(x)
  if (trim && is.null(names(x)) && length(x) > max_items) x <- x[seq_len(max_items)]
  x[] <- lapply(x, trim_json)
  x
}

index <- if (file.exists(index_json)) jsonlite::read_json(index_json) else list()
index <- Filter(function(x) is.character(x$file), index)
saved_response <- function(url) {
  hit <- index[[url]]
  httr2::response(
    status_code = hit$status, url = url,
    headers = list(`Content-Type` = hit$type),
    body = memDecompress(readBin(file.path(fix_dir, hit$file), "raw", 50e6), "gzip")
  )
}

requested <- character()
recorder <- function(req) {
  url <- req$url
  requested <<- union(requested, url)
  # Same URL twice in one run: replay what we saved, unless this is a "# keep" call
  # and the saved copy was trimmed -- then refetch it whole (it serves both).
  if (!is.null(index[[url]]) && !(!isFALSE(index[[url]]$trimmed) && !trim)) {
    return(saved_response(url))
  }
  if (grepl(never_record, url)) return(httr2::response(status_code = 599L, url = url))
  resp <- tryCatch(httr2::req_perform(req, mock = NULL),
                   httr2_http = function(e) e$resp, error = function(e) NULL)
  Sys.sleep(0.2)
  if (is.null(resp)) return(httr2::response(status_code = 599L, url = url))
  status <- httr2::resp_status(resp)
  type <- httr2::resp_header(resp, "content-type") %||% "application/octet-stream"
  body <- httr2::resp_body_raw(resp)
  if (status == 200L && grepl("json", type)) {
    j <- tryCatch(jsonlite::fromJSON(rawToChar(body), simplifyVector = FALSE),
                  error = function(e) NULL)
    if (!is.null(j)) {
      body <- charToRaw(enc2utf8(as.character(jsonlite::toJSON(
        trim_json(j), auto_unbox = TRUE, null = "null", na = "null", digits = NA
      ))))
    }
  }
  # Named by URL hash, so an incremental run never reuses a pruned entry's name.
  file <- index[[url]]$file %||% paste0(substr(rlang::hash(url), 1, 16), ".gz")
  writeBin(memCompress(body, "gzip"), file.path(fix_dir, file))
  index[[url]] <<- list(file = file, status = status, type = type, trimmed = trim)
  saved_response(url)
}

calls <- unique(c(readLines(calls_txt), if (length(args)) readLines(args[[1]])))
calls <- calls[nzchar(trimws(calls)) & !startsWith(trimws(calls), "#")]
ok <- logical(length(calls))
# URLs each successful call requested while recording. A wrapper that memoises a
# page in the session (lkl's game page, a scb season list) asks for it only once,
# so the replay pass below may not request it again; it is kept all the same.
kept <- character()
for (i in seq_along(calls)) {
  trim <- !grepl("#\\s*keep\\s*$", calls[[i]])
  requested <- character()
  out <- httr2::with_mocked_responses(recorder, tryCatch(
    suppressMessages(suppressWarnings(eval(parse(text = calls[[i]])))),
    error = function(e) e
  ))
  ok[[i]] <- !inherits(out, "error") && !is.null(out) &&
    ((is.data.frame(out) && nrow(out) > 0) || (!is.data.frame(out) && length(out) > 0))
  if (ok[[i]]) kept <- union(kept, requested)
  message(sprintf("[%d/%d] %s %s", i, length(calls), if (ok[[i]]) "ok  " else "FAIL", calls[[i]]))
}

# Replay every successful call against the final fixtures -- a "# keep" refetch may
# have replaced a trimmed response an earlier call was recorded on -- and keep only
# the calls that still return data, and only the fixtures those calls read.
used <- kept
# The replay is offline: the international runtime's per-host spacing has nothing to protect.
utils::assignInNamespace(".intl_sleep", function(seconds) invisible(), "hoopR")
for (i in which(ok)) {
  seen <- character()
  out <- httr2::with_mocked_responses(function(req) {
    seen <<- union(seen, req$url)
    if (is.null(index[[req$url]])) return(httr2::response(status_code = 404L, url = req$url))
    saved_response(req$url)
  }, tryCatch(suppressMessages(suppressWarnings(eval(parse(text = calls[[i]])))),
              error = function(e) e))
  still <- !inherits(out, "error") && !is.null(out) &&
    ((is.data.frame(out) && nrow(out) > 0) || (!is.data.frame(out) && length(out) > 0))
  if (still) {
    used <- union(used, seen)
  } else {
    ok[[i]] <- FALSE
    message("dropped on replay (fixtures changed under it): ", calls[[i]])
  }
}
used <- intersect(used, names(index))  # a blocked or failed request was never saved
drop <- setdiff(names(index), used)
unlink(file.path(fix_dir, vapply(index[drop], `[[`, "", "file")))
index <- lapply(index[used], function(x) x[c("file", "status", "type", "trimmed")])

writeLines(calls[ok], calls_txt)
jsonlite::write_json(index[order(names(index))], file.path(fix_dir, "index.json"),
                     auto_unbox = TRUE, pretty = TRUE)
message(sum(ok), " of ", length(calls), " calls recorded; ", length(index), " responses kept")
