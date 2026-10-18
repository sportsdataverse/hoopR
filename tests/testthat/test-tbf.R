# Offline tests of the TBF family (R/tbf.R, R/tbf_utils.R). Fixtures and the
# parity CSVs come from sdv-py (see fixtures/tbf/README.md); the transport is
# mocked at .intl_response(), so the status vocabulary, the envelope checks and
# every refusal run for real. Live checks at the bottom (HOOPR_INTL_LIVE_TESTS=1).

# one-line condition messages, so the expected-message regexes see no wrapping
withr::local_options(list(cli.width = 400), .local_envir = testthat::teardown_env())

tbf_fx <- function(...) testthat::test_path("fixtures", "tbf", ...)
tbf_read <- function(rel) jsonlite::read_json(tbf_fx(rel), simplifyVector = FALSE)
tbf_text <- function(rel) paste(readLines(tbf_fx(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
tbf_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
tbf_manifest <- jsonlite::read_json(tbf_fx("parity", "manifest.json"), simplifyVector = FALSE)
tbf_table <- function(short) if (startsWith(short, "leaders_")) "leaders" else short

tbf_stamped <- function(short) {
  e <- tbf_manifest[[short]]
  body <- tbf_read(e$fixture)
  body[["_request"]] <- e$request
  body
}

# Mock the transport: `routes` maps an API path to a body (a fixture path, a
# list serialised to JSON, or list(status =, body =)), or to a function(query).
tbf_mock <- function(routes, env = parent.frame()) {
  log <- new.env()
  log$calls <- list()
  fake <- function(url, query = list(), body = NULL, body_type = "none", headers = NULL, proxy_env = NULL,
                   retry_500 = FALSE, timeout = 60, proxy = NULL, follow_redirects = TRUE, statuses = NULL,
                   call = NULL) {
    path <- sub("^https://miniappapi\\.tbf\\.org\\.tr/webapi-service/api", "", url)
    query <- Filter(Negate(is.null), query)
    log$calls[[length(log$calls) + 1L]] <- list(path = path, query = query, follow_redirects = follow_redirects,
                                                retry_500 = retry_500)
    r <- routes[[path]]
    if (is.null(r)) stop("unmocked TBF route ", path)
    if (is.function(r)) r <- r(query)
    status <- 200L
    if (is.list(r) && !is.null(r$status)) {
      status <- r$status
      r <- r$body
    }
    text <- if (is.character(r) && length(r) == 1L && grepl("\\.json$", r)) tbf_text(r) else if (is.character(r)) r else tbf_json(r)
    httr2::response(status_code = status, url = url, headers = list(`Content-Type` = "application/json"),
                    body = charToRaw(enc2utf8(text)))
  }
  testthat::local_mocked_bindings(.intl_response = fake, .package = "hoopR", .env = env)
  hoopR:::.tbf_clear_cache()
  withr::defer(hoopR:::.tbf_clear_cache(), envir = env)
  log
}

PREFIX <- "/League/get-leagues-and-seasons-by-prefix"
PREFIX_BSL <- "cap/league_seasons.json"

# sdv-py frame (CSV) vs the R tibble, cell by cell; NA-vs-value is a mismatch
tbf_mismatches <- function(r, w) {
  if (is.numeric(r)) {
    wn <- suppressWarnings(as.numeric(w))
    bad <- is.na(r) != is.na(wn) | (!is.na(r) & !is.na(wn) & abs(r - wn) > 1e-9)
  } else {
    rs <- if (is.logical(r)) tolower(as.character(r)) else if (inherits(r, "POSIXct")) format(r, "%Y-%m-%d %H:%M:%S") else as.character(r)
    bad <- is.na(rs) != is.na(w) | (!is.na(rs) & !is.na(w) & rs != w)
  }
  sum(bad)
}

test_that("every route matches the sdv-py frame on the same fixture (parity)", {
  expect_length(tbf_manifest, 32L)
  for (short in names(tbf_manifest)) {
    got <- hoopR:::.tbf_parse(tbf_table(short), tbf_stamped(short))
    want <- utils::read.csv(tbf_fx("parity", paste0(short, ".csv")), colClasses = "character", na.strings = "",
                            fileEncoding = "UTF-8", check.names = FALSE)
    expect_identical(names(got), names(want), info = short)
    expect_identical(nrow(got), nrow(want), info = short)
    expect_gt(nrow(got), 0L)
    bad <- vapply(names(got), function(col) tbf_mismatches(got[[col]], want[[col]]), integer(1))
    expect_identical(bad[bad > 0], stats::setNames(integer(0), character(0)), info = short)
  }
})

test_that("ids are integers, never stringified floats; types follow the sdv-py dtypes", {
  for (short in names(tbf_manifest)) {
    got <- hoopR:::.tbf_parse(tbf_table(short), tbf_stamped(short))
    ids <- grep("(_id|^rank|^genius_id)$", names(got), value = TRUE)
    for (col in ids) expect_type(got[[col]], "integer")
    expect_false(any(grepl("\\.0$", unlist(Filter(is.character, got)))), info = short)
  }
  header <- hoopR:::.tbf_parse("game_header", tbf_stamped("game_header"))
  expect_identical(c(header$activity_id, header$season_id, header$home_team_process_id), c(22214L, 174L, 265995L))
  expect_identical(c(header$home_score, header$away_score, header$genius_id), c(90L, 89L, 2913588L))
  expect_s3_class(header$tipoff, "POSIXct")
  expect_identical(format(header$tipoff, "%Y-%m-%d %H:%M:%S %Z"), "2026-09-25 19:00:00 +03")
  box <- hoopR:::.tbf_parse("player_box", tbf_stamped("player_box"))
  expect_type(box$jersey_number, "character")
  expect_type(box$fg_pct, "integer")
  stats <- hoopR:::.tbf_parse("team_player_stats", tbf_stamped("team_player_stats"))
  expect_type(stats$fg_pct, "double")
  pbp <- hoopR:::.tbf_parse("pbp", tbf_stamped("pbp"))
  last <- pbp[nrow(pbp), ]
  expect_identical(c(last$action, last$action_en), c("Maç Sonu", "game end"))
  expect_identical(c(last$home_score, last$away_score), c(90L, 89L))
})

test_that("an empty or malformed body parses to a zero-row tibble with the documented columns", {
  for (short in names(tbf_manifest)) {
    full <- hoopR:::.tbf_parse(tbf_table(short), tbf_stamped(short))
    for (raw in list(list(), list(data = NULL), list(data = list()), "junk", NULL)) {
      empty <- hoopR:::.tbf_parse(tbf_table(short), raw)
      expect_identical(nrow(empty), 0L)
      expect_identical(vapply(empty, function(x) class(x)[1], ""), vapply(full, function(x) class(x)[1], ""),
                       info = short)
    }
  }
})

test_that("casts mirror sdv-py _i / _f / _s / _clock / _end_year", {
  expect_identical(hoopR:::.tbf_i(22214), 22214L)
  expect_identical(hoopR:::.tbf_i("22214"), 22214L)
  expect_identical(hoopR:::.tbf_i(22214.5), NA_integer_)
  expect_identical(hoopR:::.tbf_i(TRUE), NA_integer_)
  expect_identical(hoopR:::.tbf_s(22214), "22214")
  expect_identical(hoopR:::.tbf_s("  "), NA_character_)
  expect_identical(hoopR:::.tbf_f("71.4%"), 71.4)
  expect_identical(hoopR:::.tbf_f("3,5"), 3.5)
  expect_identical(hoopR:::.tbf_f("-"), NA_real_)
  expect_identical(hoopR:::.tbf_clock("25:19"), 1519L)
  expect_identical(hoopR:::.tbf_clock("01:25:20"), 5120L)
  expect_identical(hoopR:::.tbf_end_year("BSL 2026-2027"), 2027L)
  expect_identical(hoopR:::.tbf_end_year("2027"), NA_integer_)
})

# ------------------------------------------------------------------ runtime

test_that("season maps the END year to TBF's season and activity ids (one prefix request per competition)", {
  log <- tbf_mock(list(
    "/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL,
    "/League/get-league-weeks" = "cap/weeks.json"
  ))
  w <- tbf_weeks(season = 2027)
  w2 <- tbf_weeks(season = "2026", competition = "bsl")
  expect_s3_class(w, "hoopR_data")
  expect_identical(unique(w$season), 2027L)
  expect_identical(unique(w$activity_id), 22214L)
  expect_identical(unique(w2$activity_id), 20728L)
  paths <- vapply(log$calls, `[[`, "", "path")
  expect_identical(sum(paths == PREFIX), 1L)
  weeks <- Filter(function(x) x$path == "/League/get-league-weeks", log$calls)
  expect_identical(weeks[[1]]$query, list(seasonId = 174L, leagueId = 22214L))
  expect_identical(weeks[[2]]$query, list(seasonId = 172L, leagueId = 20728L))
  expect_identical(log$calls[[1]]$query, list(prefix = "bsl"))
  expect_true(all(!vapply(log$calls, `[[`, TRUE, "follow_redirects")))
  expect_true(all(!vapply(log$calls, `[[`, TRUE, "retry_500")))
  expect_error(tbf_weeks(season = 1990), class = "hoopR_no_data")
})

test_that("bad arguments are hoopR_bad_request before any request", {
  log <- tbf_mock(list())
  expect_error(tbf_weeks(2027, competition = "BSL"), class = "hoopR_bad_request")
  expect_error(tbf_weeks(2027, competition = "euroleague"), class = "hoopR_bad_request")
  expect_error(tbf_daily_matches("2026-10-11", competition = "x"), class = "hoopR_bad_request")
  expect_error(tbf_daily_matches("11/10/2026"), class = "hoopR_bad_request")
  expect_error(tbf_game_header(match_id = "abc"), class = "hoopR_bad_request")
  expect_error(tbf_player_career(player_id = 1.5), class = "hoopR_bad_request")
  expect_length(log$calls, 0L)
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL))
  expect_error(tbf_weeks(season = 2027.5), class = "hoopR_bad_request")
  expect_error(tbf_standings(season = 2027, week = "x"), class = "hoopR_bad_request")
})

test_that("HTTP statuses, redirects and envelopes map to the classed conditions", {
  status <- function(code) list("/Season/get-seasons" = list(status = code, body = "{}"))
  tbf_mock(status(404L))
  expect_error(tbf_seasons(), class = "hoopR_no_data")
  tbf_mock(status(400L))
  expect_error(tbf_seasons(), class = "hoopR_bad_request")
  tbf_mock(status(503L))
  err <- expect_error(tbf_seasons(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  tbf_mock(status(500L))
  expect_error(tbf_seasons(), class = "hoopR_asset_fetch")
  tbf_mock(status(302L)) # a redirect (vendor origin) is never followed
  err <- expect_error(tbf_seasons(), class = "hoopR_asset_fetch")
  expect_identical(err$status, 302L)
  tbf_mock(list("/Season/get-seasons" = "<html>blocked</html>"))
  expect_error(tbf_seasons(), class = "hoopR_asset_fetch")
  tbf_mock(list("/Season/get-seasons" = list(items = list())))
  expect_error(tbf_seasons(), class = "hoopR_asset_fetch")
  tbf_mock(list("/Season/get-seasons" = list(data = NULL, isSuccess = FALSE, problemDetails = list(type = "Boom"))))
  expect_error(tbf_seasons(), class = "hoopR_asset_fetch")
  tbf_mock(list("/Season/get-seasons" = list(data = NULL, isSuccess = FALSE,
                                             problemDetails = list(type = "NotFoundException"))))
  expect_error(tbf_seasons(), class = "hoopR_no_data")
})

test_that("capped and paged lists must be whole", {
  seasons <- tbf_read("cap/seasons.json") # 3 rows of the 20-row cap
  tbf_mock(list("/Season/get-seasons" = modifyList(seasons, list(count = 3L))))
  expect_error(tbf_seasons(), "capped list drifted", class = "hoopR_asset_fetch")
  tbf_mock(list("/Season/get-seasons" = seasons)) # count 20, 3 rows: a partial page
  expect_error(tbf_seasons(), "partial page", class = "hoopR_asset_fetch")
  full <- seasons
  full$data <- rep(seasons$data, length.out = 20L)
  tbf_mock(list("/Season/get-seasons" = full))
  expect_identical(nrow(tbf_seasons()), 20L)
  leaders <- list(PREFIX_BSL, "cap/leaders_assists.json")
  names(leaders) <- c(PREFIX, "/Player/get-asist-leaders")
  tbf_mock(leaders)
  expect_error(tbf_leaders_assists(2027), "capped list drifted", class = "hoopR_asset_fetch")
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL, "/Player/get-point-leaders" = "full/leaders_points.json"))
  pts <- tbf_leaders_points(2027)
  expect_identical(nrow(pts), 40L)
  expect_identical(unique(pts$category), "points")
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL,
                "/Player/get-point-leaders" = list(data = list(sum = list(), avg = list()), isSuccess = TRUE)))
  expect_error(tbf_leaders_points(2027), class = "hoopR_no_data")
  sched <- tbf_read("cap/schedule.json")
  routes <- list(PREFIX_BSL, sched)
  names(routes) <- c(PREFIX, "/Match/get-all-matches-for-filter")
  tbf_mock(routes) # count 8, 3 rows
  expect_error(tbf_schedule(2027, week = 1), "partial page", class = "hoopR_asset_fetch")
  routes[[2]] <- modifyList(sched, list(count = 3L))
  log <- tbf_mock(routes)
  s <- tbf_schedule(2027, week = 1)
  expect_identical(nrow(s), 3L)
  expect_identical(log$calls[[2]]$query, list(ActivityId = 22214L, WeekFilter = "1", Page = 1L, PageSize = -1L))
})

test_that("wrong-scope bodies are refused", {
  leagues <- tbf_read("cap/leagues.json")
  leagues$data[[2]]$seasonId <- 172L
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL, "/League/get-leagues-for-filter" = leagues))
  expect_error(tbf_leagues(2027), "out of scope", class = "hoopR_asset_fetch")
  prefix <- tbf_read(PREFIX_BSL)
  prefix$data[[1]]$url <- "tbl-2026-2027"
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = prefix))
  expect_error(tbf_league_seasons("bsl"), "out of scope", class = "hoopR_asset_fetch")
  st <- tbf_read("full/standings.json")
  st$data[[1]]$standings[[1]]$faaliyetAltAlanId <- 20728L
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL, "/League/get-standings-table" = st))
  expect_error(tbf_standings(2027), "out of scope", class = "hoopR_asset_fetch")
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL,
                "/League/get-standings-table" = "full/standings.json"))
  expect_error(tbf_standings(2027, week = 99), "hafta", class = "hoopR_asset_fetch")
  players <- modifyList(tbf_read("cap/players.json"), list(count = 3L))
  players$data[[3]]$prefix <- "kbsl"
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL, "/Player/get-player-list" = players))
  expect_error(tbf_players(2027), "out of scope", class = "hoopR_asset_fetch")
  games <- tbf_read("cap/team_games.json")
  games$data$maclar[[1]]$takimAId <- 1L
  games$data$maclar[[1]]$takimBId <- 2L
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL,
                "/Team/get-team-detail-matches-by-season-and-league" = games))
  expect_error(tbf_team_games(2027, team_process_id = 265995), "not team", class = "hoopR_asset_fetch")
  teams <- tbf_read("cap/teams.json")
  teams$data[[1]]$seasonId <- "174"
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL, "/Team/get-teams-by-leauge" = teams))
  expect_error(tbf_teams(2027), "out of scope", class = "hoopR_asset_fetch") # "174" is not 174
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL,
                "/Team/get-teams-by-leauge" = list(data = list(), isSuccess = TRUE)))
  expect_error(tbf_teams(2027), class = "hoopR_no_data")
})

test_that("daily matches check the date, the activity and truncated groups", {
  daily <- tbf_read("cap/daily_matches.json")
  day <- daily$data[[1]]$matches[[1]]$matchDateOnly
  daily$data <- lapply(daily$data, function(g) modifyList(g, list(totalCount = length(g$matches))))
  log <- tbf_mock(list("/Match/get-daily-matches" = daily))
  got <- tbf_daily_matches(as.Date(day))
  expect_identical(nrow(got), sum(lengths(lapply(daily$data, `[[`, "matches"))))
  expect_identical(log$calls[[1]]$query, list(MatchDate = day, GroupByActivity = "true"))
  tbf_mock(list("/Match/get-daily-matches" = daily))
  expect_error(tbf_daily_matches("2001-01-01"), "matchDateOnly", class = "hoopR_asset_fetch")
  tbf_mock(list("/Match/get-daily-matches" = "cap/daily_matches.json"))
  expect_error(tbf_daily_matches(day), "truncated group", class = "hoopR_asset_fetch")
})

game_routes <- function(...) {
  base <- list(
    "/Match/mac-header" = "full/header.json",
    "/Match/mac-istatistik" = "full/stats.json",
    "/Match/game-flow" = "full/flow.json",
    "/Match/shot-chart" = "full/shots.json",
    "/Match/mac-ozet" = "full/summary.json",
    "/Match/mac-leader" = "full/leaders_game.json"
  )
  utils::modifyList(base, list(...))
}

test_that("game wrappers return the finished game, header fetched once", {
  log <- tbf_mock(game_routes())
  box <- tbf_player_box(346279)
  team <- tbf_team_box(346279)
  expect_identical(sum(box$points[box$side == "home"]), 90L)
  expect_identical(team$team_process_id, c(265995L, 265993L))
  expect_identical(nrow(tbf_pbp(346279)), nrow(hoopR:::.tbf_parse("pbp", tbf_stamped("pbp"))))
  expect_gt(nrow(tbf_shots(346279)), 0L)
  expect_identical(sum(tbf_period_scores(346279)$points), 179L)
  expect_gt(nrow(tbf_highlights(346279)), 0L)
  expect_gt(nrow(tbf_game_leaders(346279)), 0L)
  expect_identical(tbf_game_header(346279)$match_id, 346279L)
  expect_gt(nrow(tbf_game_players(346279)), 10L)
  paths <- vapply(log$calls, `[[`, "", "path")
  expect_identical(sum(paths == "/Match/mac-header"), 1L)
})

test_that("unfinished, unknown, other-game and off-roster game bodies are refused", {
  header <- tbf_read("full/header.json")
  tbf_mock(game_routes("/Match/mac-header" = modifyList(header, list(data = list(matchStatusId = 2L)))))
  expect_error(tbf_game_header(346279), "not finished", class = "hoopR_asset_fetch")
  tbf_mock(game_routes("/Match/mac-header" = list(status = 404L, body = "{}")))
  expect_error(tbf_pbp(346279), class = "hoopR_no_data")
  tbf_mock(game_routes("/Match/mac-header" = list(data = setNames(list(), character(0)), isSuccess = TRUE)))
  expect_error(tbf_game_header(346279), class = "hoopR_no_data")

  flow <- tbf_read("full/flow.json")
  other <- flow
  other$data$matchId <- "346280"
  tbf_mock(game_routes("/Match/game-flow" = other))
  expect_error(tbf_pbp(346279), "matchId", class = "hoopR_asset_fetch")
  num <- flow
  num$data$matchId <- 346279L # the id must be echoed as a string
  tbf_mock(game_routes("/Match/game-flow" = num))
  expect_error(tbf_pbp(346279), "matchId", class = "hoopR_asset_fetch")
  cut <- flow
  cut$data$events <- cut$data$events[-length(cut$data$events)]
  tbf_mock(game_routes("/Match/game-flow" = cut))
  expect_error(tbf_pbp(346279), "not final", class = "hoopR_asset_fetch")
  wrong <- flow
  wrong$data$events[[length(wrong$data$events)]]$score <- "90-88"
  tbf_mock(game_routes("/Match/game-flow" = wrong))
  expect_error(tbf_pbp(346279), "final event score", class = "hoopR_asset_fetch")
  empty <- flow
  empty$data$events <- list()
  tbf_mock(game_routes("/Match/game-flow" = empty))
  expect_error(tbf_pbp(346279), class = "hoopR_no_data")
  stranger <- flow
  i <- which(vapply(stranger$data$events, function(e) is.character(e$playerName) && nzchar(e$playerName), TRUE))[1]
  stranger$data$events[[i]]$playerName <- "NOBODY"
  tbf_mock(game_routes("/Match/game-flow" = stranger))
  expect_error(tbf_pbp(346279), "header roster", class = "hoopR_asset_fetch")

  stats <- tbf_read("full/stats.json")
  stats$data$homeTeamTotal$points <- 91L
  tbf_mock(game_routes("/Match/mac-istatistik" = stats))
  expect_error(tbf_player_box(346279), "team totals", class = "hoopR_asset_fetch")
  summary <- tbf_read("full/summary.json")
  summary$data$homeTeamScore[[1]]$score <- 0L
  tbf_mock(game_routes("/Match/mac-ozet" = summary))
  expect_error(tbf_period_scores(346279), "period scores", class = "hoopR_asset_fetch")
  shots <- tbf_read("full/shots.json")
  shots$data$shotInfos <- list()
  tbf_mock(game_routes("/Match/shot-chart" = shots))
  expect_error(tbf_shots(346279), class = "hoopR_no_data")
})

test_that("team routes and the player profile", {
  tbf_mock(list("/League/get-leagues-and-seasons-by-prefix" = PREFIX_BSL,
                "/Team/get-team-detail-statistic" = "full/team_stats.json",
                "/Team/get-team-active-player-list-by-season-and-league" = "cap/team_roster.json",
                "/Team/get-team-detail-team-staff-by-season-and-league" = "cap/team_staff.json"))
  st <- tbf_team_player_stats(2027, team_process_id = 265995)
  expect_identical(unique(st$team_process_id), 265995L)
  expect_false(anyNA(st$points_per_game))
  expect_gt(nrow(tbf_team_roster(2027, 265995)), 0L)
  expect_gt(nrow(tbf_team_staff(2027, 265995)), 0L)
  expect_error(tbf_team_staff(2027, team_process_id = "x"), class = "hoopR_bad_request")
  prof <- list("cap/player_career.json")
  names(prof) <- "/Player/get-player-detail-profile-and-career-info/196413"
  tbf_mock(prof)
  expect_identical(unique(tbf_player_career(196413)$person_id), 196413L)
  names(prof) <- "/Player/get-player-detail-profile-and-career-info/1"
  prof[[1]] <- list(data = list(playerProfile = NULL, careerInfo = list()), isSuccess = TRUE)
  tbf_mock(prof)
  expect_error(tbf_player_career(1), class = "hoopR_no_data")
})

# ------------------------------------------------------------------ live

test_that("live: TBF app API (a handful of requests)", {
  skip_intl_live()
  s <- tbf_seasons()
  expect_identical(nrow(s), 20L)
  ls <- tbf_league_seasons("bsl")
  expect_true(2027L %in% ls$season)
  h <- tbf_game_header(346279)
  expect_identical(c(h$home_score, h$away_score), c(90L, 89L))
})
