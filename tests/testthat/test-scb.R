# Offline tests of the BBL / DBBL (SCB API) family: R/scb.R, R/scb_runtime.R, R/scb_parsers.R.
# Every request is mocked through httr2 (the key page and the API), so the auth headers, the
# re-derive, the redirect policy and the error vocabulary run end to end; sleeps are recorded,
# never slept. Parity: tests/testthat/fixtures/scb/parity/<case>.csv is sdv-py's frame of the same
# wrapper on the same fixture (see fixtures/scb/README.md).

skip_if_no_intl_fixtures("scb")

scb_fixture <- function(...) test_path("fixtures", "scb", ...)
scb_text <- function(rel) paste(readLines(scb_fixture(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")

SCB_KEY <- paste0(strrep("k", 20), "a:b", strrep("c", 20)) # a colon: the secret turns it into "-"
SCB_SECRET <- gsub(":", "-", paste(rev(strsplit(SCB_KEY, "")[[1]]), collapse = ""), fixed = TRUE)
# a React key first (too short to be the API key), then the API key inside a JSON-escaped script
SCB_PAGE <- paste0('<div>{"key":"row-1"}</div><script>self.__next_f.push([1,"{\\"key\\":\\"', SCB_KEY,
                   '\\"}"])</script>')

# Mock the key page and the API. `api` is a function(req) returning an httr2 response; `seen`
# records every request. The throttle is mocked and the cached secret is cleared before and after.
local_scb <- function(api, page = SCB_PAGE, env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$pages <- 0L
  local_intl_clock(env)
  rm(list = ls(.scb_auth), envir = .scb_auth)
  withr::defer(rm(list = ls(.scb_auth), envir = .scb_auth), envir = env)
  local_mocked_bindings(.intl_sleep = function(seconds) NULL, .intl_now = function() 0, .env = env)
  httr2::local_mocked_responses(function(req) {
    if (startsWith(req$url, .SCB_KEY_PAGE)) {
      seen$pages <- seen$pages + 1L
      return(httr2::response(200, headers = list("Content-Type" = "text/html"), body = charToRaw(page)))
    }
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    api(req)
  }, env = env)
  seen
}

json_resp <- function(body, status = 200L) {
  text <- if (is.character(body)) body else as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null"))
  httr2::response(status, headers = list("Content-Type" = "application/json"), body = charToRaw(enc2utf8(text)))
}
fixture_resp <- function(rel) function(req) json_resp(scb_text(rel))

# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator)
SCB_CASES <- list(
  scb_seasons = list("bbl/seasons.json", list()),
  scb_season_players = list("bbl/seasons__seasonId__2026.json", list(season = 2027)),
  scb_season_teams = list("bbl/seasons__seasonId__2026.json", list(season = 2027)),
  scb_playoff_series = list("bbl/seasons__seasonId__playoff-tree__2025.json", list(season = 2026)),
  scb_playoff_games = list("bbl/seasons__seasonId__playoff-tree__2025.json", list(season = 2026)),
  scb_player_statistics = list("full/dbbl_player_statistics_2025.json", list(season = 2026, league = "dbbl")),
  scb_team_statistics = list("full/dbbl_team_statistics_2025.json", list(season = 2026, league = "dbbl")),
  scb_games = list("full/dbbl_games_2024_first40.json", list(league = "dbbl", season = 2025)),
  scb_games_recent = list("bbl/games__recent.json", list()),
  scb_game = list("bbl/games__gameId__2026.json", list(game_id = "2006920")),
  scb_game_players = list("full/bbl_game_stats_2006920.json", list(game_id = "2006920")),
  scb_game_teams = list("full/bbl_game_stats_2006920.json", list(game_id = "2006920")),
  scb_game_actions = list("full/bbl_game_stats_2006920.json", list(game_id = "2006920")),
  scb_game_players__2005 = list("bbl/games__gameId__stats__2005.json", list(game_id = "2729")),
  scb_game_teams__2005 = list("bbl/games__gameId__stats__2005.json", list(game_id = "2729")),
  scb_standings = list("dbbl/standings__2024.json", list(league = "dbbl", season = 2025)),
  scb_season_player = list("bbl/season-players__seasonPlayerId.json", list(season_player_id = "56414")),
  scb_team = list("bbl/teams__teamId.json", list(team_id = "413")),
  scb_team_seasons = list("bbl/teams__teamId.json", list(team_id = "413")),
  scb_referees = list("bbl/referees.json", list()),
  scb_transfers = list("bbl/transfers.json", list()),
  scb_transfers_teams = list("bbl/transfers__teams.json", list()),
  scb_team_rosters = list("bbl/transfers__teams.json", list()),
  scb_records_per_game = list("bbl/records__per-game__seasonId__2025.json", list(season = 2026)),
  scb_records_season_averages = list("bbl/records__season-averages.json", list())
)
SCB_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character")

run_case <- function(case, env = parent.frame()) {
  spec <- SCB_CASES[[case]]
  seen <- local_scb(fixture_resp(spec[[1]]), env = env)
  out <- do.call(sub("__.*$", "", case), spec[[2]])
  list(out = out, seen = seen)
}

# cells that differ, NA-vs-value counted as a mismatch
parity_mismatches <- function(got, want_chr) {
  if (is.logical(got)) {
    want <- ifelse(is.na(want_chr), NA, want_chr == "true")
  } else if (is.numeric(got)) {
    want <- suppressWarnings(as.numeric(want_chr))
  } else {
    want <- want_chr
  }
  na_diff <- is.na(got) != is.na(want)
  both <- !is.na(got) & !is.na(want)
  val_diff <- if (is.double(got)) abs(got[both] - want[both]) > 1e-9 else got[both] != want[both]
  sum(na_diff) + sum(val_diff)
}

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, dtypes, cells, request)", {
  dtypes <- jsonlite::read_json(scb_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(scb_fixture("parity", "requests.json"))
  expect_setequal(names(SCB_CASES), names(dtypes))
  for (case in names(SCB_CASES)) {
    res <- run_case(case)
    got <- res$out
    want <- intl_read_oracle(scb_fixture("parity", paste0(case, ".csv")))
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    types <- vapply(got, function(x) if (is.double(x)) "numeric" else class(x)[[1]], character(1))
    want_types <- stats::setNames(unname(SCB_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    expect_identical(types, want_types[names(got)], label = case)
    bad <- vapply(names(got), function(n) parity_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same request sdv-py sends: host, path and query (league picks the host, never sent)
    req <- res$seen$reqs[[1]]
    parts <- httr2::url_parse(req$url)
    want_req <- requests[[case]]
    expect_identical(sub("\\?.*$", "", req$url), want_req$url, label = case)
    flat <- function(q) paste(names(q), vapply(q, as.character, ""), sep = "=", collapse = "&")
    expect_identical(flat(parts$query %||% list()), flat(want_req$query), label = case)
  }
})

test_that("ids keep one type: strings except real_player_id / season_id / action_id / order_id", {
  acts <- run_case("scb_game_actions")$out
  expect_type(acts$game_id, "character")
  expect_type(acts$season_player_id, "character")
  expect_type(acts$action_id, "integer")
  expect_type(acts$order_id, "integer")
  players <- run_case("scb_game_players")$out
  expect_type(players$real_player_id, "integer")
  expect_type(players$season_id, "integer")
  expect_false(any(grepl("\\.0$", players$season_player_id)))
  pg <- run_case("scb_playoff_games")$out # the playoff tree sends integer ids: strings here
  expect_type(pg$game_id, "character")
  expect_type(pg$home_team_id, "character")
  expect_false("player_id" %in% c(names(acts), names(players)))
})

test_that("season is the END year, sent as the START-year seasonId", {
  expect_identical(.scb_season_id(2026), 2025L)
  expect_identical(.scb_season_id(2026L), 2025L)
  expect_identical(.scb_season_id("2026"), 2025L)
  expect_null(.scb_season_id(NULL))
  for (bad in list(0, -1, 2026.5, "x", "20a6", TRUE, NA, c(2025, 2026))) {
    expect_error(.scb_season_id(bad), class = "hoopR_bad_request")
  }
  res <- run_case("scb_season_teams") # season = 2027 -> /seasons/2026
  expect_match(res$seen$reqs[[1]]$url, "/seasons/2026$")
  expect_identical(unique(res$out$season), 2027L)
  expect_identical(unique(res$out$season_id), 2026L)
})

test_that("arguments are checked before any request", {
  seen <- local_scb(function(req) stop("no request expected"))
  expect_error(scb_seasons(league = "nba"), class = "hoopR_bad_request")
  expect_error(scb_seasons(league = NULL), class = "hoopR_bad_request")
  expect_error(scb_player_statistics(season = 2026, display_type = "ALL"), class = "hoopR_bad_request")
  expect_error(scb_games(game_type = "live"), class = "hoopR_bad_request")
  expect_error(scb_game(game_id = c("1", "2")), class = "hoopR_bad_request")
  expect_identical(length(seen$reqs), 0L)
  expect_identical(seen$pages, 0L)
})

test_that("auth: two headers, the secret is the reversed page key, no redirects, scraped once", {
  seen <- local_scb(fixture_resp("bbl/seasons.json"))
  scb_seasons()
  scb_seasons(league = "dbbl")
  expect_identical(seen$pages, 1L)
  req <- seen$reqs[[1]]
  expect_identical(req$headers[["x-api-key"]], "publicWebUser")
  expect_identical(unclass(req$headers[["x-api-secret"]]), SCB_SECRET)
  expect_identical(req$options$followlocation, 0L)
  expect_match(seen$reqs[[2]]$url, "^https://api-1\\.dbbl\\.scb\\.world/seasons")
  expect_identical(.scb_page_key(paste0('"key":"', SCB_KEY, '"')), SCB_KEY) # unescaped page too
  expect_error(.scb_page_key('{"key":"row-1"}'), class = "hoopR_asset_fetch")
  expect_error(.scb_derive_secret("short"), class = "hoopR_asset_fetch")
})

test_that("a refused secret is re-derived once, then refused without leaking it", {
  seen <- local_scb(function(req) json_resp('{"status":"error","error":"No valid api key provided."}', 403L))
  err <- expect_error(scb_seasons(), class = "hoopR_asset_fetch")
  expect_identical(seen$pages, 2L)
  expect_identical(length(seen$reqs), 2L)
  expect_match(conditionMessage(err), "refused the derived x-api-secret")
  expect_false(grepl(SCB_SECRET, conditionMessage(err), fixed = TRUE))
  # a key-page failure is a failed fetch too
  local_scb(function(req) stop("unused"), page = "<html>no key</html>")
  expect_error(scb_seasons(), class = "hoopR_asset_fetch")
})

test_that("an echo of the key or the secret in a body is redacted", {
  local_scb(function(req) json_resp(paste0("server error, secret ", SCB_SECRET, " key ", SCB_KEY), 500L))
  err <- expect_error(scb_seasons(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_false(grepl(SCB_SECRET, conditionMessage(err), fixed = TRUE))
  expect_false(grepl(SCB_KEY, conditionMessage(err), fixed = TRUE))
  expect_match(conditionMessage(err), "<redacted>", fixed = TRUE)
})

test_that("the error vocabulary matches sdv-py", {
  cases <- list(
    list(json_resp("nope", 404L), "hoopR_no_data", "/games/10130"),
    list(httr2::response(204), "hoopR_no_data", "/games/10130"),
    list(json_resp('"not a valid gameId"', 400L), "hoopR_no_data", "/games/10130"),
    list(json_resp('"currentPage is required and needs to be a number"', 400L), "hoopR_bad_request", "/games/10130"),
    list(json_resp('"bad"', 422L), "hoopR_bad_request", "/games/10130"),
    list(json_resp("[]"), "hoopR_no_data", "/games/10130"),
    list(json_resp('{"items":[],"totalPages":1}'), "hoopR_no_data", "/games/10130"),
    list(json_resp('{"seasonId":2025,"quarterFinals":[],"semiFinals":[],"finals":{}}'), "hoopR_no_data",
         "/seasons/2025/playoff-tree"),
    list(json_resp('{"present":[],"future":[],"past":[]}'), "hoopR_no_data", "/games/recent"),
    list(httr2::response(500, headers = list("Content-Type" = "text/plain"), body = charToRaw("x")),
         "hoopR_asset_fetch", "/games/10130"),
    list(httr2::response(200, headers = list("Content-Type" = "text/html"), body = charToRaw("<html>hi</html>")),
         "hoopR_asset_fetch", "/games/10130"),
    list(httr2::response(200, body = raw()), "hoopR_asset_fetch", "/games/10130"),
    list(json_resp('"just a string"'), "hoopR_asset_fetch", "/games/10130"),
    list(json_resp('{"status":"error","error":"No valid api key provided."}'), "hoopR_asset_fetch", "/games/10130"),
    list(httr2::response(302, headers = list(Location = "https://elsewhere.example/")), "hoopR_asset_fetch",
         "/games/10130")
  )
  for (cs in cases) {
    local_scb(function(req) cs[[1]])
    expect_error(.scb_get(paste0(.SCB_BASE, cs[[3]]), list(league = "dbbl")), class = cs[[2]],
                 label = paste(httr2::resp_status(cs[[1]]), cs[[3]]))
  }
})

test_that("not-found and failed-fetch are different conditions under one parent", {
  local_scb(function(req) json_resp("nope", 404L))
  err <- expect_error(scb_game(game_id = "1"), class = "hoopR_error")
  expect_s3_class(err, "hoopR_no_data")
  expect_false(inherits(err, "hoopR_asset_fetch"))
})

test_that("a truncated page is refused, not returned as the season", {
  game <- list(id = "10130", seasonId = 2024L, competition = "DBBL")
  local_scb(function(req) json_resp(list(items = list(game), totalPages = 3L, currentPage = 1L)))
  expect_error(scb_games(league = "dbbl", season = 2025, page_size = 1), class = "hoopR_asset_fetch",
               regexp = "truncated page")
  local_scb(function(req) json_resp(list(items = list(game), totalPages = 1L, currentPage = 1L)))
  expect_identical(nrow(scb_games(league = "dbbl", season = 2025)), 1L)
})

test_that("a body for another game, season, club or league is refused", {
  game <- function(...) utils::modifyList(list(id = "10130", seasonId = 2024L, competition = "DBBL"), list(...))
  page <- function(rows) list(items = rows, totalPages = 1L, currentPage = 1L)
  cases <- list(
    list("/games", list(seasonId = 2024L, currentPage = 1L), "dbbl", page(list(game(seasonId = 2023L)))),
    list("/games", list(seasonId = 2024L, currentPage = 1L), "dbbl", page(list(game(seasonId = "2024")))),
    list("/games", list(seasonId = 2024L, currentPage = 1L), "bbl", page(list(game()))),
    list("/games", list(seasonId = 2024L, currentPage = 1L), "dbbl", page(list(game(competition = "BBL")))),
    list("/games", list(seasonId = 2024L, currentPage = 1L), "dbbl", page(list(list(id = "1", seasonId = 2024L)))),
    list("/games/10130", list(), "dbbl", game(id = "10131")),
    list("/games/10130/stats", list(), "dbbl", list(gameId = "999", status = "OFFICIAL", g = list(competition = "DBBL"))),
    list("/standings", list(seasonId = 2024L), "dbbl", list(list(seasonId = 2023L, competition = "DBBL"))),
    list("/seasons/2025", list(), "bbl", list(id = 2024L, teams = list())),
    list("/seasons/2025/playoff-tree", list(), "bbl", list(seasonId = 2024L, finals = list(games = list(1L)))),
    list("/seasons/2025/team-statistics", list(displayType = "MAIN_ROUND"), "bbl",
         list(list(seasonTeam = list(seasonId = 2024L), competition = "BBL"))),
    list("/teams/413", list(), "bbl", list(id = "414")),
    list("/season-players/56414", list(), "bbl", list(id = "1")),
    list("/records/per-game/2025", list(), "bbl", list(seasonId = "2024", seasonRecords = list(points = list(1L))))
  )
  for (cs in cases) {
    local_scb(function(req) json_resp(cs[[4]]))
    expect_error(.scb_get(paste0(.SCB_BASE, cs[[1]]), c(list(league = cs[[3]]), cs[[2]])),
                 class = "hoopR_asset_fetch", regexp = "out of scope", label = cs[[1]])
  }
})

test_that("a box score exists only once the game is over", {
  stats <- function(status) list(gameId = "10130", home = list(competition = "DBBL"), status = status)
  local_scb(function(req) json_resp(stats("PRE")))
  expect_error(scb_game_players(game_id = "10130", league = "dbbl"), class = "hoopR_no_data", regexp = "not started")
  local_scb(function(req) json_resp(stats("LIVE")))
  expect_error(scb_game_players(game_id = "10130", league = "dbbl"), class = "hoopR_asset_fetch", regexp = "in play")
  for (status in c("POST", "OFFICIAL")) {
    local_scb(function(req) json_resp(stats(status)))
    expect_identical(.scb_get(paste0(.SCB_BASE, "/games/10130/stats"), list(league = "dbbl"))[["status"]], status)
  }
})

test_that("the request is stamped with league, END-year season and display type", {
  local_scb(fixture_resp("full/dbbl_team_statistics_2025.json"))
  body <- .scb_get(paste0(.SCB_BASE, "/seasons/2025/team-statistics"), list(league = "dbbl", displayType = "MAIN_ROUND"))
  expect_identical(body[[1]][["_request"]], list(league = "dbbl", season = 2026L, display_type = "MAIN_ROUND"))
})

test_that("a connection failure is a transient failed fetch, never empty", {
  local_scb(function(req) stop("connection reset"))
  err <- expect_error(scb_seasons(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
})

test_that("a null list entry or name is skipped, never joined as Python's \"None\"", {
  expect_identical(.scb_join(list(list(name = "DYN"), list(name = NULL), NULL, "x")), "DYN,x")
  expect_null(.scb_join(list(NULL)))
})

test_that("an empty or malformed payload parses to a zero-row frame with the documented columns", {
  parsers <- c(
    seasons = ".scb_parse_seasons", season_players = ".scb_parse_season_players",
    season_teams = ".scb_parse_season_teams", playoff_series = ".scb_parse_playoff_series",
    playoff_games = ".scb_parse_playoff_games", player_statistics = ".scb_parse_player_statistics",
    team_statistics = ".scb_parse_team_statistics", games = ".scb_parse_games", games_recent = ".scb_parse_games_recent",
    game = ".scb_parse_games", game_players = ".scb_parse_game_players", game_teams = ".scb_parse_game_teams",
    game_actions = ".scb_parse_game_actions", standings = ".scb_parse_standings",
    season_player = ".scb_parse_season_player", team = ".scb_parse_team", team_seasons = ".scb_parse_team_seasons",
    referees = ".scb_parse_referees", transfers = ".scb_parse_transfers", transfers_teams = ".scb_parse_transfers_teams",
    team_rosters = ".scb_parse_team_rosters", records_per_game = ".scb_parse_records_per_game",
    records_season_averages = ".scb_parse_records_season_averages"
  )
  expect_setequal(names(parsers), names(.scb_columns))
  dtypes <- jsonlite::read_json(scb_fixture("parity", "dtypes.json"))
  for (short in names(parsers)) {
    for (payload in list(list(), stats::setNames(list(), character()), NULL, "x", list(1L, "a"))) {
      out <- get(parsers[[short]])(payload, .scb_columns[[short]])
      expect_identical(nrow(out), 0L, label = short)
      expect_identical(names(out), .scb_columns[[short]], label = short)
    }
    dt <- dtypes[[paste0("scb_", short)]]
    want <- stats::setNames(unname(SCB_RTYPE[unlist(dt)]), names(dt))[.scb_columns[[short]]]
    got <- vapply(out, function(x) if (is.double(x)) "numeric" else class(x)[[1]], character(1))
    expect_identical(unname(got), unname(want), label = short)
  }
})

test_that("live: BBL and DBBL seasons", {
  skip_intl_live()
  bbl <- scb_seasons()
  expect_gt(nrow(bbl), 50L)
  expect_identical(unique(bbl$league), "bbl")
  Sys.sleep(1)
  dbbl <- scb_seasons(league = "dbbl")
  expect_identical(unique(dbbl$league), "dbbl")
  expect_true(all(c(2025L, 2026L) %in% dbbl$season))
})
