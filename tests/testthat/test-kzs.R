# Offline tests of the KZS family: R/kzs.R, R/kzs_runtime.R, R/kzs_parsers.R. Every request is mocked through
# httr2, so the envelope, the season mapping, the dependency requests, the retries and the error vocabulary run end
# to end; the throttle is recorded, never slept. Parity: tests/testthat/fixtures/kzs/parity/<case>.csv is sdv-py's
# frame of the same wrapper on the same fixtures (see fixtures/kzs/README.md).

withr::local_options(list(cli.width = 10000), .local_envir = testthat::teardown_env())

kzs_fixture <- function(...) test_path("fixtures", "kzs", ...)
kzs_text <- function(name) {
  con <- if (endsWith(name, ".gz")) gzfile(kzs_fixture(name), encoding = "UTF-8") else
    file(kzs_fixture(name), encoding = "UTF-8")
  on.exit(close(con))
  paste(readLines(con, warn = FALSE), collapse = "\n")
}
kzs_body <- function(name) jsonlite::parse_json(kzs_text(name), simplifyVector = FALSE)
kzs_json <- function(x) {
  as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA, always_decimal = TRUE))
}

kzs_resp <- function(body, status = 200L, ctype = "application/json") {
  text <- if (is.character(body)) body else kzs_json(body)
  httr2::response(status, headers = list(`Content-Type` = ctype), body = charToRaw(enc2utf8(text)))
}
#' A fixture as the API sends it, `mutate(data)` applied to its `data`.
kzs_ok <- function(name, mutate = NULL) {
  body <- kzs_body(name)
  if (!is.null(mutate)) body$data <- mutate(body$data)
  kzs_resp(body)
}
kzs_route <- function(req) sub("^.*/api/v1/public", "", httr2::url_parse(req$url)$path)

# Mock the transport. `routes` maps a route (the path after /public) to a fixture name, a response, a list of
# responses (one per attempt, the last repeated) or a function(req). `seen` records every request and sleep. The
# dependency cache and the throttle clock are cleared.
local_kzs <- function(routes = list(), env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$sleeps <- numeric()
  rm(list = ls(.intl_clock), envir = .intl_clock)
  .kzs_clear_cache()
  withr::defer(.kzs_clear_cache(), envir = env)
  withr::local_options(list(hoopR.proxy = NULL), .local_envir = env)
  local_mocked_bindings(
    .intl_sleep = function(seconds) seen$sleeps <- c(seen$sleeps, seconds),
    .intl_now = function() sum(seen$sleeps), # the clock moves only by what was slept
    .package = "hoopR", .env = env
  )
  httr2::local_mocked_responses(function(req) {
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    route <- kzs_route(req)
    answer <- routes[[route]]
    if (is.null(answer)) stop("unexpected request: ", route)
    if (is.function(answer)) return(answer(req))
    if (is.character(answer)) return(kzs_ok(answer))
    if (inherits(answer, "httr2_response")) return(answer)
    n <- sum(vapply(seen$reqs, kzs_route, "") == route)
    answer[[min(n, length(answer))]]
  }, env = env)
  seen
}
kzs_query <- function(req) httr2::url_parse(req$url)$query %||% list()
kzs_flat_query <- function(q) paste(names(q), vapply(q, as.character, ""), sep = "=", collapse = "&")

KZS_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character")
kzs_types <- function(df) vapply(df, function(x) if (is.double(x)) "numeric" else class(x)[[1]], character(1))

# cells that differ, NA-vs-value counted as a mismatch
kzs_mismatches <- function(got, want_chr) {
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
kzs_parity <- function(case) {
  name <- if (case == "pbp") "pbp.csv.gz" else paste0(case, ".csv")
  # a path, not a re-encoding connection: file() reads the gzip too, and encoding = marks UTF-8 in any locale
  utils::read.csv(kzs_fixture("parity", name), colClasses = "character", na.strings = "<null>", check.names = FALSE, encoding = "UTF-8")
}

test_that("every wrapper matches sdv-py's frame on the same bodies (columns, order, dtypes, cells, requests)", {
  dtypes <- jsonlite::read_json(kzs_fixture("parity", "dtypes.json"))
  cases <- jsonlite::read_json(kzs_fixture("parity", "requests.json"))
  wrappers <- grep("^kzs_", getNamespaceExports("hoopR"), value = TRUE)
  expect_length(wrappers, 23L)
  expect_setequal(unique(vapply(cases, function(x) x$fn, "")), wrappers)
  for (case in names(cases)) {
    spec <- cases[[case]]
    seen <- local_kzs(spec$routes)
    got <- do.call(spec$fn, spec$args)
    want <- kzs_parity(case)
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    want_types <- stats::setNames(unname(KZS_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    expect_identical(kzs_types(got), want_types, label = case)
    bad <- vapply(names(got), function(n) kzs_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same requests sdv-py sends, in the same order: URL and query
    expect_identical(length(seen$reqs), length(spec$requests), label = case)
    for (i in seq_along(spec$requests)) {
      req <- seen$reqs[[i]]
      w <- spec$requests[[i]]
      expect_identical(req$method %||% "GET", "GET", label = case)
      expect_identical(sub("\\?.*$", "", req$url), w$url, label = case)
      expect_identical(kzs_flat_query(kzs_query(req)), kzs_flat_query(w$query), label = case)
    }
  }
})

test_that("every id column is an integer and the documented columns come first", {
  seen <- local_kzs(list(`/matches/101839` = "match_101839.json"))
  df <- kzs_match(101839)
  ids <- grep("(^|_)id$", names(df), value = TRUE)
  expect_true(length(ids) > 10)
  for (col in ids) expect_type(df[[col]], "integer")
  expect_identical(names(df)[seq_along(.kzs_dtypes$match)], names(.kzs_dtypes$match))
  expect_identical(df$genius_match_id, 2698579L)
})

test_that("an empty body parses to a zero-row tibble with the documented columns and types", {
  codes <- c(i = "integer", f = "numeric", b = "logical", s = "character")
  for (kind in names(.kzs_dtypes)) {
    for (raw in list(list(), list(items = list()), NULL, "x")) {
      df <- .kzs_parse(kind, raw)
      expect_identical(nrow(df), 0L, label = kind)
      expect_identical(names(df), names(.kzs_dtypes[[kind]]), label = kind)
      expect_identical(kzs_types(df), stats::setNames(unname(codes[.kzs_dtypes[[kind]]]), names(df)), label = kind)
    }
  }
})

test_that("lists are written as Python's json.dumps writes them", {
  x <- jsonlite::parse_json('{"a": [1, 1.0, 2.5, 1e-05, 1e16, null, true, "\\u010c\\"\\n"], "b": {}, "c": []}',
                            simplifyVector = FALSE)
  expect_identical(.kzs_dumps(x), '{"a": [1, 1.0, 2.5, 1e-05, 1e+16, null, true, "\u010c\\"\\n"], "b": {}, "c": []}')
  expect_identical(.kzs_py_float(0.1), "0.1")
  expect_identical(.kzs_py_float(123456.789), "123456.789")
  expect_identical(.kzs_py_float(-0.00012), "-0.00012")
})

# --- the season ------------------------------------------------------------------------------------------------------

test_that("an END year maps to the opaque season id; anything else is refused before any request", {
  ends <- c(2027, 2026, 2001, 2030, 2000, 1992)
  sids <- c(27L, 26L, 1L, 30L, 39L, 31L)
  for (i in seq_along(ends)) expect_identical(.kzs_season_id(ends[[i]]), sids[[i]])
  expect_identical(.kzs_season_id("2027"), 27L)
  expect_length(.KZS_SEASON_IDS, 39L)
  seen <- local_kzs()
  for (bad in list(TRUE, "abc", "2027.5", 1991, 2031, 0, 26.5)) {
    expect_error(kzs_competitions(season = bad), class = "hoopR_bad_request")
    expect_error(kzs_player_stats(106285, season = bad), class = "hoopR_bad_request")
  }
  expect_length(seen$reqs, 0L)
})

test_that("the season is sent as seasonId and stamped as both; an empty season sends none", {
  seen <- local_kzs(list(`/competitions/` = "competitions_s26.json"))
  raw <- .kzs_get("/competitions/", query = list(limit = 10000L, season = 2026))
  expect_identical(kzs_query(seen$reqs[[1]]), list(limit = "10000", seasonId = "26"))
  expect_identical(raw[["_request"]], list(season_id = 26L, season = 2026L))
  seen <- local_kzs(list(`/competitions/` = "competitions.json"))
  expect_identical(nrow(kzs_competitions()), 3L)
  expect_identical(kzs_query(seen$reqs[[1]]), list(limit = "10000"))
})

test_that("the envelope is unwrapped and a bare list is wrapped as items", {
  seen <- local_kzs(list(`/matches/579/playingDays` = "days_579.json", `/competitions/579` = "competition_579.json"))
  raw <- .kzs_get("/matches/{competition_id}/playingDays", ids = list(competition_id = 579L))
  expect_named(raw, c("items", "_request"))
  expect_length(raw$items, 3L)
  expect_identical(raw[["_request"]], list(competition_id = 579L))
  expect_identical(kzs_playing_days(579)$competition_id, rep(579L, 3))
})

# --- transport and the error vocabulary ------------------------------------------------------------------------------

test_that("every attempt waits its turn (dependency requests too) and HTTP 500 is retried", {
  seen <- local_kzs(list(`/matches/101839/stats` = "stats_101839.json", `/matches/101839` = "match_101839.json"))
  kzs_box_score(101839)
  expect_length(seen$reqs, 2L)
  expect_identical(seen$sleeps, 1) # the header request waited a second after the box score
  seen <- local_kzs(list(`/teams/17551` = list(kzs_resp("oops", 500L), kzs_ok("team_17551.json"))))
  expect_identical(kzs_team(17551)$team_id, 17551L)
  expect_length(seen$reqs, 2L)
})

test_that("HTTP 400 is hoopR_asset_fetch with the API's message, never hoopR_bad_request, and is not retried", {
  bodies <- list(
    list(status = "INVALID_REQUEST", errorMessage = "Match with id 99999999 does not exist"),
    list(status = "VALIDATION_ERROR", validationErrorDetails = list(fieldErrors = list(statsCategory = "must not be null")))
  )
  for (body in bodies) {
    seen <- local_kzs(list(`/matches/99999999` = kzs_resp(body, 400L)))
    err <- expect_error(kzs_match(99999999), class = "hoopR_asset_fetch")
    expect_false(inherits(err, "hoopR_bad_request"))
    expect_identical(err$status, 400L)
    expect_match(conditionMessage(err), "400")
    expect_match(conditionMessage(err), "does not exist|fieldErrors")
    expect_false(grepl("?", conditionMessage(err), fixed = TRUE))
    expect_length(seen$reqs, 1L)
  }
})

test_that("404 is hoopR_no_data; 5xx, non-JSON and empty bodies are hoopR_asset_fetch", {
  local_kzs(list(`/teams/1` = kzs_resp("no", 404L)))
  expect_error(kzs_team(1), class = "hoopR_no_data")
  seen <- local_kzs(list(`/teams/1` = kzs_resp("bad gateway", 502L)))
  err <- expect_error(kzs_team(1), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_length(seen$reqs, 3L)
  for (answer in list(kzs_resp("<html>"), kzs_resp(""))) {
    local_kzs(list(`/teams/1` = answer))
    expect_error(kzs_team(1), class = "hoopR_asset_fetch")
  }
})

test_that("an envelope that is not OK is refused; an empty answer is hoopR_no_data", {
  bad <- list(
    list(status = "INVALID_REQUEST", errorMessage = "x", data = list(id = 1L)), list(status = "OK"),
    list(data = list(id = 1L)), list(status = TRUE, data = list(id = 1L)), list(list(id = 1L))
  )
  for (body in bad) {
    local_kzs(list(`/teams/1` = kzs_resp(body)))
    expect_error(kzs_team(1), class = "hoopR_asset_fetch")
  }
  local_kzs(list(`/teams/` = kzs_resp(list(status = "OK", data = list(items = list(), count = 0L)))))
  expect_error(kzs_teams(579), class = "hoopR_no_data")
  local_kzs(list(`/teams/1` = '{"status": "OK", "data": {}}' |> kzs_resp()))
  expect_error(kzs_team(1), class = "hoopR_no_data")
  local_kzs(list(`/teams/1` = '{"status": "OK", "data": null}' |> kzs_resp()))
  expect_error(kzs_team(1), class = "hoopR_no_data")
})

test_that("a bad id or choice is hoopR_bad_request before any request", {
  seen <- local_kzs()
  expect_error(kzs_teams("five"), class = "hoopR_bad_request")
  expect_error(kzs_match(-1), class = "hoopR_bad_request")
  expect_error(kzs_team(1.5), class = "hoopR_bad_request")
  expect_error(kzs_player_leaderboard(579, stats_category = "XYZ"), "stats_category", class = "hoopR_bad_request")
  expect_error(kzs_team_leaderboard(579, sort_by = "name"), "sort_by", class = "hoopR_bad_request")
  expect_error(kzs_matches(579, date_from = 20251001), class = "hoopR_bad_request")
  expect_length(seen$reqs, 0L)
})

# --- truncated pages -------------------------------------------------------------------------------------------------

test_that("a full page is cut and refused, and the API's silent default cap is 150", {
  local_kzs(list(`/matches/` = "matches_579_2025-10.json"))
  expect_error(.kzs_get("/matches/", query = list(competitionId = 579L, limit = 3L)), "truncated page",
               class = "hoopR_asset_fetch")
  rows <- lapply(seq_len(150), function(i) list(id = i, competitions = list(list(competitionId = 579L))))
  local_kzs(list(`/matches/` = kzs_resp(list(status = "OK", data = list(items = rows)))))
  expect_error(.kzs_get("/matches/", query = list(competitionId = 579L)), "limit=150", class = "hoopR_asset_fetch")
  local_kzs(list(`/matches/` = "matches_579_2025-10.json"))
  expect_length(.kzs_get("/matches/", query = list(competitionId = 579L, limit = 1000L))$items, 3L)
})

# --- scope: the body must be the one asked for ------------------------------------------------------------------------

kzs_assign <- function(x, keys, value) {
  k <- keys[[1]]
  if (length(keys) == 1L) {
    x[k] <- list(value) # a NULL value stays as a JSON null
    return(x)
  }
  x[[k]] <- kzs_assign(x[[k]], keys[-1], value)
  x
}
#' A mutation setting `path` ("items.0.season.id", 0-based list positions) to `value`.
kzs_set <- function(path, value) {
  keys <- lapply(strsplit(path, ".", fixed = TRUE)[[1]], function(k) if (grepl("^[0-9]+$", k)) as.integer(k) + 1L else k)
  function(data) kzs_assign(data, keys, value)
}
KZS_SCOPE <- list(
  # call, fixture route, fixture, mutation, dependencies, needle
  list(quote(kzs_competition(579)), "/competitions/579", "competition_579.json", kzs_set("id", 30L), list(),
       "asked for competition 579"),
  list(quote(kzs_competition(579)), "/competitions/579", "competition_579.json", kzs_set("id", TRUE), list(),
       "competition 579"),
  list(quote(kzs_competition(579)), "/competitions/579", "competition_579.json", kzs_set("id", 579), list(),
       "competition 579"),
  list(quote(kzs_match(101839)), "/matches/101839", "match_101839.json", kzs_set("id", 62586L), list(),
       "asked for match 101839"),
  list(quote(kzs_team(17551)), "/teams/17551", "team_17551.json", kzs_set("id", 1L), list(), "asked for team 17551"),
  list(quote(kzs_player(106285)), "/players/106285", "player_106285.json", kzs_set("id", 2L), list(),
       "asked for player 106285"),
  list(quote(kzs_competitions(season = 2026)), "/competitions/", "competitions_s26.json",
       kzs_set("items.3.season.id", 25L), list(), "seasonId=26"),
  list(quote(kzs_matches(579)), "/matches/", "matches_579_2025-10.json",
       kzs_set("items.1.competitions.0.competitionId", 584L), list(), "not in competition 579"),
  list(quote(kzs_matches(579, "2025-10-01T00:00:00.000Z", "2025-10-31T23:59:59.000Z")), "/matches/",
       "matches_579_2025-10.json", kzs_set("items.0.dateTime", "2025-11-02T18:00:00Z"), list(), "outside"),
  list(quote(kzs_matches(579, "2025-10-01T00:00:00.000Z")), "/matches/", "matches_579_2025-10.json",
       kzs_set("items.0.dateTime", NULL), list(), "no dateTime"),
  list(quote(kzs_standings(579)), "/matches/standings", "standings_579.json", kzs_set("competition.id", 30L), list(),
       "competitionId=579"),
  list(quote(kzs_teams(579)), "/teams/", "teams_579.json", kzs_set("items.0.id", 1L),
       list(`/matches/standings` = "standings_579.json"), "not in competition 579"),
  list(quote(kzs_player_leaderboard(579)), "/competitions/579/playerStats", "player_board_579.json",
       kzs_set("items.0.teamId", 1L), list(`/matches/standings` = "standings_579.json"), "not in competition 579"),
  list(quote(kzs_rounds(579)), "/competitions/579/rounds", "rounds_579.json", kzs_set("phases.0.id", 9L),
       list(`/competitions/579` = "competition_579.json"), "not the competition's"),
  list(quote(kzs_playing_days(579)), "/matches/579/playingDays", "days_579.json", kzs_set("0.date", "2031-01-01"),
       list(`/competitions/579` = "competition_579.json"), "outside competition 579"),
  list(quote(kzs_player_stats(106285, 2026)), "/players/106285/stats", "player_stats_106285_26.json",
       kzs_set("competitionStats.0.competitionId", 1L), list(`/competitions/` = "competitions_s26.json"),
       "not in season 26")
)

test_that("a body for another competition, match, team, player or season is refused", {
  for (case in KZS_SCOPE) {
    routes <- c(stats::setNames(list(kzs_ok(case[[3]], case[[4]])), case[[2]]), case[[5]])
    local_kzs(routes)
    expect_error(eval(case[[1]]), case[[6]], fixed = TRUE, class = "hoopR_asset_fetch", label = deparse(case[[1]]))
  }
})

test_that("a dependency for another competition is refused", {
  local_kzs(list(`/competitions/579/rounds` = "rounds_579.json",
                 `/competitions/579` = kzs_ok("competition_579.json", kzs_set("id", 30L))))
  expect_error(kzs_rounds(579), "the header answered id 30", class = "hoopR_asset_fetch")
  local_kzs(list(`/teams/` = "teams_579.json",
                 `/matches/standings` = kzs_ok("standings_579.json", kzs_set("competition.id", 30L))))
  expect_error(kzs_teams(579), "standings dependency is another competition", class = "hoopR_asset_fetch")
})

test_that("a leaderboard must be in the order asked; the competition id is sent from the path", {
  reverse <- function(data) {
    data$items <- rev(data$items)
    data
  }
  local_kzs(list(`/competitions/579/teamStats` = kzs_ok("team_board_579.json", reverse),
                 `/matches/standings` = "standings_579.json"))
  expect_error(kzs_team_leaderboard(579), "not ordered DESC by average", class = "hoopR_asset_fetch")
  seen <- local_kzs(list(`/competitions/579/teamStats` = kzs_ok("team_board_579.json", reverse),
                         `/matches/standings` = "standings_579.json"))
  df <- kzs_team_leaderboard(579, sort = "ASC")
  expect_identical(df$average, sort(df$average))
  expect_identical(kzs_query(seen$reqs[[1]])$competitionId, "579")
  local_kzs(list(`/competitions/579/teamStats` = kzs_ok("team_board_579.json", kzs_set("items.0.average", "x")),
                 `/matches/standings` = "standings_579.json"))
  expect_error(kzs_team_leaderboard(579), "without a numeric average", class = "hoopR_asset_fetch")
})

test_that("standings without rows are hoopR_no_data", {
  empty <- function(data) {
    data$phases <- lapply(data$phases, function(p) {
      p$standings <- list()
      p$groups <- list()
      p
    })
    data
  }
  local_kzs(list(`/matches/standings` = kzs_ok("standings_579.json", empty)))
  expect_error(kzs_standings(579), "no standings rows", class = "hoopR_no_data")
})

# --- play-by-play and box score --------------------------------------------------------------------------------------

test_that("a game that is not final is refused on the stat routes but not by the header route", {
  live <- kzs_ok("match_101839.json", kzs_set("status", "LIVE"))
  local_kzs(list(`/matches/101839` = live, `/matches/101839/stats` = "stats_101839.json",
                 `/matches/101839/playByPlay` = "pbp_101839.json.gz"))
  expect_error(kzs_box_score(101839), "not final", class = "hoopR_asset_fetch")
  expect_error(kzs_pbp(101839), "not final", class = "hoopR_asset_fetch")
  expect_identical(kzs_match(101839)$status, "LIVE")
})

test_that("the finished header is fetched once and cached for the session", {
  seen <- local_kzs(list(`/matches/101839` = "match_101839.json", `/matches/101839/stats` = "stats_101839.json",
                         `/matches/101839/playByPlay` = "pbp_101839.json.gz"))
  kzs_box_score(101839)
  kzs_team_box_score(101839)
  kzs_pbp_players(101839)
  routes <- vapply(seen$reqs, kzs_route, "")
  expect_identical(sum(routes == "/matches/101839"), 1L)
  expect_length(routes, 4L)
})

test_that("play-by-play: no actions is hoopR_no_data; another match or the wrong home/away order is refused", {
  header <- list(`/matches/101839` = "match_101839.json")
  none <- function(data) {
    data$actions <- list()
    data
  }
  local_kzs(c(list(`/matches/101839/playByPlay` = kzs_ok("pbp_101839.json.gz", none)), header))
  expect_error(kzs_pbp(101839), "no play-by-play", class = "hoopR_no_data")
  other <- function(data) {
    data$actions[[1]]$matchTeamId <- 1L
    data
  }
  local_kzs(c(list(`/matches/101839/playByPlay` = kzs_ok("pbp_101839.json.gz", other)), header))
  expect_error(kzs_pbp(101839), "is not match 101839's", class = "hoopR_asset_fetch")
  swap <- function(data) {
    first <- data$firstTeamPlayers
    data$firstTeamPlayers <- data$secondTeamPlayers
    data$secondTeamPlayers <- first
    data
  }
  local_kzs(c(list(`/matches/101839/playByPlay` = kzs_ok("pbp_101839.json.gz", swap)), header))
  expect_error(kzs_pbp(101839), "home/away order is wrong", class = "hoopR_asset_fetch")
  one <- function(data) {
    team <- data$actions[[1]]$matchTeamId
    data$actions <- Filter(function(a) is.null(a$matchTeamId) || identical(a$matchTeamId, team), data$actions)
    data
  }
  local_kzs(c(list(`/matches/101839/playByPlay` = kzs_ok("pbp_101839.json.gz", one)), header))
  expect_error(kzs_pbp(101839), "not both of match 101839's", class = "hoopR_asset_fetch")
})

test_that("box score: another match or swapped teams is refused; no player lines is hoopR_no_data", {
  header <- list(`/matches/101839` = "match_101839.json")
  local_kzs(c(list(`/matches/101839/stats` = kzs_ok("stats_101839.json", kzs_set("matchId", 62586L))), header))
  expect_error(kzs_box_score(101839), "asked for match 101839", class = "hoopR_asset_fetch")
  swap <- function(data) {
    first <- data$firstTeam
    data$firstTeam <- data$secondTeam
    data$secondTeam <- first
    data
  }
  local_kzs(c(list(`/matches/101839/stats` = kzs_ok("stats_101839.json", swap)), header))
  expect_error(kzs_team_box_score(101839), "home/away order", class = "hoopR_asset_fetch")
  local_kzs(c(list(`/matches/101839/stats` = kzs_ok("stats_101839.json", kzs_set("secondTeam.playerStats", list()))),
              header))
  expect_error(kzs_score_changes(101839), "no box score", class = "hoopR_no_data")
})

test_that("the play-by-play keeps the home/away side, the action order and the integer scores", {
  local_kzs(list(`/matches/101839/playByPlay` = "pbp_101839.json.gz", `/matches/101839` = "match_101839.json"))
  df <- kzs_pbp(101839)
  expect_identical(df$action_number, seq_len(816L))
  expect_setequal(stats::na.omit(df$team_side), c("home", "away"))
  expect_type(df$score1, "integer")
  last <- df[nrow(df), ]
  expect_identical(c(last$score1, last$score2), c(95L, 93L))
})

# --- live (HOOPR_INTL_LIVE_TESTS=1) ----------------------------------------------------------------------------------

test_that("live: the seasons list is the 39 seasons the runtime maps", {
  skip_intl_live()
  .kzs_clear_cache()
  df <- kzs_seasons()
  expect_identical(nrow(df), 39L)
  expect_setequal(df$season_id, unname(.KZS_SEASON_IDS))
  expect_identical(df$season[match(26L, df$season_id)], 2026L)
})
