# B.LEAGUE (`bleague_*()`): offline tests against the sdv-py fixtures (tests/testthat/fixtures/bleague/,
# provenance in its README). The transport is mocked at `.intl_response()`, so every wrapper runs end to
# end: feed fallback, scope refusals, HTML walk, casts. parity/<set>/<route>.csv is sdv-py's frame on the
# same fixture; parity/manifest.json holds sdv-py's column types.

bleague_fx <- function(...) testthat::test_path("fixtures", "bleague", ...)

bleague_read <- function(rel) {
  path <- bleague_fx(rel)
  con <- if (grepl("\\.gz$", path)) gzfile(path, encoding = "UTF-8") else file(path, encoding = "UTF-8")
  on.exit(close(con))
  paste(readLines(con, warn = FALSE), collapse = "\n")
}

bleague_json <- function(rel) jsonlite::parse_json(bleague_read(rel), simplifyVector = FALSE)
bleague_to_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

BLEAGUE_MANIFEST <- jsonlite::read_json(testthat::test_path("fixtures", "bleague", "parity", "manifest.json"))
BLEAGUE_GAME <- c("game_info", "period_scores", "player_box", "team_box", "team_summary", "pbp", "shots",
                  "leaders", "score_track")
BLEAGUE_SCHED <- c("schedule", "schedule_clubs", "schedule_events", "schedule_days")
BLEAGUE_HTML <- list("content-type" = "text/html; charset=utf-8")
BLEAGUE_DENIED <- list(status = 403L, headers = list("content-type" = "application/xml"),
                       body = "<Error><Code>AccessDenied</Code></Error>")

#' `expect_error()` on the class, then the pattern on the message with cli's line wrapping undone.
bleague_expect_error <- function(expr, pattern, class) {
  e <- expect_error(expr, class = class)
  expect_match(gsub("\\s+", " ", conditionMessage(e)), pattern, fixed = TRUE)
  invisible(e)
}

#' Mock the transport: `handler(url, query)` returns `list(status, headers, body)`.
#' Returns an environment whose `log` lists every request.
local_bleague_site <- function(handler, env = parent.frame()) {
  seen <- new.env()
  seen$log <- list()
  local_mocked_bindings(
    .intl_response = function(url, query = list(), body = NULL, body_type = "none", headers = NULL,
                              proxy_env = NULL, retry_500 = FALSE, ...) {
      seen$log[[length(seen$log) + 1L]] <- list(url = url, query = query, retry_500 = retry_500)
      r <- handler(url, query)
      httr2::response(status_code = r$status %||% 200L, url = url,
                      headers = r$headers %||% list("content-type" = "application/json"),
                      body = charToRaw(enc2utf8(r$body %||% "")))
    },
    .package = "hoopR", .env = env
  )
  seen
}

#' S3 + site: `bodies` maps "v2_genius_contexts/504734" -> body text (snapshot 110); every other
#' S3 key is AccessDenied; game_detail serves `embed`; `pages` maps "schedule" / "standings" -> HTML.
bleague_handler <- function(bodies = list(), embed = "<html></html>", pages = list()) {
  s3 <- paste0(.bleague_s3, "/")
  function(url, query) {
    if (startsWith(url, s3)) {
      rest <- substring(url, nchar(s3) + 1L)
      for (k in names(bodies)) {
        if (rest == paste0(k, "/latestid")) return(list(headers = list("content-type" = "application/octet-stream"), body = "110"))
        if (rest == paste0(k, "/110.json")) return(list(body = bodies[[k]]))
      }
      return(BLEAGUE_DENIED)
    }
    if (url == paste0(.bleague_site, "/game_detail/")) return(list(headers = BLEAGUE_HTML, body = embed))
    for (p in names(pages)) if (url == paste0(.bleague_site, "/", p, "/")) return(list(headers = BLEAGUE_HTML, body = pages[[p]]))
    list(status = 404L, body = "")
  }
}

V2_TEXT <- bleague_read("full/v2_504734.json.gz")
V1_TEXT <- bleague_read("full/v1_10693.json.gz")
SCHEDULE_HTML <- bleague_read("html/schedule_2025_1004.html.gz")
STANDINGS_HTML <- bleague_read("html/standings_2025_b1.html.gz")
EMBED_HTML <- bleague_read("html/game_detail_1.html")
v2_site <- function(text = V2_TEXT) bleague_handler(list(`v2_genius_contexts/504734` = text))

#' Mismatching cells between an R frame and sdv-py's frame (CSV) on the same fixture;
#' NA-vs-value counts as a mismatch.
bleague_mismatches <- function(df, set, short) {
  path <- bleague_fx("parity", set, paste0(short, ".csv"))
  if (!file.exists(path)) path <- paste0(path, ".gz") # read.csv reads gzip transparently
  csv <- utils::read.csv(path, colClasses = "character", na.strings = "", encoding = "UTF-8", check.names = FALSE)
  expect_identical(names(df), names(csv))
  expect_identical(nrow(df), nrow(csv))
  sum(vapply(names(csv), function(col) {
    r <- df[[col]]
    p <- csv[[col]]
    if (is.double(r) && !inherits(r, c("POSIXct", "Date"))) {
      pv <- as.numeric(p)
      return(sum(xor(is.na(r), is.na(pv)) | (!is.na(r) & !is.na(pv) & abs(r - pv) > 1e-9)))
    }
    rs <- if (inherits(r, "POSIXct")) format(r, "%Y-%m-%d %H:%M:%S") else as.character(r)
    sum(xor(is.na(rs), is.na(p)) | (!is.na(rs) & !is.na(p) & rs != p))
  }, integer(1)))
}

#' Column names and classes equal sdv-py's spec; ids are text, schedule_key an integer.
bleague_expect_types <- function(df, short) {
  spec <- unlist(BLEAGUE_MANIFEST$specs[[short]])
  expect_identical(names(df), names(spec))
  want <- c(integer = "integer", double = "numeric", character = "character", logical = "logical",
            Date = "Date", POSIXct = "POSIXct")[spec]
  expect_identical(unname(vapply(df, function(x) class(x)[[1]], character(1))), unname(want))
  ids <- names(df)[(endsWith(names(df), "_id") & names(df) != "event_id") | names(df) == "convention_key"]
  for (c in ids) {
    expect_type(df[[c]], "character")
    expect_false(any(grepl(".", df[[c]], fixed = TRUE)), label = c)
  }
  if ("schedule_key" %in% names(df)) expect_type(df$schedule_key, "integer")
  if ("recorded_at" %in% names(df)) expect_identical(attr(df$recorded_at, "tzone"), "UTC")
}

bleague_game_frames <- function(key) {
  sapply(BLEAGUE_GAME, function(s) get(paste0("bleague_", s))(schedule_key = key), simplify = FALSE)
}

# --- parity: every route, end to end, against sdv-py's frame on the same fixture ----------

test_that("B.LEAGUE game wrappers match sdv-py on the full v2 and v1 contexts", {
  site <- local_bleague_site(bleague_handler(list(`v2_genius_contexts/504734` = V2_TEXT,
                                                  `v1_contexts/10693` = V1_TEXT)))
  for (set in c("v2_504734", "v1_10693")) {
    frames <- bleague_game_frames(BLEAGUE_MANIFEST$sets[[set]]$schedule_key)
    for (short in BLEAGUE_GAME) {
      expect_s3_class(frames[[short]], "hoopR_data")
      bleague_expect_types(frames[[short]], short)
      expect_identical(bleague_mismatches(frames[[short]], set, short), 0L, label = paste(set, short))
    }
  }
  urls <- vapply(site$log, `[[`, character(1), "url")
  expect_identical(urls[1:2], c("https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/504734/latestid",
                                "https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/504734/110.json"))
  # 10693: v2 misses (AccessDenied), then v1
  expect_true("https://b-league.s3.amazonaws.com/web_json/v1_contexts/10693/110.json" %in% urls)
  expect_true(all(vapply(site$log, `[[`, logical(1), "retry_500")))
})

test_that("B.LEAGUE falls back to the game page's embedded context (2016-17)", {
  site <- local_bleague_site(bleague_handler(embed = EMBED_HTML))
  frames <- bleague_game_frames(1)
  for (short in BLEAGUE_GAME) {
    bleague_expect_types(frames[[short]], short)
    expect_identical(bleague_mismatches(frames[[short]], "embed_1", short), 0L, label = short)
  }
  expect_identical(unique(frames$pbp$feed), "v1")
  page <- Filter(function(x) grepl("game_detail", x$url), site$log)[[1]]
  expect_identical(page$query, list(ScheduleKey = 1L, tab = 4L))
  expect_length(site$log, 3L * length(BLEAGUE_GAME)) # v2 miss, v1 miss, page
})

test_that("B.LEAGUE parsers match sdv-py on the refs captures of other seasons and feeds", {
  for (set in c("v2_505508", "v2_500017", "v2_5856", "v1_2988")) {
    raw <- bleague_json(BLEAGUE_MANIFEST$sets[[set]]$fixture)
    for (short in BLEAGUE_GAME) {
      df <- get(paste0(".bleague_parse_", short))(raw)
      bleague_expect_types(df, short)
      expect_identical(bleague_mismatches(df, set, short), 0L, label = paste(set, short))
    }
  }
  for (set in c("schedule_b1_2016_0922", "schedule_b2_2025_1004", "schedule_b3_2025_0419")) {
    rec <- bleague_json(BLEAGUE_MANIFEST$sets[[set]]$fixture)
    for (short in BLEAGUE_SCHED) {
      expect_identical(bleague_mismatches(get(paste0(".bleague_parse_", short))(rec), set, short), 0L,
                       label = paste(set, short))
    }
  }
  for (set in c("standings_b1_2016", "standings_b3_2025")) {
    df <- .bleague_parse_standings(bleague_json(BLEAGUE_MANIFEST$sets[[set]]$fixture))
    expect_identical(bleague_mismatches(df, set, "standings"), 0L, label = set)
  }
})

test_that("B.LEAGUE schedule wrappers walk the real page, map the season and match sdv-py", {
  site <- local_bleague_site(bleague_handler(pages = list(schedule = SCHEDULE_HTML)))
  for (short in BLEAGUE_SCHED) {
    df <- get(paste0("bleague_", short))(season = 2026, tab = 1, month = 10, day = 4)
    expect_s3_class(df, "hoopR_data")
    bleague_expect_types(df, short)
    expect_identical(bleague_mismatches(df, "schedule_page", short), 0L, label = short)
  }
  expect_identical(site$log[[1]]$query, list(tab = 1L, year = 2025L, event = 2L, mon = "10", day = "04"))
  expect_identical(site$log[[1]]$url, "https://www.bleague.jp/schedule/")
  expect_true(site$log[[1]]$retry_500)
  bleague_schedule(season = "2026", tab = 1L, month = 10, day = 4, event = 2)
  expect_identical(site$log[[5]]$query$event, 2L)
})

test_that("B.LEAGUE standings walk the real page, map the season and match sdv-py", {
  site <- local_bleague_site(bleague_handler(pages = list(standings = STANDINGS_HTML)))
  df <- bleague_standings(season = 2026, tab = 1)
  bleague_expect_types(df, "standings")
  expect_identical(bleague_mismatches(df, "standings_page", "standings"), 0L)
  expect_identical(site$log[[1]]$query, list(year = 2025L, tab = 1L))
  expect_true(all(df$season == 2026L))
  expect_true(all(df$win_pct >= 0 & df$win_pct <= 1))
})

# --- empty payloads ---------------------------------------------------------------------

test_that("B.LEAGUE parsers give a typed zero-row tibble for an empty or unrecognised payload", {
  for (short in names(BLEAGUE_MANIFEST$specs)) {
    for (bad in list(list(), NULL, "x", list(Game = 3L), structure(list(), names = character()))) {
      df <- get(paste0(".bleague_parse_", short))(bad)
      expect_identical(nrow(df), 0L)
      bleague_expect_types(df, short)
    }
  }
})

test_that("B.LEAGUE v1-only routes are zero-row on a v2 game, and shots on a v1 game", {
  local_bleague_site(bleague_handler(list(`v2_genius_contexts/504734` = V2_TEXT, `v1_contexts/10693` = V1_TEXT)))
  expect_identical(nrow(bleague_leaders(504734)), 0L)
  expect_identical(nrow(bleague_score_track(504734)), 0L)
  expect_identical(nrow(bleague_shots(10693)), 0L)
  bleague_expect_types(bleague_leaders(504734), "leaders")
})

# --- season mapping ----------------------------------------------------------------------

test_that("B.LEAGUE seasons are END years: the guard compares Year = season - 1", {
  local_bleague_site(v2_site())
  expect_identical(bleague_game_info(504734, season = 2026)$year, 2025L)
  expect_identical(bleague_game_info(504734, season = 2026)$season, 2026L)
  bleague_expect_error(bleague_pbp(504734, season = 2025), "Year 2025, asked for season 2025 (Year 2024)",
                       "hoopR_asset_fetch")
  expect_s3_class(bleague_pbp(504734.0, season = 2026.0), "hoopR_data") # whole doubles are integers
})

# --- refusals ----------------------------------------------------------------------------

mutate_v2 <- function(f) {
  body <- jsonlite::parse_json(V2_TEXT, simplifyVector = FALSE)
  bleague_to_json(f(body))
}

test_that("B.LEAGUE refuses wrong-scope, unfinished and drifted contexts", {
  local_bleague_site(bleague_handler())
  e <- bleague_expect_error(bleague_pbp(999999), "no S3 context and no embedded context", "hoopR_no_data")
  cases <- list(
    list(function(b) { b$Game$ScheduleKey <- 1L; b }, "out of scope: Game.ScheduleKey 1"),
    list(function(b) { b$PlayByPlays[[6]]$ScheduleKey <- 7L; b }, "PlayByPlays row of game 7"),
    list(function(b) { b$HomeBoxscores[[1]]$TeamID <- "1"; b }, "HomeBoxscores row of team '1'"),
    list(function(b) { b$Game$GameEndedFlg <- FALSE; b }, "not final"),
    list(function(b) { b$Leaders <- list(); b }, "not a v2 context"),
    list(function(b) { b$PlayByPlays <- list(); b }, "PlayByPlays empty or not a list"),
    list(function(b) { b$Game$AwayTeamID <- b$Game$HomeTeamID; b }, "without two team ids"),
    list(function(b) { b$Game$ScheduleKey <- "504734"; b }, "Game.ScheduleKey '504734'"),
    list(function(b) list(error = "boom", message = "x"), "not a v2 context")
  )
  for (cs in cases) {
    local_bleague_site(v2_site(mutate_v2(cs[[1]])))
    bleague_expect_error(bleague_pbp(504734), cs[[2]], "hoopR_asset_fetch")
  }
  local_bleague_site(v2_site("not json"))
  bleague_expect_error(bleague_pbp(504734), "a body that is not JSON", "hoopR_asset_fetch")
})

test_that("B.LEAGUE refuses an embed of another game, a bad latestid and a missing embed", {
  local_bleague_site(bleague_handler(embed = EMBED_HTML))
  bleague_expect_error(bleague_pbp(2), "out of scope: embed ScheduleKey '1', asked for '2'", "hoopR_asset_fetch")
  local_bleague_site(function(url, query) list(body = if (endsWith(url, "latestid")) "abc" else ""))
  bleague_expect_error(bleague_pbp(5), "not an integer snapshot id", "hoopR_asset_fetch")
  local_bleague_site(bleague_handler(embed = "<html>_contexts_s3id.data = 42;</html>"))
  bleague_expect_error(bleague_pbp(5), "embed is not an object", "hoopR_asset_fetch")
  local_bleague_site(bleague_handler(embed = "<html>no embed</html>"))
  bleague_expect_error(bleague_pbp(5), "no S3 context and no embedded context", "hoopR_no_data")
})

test_that("B.LEAGUE non-200 answers use the error vocabulary", {
  local_bleague_site(function(url, query) list(status = 404L))
  e <- bleague_expect_error(bleague_pbp(5), "answered HTTP 404", "hoopR_no_data")
  expect_identical(e$status, 404L)
  local_bleague_site(function(url, query) list(status = 400L))
  bleague_expect_error(bleague_pbp(5), "rejected the request: HTTP 400", "hoopR_bad_request")
  local_bleague_site(function(url, query) list(status = 403L, body = "blocked")) # not S3's AccessDenied
  e <- bleague_expect_error(bleague_pbp(5), "answered HTTP 403, not 200", "hoopR_asset_fetch")
  expect_false(e$transient)
  local_bleague_site(function(url, query) list(status = 503L))
  expect_true(expect_error(bleague_pbp(5), class = "hoopR_asset_fetch")$transient)
  local_bleague_site(function(url, query) list(status = 200L, headers = list("content-type" = "application/json"),
                                               body = "{}"))
  bleague_expect_error(bleague_standings(2026, 1), "application/json, not HTML", "hoopR_asset_fetch")
  local_bleague_site(function(url, query) list(status = 200L, headers = BLEAGUE_HTML, body = " "))
  bleague_expect_error(bleague_standings(2026, 1), "HTTP 200 with an empty body", "hoopR_asset_fetch")
})

test_that("B.LEAGUE retries HTTP 500 three times, each attempt throttled", {
  local_mocked_bindings(.intl_sleep = function(seconds) invisible(NULL), .package = "hoopR")
  n <- 0L
  httr2::local_mocked_responses(function(req) {
    n <<- n + 1L
    httr2::response(status_code = 500L, url = req$url)
  })
  e <- expect_error(bleague_pbp(5), class = "hoopR_asset_fetch")
  expect_identical(n, 3L)
  expect_true(e$transient)
})

test_that("B.LEAGUE schedule pages are refused out of scope, paged or empty", {
  local_bleague_site(bleague_handler(pages = list(schedule = SCHEDULE_HTML)))
  bleague_expect_error(bleague_schedule(2026, 1, 10, 5), "out of scope: current day", "hoopR_asset_fetch")
  bleague_expect_error(bleague_schedule(2025, 1, 10, 4), "out of scope: selected year '2025', asked for '2024'",
                       "hoopR_asset_fetch")
  bleague_expect_error(bleague_schedule(2026, 2, 10, 4), "out of scope: active tab", "hoopR_asset_fetch")
  bleague_expect_error(bleague_schedule(2026, 1, 10, 4, event = 3), "out of scope: selected event",
                       "hoopR_asset_fetch")
  paged <- sub("</body>", '<a href="javascript:schedule_b1_more()">more</a></body>', SCHEDULE_HTML, fixed = TRUE)
  local_bleague_site(bleague_handler(pages = list(schedule = paged)))
  bleague_expect_error(bleague_schedule(2026, 1, 10, 4), "list is paged", "hoopR_asset_fetch")
  more <- sub("</body>", "<button>\u3082\u3063\u3068\u898b\u308b</button></body>", SCHEDULE_HTML, fixed = TRUE)
  local_bleague_site(bleague_handler(pages = list(schedule = more)))
  bleague_expect_error(bleague_schedule(2026, 1, 10, 4), "list is paged", "hoopR_asset_fetch")
  emptied <- gsub('(?s)<li[^>]*class="[^"]*list-item[^"]*"[^>]*id="\\d+".*?</li>', "", SCHEDULE_HTML, perl = TRUE)
  local_bleague_site(bleague_handler(pages = list(schedule = emptied)))
  # as in sdv-py, a list without game items is layout drift (the zero-games branch needs items to reach)
  bleague_expect_error(bleague_schedule(2026, 1, 10, 4), "game list ids", "hoopR_asset_fetch")
})

test_that("B.LEAGUE standings are refused for another season, tab or a stub page", {
  local_bleague_site(bleague_handler(pages = list(standings = STANDINGS_HTML)))
  bleague_expect_error(bleague_standings(2025, 1), "out of scope: selected year", "hoopR_asset_fetch")
  bleague_expect_error(bleague_standings(2026, 3), "out of scope: active tab", "hoopR_asset_fetch")
  local_bleague_site(bleague_handler(pages = list(standings = "<html><body>stub</body></html>")))
  bleague_expect_error(bleague_standings(2026, 1), "not the page asked for", "hoopR_asset_fetch")
})

test_that("B.LEAGUE arguments are validated before any request", {
  site <- local_bleague_site(function(url, query) list(status = 500L))
  for (bad in list("x", 1.5, TRUE, NULL, NA, -1, c(1, 2))) {
    expect_error(bleague_pbp(bad), class = "hoopR_bad_request")
  }
  expect_error(bleague_pbp(5, season = "2026-27"), class = "hoopR_bad_request")
  expect_error(bleague_schedule(2026, 9, 10, 4), class = "hoopR_bad_request")
  expect_error(bleague_schedule(2026, 1, 13, 4), class = "hoopR_bad_request")
  expect_error(bleague_schedule(2026, 1, 10, 32), class = "hoopR_bad_request")
  expect_error(bleague_standings(2026, 0), class = "hoopR_bad_request")
  expect_length(site$log, 0L)
})

test_that("B.LEAGUE play-by-play codes follow the feed", {
  expect_identical(.bleague_action_name(18L, "v2"), "team_rebound_def")
  expect_identical(.bleague_action_name(18L, "v1"), "team_rebound_off")
  expect_identical(.bleague_action_name(19L, "v2"), "team_rebound_off")
  expect_identical(.bleague_action_name(19L, NA_character_), NA_character_)
  expect_identical(.bleague_action_name(20L, "v2"), NA_character_)
  local_bleague_site(bleague_handler(list(`v2_genius_contexts/504734` = V2_TEXT, `v1_contexts/10693` = V1_TEXT)))
  v1 <- bleague_pbp(10693)
  expect_gt(sum(v1$action == "substitution", na.rm = TRUE), 0L)
  expect_true(all(c("player_in", "player_out") %in% bleague_pbp(504734)$action))
})

# --- live -------------------------------------------------------------------------------

test_that("B.LEAGUE live: standings and one finished game", {
  skip_intl_live()
  st <- bleague_standings(season = 2026, tab = 1)
  bleague_expect_types(st, "standings")
  expect_gt(nrow(st), 10L)
  info <- bleague_game_info(schedule_key = 504734, season = 2026)
  bleague_expect_types(info, "game_info")
  expect_identical(info$schedule_key, 504734L)
  expect_identical(info$feed, "v2")
})
