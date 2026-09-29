# The NBA CDN wrappers: nba_live_pbp(), nba_live_boxscore(), nba_todays_scoreboard(),
# nba_schedule() (cdn.nba.com) and nbagl_live_pbp(), nbagl_live_boxscore()
# (cdn-gleague.nba.com).
#
# Both hosts sit behind Akamai Bot Manager. Probed from a residential IP on 2026-09-27 UTC
# (Windows R 4.6.1, libcurl 8.14.1 with its Schannel and its OpenSSL 3.5 backend):
# - Without browser headers both hosts answered 403 "Access Denied" (cdn.nba.com over
#   either protocol). That is what the header-less nbagl_live_*() got.
# - The old five-header set got the JSON from cdn.nba.com over HTTP/2 but a 403 over
#   HTTP/1.1. cdn-gleague.nba.com speaks only HTTP/1.1, so the old set got its
#   "Home - NBA G League" HTML page (a 200) instead of the JSON.
# - .nba_cdn_headers() adds Chrome's client hints and fetch metadata. It got the JSON from
#   cdn.nba.com over HTTP/2 and HTTP/1.1, and from cdn-gleague.nba.com. Over HTTP/1.1 the
#   TLS client matters too: Git for Windows' curl 8.19 sent this exact set and was refused
#   (403 on cdn.nba.com, the home page on cdn-gleague.nba.com). Only Windows R and Python
#   requests were verified; Linux and macOS libcurl builds are unverified.

cdn_fixture <- function(file) {
  con <- gzfile(test_path("fixtures", "nba_live", file), "rb")
  on.exit(close(con))
  readBin(con, "raw", n = 1e7)
}

# Serve the captured payload named after the requested URL (see fixtures/nba_live/README.md).
local_cdn_fixtures <- function(env = parent.frame()) {
  local_mocked_bindings(
    .retry_request = function(url, params = list(), headers = NULL, ...) {
      file <- sub(".json", "", basename(url), fixed = TRUE)
      if (grepl("cdn-gleague", url, fixed = TRUE)) file <- paste0(file, "_gleague")
      httr2::response(
        status_code = 200L,
        url = url,
        headers = list(`Content-Type` = "application/json"),
        body = cdn_fixture(paste0(file, ".json.gz"))
      )
    },
    .env = env
  )
}

test_that("every NBA CDN wrapper sends the shared browser header set", {
  seen <- list()
  local_mocked_bindings(
    .retry_request = function(url, params = list(), headers = NULL, ...) {
      seen[[url]] <<- list(headers = headers)
      stop("offline")
    }
  )
  suppressMessages({
    nba_live_pbp(game_id = "0022500001")
    nba_live_boxscore(game_id = "0022500001")
    nba_todays_scoreboard()
    nba_schedule(league_id = "00")
    nbagl_live_pbp(game_id = "2052500034")
    nbagl_live_boxscore(game_id = "2052500034")
  })

  expect_length(seen, 6)
  for (url in names(seen)) {
    expect_identical(seen[[url]]$headers, .nba_cdn_headers(), info = url)
  }
  # The old set had none of the sec-ch-* or Sec-Fetch-* headers, and both hosts
  # refused it over HTTP/1.1.
  expect_in(
    c("sec-ch-ua", "sec-ch-ua-mobile", "sec-ch-ua-platform",
      "Sec-Fetch-Site", "Sec-Fetch-Mode", "Sec-Fetch-Dest",
      "User-Agent", "Origin", "Referer"),
    names(.nba_cdn_headers())
  )
})

test_that("the sec-ch-ua brands carry the User-Agent's Chrome major version", {
  # Chromium also derives the placeholder brand and the brand order from the
  # major version, so a version change means copying the whole sec-ch-ua value
  # from that Chrome (see .nba_cdn_headers()).
  h <- .nba_cdn_headers()
  v <- sub(".*Chrome/(\\d+).*", "\\1", h[["User-Agent"]])
  expect_true(grepl(sprintf('"Chromium";v="%s"', v), h[["sec-ch-ua"]], fixed = TRUE))
  expect_true(grepl(sprintf('"Google Chrome";v="%s"', v), h[["sec-ch-ua"]], fixed = TRUE))
})

test_that("nba_live_pbp() and nba_live_boxscore() parse captured cdn.nba.com payloads", {
  local_cdn_fixtures()

  pbp <- nba_live_pbp(game_id = "0022500001")
  expect_s3_class(pbp, "hoopR_data")
  expect_equal(nrow(pbp), 707)
  expect_in(
    c("event_num", "clock", "period", "action_type", "description", "team_id",
      "player1_id", "player2_id", "player3_id", "home_score", "away_score"),
    colnames(pbp)
  )

  box <- nba_live_boxscore(game_id = "0022500001")
  expect_named(box, c(
    "game_details", "arena", "officials", "home_team_boxscore", "away_team_boxscore",
    "home_team_player_boxscore", "away_team_player_boxscore",
    "home_team_linescores", "away_team_linescores"
  ))
  expect_equal(box$game_details$home_team_tricode, "OKC")
  expect_equal(box$game_details$home_team_score, 125)
  expect_equal(box$game_details$away_team_tricode, "HOU")
  expect_equal(box$game_details$away_team_score, 124)
  expect_equal(nrow(box$home_team_player_boxscore), 18)
  expect_equal(nrow(box$away_team_player_boxscore), 17)
})

test_that("nbagl_live_pbp() and nbagl_live_boxscore() parse captured cdn-gleague.nba.com payloads", {
  local_cdn_fixtures()

  pbp <- nbagl_live_pbp(game_id = "2052500034")
  expect_s3_class(pbp, "hoopR_data")
  expect_equal(nrow(pbp), 595)
  expect_in(c("event_num", "clock", "period", "action_type", "player1_id"), colnames(pbp))

  box <- nbagl_live_boxscore(game_id = "2052500034")
  expect_equal(box$game_details$home_team_tricode, "RAP")
  expect_equal(box$game_details$home_team_score, 111)
  expect_equal(box$game_details$away_team_tricode, "MNE")
  expect_equal(box$game_details$away_team_score, 75)
  expect_equal(nrow(box$home_team_player_boxscore), 14)
  expect_equal(nrow(box$away_team_player_boxscore), 13)
})

test_that("a warning while parsing no longer throws the result away", {
  # The wrappers' tryCatch() used to carry an empty `warning` handler, which
  # abandons the whole parse at the first warning and returns an empty result.
  local_cdn_fixtures()
  resp_text <- .resp_text
  local_mocked_bindings(.resp_text = function(resp) {
    warning("simulated parse warning")
    resp_text(resp)
  })
  expect_warning(pbp <- nba_live_pbp(game_id = "0022500001"), "simulated")
  expect_equal(nrow(pbp), 707)
  expect_warning(box <- nba_live_boxscore(game_id = "0022500001"), "simulated")
  expect_equal(nrow(box$home_team_player_boxscore), 18)
  expect_warning(pbp <- nbagl_live_pbp(game_id = "2052500034"), "simulated")
  expect_equal(nrow(pbp), 595)
  expect_warning(box <- nbagl_live_boxscore(game_id = "2052500034"), "simulated")
  expect_equal(nrow(box$home_team_player_boxscore), 14)
})

test_that("nba_schedule() fetches each league from its own CDN host", {
  seen <- character()
  local_mocked_bindings(
    .retry_request = function(url, params = list(), headers = NULL, ...) {
      seen <<- c(seen, url)
      stop("offline")
    }
  )
  suppressMessages(for (lg in c("00", "10", "20")) nba_schedule(league_id = lg))
  expect_identical(seen, c(
    "https://cdn.nba.com/static/json/staticData/scheduleLeagueV2.json",
    "https://cdn.wnba.com/static/json/staticData/scheduleLeagueV2.json",
    "https://cdn-gleague.nba.com/static/json/staticData/scheduleLeagueV2.json"
  ))
  # An unknown league is an argument error, raised before any request.
  expect_error(nba_schedule(league_id = "15"), "league_id")
  expect_length(seen, 3)
})

test_that("nba_schedule() returns the requested league's schedule, never another's", {
  body <- NULL
  local_mocked_bindings(
    .retry_request = function(url, params = list(), headers = NULL, ...) {
      httr2::response(200L, headers = list(`Content-Type` = "application/json"), body = charToRaw(body))
    }
  )
  # The leagueSchedule shape of the real feed, cut to one game.
  schedule <- function(league_id, game_id) {
    sprintf(paste0(
      '{"leagueSchedule":{"seasonYear":"2026-27","leagueId":"%s","gameDates":[{"gameDate":',
      '"11/06/2026 00:00:00","games":[{"gameId":"%s","homeTeam":{"teamId":1},"awayTeam":{"teamId":2}}]}]}}'
    ), league_id, game_id)
  }
  body <- schedule("20", "2052600001")
  gl <- nba_schedule(league_id = "20", season = "2026-27")
  expect_equal(nrow(gl), 1)
  expect_equal(gl$league_id, "20")
  # "5" is the NBA's Play-In only; a G League "205" game is not one.
  expect_true(is.na(gl$season_type_description))

  body <- schedule("00", "0052600001")
  expect_equal(nba_schedule(league_id = "00", season = "2026-27")$season_type_description, "Play-In Game")

  # The old bug: the NBA schedule served for a G League request.
  body <- schedule("00", "0022600001")
  expect_null(suppressMessages(nba_schedule(league_id = "20", season = "2026-27")))
})

test_that("nba_todays_scoreboard() on a day without games is empty, not an error", {
  local_mocked_bindings(
    .retry_request = function(url, params = list(), headers = NULL, ...) {
      httr2::response(
        200L,
        headers = list(`Content-Type` = "application/json"),
        body = charToRaw('{"scoreboard":{"gameDate":"2026-09-29","leagueId":"00","games":[]}}')
      )
    }
  )
  expect_silent(out <- nba_todays_scoreboard())
  expect_equal(nrow(out), 0)
})

test_that("cdn.nba.com accepts the shared header set over HTTP/1.1 (live)", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  resp <- httr2::request(paste0(nba_live_endpoint("playbyplay"), "/playbyplay_0022500001.json")) |>
    httr2::req_headers(!!!as.list(.nba_cdn_headers())) |>
    httr2::req_options(http_version = 2L) |> # CURL_HTTP_VERSION_1_1
    httr2::req_timeout(20) |>
    httr2::req_error(is_error = function(resp) FALSE) |>
    httr2::req_perform()

  expect_equal(httr2::resp_status(resp), 200L)
  expect_equal(httr2::resp_content_type(resp), "application/json")

  Sys.sleep(3)
})

test_that("NBA G-League live play-by-play and boxscore (live)", {
  skip_on_cran()
  skip_on_ci()
  skip_nbagl_stats_test()

  pbp <- nbagl_live_pbp(game_id = "2052500034")
  expect_gt(nrow(pbp), 0)
  expect_in(c("event_num", "clock", "period", "action_type", "player1_id"), colnames(pbp))

  Sys.sleep(3)

  box <- nbagl_live_boxscore(game_id = "2052500034")
  expect_length(box, 9)
  expect_gt(nrow(box$home_team_player_boxscore), 0)
  expect_gt(nrow(box$away_team_player_boxscore), 0)

  Sys.sleep(3)
})
