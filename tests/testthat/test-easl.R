# Offline tests of the EASL family: R/easl.R, R/easl_runtime.R, R/easl_parsers.R. Every request is
# mocked through httr2, so the season mapping, the freshness check, the game checks, the retries and
# the error vocabulary run end to end; the throttle is recorded, never slept. Parity:
# tests/testthat/fixtures/easl/parity/<case>.csv is sdv-py's frame of the same wrapper on the same
# fixture (see fixtures/easl/README.md).

easl_fixture <- function(...) test_path("fixtures", "easl", ...)
easl_text <- function(rel) paste(readLines(easl_fixture(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
easl_body <- function(rel) jsonlite::parse_json(easl_text(rel), simplifyVector = FALSE)

EASL_API <- "https://easl.joshricha.com/api/v1"
EASL_G <- "10af8fd4-106e-11f1-960b-5798087c7aa3" # the 2025-26 final
EASL_G24 <- "6e3c321b-d078-11ee-bd9b-cfe0b28e3077" # the 2023-24 championship game
EASL_T <- "865489e8-b0f5-11ed-8b3f-c199a9dea184" # Utsunomiya Brex
EASL_PL <- "85c99dab-9f67-11f0-8780-a731edb5aad5"
EASL_OTHER <- "00000000-0000-1000-8000-000000000000"
EASL_S <- c(`2024` = "c24ce68a-6420-11ee-9daf-6b6188281bd0", `2025` = "57cefc32-5ace-11ef-81a0-3d1f6018efb7",
            `2026` = "77441bb3-9759-11f0-b659-0561c09a0222", `2027` = "1409787d-a683-11f1-aea7-b596f55be5ed")
# an hour after fixtures/easl/health.json's timestamp (2026-10-12T22:01:41Z)
EASL_NOW <- as.double(as.POSIXct("2026-10-12 23:00:00", tz = "UTC"))

# route -> fixture, the same table as the sdv-py generator
EASL_ROUTES <- c(
  "/health" = "health.json", "/metadata/seasons" = "seasons.json",
  stats::setNames("game.json", paste0("/matches/", EASL_G)),
  stats::setNames("game_2024.json", paste0("/matches/", EASL_G24)),
  stats::setNames("boxscore.json", paste0("/matches/", EASL_G, "/boxscore")),
  stats::setNames("playbyplay.json", paste0("/matches/", EASL_G, "/playbyplay")),
  stats::setNames("teamstats.json", paste0("/matches/", EASL_G, "/teamstats")),
  stats::setNames("teamstats_period.json", paste0("/matches/", EASL_G, "/teamstats/by/period")),
  "/teams" = "teams.json", "/matches" = "matches_2026.json", "/standings" = "standings_2026.json",
  "/leaders" = "leaders_2026.json", "/players" = "players.json",
  stats::setNames("team.json", paste0("/teams/", EASL_T)),
  stats::setNames("team_matches_2026.json", paste0("/teams/", EASL_T, "/matches")),
  stats::setNames("team_stats_2026.json", paste0("/teams/", EASL_T, "/stats")),
  stats::setNames("team_leaders_2026.json", paste0("/teams/", EASL_T, "/leaders")),
  stats::setNames("player.json", paste0("/players/", EASL_PL)),
  stats::setNames("player_stats.json", paste0("/players/", EASL_PL, "/stats"))
)

easl_resp <- function(body, status = 200L, headers = list()) {
  text <- if (is.character(body)) body else as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null",
                                                                         digits = NA))
  httr2::response(status, headers = c(list("Content-Type" = "application/json; charset=utf-8"), headers),
                  body = charToRaw(enc2utf8(text)))
}
easl_path <- function(req) sub(paste0("^", EASL_API), "", sub("\\?.*$", "", req$url))

# Mock the API. `over` replaces routes: a fixture name, an R body, an httr2 response, a list of those
# (answered in turn) or a function(req). `seen` records every request and every throttle wait; the
# session cache is cleared before and after, and the clock is fixed at `now`.
local_easl <- function(over = list(), now = EASL_NOW, env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$waits <- list()
  .easl_clear_cache()
  withr::defer(.easl_clear_cache(), envir = env)
  withr::local_options(cli.width = 10000, .local_envir = env)
  local_mocked_bindings(
    .intl_wait = function(url, min_interval = 1) {
      seen$waits[[length(seen$waits) + 1L]] <- list(url = url, interval = min_interval)
      invisible(0)
    },
    .easl_now = function() now,
    .package = "hoopR", .env = env
  )
  answers <- new.env()
  httr2::local_mocked_responses(function(req) {
    path <- easl_path(req)
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    ans <- if (path %in% names(over)) over[[path]] else if (path %in% names(EASL_ROUTES)) EASL_ROUTES[[path]] else {
      stop("unexpected request ", path)
    }
    if (is.list(ans) && !is.null(attr(ans, "turns"))) {
      i <- (answers[[path]] %||% 0L) + 1L
      answers[[path]] <- i
      ans <- ans[[min(i, length(ans))]]
    }
    if (is.function(ans)) return(ans(req))
    if (inherits(ans, "httr2_response")) return(ans)
    if (is.character(ans) && length(ans) == 1L && endsWith(ans, ".json")) return(easl_resp(easl_text(ans)))
    easl_resp(ans)
  }, env = env)
  seen
}
easl_turns <- function(...) structure(list(...), turns = TRUE)
easl_paths <- function(seen) vapply(seen$reqs, easl_path, character(1))

# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator)
EASL_CASES <- list(
  easl_health = list(list(), list()),
  easl_seasons = list(list(), list()),
  easl_schedule = list(list(season = 2026), list()),
  easl_schedule__active = list(list(), list("/matches" = "matches_active.json")),
  easl_game = list(list(fixture_id = EASL_G), list()),
  easl_game__2024 = list(list(fixture_id = EASL_G24), list()),
  easl_player_box = list(list(fixture_id = EASL_G), list()),
  easl_pbp = list(list(fixture_id = EASL_G), list()),
  easl_team_box = list(list(fixture_id = EASL_G), list()),
  easl_team_box_by_period = list(list(fixture_id = EASL_G), list()),
  easl_standings = list(list(season = 2026), list()),
  easl_leaders = list(list(season = 2026), list()),
  easl_teams = list(list(), list()),
  easl_team = list(list(team_id = EASL_T), list()),
  easl_team_schedule = list(list(team_id = EASL_T, season = 2026), list()),
  easl_team_stats = list(list(team_id = EASL_T, season = 2026), list()),
  easl_team_leaders = list(list(team_id = EASL_T, season = 2026), list()),
  easl_players = list(list(), list()),
  easl_players__roster = list(list(season = 2026, team_id = EASL_T), list("/players" = "roster_2026.json")),
  easl_player = list(list(player_id = EASL_PL), list()),
  easl_player_stats = list(list(player_id = EASL_PL), list())
)
EASL_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character", Date = "Date")

easl_run_case <- function(case, env = parent.frame()) {
  spec <- EASL_CASES[[case]]
  seen <- local_easl(spec[[2]], env = env)
  out <- do.call(sub("__.*$", "", case), spec[[1]])
  list(out = out, seen = seen)
}
easl_type <- function(x) if (is.double(x) && !inherits(x, "Date")) "numeric" else class(x)[[1]]

# cells that differ, NA-vs-value counted as a mismatch
easl_mismatches <- function(got, want_chr) {
  if (inherits(got, "Date")) got <- format(got, "%Y-%m-%d")
  want <- if (is.logical(got)) ifelse(is.na(want_chr), NA, want_chr == "true") else if (is.numeric(got)) {
    suppressWarnings(as.numeric(want_chr))
  } else {
    want_chr
  }
  na_diff <- is.na(got) != is.na(want)
  both <- !is.na(got) & !is.na(want)
  val_diff <- if (is.double(got)) abs(got[both] - want[both]) > 1e-9 else got[both] != want[both]
  sum(na_diff) + sum(val_diff)
}

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, types, cells, requests)", {
  dtypes <- jsonlite::read_json(easl_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(easl_fixture("parity", "requests.json"))
  expect_setequal(names(EASL_CASES), names(dtypes))
  exports <- getNamespaceExports("hoopR")
  expect_setequal(unique(sub("__.*$", "", names(EASL_CASES))), exports[startsWith(exports, "easl_")])
  for (case in names(EASL_CASES)) {
    res <- easl_run_case(case)
    got <- res$out
    want <- utils::read.csv(easl_fixture("parity", paste0(case, ".csv")), colClasses = "character",
                            na.strings = "\\N", check.names = FALSE, encoding = "UTF-8")
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    want_types <- stats::setNames(unname(EASL_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    if ("received_time" %in% names(want_types)) want_types[["received_time"]] <- "numeric" # Int64 epoch ms
    expect_identical(vapply(got, easl_type, character(1)), want_types[names(got)], label = case)
    bad <- vapply(names(got), function(n) easl_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same requests, in the same order, with the same query as sdv-py
    want_req <- requests[[case]]
    expect_identical(easl_paths(res$seen), vapply(want_req, function(r) r$route, character(1)), label = case)
    flat <- function(x) sort(paste(names(x), vapply(x, as.character, ""), sep = "="))
    for (i in seq_along(want_req)) {
      q <- httr2::url_parse(res$seen$reqs[[i]]$url)$query %||% list()
      expect_identical(flat(q), flat(want_req[[i]]$params), label = paste(case, i))
    }
  }
})

test_that("ids are DataCore UUID strings; row ids, scores and periods are integers", {
  games <- easl_run_case("easl_schedule")$out
  for (col in c("season_id", "fixture_id", "home_team_id", "away_team_id", "pool_id", "stage_id")) {
    expect_type(games[[col]], "character")
  }
  expect_type(games$season, "integer")
  expect_type(games$fixture_number, "integer")
  expect_type(games$home_score, "integer")
  expect_identical(unique(games$season), 2026L)
  pbp <- easl_run_case("easl_pbp")$out
  expect_type(pbp$received_time, "double")
  expect_type(pbp$period_id, "integer")
  expect_identical(tapply(pbp$points_scored, pbp$team_id, sum)[[EASL_T]], 90L)
  expect_identical(pbp$event_number, seq_len(495))
  seasons <- easl_run_case("easl_seasons")$out
  expect_type(seasons$season_row_id, "integer")
  expect_s3_class(seasons$start_date, "Date")
  roster <- easl_run_case("easl_players__roster")$out
  expect_s3_class(roster$dob, "Date")
  expect_type(roster$jersey_number, "character")
  box <- easl_run_case("easl_player_box")$out
  expect_identical(sum(!box$played), 7L)
  expect_identical(sum(box$points[box$team_id == EASL_T]), 90L)
  old <- easl_run_case("easl_game__2024")$out
  expect_true(is.na(old$fixture_number))
})

test_that("the fixture's sides come from isHome, not from list order", {
  game <- easl_run_case("easl_game")$out
  expect_identical(game$away_team_id, EASL_T)
  expect_identical(c(game$away_score, game$home_score), c(90L, 81L))
  expect_true(is.na(game$season))
})

test_that("season is the END year, mapped to the DataCore seasonId; NULL is the ACTIVE season", {
  rows <- easl_body("matches_2026.json")
  for (end in names(EASL_S)) {
    sid <- EASL_S[[end]]
    seen <- local_easl(list("/matches" = lapply(rows, function(r) utils::modifyList(r, list(seasonId = sid)))))
    raw <- .easl_get("/matches", list(season = as.integer(end)))
    expect_identical(raw[["_request"]], list(season = as.integer(end), season_id = sid))
    expect_identical(httr2::url_parse(seen$reqs[[2]]$url)$query, list(seasonId = sid))
  }
  seen <- local_easl(list("/matches" = lapply(rows, function(r) utils::modifyList(r, list(seasonId = EASL_S[["2027"]])))))
  expect_identical(.easl_get("/matches")[["_request"]]$season, 2027L)
  expect_identical(easl_paths(seen), c("/metadata/seasons", "/matches", "/health"))
  # the seasons list is fetched once per session
  seen <- local_easl()
  easl_schedule(season = 2026)
  easl_standings(season = 2026)
  expect_identical(sum(easl_paths(seen) == "/metadata/seasons"), 1L)
})

test_that("an unknown or malformed season is hoopR_bad_request before the route is requested", {
  for (bad in list(2022, 2028, "x", TRUE, 2026.5, NA, c(2025, 2026), -2026)) {
    seen <- local_easl()
    expect_error(easl_standings(season = bad), class = "hoopR_bad_request", regexp = "season|END year")
    expect_false("/standings" %in% easl_paths(seen))
  }
  local_easl(list("/standings" = "standings_2026.json"))
  expect_identical(nrow(easl_standings(season = "2026")), 3L)
})

test_that("malformed ids are hoopR_bad_request before any request", {
  seen <- local_easl()
  expect_error(easl_player_box("not-a-uuid"), class = "hoopR_bad_request", regexp = "UUID")
  expect_error(easl_team(123), class = "hoopR_bad_request", regexp = "UUID")
  expect_error(easl_player_stats("x"), class = "hoopR_bad_request", regexp = "UUID")
  expect_error(easl_game(NULL), class = "hoopR_bad_request", regexp = "UUID")
  expect_error(.easl_get("/auth/login"), class = "hoopR_bad_request", regexp = "Not an EASL route")
  expect_identical(length(seen$reqs), 0L)
  expect_error(easl_players(team_id = "nope"), class = "hoopR_bad_request", regexp = "team_id")
  expect_identical(length(seen$reqs), 0L)
})

test_that("an empty payload is hoopR_no_data; an empty or malformed body parses to a typed zero-row tibble", {
  local_easl(list("/teams" = list()))
  expect_error(easl_teams(), class = "hoopR_no_data")
  local_easl(list("/leaders" = list(pointsPerGame = list())))
  expect_error(easl_leaders(season = 2026), class = "hoopR_no_data")
  dtypes <- jsonlite::read_json(easl_fixture("parity", "dtypes.json"))
  for (kind in names(.easl_specs)) {
    want <- names(dtypes[[paste0("easl_", kind)]])
    for (bad in list(list(), stats::setNames(list(), character()), NULL, "x", list(items = list()),
                     list(`_request` = list(season = 2026L)))) {
      empty <- .easl_parse(kind, bad)
      expect_identical(nrow(empty), 0L, label = kind)
      expect_identical(names(empty), want, label = kind)
    }
    types <- unname(EASL_RTYPE[unlist(dtypes[[paste0("easl_", kind)]])])
    types[want == "received_time"] <- "numeric"
    expect_identical(unname(vapply(empty, easl_type, "")), types, label = kind)
  }
})

test_that("an active-season list is checked against the health clock; past seasons are not", {
  seen <- local_easl(list("/matches" = "matches_active.json"))
  expect_identical(nrow(easl_schedule()), 3L)
  expect_true("/health" %in% easl_paths(seen))
  # the SCHEDULED game tipped off 2026-11-05T10:10; two days later the mirror looks stalled
  later <- as.double(as.POSIXct("2026-11-07 01:00:00", tz = "UTC"))
  local_easl(list("/matches" = "matches_active.json",
                  "/health" = list(status = "OK", timestamp = "2026-11-07T00:00:00.000Z")), now = later)
  expect_error(easl_schedule(), class = "hoopR_asset_fetch", regexp = "stalled")
  local_easl(list("/matches" = "matches_active.json",
                  "/health" = list(status = "OK", timestamp = "2026-09-01T00:00:00.000Z")))
  expect_error(easl_schedule(), class = "hoopR_asset_fetch", regexp = "more than a day")
  local_easl(list("/matches" = "matches_active.json", "/health" = list(status = "DOWN", timestamp = "x")))
  expect_error(easl_schedule(), class = "hoopR_asset_fetch", regexp = "not OK")
  seen <- local_easl()
  easl_schedule(season = 2026)
  expect_false("/health" %in% easl_paths(seen))
})

test_that("a fixture list of another season is refused", {
  rows <- easl_body("matches_2026.json")
  rows[[2]]$seasonId <- EASL_S[["2025"]]
  local_easl(list("/matches" = rows))
  expect_error(easl_schedule(season = 2026), class = "hoopR_asset_fetch", regexp = "another season")
})

test_that("a game reads its header once, then the route", {
  seen <- local_easl()
  easl_player_box(EASL_G)
  expect_identical(easl_paths(seen), paste0("/matches/", EASL_G, c("", "/boxscore")))
  easl_team_box(EASL_G)
  expect_identical(sum(easl_paths(seen) == paste0("/matches/", EASL_G)), 1L)
  raw <- .easl_get(paste0("/matches/", EASL_G, "/boxscore"))
  expect_identical(raw[["_request"]], list(fixture_id = EASL_G))
})

test_that("an unfinished, foreign or unscored header is refused", {
  hdr <- easl_body("game.json")
  for (patch in list(list(status = "SCHEDULED"), list(status = "DRAFT"),
                     list(fixtureId = "bde3aaa1-da50-11ef-97fd-97d4eecf418b"))) {
    local_easl(stats::setNames(list(utils::modifyList(hdr, patch)), paste0("/matches/", EASL_G)))
    expect_error(easl_player_box(EASL_G), class = "hoopR_asset_fetch")
  }
  h <- hdr
  h$competitors[[1]]["score"] <- list(NULL)
  local_easl(stats::setNames(list(h), paste0("/matches/", EASL_G)))
  expect_error(easl_game(EASL_G), class = "hoopR_asset_fetch", regexp = "two scored")
})

test_that("a box score must belong to the fixture and add up to its score", {
  route <- paste0("/matches/", EASL_G, "/boxscore")
  box <- easl_body("boxscore.json")
  b <- box
  b$boxScore[[1]]$statistics$points <- b$boxScore[[1]]$statistics$points + 2L
  local_easl(stats::setNames(list(b), route))
  expect_error(easl_player_box(EASL_G), class = "hoopR_asset_fetch", regexp = "player points")
  b <- box
  b$boxScore <- Filter(function(r) identical(r$entityId, EASL_T), b$boxScore)
  local_easl(stats::setNames(list(b), route))
  expect_error(easl_player_box(EASL_G), class = "hoopR_asset_fetch")
  b <- box
  b$boxScore[[3]]$fixtureId <- "bde3aaa1-da50-11ef-97fd-97d4eecf418b"
  local_easl(stats::setNames(list(b), route))
  expect_error(easl_player_box(EASL_G), class = "hoopR_asset_fetch", regexp = "another fixture")
})

test_that("a play-by-play must end on the final score in the final period of the period table", {
  route <- paste0("/matches/", EASL_G, "/playbyplay")
  pbp <- easl_body("playbyplay.json")
  p <- pbp
  p$playbyplay <- p$playbyplay[seq_len(length(p$playbyplay) - 6L)]
  local_easl(stats::setNames(list(p), route))
  expect_error(easl_pbp(EASL_G), class = "hoopR_asset_fetch", regexp = "final score")
  p <- pbp
  p$playbyplay[[length(p$playbyplay)]]$periodId <- 3L
  local_easl(stats::setNames(list(p), route))
  expect_error(easl_pbp(EASL_G), class = "hoopR_asset_fetch", regexp = "final period")
  p <- pbp
  p$teams[[1]]$teamId <- EASL_OTHER
  local_easl(stats::setNames(list(p), route))
  expect_error(easl_pbp(EASL_G), class = "hoopR_asset_fetch", regexp = "not this fixture")
  per <- lapply(easl_body("teamstats_period.json"), function(r) c(r, list(period_5 = list(points = 0L))))
  local_easl(stats::setNames(list(per), paste0("/matches/", EASL_G, "/teamstats/by/period")))
  expect_error(easl_pbp(EASL_G), class = "hoopR_asset_fetch", regexp = "period table")
})

test_that("team totals and the period table must add up to the score", {
  ts <- easl_body("teamstats.json")
  ts[[1]]$statistics$points <- ts[[1]]$statistics$points + 1L
  per <- easl_body("teamstats_period.json")
  per[[1]]$period_2$points <- per[[1]]$period_2$points + 1L
  local_easl(stats::setNames(list(ts, per), paste0("/matches/", EASL_G, c("/teamstats", "/teamstats/by/period"))))
  expect_error(easl_team_box(EASL_G), class = "hoopR_asset_fetch", regexp = "team points")
  expect_error(easl_team_box_by_period(EASL_G), class = "hoopR_asset_fetch", regexp = "period points")
})

test_that("error envelopes and error statuses are hoopR_asset_fetch; 404 is hoopR_no_data", {
  envelope <- list(error = "Internal server error")
  for (status in c(200L, 400L, 422L, 500L, 403L)) {
    local_easl(list("/health" = easl_resp(envelope, status)))
    err <- tryCatch(easl_health(), hoopR_error = function(e) e)
    expect_s3_class(err, "hoopR_asset_fetch")
    if (status != 200L) expect_identical(err$status, status)
  }
  local_easl(list("/standings" = easl_resp(list(message = "not found"), 404L)))
  expect_error(easl_standings(season = 2026), class = "hoopR_no_data")
  local_easl(list("/teams" = list(data = list(), `next` = "x")))
  expect_error(easl_teams(), class = "hoopR_asset_fetch", regexp = "paging")
  local_easl(list("/teams" = "", "/health" = "true"))
  expect_error(easl_teams(), class = "hoopR_asset_fetch", regexp = "empty body")
  expect_error(easl_health(), class = "hoopR_asset_fetch", regexp = "expected a JSON object")
})

test_that("a 500 is not retried; 502 / 503 are, and every attempt waits its turn", {
  route <- paste0("/matches/", EASL_G)
  seen <- local_easl(stats::setNames(list(easl_resp(list(error = "x"), 500L)), route))
  expect_error(easl_game(EASL_G), class = "hoopR_asset_fetch")
  expect_identical(sum(easl_paths(seen) == route), 1L)
  seen <- local_easl(list("/teams" = easl_turns(easl_resp("{}", 503L), easl_resp("{}", 502L), "teams.json")))
  expect_identical(nrow(easl_teams()), 3L)
  expect_identical(length(seen$waits), 3L)
  expect_true(all(startsWith(vapply(seen$waits, function(w) w$url, ""), EASL_API)))
  seen <- local_easl(list("/teams" = easl_turns(easl_resp("{}", 429L, list(`Retry-After` = "7")), "teams.json")))
  easl_teams()
  expect_gte(seen$waits[[2]]$interval, 7)
})

test_that("standings, leaders and team fixtures are tied to the season and team asked for", {
  st <- easl_body("standings_2026.json")
  st[[1]]$lastFiveMatches[[1]]$startTimeUTC <- "2024-01-01T10:00:00"
  local_easl(list("/standings" = st))
  expect_error(easl_standings(season = 2026), class = "hoopR_asset_fetch", regexp = "outside the season")
  ld <- easl_body("leaders_2026.json")
  ld$pointsPerGame[[2]]$seasonId <- EASL_S[["2025"]]
  local_easl(list("/leaders" = ld))
  expect_error(easl_leaders(season = 2026), class = "hoopR_asset_fetch", regexp = "another season")
  local_easl()
  expect_error(easl_team_leaders(EASL_T, season = 2025), class = "hoopR_asset_fetch", regexp = "another season or team")
  local_easl(stats::setNames(list("team_leaders_2026.json"), paste0("/teams/", EASL_OTHER, "/leaders")))
  expect_error(easl_team_leaders(EASL_OTHER, season = 2026), class = "hoopR_asset_fetch",
               regexp = "another season or team")
  route <- paste0("/teams/", EASL_T, "/matches")
  rows <- easl_body("team_matches_2026.json")
  local_easl()
  expect_error(easl_team_schedule(EASL_T, season = 2025), class = "hoopR_asset_fetch", regexp = "neither")
  r <- rows
  r[[1]]$stage <- stats::setNames(list(), character())
  local_easl(stats::setNames(list(r), route))
  expect_error(easl_team_schedule(EASL_T, season = 2026), class = "hoopR_asset_fetch", regexp = "neither")
  r <- lapply(rows, function(x) utils::modifyList(x, list(seasonId = EASL_S[["2026"]], stage = NULL)))
  local_easl(stats::setNames(list(r), route))
  expect_identical(easl_team_schedule(EASL_T, season = 2026)$season_id, rep(EASL_S[["2026"]], 3))
  r <- rows
  r[[1]]$competitors[[1]]$teamId <- r[[1]]$competitors[[2]]$teamId
  local_easl(stats::setNames(list(r), route))
  expect_error(easl_team_schedule(EASL_T, season = 2026), class = "hoopR_asset_fetch", regexp = "does not involve")
})

test_that("team and player stats are tied by a games count; entity routes check the id they echo", {
  route <- paste0("/teams/", EASL_T, "/stats")
  body <- easl_body("team_stats_2026.json")
  local_easl(stats::setNames(list(utils::modifyList(body, list(games = 0L))), route))
  expect_error(easl_team_stats(EASL_T, season = 2026), class = "hoopR_no_data")
  local_easl(stats::setNames(list(body[names(body) != "games"]), route))
  expect_error(easl_team_stats(EASL_T, season = 2026), class = "hoopR_asset_fetch", regexp = "games")
  route <- paste0("/players/", EASL_PL, "/stats")
  body <- easl_body("player_stats.json")
  seen <- local_easl()
  expect_identical(.easl_get(route)[["_request"]], list(player_id = EASL_PL))
  expect_null(httr2::url_parse(seen$reqs[[1]]$url)$query)
  local_easl(stats::setNames(list(utils::modifyList(body, list(games = 0L))), route))
  expect_error(easl_player_stats(EASL_PL), class = "hoopR_no_data")
  local_easl(stats::setNames(list(list(unrelated = 1L)), route))
  expect_error(easl_player_stats(EASL_PL), class = "hoopR_asset_fetch", regexp = "games")
  local_easl(stats::setNames(list("team.json", "player.json"), paste0(c("/teams/", "/players/"), EASL_OTHER)))
  expect_error(easl_team(EASL_OTHER), class = "hoopR_asset_fetch", regexp = "teamId")
  expect_error(easl_player(EASL_OTHER), class = "hoopR_asset_fetch", regexp = "playerId")
})

test_that("directories are the EASL organisation and every player row has a playerId", {
  rows <- easl_body("teams.json")
  rows[[1]]$organizationId <- "zzzzz"
  local_easl(list("/teams" = rows))
  expect_error(easl_teams(), class = "hoopR_asset_fetch", regexp = "organisation")
  local_easl(list("/players" = list(list(playerId = NULL))))
  expect_error(easl_players(), class = "hoopR_asset_fetch", regexp = "playerId")
  seasons <- lapply(easl_body("seasons.json"), function(r) utils::modifyList(r, list(status = "COMPLETE")))
  local_easl(list("/metadata/seasons" = seasons))
  expect_error(easl_seasons(), class = "hoopR_asset_fetch", regexp = "ACTIVE")
})

test_that("live: the sync server answers the seasons list and a finished game", {
  skip_intl_live()
  .easl_clear_cache()
  seasons <- easl_seasons()
  expect_true(all(c(2024L, 2025L, 2026L, 2027L) %in% seasons$season))
  box <- easl_player_box(EASL_G)
  expect_identical(sum(box$points[box$team_id == EASL_T]), 90L)
})
