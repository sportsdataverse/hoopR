test_that("S3 XML 403 is no-data, Akamai HTML 403 is a fetch error", {
  xml <- paste(readLines(file.path(fx, "l2m_json_0022500002_no_report_s3_403.xml"), warn = FALSE), collapse = "\n")
  html <- paste(readLines(file.path(fx, "akamai_403_blocked_ua.html"), warn = FALSE), collapse = "\n")
  expect_identical(.classify_official_403(xml), "no_data")
  expect_identical(.classify_official_403(html), "fetch_error")
})

test_that("L2M parser matches sdv-py golden output (calls)", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  got <- .parse_nba_l2m(x)$calls
  gold <- .read_gold("l2m_0042500405_calls.csv")

  .expect_matches_gold(got, gold)
  expect_identical(got$decision, gold$decision)
  expect_type(got$period, "integer")
  expect_type(got$pos_id, "integer")
  expect_type(got$pos_team_id, "integer")
  expect_type(got$seconds_remaining, "double")
  expect_identical(got$game_id[1], "0042500405")
})

test_that("L2M parser matches sdv-py golden output (game, stats)", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  out <- .parse_nba_l2m(x)
  gold_game <- .read_gold("l2m_0042500405_game.csv")
  gold_stats <- .read_gold("l2m_0042500405_stats.csv")

  .expect_matches_gold(out$game, gold_game)
  expect_s3_class(out$game$game_date, "Date")
  expect_type(out$game$home_team_id, "integer")

  .expect_matches_gold(out$stats, gold_stats)
  expect_type(out$stats$home, "integer")
})

test_that("decision normalization: NCC/NCI/star/blank/Undetectable", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$CallRatingName[1:5] <- c("NCC", "NCI", "Undetectable", "", "CC*")
  got <- .parse_nba_l2m(x)$calls$decision[1:5]
  expect_identical(got, c("CNC", "INC", NA_character_, NA_character_, "CC"))
})

test_that("names are kept verbatim (no ASCII folding)", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$DP[1] <- "Nikola Jokić"
  expect_identical(.parse_nba_l2m(x)$calls$disadvantaged[1], "Nikola Jokić")
})

test_that("game_id is a 10-char zero-padded string from an int game id", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$game$GameId <- 42500405
  got <- .parse_nba_l2m(x)$calls$game_id[1]
  expect_identical(got, "0042500405")
  expect_equal(nchar(got), 10)
})

test_that("referee assignments parser matches sdv-py golden output (nba)", {
  x <- jsonlite::fromJSON(file.path(fx, "referee_assignments_2026-06-13.json"), simplifyVector = FALSE)
  out <- .parse_nba_referee_assignments(x, "nba")
  gold_off <- .read_gold("referee_assignments_2026-06-13_nba_officials.csv")
  gold_replay <- .read_gold("referee_assignments_2026-06-13_nba_replay_center.csv")

  .expect_matches_gold(out$officials, gold_off)
  .expect_matches_gold(out$replay_center, gold_replay)
  expect_type(out$officials$official_id, "integer")
  expect_type(out$officials$home_team_id, "integer")
  expect_type(out$officials$crew_position, "integer")
  expect_type(out$officials$season, "integer")

  chief <- out$officials[out$officials$crew_position == 1, ]
  expect_equal(chief$official_id, 1162L)
  expect_identical(chief$official_name, "Scott Foster")
  expect_identical(chief$jersey_num, "48")
})

test_that("referee assignments parser matches sdv-py golden output (wnba)", {
  x <- jsonlite::fromJSON(file.path(fx, "referee_assignments_2026-06-13.json"), simplifyVector = FALSE)
  out <- .parse_nba_referee_assignments(x, "wnba")
  gold_off <- .read_gold("referee_assignments_2026-06-13_wnba_officials.csv")
  gold_replay <- .read_gold("referee_assignments_2026-06-13_wnba_replay_center.csv")

  .expect_matches_gold(out$officials, gold_off)
  .expect_matches_gold(out$replay_center, gold_replay)
  expect_equal(nrow(out$officials), 12)
  # WNBA is a single-year season: the feed's season code (e.g. "22026") maps
  # to the SAME end year, unlike NBA/G-League's START+1.
  expect_true(all(out$officials$season == 2026L))
  expect_true(all(out$officials$league == "wnba"))
})

test_that("referee assignments: unknown league keeps schema, empty rows", {
  x <- jsonlite::fromJSON(file.path(fx, "referee_assignments_2026-06-13.json"), simplifyVector = FALSE)
  x[["gl"]] <- list(Table = list(rows = list()), Table1 = list(rows = list()))
  out <- .parse_nba_referee_assignments(x, "gl")
  expect_equal(nrow(out$officials), 0)
  expect_true("official_id" %in% names(out$officials))
  expect_type(out$officials$official_id, "integer")
})

test_that("referee assignments: bad league errors", {
  expect_error(.parse_nba_referee_assignments(list(), "mlb"), regexp = "nba.*gl.*wnba|league")
  expect_error(nba_referee_assignments("2026-06-13", league = "mlb"), regexp = "nba.*gl.*wnba|league")
})

test_that("L2M games listing matches sdv-py golden output (415 rows)", {
  html <- paste(readLines(file.path(fx, "l2m_listing_2025-26.html"), warn = FALSE), collapse = "\n")
  got <- .parse_nba_l2m_games(html, 2026)
  gold <- .read_gold("l2m_listing_2025-26_games.csv")

  expect_equal(nrow(got), 415)
  expect_equal(length(unique(got$game_id)), 415)
  .expect_matches_gold(got, gold)
  expect_identical(got$game_id[1], "0042500405")
  expect_identical(got$season_type[1], "playoffs")
  expect_identical(got$label[1], "Knicks 94, Spurs 90")
  expect_type(got$season, "integer")
})

# ---------------------------------------------------------------------------
# T1/P2: extractors must yield NA on a non-match, never a dropped element
# (row-misaligning) or the unchanged input.
# ---------------------------------------------------------------------------

test_that("period: missing/'OT' PeriodName parses to NA without shifting rows", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  n <- nrow(x$l2m)
  x$l2m$PeriodName[1] <- NA
  got_na <- .parse_nba_l2m(x)$calls
  expect_equal(nrow(got_na), n)
  expect_identical(got_na$period[1], NA_integer_)

  x2 <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x2$l2m$PeriodName[1] <- "OT"
  got_ot <- .parse_nba_l2m(x2)$calls
  expect_equal(nrow(got_ot), n)
  expect_identical(got_ot$period[1], NA_integer_)
})

test_that("call_type without a colon yields NA call and NA type", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$CallType[1] <- "Instant Replay"
  got <- .parse_nba_l2m(x)$calls
  expect_identical(got$call[1], NA_character_)
  expect_identical(got$type[1], NA_character_)
  expect_identical(got$call_type[1], "Instant Replay")
})

test_that("clock '45.3' (no minutes) parses to NA seconds_remaining", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$PCTime[1] <- "45.3"
  got <- .parse_nba_l2m(x)$calls
  expect_identical(got$seconds_remaining[1], NA_real_)
})

# ---------------------------------------------------------------------------
# T2/P3: Unicode-whitespace handling via stringr, matching Python str.strip()
# ---------------------------------------------------------------------------

test_that("decision 'CC'+NBSP normalizes to 'CC'", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$CallRatingName[1] <- "CC\u00a0"
  expect_identical(.parse_nba_l2m(x)$calls$decision[1], "CC")
})

test_that("call_type 'Foul:'+NBSP+'Personal' splits to call FOUL / type PERSONAL", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$l2m$CallType[1] <- "Foul:\u00a0Personal"
  got <- .parse_nba_l2m(x)$calls
  expect_identical(got$call[1], "FOUL")
  expect_identical(got$type[1], "PERSONAL")
})

test_that("listing labels: interior NBSP kept, edge whitespace incl. thin space stripped", {
  h <- paste0(
    '<a href="L2MReport.html?gameId=0042500405">Knicks 94,\u00a0Spurs 90</a>',
    '<a href="L2MReport.html?gameId=0042500406">\u2009Spurs 90, Knicks 94\u2009</a>'
  )
  got <- .parse_nba_l2m_games(h, 2026)
  expect_identical(got$label[1], "Knicks 94,\u00a0Spurs 90")
  expect_identical(got$label[2], "Spurs 90, Knicks 94")
})

test_that("listing labels: a '>' inside a label is kept whole (N5)", {
  h <- '<a href="L2MReport.html?gameId=0042500405">Knicks 94 > Spurs 90</a>'
  expect_identical(.parse_nba_l2m_games(h, 2026)$label, "Knicks 94 > Spurs 90")
})

# ---------------------------------------------------------------------------
# P6: `[[ ]]` (not `$`) on every field read off parsed JSON -- a `$` partial
# match on a missing field must never fall through to a differently-named
# sibling field.
# ---------------------------------------------------------------------------

test_that("missing Home_team gives NA, not Home_team_abbr's value", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$game$Home_team <- NULL
  got <- .parse_nba_l2m(x)$game
  expect_identical(got$home_team_name, NA_character_)
  expect_identical(got$home_team_abbr, "SAS")
})

test_that("missing GameDate gives NA date, not GameDateOut's value", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$game$GameDate <- NULL
  got <- .parse_nba_l2m(x)$game
  expect_identical(got$game_date, as.Date(NA))
})

test_that("a field missing from every row becomes an NA column, not a tibble size error (P-a)", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  n <- nrow(x$l2m)
  # Every field in turn, as an older report might omit any one of them.
  for (f in names(x$l2m)) {
    y <- x
    y$l2m[[f]] <- NULL
    expect_equal(nrow(.parse_nba_l2m(y)$calls), n, info = f)
  }
  for (f in names(x$stats)) {
    y <- x
    y$stats[[f]] <- NULL
    expect_equal(nrow(.parse_nba_l2m(y)$stats), nrow(x$stats), info = f)
  }

  x$l2m$Difficulty <- NULL
  x$l2m$posID <- NULL
  x$l2m$CP <- NULL
  x$l2m$CallRatingName <- NULL
  x$stats$stats_name <- NULL
  out <- .parse_nba_l2m(x)
  expect_identical(out$calls$difficulty, rep(NA_character_, n))
  expect_identical(out$calls$pos_id, rep(NA_integer_, n))
  expect_identical(out$calls$committing, rep(NA_character_, n))
  expect_identical(out$calls$decision, rep(NA_character_, n))
  expect_identical(out$stats$stat_name, rep(NA_character_, nrow(x$stats)))
})

# ---------------------------------------------------------------------------
# T3: typed prototypes shared by the empty and non-empty paths.
# ---------------------------------------------------------------------------

test_that("typed empty frames: calls/game/stats share a schema with the non-empty path", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  nonempty <- .parse_nba_l2m(x)
  empty <- .parse_nba_l2m(list(game = list(), l2m = list(), stats = list()))

  for (tbl in c("calls", "game", "stats")) {
    expect_identical(names(nonempty[[tbl]]), names(empty[[tbl]]), info = tbl)
    expect_identical(vapply(nonempty[[tbl]], class, ""), vapply(empty[[tbl]], class, ""), info = tbl)
  }
  combined <- dplyr::bind_rows(empty$calls, nonempty$calls)
  expect_equal(nrow(combined), nrow(nonempty$calls))
})

test_that("typed empty frames: listing shares a schema across an off-day and a real page", {
  html <- paste(readLines(file.path(fx, "l2m_listing_2025-26.html"), warn = FALSE), collapse = "\n")
  nonempty <- .parse_nba_l2m_games(html, 2026)
  empty <- .parse_nba_l2m_games("<html><body>Last Two Minute reports</body></html>", 2026)

  expect_identical(names(nonempty), names(empty))
  expect_identical(vapply(nonempty, class, ""), vapply(empty, class, ""))
  combined <- dplyr::bind_rows(empty, nonempty)
  expect_equal(nrow(combined), nrow(nonempty))
})

test_that("typed empty frames: officials/replay_center share a schema across leagues", {
  x <- jsonlite::fromJSON(file.path(fx, "referee_assignments_2026-06-13.json"), simplifyVector = FALSE)
  nonempty <- .parse_nba_referee_assignments(x, "nba")
  x[["gl"]] <- list(Table = list(rows = list()), Table1 = list(rows = list()))
  empty <- .parse_nba_referee_assignments(x, "gl")

  for (tbl in c("officials", "replay_center")) {
    expect_identical(names(nonempty[[tbl]]), names(empty[[tbl]]), info = tbl)
    expect_identical(vapply(nonempty[[tbl]], class, ""), vapply(empty[[tbl]], class, ""), info = tbl)
  }
  combined <- dplyr::bind_rows(empty$officials, nonempty$officials)
  expect_equal(nrow(combined), nrow(nonempty$officials))
})

# ---------------------------------------------------------------------------
# P7/P8: input validation
# ---------------------------------------------------------------------------

test_that(".gid10 zero-pads all-digit ids, keeps others verbatim, never overflows", {
  expect_identical(.gid10("42500405"), "0042500405")
  expect_identical(.gid10(42500405), "0042500405")
  expect_identical(.gid10("abc"), "abc")
  expect_identical(.gid10(NULL), NA_character_)
  expect_identical(.gid10(NA), NA_character_)
  # 3e9 > .Machine$integer.max: must stay a pure string op, never overflow.
  expect_identical(.gid10(3e9), "3000000000")
  # A fractional id is kept verbatim, never rounded into another game's id.
  expect_identical(.gid10(42500405.5), "42500405.5")
})

test_that("nba_l2m_games(season): accepts numeric-like string or number, rejects a non-4-digit season", {
  html <- paste(readLines(file.path(fx, "l2m_listing_2025-26.html"), warn = FALSE), collapse = "\n")
  local_mocked_bindings(
    req_perform = function(req, ...) httr2::response(status_code = 200L, body = charToRaw(html)),
    .package = "httr2"
  )
  expect_equal(nrow(nba_l2m_games(2026)), 415)
  expect_equal(nrow(nba_l2m_games("2026")), 415)
  expect_error(nba_l2m_games(26), regexp = "4-digit")
  expect_error(nba_l2m_games("abc"), regexp = "4-digit")
  expect_error(nba_l2m_games(20266), regexp = "4-digit")
})

test_that("nba_referee_assignments(date): Date/POSIXct formatted directly (no as.Date tz shift), bad string errors", {
  captured <- NULL
  # The shape of a real day without games: every league block is present,
  # with zero-row tables.
  empty_day <- '{"nba":{"Table":{"rows":[]},"Table1":{"rows":[]}},"gl":{"Table":{"rows":[]},"Table1":{"rows":[]}},"wnba":{"Table":{"rows":[]},"Table1":{"rows":[]}}}'
  local_mocked_bindings(
    .official_nba_get = function(url, params = list(), proxy = NULL) {
      captured <<- params$date
      empty_day
    }
  )
  nba_referee_assignments(as.Date("2026-06-13"))
  expect_identical(captured, "2026-06-13")

  # 22:30 in New York is already 2026-06-14 in UTC: format() keeps the
  # caller's calendar day, as.Date() would move it forward one.
  nba_referee_assignments(as.POSIXct("2026-06-13 22:30:00", tz = "America/New_York"))
  expect_identical(captured, "2026-06-13")

  expect_error(nba_referee_assignments("06/13/2026"), regexp = "YYYY-MM-DD")
  expect_error(nba_referee_assignments(date = "2026-6-13"), regexp = "YYYY-MM-DD")

  # Shape-valid but impossible dates are rejected before any request.
  captured <- NULL
  expect_error(nba_referee_assignments("2026-02-31"), regexp = "valid 'YYYY-MM-DD'")
  expect_null(captured)
})

test_that("nba_referee_assignments(): a missing league block is a fetch error, an empty one is an empty day", {
  payload <- NULL
  local_mocked_bindings(
    .official_nba_get = function(url, params = list(), proxy = NULL) payload
  )
  # The feed always carries all three league blocks; one without its block
  # is an error envelope or a changed schema, not a day without games.
  payload <- '{"nba":{"Table":{"rows":[]},"Table1":{"rows":[]}}}'
  expect_error(nba_referee_assignments("2026-06-13", league = "wnba"), class = "hoopR_fetch_error")
  payload <- '{"wnba":{"Table":{"rows":[]}}}'
  expect_error(nba_referee_assignments("2026-06-13", league = "wnba"), class = "hoopR_fetch_error")

  payload <- '{"wnba":{"Table":{"rows":[]},"Table1":{"rows":[]}}}'
  out <- nba_referee_assignments("2026-06-13", league = "wnba")
  expect_equal(nrow(out$officials), 0)
  expect_equal(nrow(out$replay_center), 0)
})

# ---------------------------------------------------------------------------
# P1: HTTP error classification through .official_nba_get(), mocked at the
# httr2::req_perform() boundary (the request is now built inline rather than
# via the shared .retry_request()).
# ---------------------------------------------------------------------------

.mock_resp <- function(status, body, content_type = "application/json") {
  function(req, ...) {
    httr2::response(status_code = status, headers = list(`Content-Type` = content_type), body = charToRaw(body))
  }
}

test_that("S3 XML 403 -> hoopR_no_data, Akamai HTML 403 -> hoopR_fetch_error, 404 -> hoopR_no_data", {
  local_mocked_bindings(
    req_perform = .mock_resp(403L, '<?xml version="1.0"?><Error><Code>AccessDenied</Code></Error>', "application/xml"),
    .package = "httr2"
  )
  expect_error(.official_nba_get("https://official.nba.com/l2m/json/0022500002.json"), class = "hoopR_no_data")

  local_mocked_bindings(
    req_perform = .mock_resp(403L, "<html><body>Access Denied</body></html>", "text/html"),
    .package = "httr2"
  )
  expect_error(.official_nba_get("https://official.nba.com/l2m/json/0022500002.json"), class = "hoopR_fetch_error")

  local_mocked_bindings(
    req_perform = .mock_resp(404L, "<html>Page not found</html>", "text/html"),
    .package = "httr2"
  )
  expect_error(.official_nba_get("https://official.nba.com/nope"), class = "hoopR_no_data")

  # A non-403 status carrying an AccessDenied body is still a fetch error --
  # only a literal 403 gets the body-based reclassification to no_data.
  local_mocked_bindings(
    req_perform = .mock_resp(500L, "<Error><Code>AccessDenied</Code></Error>", "application/xml"),
    .package = "httr2"
  )
  expect_error(.official_nba_get("https://official.nba.com/l2m/json/0022500002.json"), class = "hoopR_fetch_error")
})

test_that("a 200 response with a non-JSON body is a hoopR_fetch_error (all three functions)", {
  local_mocked_bindings(
    req_perform = .mock_resp(200L, "<html><body>Access Denied</body></html>", "text/html"),
    .package = "httr2"
  )
  expect_error(nba_l2m("0042500405"), class = "hoopR_fetch_error")
  expect_error(nba_referee_assignments("2026-06-13"), class = "hoopR_fetch_error")
})

test_that("nba_l2m_games: a 200 page missing the 'Last Two Minute' marker is a hoopR_fetch_error", {
  local_mocked_bindings(
    req_perform = .mock_resp(200L, "<html><body>Akamai interstitial</body></html>", "text/html"),
    .package = "httr2"
  )
  expect_error(nba_l2m_games(2030), class = "hoopR_fetch_error")
})

test_that("a transport-level failure surfaces as a hoopR_fetch_error, not a raw httr2 condition", {
  local_mocked_bindings(
    req_perform = function(req, ...) stop("simulated connection reset"),
    .package = "httr2"
  )
  expect_error(.official_nba_get("https://official.nba.com/l2m/json/0042500405.json"), class = "hoopR_fetch_error")
})

test_that("a response without a body is still classified by its status (finding 8)", {
  bodiless <- function(status) function(req, ...) httr2::response(status_code = status)
  u <- "https://official.nba.com/l2m/json/0042500405.json"

  local_mocked_bindings(req_perform = bodiless(503L), .package = "httr2")
  expect_error(.official_nba_get(u), class = "hoopR_fetch_error")
  local_mocked_bindings(req_perform = bodiless(403L), .package = "httr2")
  expect_error(.official_nba_get(u), class = "hoopR_fetch_error")
  local_mocked_bindings(req_perform = bodiless(404L), .package = "httr2")
  expect_error(.official_nba_get(u), class = "hoopR_no_data")

  # An empty 200 is a fetch error from every public function, as in sdv-py.
  local_mocked_bindings(req_perform = bodiless(200L), .package = "httr2")
  expect_error(nba_l2m("0042500405"), class = "hoopR_fetch_error")
  expect_error(nba_l2m_games(2026), class = "hoopR_fetch_error")
  expect_error(nba_referee_assignments("2026-06-13"), class = "hoopR_fetch_error")
})

test_that("nba_l2m(game_id): anything but one all-digit id errors before any request (N1)", {
  requested <- character()
  l2m_json <- readBin(file.path(fx, "l2m_json_0042500405.json"), "raw", file.size(file.path(fx, "l2m_json_0042500405.json")))
  local_mocked_bindings(
    req_perform = function(req, ...) {
      requested <<- c(requested, req$url)
      httr2::response(status_code = 200L, body = l2m_json)
    },
    .package = "httr2"
  )
  bad_ids <- list("abc", NA, NULL, "{1+1}", "0042500405.json", -5, 42500405.5, c("0042500405", "0042500406"))
  for (bad in bad_ids) {
    err <- expect_error(nba_l2m(bad), regexp = "game_id")
    expect_false(inherits(err, "hoopR_error"))
  }
  expect_identical(requested, character())

  # A good numeric id is zero-padded into the URL and parses end to end.
  out <- nba_l2m(42500405)
  expect_identical(requested, "https://official.nba.com/l2m/json/0042500405.json")
  expect_equal(nrow(out$calls), 21)
})

test_that("error messages interpolate the URL as a value, never as a glue template (N1)", {
  local_mocked_bindings(
    req_perform = .mock_resp(403L, "<html><body>Access Denied</body></html>", "text/html"),
    .package = "httr2"
  )
  err <- expect_error(.official_nba_get("https://official.nba.com/l2m/json/{1+1}.json"), class = "hoopR_fetch_error")
  expect_match(conditionMessage(err), "{1+1}", fixed = TRUE)
})

test_that("caller mistakes are ordinary errors raised before any request, not hoopR_fetch_error (N2)", {
  requested <- FALSE
  local_mocked_bindings(
    req_perform = function(req, ...) {
      requested <<- TRUE
      httr2::response(status_code = 200L, body = charToRaw('{"nba":{},"gl":{},"wnba":{}}'))
    },
    .package = "httr2"
  )
  err <- expect_error(.official_nba_get("https://official.nba.com/l2m/json/0042500405.json", proxy = list(bogus = 1)))
  expect_false(inherits(err, "hoopR_error"))
  for (bad in list(as.Date(c("2026-06-13", "2026-06-14")), as.Date(NA), NULL, c("2026-06-13", "2026-06-14"))) {
    err <- expect_error(nba_referee_assignments(bad), regexp = "date")
    expect_false(inherits(err, "hoopR_error"))
  }
  expect_false(requested)
})

test_that("transport failures get the retry budget: retry_on_failure is set (N3)", {
  captured <- NULL
  local_mocked_bindings(
    req_perform = function(req, ...) {
      captured <<- req
      httr2::response(status_code = 200L, body = charToRaw("ok"))
    },
    .package = "httr2"
  )
  .official_nba_get("https://official.nba.com/l2m/json/0042500405.json")
  expect_true(isTRUE(captured$policies$retry_on_failure))
  expect_equal(captured$policies$retry_max_tries, 3)
})

# ---------------------------------------------------------------------------
# Gated live test: real official.nba.com fetches.
# ---------------------------------------------------------------------------

test_that("live: nba_l2m / nba_l2m_games / nba_referee_assignments real schemas", {
  skip_on_cran()
  skip_on_ci()
  skip_if_offline("official.nba.com")
  skip_official_nba_test()

  l2m <- nba_l2m("0042500405")
  expect_equal(nrow(l2m$calls), 21)

  games <- nba_l2m_games(2026)
  expect_gte(nrow(games), 415)

  refs <- nba_referee_assignments("2026-06-13")
  expect_gte(nrow(refs$officials), 4)
})

test_that("a malformed GameDate gives NA, not an error", {
  x <- jsonlite::fromJSON(file.path(fx, "l2m_json_0042500405.json"))
  x$game$GameDate <- "not-a-date"
  got <- .parse_nba_l2m(x)$game
  expect_equal(nrow(got), 1L)
  expect_true(is.na(got$game_date))
})

test_that("a 200 whose JSON is not an object is a hoopR_fetch_error", {
  body <- NULL
  local_mocked_bindings(
    .official_nba_get = function(url, params = list(), proxy = NULL) body
  )
  for (b in c("null", "[]", '"error"', "42")) {
    body <- b
    expect_error(nba_l2m("0042500405"), class = "hoopR_fetch_error", info = b)
    expect_error(nba_referee_assignments("2026-06-13"), class = "hoopR_fetch_error", info = b)
  }
})
