# The wrappers below call .retry_request() themselves rather than a shared
# helper. .retry_request() turns off httr2's status errors, so each one checks
# the status with .stop_for_http_status(): an error response has to reach the
# wrapper's error handler as a reported cause (`HTTP 401 Unauthorized from
# <url>`), never be parsed as data. See test-http_status.R for the helpers.

local_routed_responses <- function(route, env = parent.frame()) {
  httr2::local_mocked_responses(function(req) {
    r <- route(req$url)
    httr2::response(
      status_code = r$status %||% 200L, url = req$url,
      # Retry-After: 0 keeps req_retry() from backing off
      headers = list(`Content-Type` = r$type %||% "application/json", `Retry-After` = "0"),
      body = if (is.raw(r$body)) r$body else charToRaw(r$body)
    )
  }, env = env)
}

collect_messages <- function(expr) {
  msgs <- character()
  value <- withCallingHandlers(expr, message = function(m) {
    msgs <<- c(msgs, conditionMessage(m))
    invokeRestart("muffleMessage")
  })
  list(value = value, messages = trimws(msgs))
}

gz_fixture <- function(...) {
  con <- gzfile(test_path("fixtures", ...), "rb")
  on.exit(close(con))
  readBin(con, "raw", n = 1e7)
}

direct_request_wrappers <- list(
  espn_mbb_wp          = function() espn_mbb_wp(game_id = 401479672),
  espn_nba_wp          = function() espn_nba_wp(game_id = 401283399),
  nba_draftboard       = function() nba_draftboard(season = 2025),
  nba_live_pbp         = function() nba_live_pbp(game_id = "0022500001"),
  nba_live_boxscore    = function() nba_live_boxscore(game_id = "0022500001"),
  nba_schedule         = function() nba_schedule(league_id = "00"),
  nba_todays_scoreboard = function() nba_todays_scoreboard(),
  nbagl_live_pbp       = function() nbagl_live_pbp(game_id = "2052500034"),
  nbagl_live_boxscore  = function() nbagl_live_boxscore(game_id = "2052500034"),
  ncaa_mbb_teams       = function() ncaa_mbb_teams(year = 2024, division = 1),
  rotowire_injuries    = function() rotowire_injuries(),
  torvik_ncaa_results  = function() torvik_ncaa_results(min_year = 2010, max_year = 2024, type = "conf")
)

error_cases <- list(
  list(status = 401L, desc = "Unauthorized", type = "application/json",
       body = '{"message":"Missing authentication token"}', detail = ": Missing authentication token$"),
  list(status = 500L, desc = "Internal Server Error", type = "text/html",
       body = "<html><body>Internal Server Error</body></html>", detail = "$")
)

for (fn in names(direct_request_wrappers)) {
  for (case in error_cases) {
    test_that(sprintf("%s() reports an HTTP %d as its cause instead of parsing it", fn, case$status), {
      skip_on_cran()
      local_routed_responses(function(url) case)
      out <- collect_messages(direct_request_wrappers[[fn]]())
      expect_equal(NROW(out$value), 0L)
      expect_false(inherits(out$value, "hoopR_data") && nrow(out$value) > 0)
      pattern <- paste0("HTTP ", case$status, " ", case$desc, " from https?://[^ ]+", case$detail)
      expect_true(any(grepl(pattern, out$messages)), info = paste(out$messages, collapse = "\n"))
    })
  }
}

# A 200 still parses: the status check passes a 2xx response through unchanged.

test_that("the ESPN win-probability, RotoWire and Torvik wrappers parse a recorded 200", {
  skip_on_cran()
  local_http_fixtures()
  for (fn in c("espn_mbb_wp", "espn_nba_wp", "rotowire_injuries", "torvik_ncaa_results")) {
    x <- suppressMessages(direct_request_wrappers[[fn]]())
    expect_s3_class(x, "hoopR_data")
    expect_gt(nrow(x), 0)
  }
})

test_that("the NBA and G League CDN live wrappers parse a recorded 200", {
  skip_on_cran()
  local_routed_responses(function(url) {
    file <- sub(".json", "", basename(url), fixed = TRUE)
    if (grepl("cdn-gleague", url, fixed = TRUE)) file <- paste0(file, "_gleague")
    list(body = gz_fixture("nba_live", paste0(file, ".json.gz")))
  })
  pbp <- nba_live_pbp(game_id = "0022500001")
  expect_equal(nrow(pbp), 707L)
  gl_pbp <- nbagl_live_pbp(game_id = "2052500034")
  expect_equal(nrow(gl_pbp), 595L)
  for (x in list(nba_live_boxscore(game_id = "0022500001"),
                 nbagl_live_boxscore(game_id = "2052500034"))) {
    expect_type(x, "list")
    expect_gt(length(x), 0)
    expect_gt(nrow(x[[1]]), 0)
  }
})

test_that("nba_schedule(), nba_todays_scoreboard() and nba_draftboard() parse a 200", {
  skip_on_cran()
  game <- '{"gameId":"0022500001","gameCode":"20251021/HOUOKC","gameStatus":3,
    "homeTeam":{"teamId":1610612760,"teamTricode":"OKC","score":125},
    "awayTeam":{"teamId":1610612745,"teamTricode":"HOU","score":124}'
  local_routed_responses(function(url) {
    if (grepl("scheduleLeagueV2", url, fixed = TRUE)) {
      list(body = paste0('{"leagueSchedule":{"seasonYear":"2025-26","leagueId":"00","gameDates":[',
                         '{"gameDate":"10/21/2025 00:00:00","games":[', game, '}]}]}}'))
    } else if (grepl("todaysScoreboard", url, fixed = TRUE)) {
      list(body = paste0('{"scoreboard":{"gameDate":"2025-10-21","games":[', game, ',',
                         '"gameLeaders":{"homeLeaders":{"personId":1628983,"points":35},',
                         '"awayLeaders":{"personId":1630224,"points":30}},',
                         '"pbOdds":{"team":null,"odds":0.0,"suspended":0}}]}}'))
    } else {
      list(body = paste0('{"results":{"isDraftLive":false,"liveDraftCurrentPickNumber":0,',
                         '"picks":{"firstRound":[{"pickNumber":1,"teamId":1610612742}],"secondRound":[{"pickNumber":31,"teamId":1610612738}]},',
                         '"teamsWithoutPicks":{"firstRound":[{"teamId":1610612737}],"secondRound":[]}}}'))
    }
  })
  sched <- nba_schedule(league_id = "00")
  expect_equal(sched$game_id, "0022500001")
  expect_equal(sched$home_team_tricode, "OKC")
  expect_equal(sched$season_type_description, "Regular Season")

  board <- nba_todays_scoreboard()
  expect_s3_class(board, "hoopR_data")
  expect_equal(board$game_id, "0022500001")

  draft <- nba_draftboard(season = 2025)
  expect_named(draft, c("Picks", "TeamsWithoutPicks", "LiveDetails"))
  expect_equal(draft$Picks$pick_number, c(1L, 31L))
})

test_that("ncaa_mbb_teams() parses a 200", {
  skip_on_cran()
  local_routed_responses(function(url) {
    if (grepl("conf_id=-1", url, fixed = TRUE)) {
      nav <- paste(rep('<ul class="level2"><li><a href="#">x</a></li></ul>', 3), collapse = "")
      body <- paste0(
        "<html><body>", nav,
        '<ul class="level2"><li><a href="#">Conferences</a></li>',
        '<li><a href="javascript:changeConference(823)">ACC</a></li></ul>',
        '<table><tr><td><a href="/teams/573789">Duke</a></td></tr></table></body></html>'
      )
    } else {
      body <- '<html><body><table><tr><td><a href="/teams/573789">Duke</a></td></tr></table></body></html>'
    }
    list(type = "text/html", body = body)
  })
  x <- ncaa_mbb_teams(year = 2024, division = 1)
  expect_s3_class(x, "hoopR_data")
  expect_equal(x$team_name, "Duke")
  expect_equal(x$conference, "ACC")
  expect_equal(x$season_team_id, "573789")
})

test_that("check_status() raises the same classed error as .stop_for_http_status()", {
  bad <- httr2::response(status_code = 404L, url = "https://site.api.espn.com/x?lang=en")
  expect_error(check_status(bad), "^HTTP 404 Not Found from https://site.api.espn.com/x$",
               class = "hoopR_http_error")
  ok <- httr2::response(status_code = 200L, url = "https://site.api.espn.com/x")
  expect_identical(check_status(ok), ok)
})
