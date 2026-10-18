# Offline tests of the CEBL family: R/cebl.R, R/cebl_runtime.R, R/cebl_parsers.R. Every request is
# mocked through httr2 (the Stats Hub page, its bundle chunk and the API), so the header key, its
# re-read, the redirect policy, the retries and the error vocabulary run end to end; the throttle is
# recorded, never slept. Parity: tests/testthat/fixtures/cebl/parity/<case>.csv is sdv-py's frame of
# the same wrapper on the same fixture (see fixtures/cebl/README.md).

cebl_fixture <- function(...) test_path("fixtures", "cebl", ...)
cebl_text <- function(rel) paste(readLines(cebl_fixture(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
cebl_body <- function(rel) jsonlite::parse_json(cebl_text(rel), simplifyVector = FALSE)

CEBL_BUNDLE_KEY <- strrep("Bk", 15) # 30 letters / digits, NOT the documented fallback
CEBL_CHUNK <- "static/chunks/app/league-leaders/page-3d6b0f7141194e04.js"
CEBL_HOME <- paste0('<html><script src="/_next/static/chunks/main-app-1.js"></script>self.__next_f.push(["',
                    CEBL_CHUNK, '"])</html>')
cebl_bundle_js <- function(key) {
  paste0('let r=n.Z.create({baseURL:"https://api.data.cebl.ca/",headers:{"X-Api-Key":"', key, '"}});')
}

cebl_resp <- function(body, status = 200L, ctype = "application/json; charset=utf-8", headers = list()) {
  text <- if (is.character(body)) body else as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null"))
  httr2::response(status, headers = c(list("Content-Type" = ctype), headers), body = charToRaw(enc2utf8(text)))
}

# Mock the hub and the API. `api(req)` answers the API requests (the key is checked first: a request
# without `key` gets a 401); `hub(req)` the hub pages. `seen` records every request and every throttle
# wait (one per attempt). The key cache is cleared before and after.
local_cebl <- function(api, key = CEBL_BUNDLE_KEY, hub = NULL, env = parent.frame()) {
  seen <- new.env()
  seen$api <- list()
  seen$hub <- list()
  seen$waits <- list()
  rm(list = ls(.cebl_key), envir = .cebl_key)
  withr::defer(rm(list = ls(.cebl_key), envir = .cebl_key), envir = env)
  local_mocked_bindings(
    .intl_wait = function(url, min_interval = 1) {
      seen$waits[[length(seen$waits) + 1L]] <- list(url = url, interval = min_interval)
      invisible(0)
    },
    .package = "hoopR", .env = env
  )
  hub <- hub %||% function(req) {
    if (endsWith(httr2::url_parse(req$url)$path, "/league-leaders")) {
      return(cebl_resp(CEBL_HOME, ctype = "text/html; charset=utf-8"))
    }
    cebl_resp(cebl_bundle_js(key), ctype = "application/javascript")
  }
  httr2::local_mocked_responses(function(req) {
    if (startsWith(req$url, .CEBL_HUB)) {
      seen$hub[[length(seen$hub) + 1L]] <- req
      return(hub(req))
    }
    seen$api[[length(seen$api) + 1L]] <- req
    if (!identical(unclass(req$headers[["X-Api-Key"]]), key)) return(cebl_resp('{"detail": "Unauthorized"}', 401L))
    api(req)
  }, env = env)
  seen
}
cebl_routes <- function(routes) {
  function(req) {
    body <- routes[[httr2::url_parse(req$url)$path]]
    if (is.function(body)) body(req) else cebl_resp(body)
  }
}
cebl_path <- function(req) httr2::url_parse(req$url)$path

# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator)
CEBL_CASES <- list(
  cebl_seasons = list("/seasons/", "seasons.json", list()),
  cebl_teams = list("/teams/", "teams.json", list()),
  cebl_standings = list("/teams/2025/", "standings_2025.json", list(season = 2025)),
  cebl_roster = list("/teams/14/roster/2025/", "roster_14_2025.json", list(team_id = 14, season = 2025)),
  cebl_team_stats = list("/teams/statistics/aggregated/", "team_stats_tot_2025_reg.json",
                         list(mode = "TOTALS", season = 2025, competition = "REGULAR")),
  cebl_games = list("/games/2025/", "games_2025.json", list(season = 2025)),
  cebl_games__team20 = list("/games/2025/", "games_2025_team20.json", list(season = 2025, team_id = 20)),
  cebl_player_stats = list("/players/statistics/aggregated/", "player_stats_pg_2025.json",
                           list(mode = "PER_GAME", season = 2025)),
  cebl_player_leaders = list("/players/statistics/leaders/", "leaders_pg_2025.json",
                             list(mode = "PER_GAME", season = 2025)),
  cebl_player_seasons = list("/players/570965/statistics/", "player_seasons_570965_pg.json",
                             list(player_id = 570965, mode = "PER_GAME")),
  cebl_player_seasons__career = list("/players/570965/statistics/", "player_seasons_570965_career.json",
                                     list(player_id = 570965, mode = "TOTALS", career_only = TRUE)),
  cebl_player = list("/players/570965/", "player_570965.json", list(player_id = 570965)),
  cebl_player_gamelog = list("/players/570965/gamelog/", "gamelog_570965_2025.json",
                             list(player_id = 570965, season = 2025)),
  cebl_news = list("/news/articles/en/", "news_synthetic.json", list(language = "en"))
)
CEBL_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character", Date = "Date",
                "Datetime(time_unit='us', time_zone='UTC')" = "POSIXct")

cebl_run_case <- function(case, env = parent.frame()) {
  spec <- CEBL_CASES[[case]]
  seen <- local_cebl(cebl_routes(stats::setNames(list(cebl_text(spec[[2]])), spec[[1]])), env = env)
  out <- do.call(sub("__.*$", "", case), spec[[3]])
  list(out = out, seen = seen)
}
cebl_type <- function(x) if (inherits(x, "POSIXct")) "POSIXct" else if (is.double(x) && !inherits(x, "Date")) "numeric" else class(x)[[1]]

# cells that differ, NA-vs-value counted as a mismatch
cebl_mismatches <- function(got, want_chr) {
  if (inherits(got, "POSIXct")) {
    got <- format(got, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
  } else if (inherits(got, "Date")) {
    got <- format(got, "%Y-%m-%d")
  }
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

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, dtypes, cells, request)", {
  dtypes <- jsonlite::read_json(cebl_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(cebl_fixture("parity", "requests.json"))
  expect_setequal(names(CEBL_CASES), names(dtypes))
  expect_setequal(unique(sub("__.*$", "", names(CEBL_CASES))), getNamespaceExports("hoopR")[
    startsWith(getNamespaceExports("hoopR"), "cebl_")])
  for (case in names(CEBL_CASES)) {
    res <- cebl_run_case(case)
    got <- res$out
    want <- intl_read_oracle(cebl_fixture("parity", paste0(case, ".csv")))
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    types <- vapply(got, cebl_type, character(1))
    want_types <- stats::setNames(unname(CEBL_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    expect_identical(types, want_types[names(got)], label = case)
    bad <- vapply(names(got), function(n) cebl_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same request sdv-py sends: path and query
    req <- res$seen$api[[1]]
    want_req <- requests[[case]]
    expect_identical(sub("\\?.*$", "", req$url), want_req$url, label = case)
    q <- httr2::url_parse(req$url)$query %||% list()
    flat <- function(x) sort(paste(names(x), vapply(x, as.character, ""), sep = "="))
    expect_identical(flat(q), flat(want_req$query), label = case)
  }
})

test_that("an object in a string column is compact JSON, not sdv-py's Python repr (deliberate)", {
  expect_identical(.cebl_s(list(name = "TSN", id = 4L)), '{"name":"TSN","id":4}')
  expect_identical(.cebl_s(list(list(name = "TSN"), "https://x/logo.png")), '{"name":"TSN"}; https://x/logo.png')
  # the parity CSVs hold no Python repr, so the cell comparison never hides this divergence
  for (f in list.files(cebl_fixture("parity"), pattern = "\\.csv$", full.names = TRUE)) {
    expect_false(any(grepl("{'", readLines(f, encoding = "UTF-8", warn = FALSE), fixed = TRUE)), label = basename(f))
  }
})

test_that("a whole double past 2^31 is an integer's text; below it keeps Python's \".0\"", {
  expect_identical(.cebl_py_str(3000000000), "3000000000")
  expect_identical(.cebl_py_str(25), "25.0")
  expect_identical(.cba_str(3000000000), "3000000000")
  expect_identical(.cba_str(25), "25.0")
})

test_that("ids are integers (genius_match_id too), timestamps are UTC POSIXct", {
  games <- cebl_run_case("cebl_games")$out
  for (col in c("season", "game_id", "genius_match_id", "home_team_id", "away_team_id")) {
    expect_type(games[[col]], "integer")
  }
  expect_identical(games$genius_match_id[[1]], 2600563L)
  expect_identical(attr(games$start_time_utc, "tzone"), "UTC")
  log <- cebl_run_case("cebl_player_gamelog")$out
  expect_type(log$player_id, "integer")
  expect_type(log$rebounds, "integer") # the API sends it as a string
  expect_identical(unique(log$player_id), 570965L)
  roster <- cebl_run_case("cebl_roster")$out
  expect_s3_class(roster$birth_date, "Date")
  expect_type(roster$jersey_number, "character")
  stats <- cebl_run_case("cebl_team_stats")$out
  expect_identical(sum(stats$is_league_row), 1L)
  expect_true(is.na(stats$team_id[stats$is_league_row]))
  expect_type(stats$points, "double")
})

test_that("season is the calendar year = the END year, sent unchanged", {
  res <- cebl_run_case("cebl_standings")
  expect_identical(cebl_path(res$seen$api[[1]]), "/teams/2025/")
  expect_identical(unique(res$out$season), 2025L)
  local_cebl(cebl_routes(list("/teams/2025/" = cebl_text("standings_2025.json"))))
  raw <- .cebl_get("standings", season = "2025")
  expect_identical(raw[["_request"]], list(kind = "standings", season = 2025L))
  for (bad in list(25, 99999, "x", TRUE, 2025.5, NA, c(2025, 2026), -2025)) {
    expect_error(.cebl_season_arg(bad), class = "hoopR_bad_request")
  }
})

test_that("arguments are checked before any request", {
  seen <- local_cebl(function(req) stop("no request expected"))
  expect_error(cebl_player_stats(mode = "TOTAL"), class = "hoopR_bad_request", regexp = "mode")
  expect_error(cebl_player_stats(mode = NULL), class = "hoopR_bad_request", regexp = "required")
  expect_error(cebl_player_stats(mode = "TOTALS", competition = "PLAYOFFS"), class = "hoopR_bad_request")
  expect_error(cebl_team_stats(mode = "TOTALS", segment = "JANUARY"), class = "hoopR_bad_request")
  expect_error(cebl_team_stats(vs_conference = "NORTH"), class = "hoopR_bad_request")
  expect_error(cebl_games(season = 25), class = "hoopR_bad_request", regexp = "4-digit")
  expect_error(cebl_player(player_id = "12a"), class = "hoopR_bad_request")
  expect_error(cebl_player_seasons(player_id = 1, career_only = "yes"), class = "hoopR_bad_request")
  expect_error(cebl_player_leaders(statistics = " , "), class = "hoopR_bad_request")
  expect_error(cebl_news(language = "e n"), class = "hoopR_bad_request")
  expect_identical(length(seen$api) + length(seen$hub), 0L)
})

test_that("the key is read from the bundle once, sent as the hub sends it, never with redirects", {
  seen <- local_cebl(cebl_routes(list("/games/2025/" = cebl_text("games_2025.json"),
                                      "/seasons/" = cebl_text("seasons.json"))))
  expect_identical(nrow(cebl_games(season = 2025)), 3L)
  expect_identical(nrow(cebl_seasons()), 3L)
  expect_identical(.cebl_key$source, "bundle")
  expect_identical(vapply(seen$hub, cebl_path, ""), c("/league-leaders", paste0("/_next/", CEBL_CHUNK)))
  expect_identical(length(seen$waits), 4L) # one throttle wait per request, the bundle reads included
  req <- seen$api[[1]]
  expect_identical(unclass(req$headers[["X-Api-Key"]]), CEBL_BUNDLE_KEY)
  expect_identical(unclass(req$headers[["Origin"]]), .CEBL_HUB)
  expect_identical(req$options$followlocation, 0L)
  expect_identical(seen$hub[[1]]$options$followlocation, 0L)
})

test_that("the documented fallback key answers an unreadable bundle", {
  seen <- local_cebl(cebl_routes(list("/seasons/" = cebl_text("seasons.json"))), key = .CEBL_FALLBACK_KEY,
                     hub = function(req) cebl_resp("", 500L, ctype = "text/html"))
  expect_identical(nrow(cebl_seasons()), 3L)
  expect_identical(.cebl_key$source, "fallback")
  expect_identical(length(seen$hub), 1L) # a hub 500 is not retried either
  for (js in c("no key here", 'headers:{"X-Api-Key":"short"}', paste0('headers:{"X-Api-Key":"', strrep("!", 30), '"}'))) {
    local_cebl(cebl_routes(list("/seasons/" = cebl_text("seasons.json"))), key = .CEBL_FALLBACK_KEY,
               hub = function(req) {
                 if (endsWith(cebl_path(req), "/league-leaders")) cebl_resp(CEBL_HOME, ctype = "text/html") else cebl_resp(js, ctype = "text/javascript")
               })
    expect_identical(nrow(cebl_seasons()), 3L)
    expect_identical(.cebl_key$source, "fallback", label = js)
  }
})

test_that("a 401 re-reads the bundle once and succeeds with the rotated key", {
  rotated <- strrep("Z", 30)
  reads <- 0L
  hub <- function(req) {
    if (endsWith(cebl_path(req), "/league-leaders")) {
      reads <<- reads + 1L
      return(cebl_resp(CEBL_HOME, ctype = "text/html"))
    }
    cebl_resp(cebl_bundle_js(if (reads == 1L) CEBL_BUNDLE_KEY else rotated), ctype = "text/javascript")
  }
  seen <- local_cebl(cebl_routes(list("/seasons/" = cebl_text("seasons.json"))), key = rotated, hub = hub)
  expect_identical(nrow(cebl_seasons()), 3L)
  expect_identical(reads, 2L)
  expect_identical(length(seen$api), 2L)
})

test_that("a key the API keeps refusing raises with the rotated hint and never prints the key", {
  q <- strrep("Q", 30)
  seen <- local_cebl(function(req) stop("unused"), key = q,
                     hub = function(req) {
                       if (endsWith(cebl_path(req), "/league-leaders")) cebl_resp(CEBL_HOME, ctype = "text/html") else cebl_resp(cebl_bundle_js(CEBL_BUNDLE_KEY), ctype = "text/javascript")
                     })
  err <- expect_error(cebl_seasons(), class = "hoopR_asset_fetch")
  msg <- conditionMessage(err)
  expect_match(msg, "key rotated?", fixed = TRUE)
  expect_match(msg, "HTTP 401", fixed = TRUE)
  for (k in c(CEBL_BUNDLE_KEY, .CEBL_FALLBACK_KEY, q)) expect_false(grepl(k, msg, fixed = TRUE))
  expect_identical(err$status, 401L)
  expect_identical(length(seen$api), 1L) # the bundle still holds the refused key: no second try with it
})

test_that("the key is scrubbed from any error text", {
  rm(list = ls(.cebl_key), envir = .cebl_key)
  withr::defer(rm(list = ls(.cebl_key), envir = .cebl_key))
  .cebl_key$value <- CEBL_BUNDLE_KEY
  expect_identical(.cebl_scrub(paste("x", CEBL_BUNDLE_KEY, "y", .CEBL_FALLBACK_KEY)), "x <key> y <key>")
})

test_that("404 is no data, 400 / 422 a bad request, any other non-200 a failed fetch", {
  for (cs in list(list(404L, "hoopR_no_data"), list(422L, "hoopR_bad_request"), list(400L, "hoopR_bad_request"),
                  list(403L, "hoopR_asset_fetch"), list(204L, "hoopR_asset_fetch"))) {
    local_cebl(function(req) cebl_resp("", cs[[1]]))
    err <- expect_error(cebl_seasons(), class = cs[[2]], label = cs[[1]])
    expect_identical(err$status, cs[[1]])
  }
})

test_that("retries wait their turn and honour Retry-After", {
  n <- 0L
  seen <- local_cebl(function(req) {
    n <<- n + 1L
    if (n == 1L) return(cebl_resp("", 429L, headers = list("Retry-After" = "7")))
    if (n == 2L) return(cebl_resp("", 503L))
    cebl_resp(cebl_text("seasons.json"))
  })
  expect_identical(nrow(cebl_seasons()), 3L)
  expect_identical(length(seen$api), 3L)
  expect_identical(length(seen$waits), 5L) # bundle (2) + three attempts
  expect_gte(max(vapply(seen$waits, function(w) w$interval, numeric(1))), 7)
})

test_that("a server that never recovers fails after three attempts; a 500 is not retried", {
  seen <- local_cebl(function(req) cebl_resp("", 503L))
  err <- expect_error(cebl_seasons(), class = "hoopR_asset_fetch", regexp = "HTTP 503")
  expect_true(err$transient)
  expect_identical(length(seen$api), 3L)
  seen <- local_cebl(function(req) cebl_resp("", 500L))
  err <- expect_error(cebl_seasons(), class = "hoopR_asset_fetch", regexp = "HTTP 500")
  expect_true(err$transient)
  expect_identical(length(seen$api), 1L)
})

test_that("a redirect is never followed: the key stays on the API host", {
  seen <- local_cebl(function(req) httr2::response(302L, headers = list(Location = "https://elsewhere.example/")))
  expect_error(cebl_seasons(), class = "hoopR_asset_fetch", regexp = "HTTP 302")
  expect_identical(length(seen$api), 1L)
})

test_that("a wrong body is a failed fetch", {
  cases <- list(
    cebl_resp("<html>nope</html>", ctype = "text/html"),
    cebl_resp("not json"),
    cebl_resp(""),
    cebl_resp('{"detail": "boom"}'),
    cebl_resp('{"seasons": []}'),
    cebl_resp("[1, 2]"),
    cebl_resp(cebl_text("seasons.json"), ctype = "")
  )
  for (resp in cases) {
    local_cebl(function(req) resp)
    expect_error(cebl_seasons(), class = "hoopR_asset_fetch")
  }
})

test_that("an empty list is no data, never an empty frame", {
  local_cebl(cebl_routes(list("/games/1999/" = "[]", "/teams/1999/" = "[]", "/news/articles/en/" = "[]")))
  expect_error(cebl_games(season = 1999), class = "hoopR_no_data")
  expect_error(cebl_standings(season = 1999), class = "hoopR_no_data")
  expect_error(cebl_news(language = "en"), class = "hoopR_no_data")
})

test_that("an all-null profile is no data; another player's profile is refused", {
  null <- lapply(cebl_body("player_570965.json"), function(v) NULL)
  local_cebl(cebl_routes(list("/players/999999999/" = jsonlite::toJSON(null, null = "null", auto_unbox = TRUE),
                              "/players/570965/" = cebl_text("player_530.json"))))
  expect_error(cebl_player(player_id = 999999999), class = "hoopR_no_data")
  expect_error(cebl_player(player_id = 570965), class = "hoopR_asset_fetch", regexp = "another\\s+player")
})

test_that("games for another season or team are refused; a team filter is sent and checked", {
  local_cebl(cebl_routes(list("/games/2026/" = cebl_text("games_2025.json"))))
  expect_error(cebl_games(season = 2026), class = "hoopR_asset_fetch", regexp = "another\\s+season")
  local_cebl(cebl_routes(list("/games/2025/" = cebl_text("games_2025.json"))))
  expect_error(cebl_games(season = 2025, team_id = 20), class = "hoopR_asset_fetch", regexp = "another\\s+team")
  res <- cebl_run_case("cebl_games__team20")
  expect_identical(httr2::url_parse(res$seen$api[[1]]$url)$query, list(team_id = "20"))
})

test_that("leaders must be keyed by the statistics asked for", {
  local_cebl(cebl_routes(list("/players/statistics/leaders/" = cebl_text("leaders_pg_2025.json"))))
  out <- cebl_player_leaders(mode = "PER_GAME", season = 2025)
  expect_identical(nrow(out), 12L)
  expect_identical(out$ranking[out$statistic == "POINTS"], 1:3)
  expect_error(cebl_player_leaders(statistics = "POINTS", season = 2025), class = "hoopR_asset_fetch",
               regexp = "keyed\\s+by\\s+the\\s+statistics")
  local_cebl(cebl_routes(list("/players/statistics/leaders/" = '{"POINTS": []}')))
  expect_error(cebl_player_leaders(statistics = "POINTS", season = 1999), class = "hoopR_no_data")
})

test_that("a player table for another team and a team table without one league row are refused", {
  local_cebl(cebl_routes(list("/players/statistics/aggregated/" = cebl_text("player_stats_pg_2025.json"))))
  expect_error(cebl_player_stats(season = 2025, team_id = 20), class = "hoopR_asset_fetch", regexp = "another\\s+team")
  teams_only <- Filter(function(r) !is.null(r[["id"]]), cebl_body("team_stats_tot_2025_reg.json"))
  local_cebl(cebl_routes(list("/teams/statistics/aggregated/" = jsonlite::toJSON(teams_only, auto_unbox = TRUE,
                                                                                  null = "null"))))
  expect_error(cebl_team_stats(mode = "TOTALS", season = 2025), class = "hoopR_asset_fetch", regexp = "league\\s+row")
})

test_that("career_only must answer the career row alone; the rows must be the player's", {
  seen <- local_cebl(cebl_routes(list("/players/570965/statistics/" = cebl_text("player_seasons_570965_pg.json"))))
  expect_error(cebl_player_seasons(player_id = 570965, mode = "TOTALS", career_only = TRUE),
               class = "hoopR_asset_fetch", regexp = "career\\s+row")
  expect_identical(httr2::url_parse(seen$api[[1]]$url)$query$career_only, "true")
  local_cebl(cebl_routes(list("/players/530/statistics/" = cebl_text("player_seasons_570965_pg.json"))))
  expect_error(cebl_player_seasons(player_id = 530), class = "hoopR_asset_fetch", regexp = "another\\s+player")
  out <- cebl_run_case("cebl_player_seasons")$out
  expect_identical(out$is_career, c(FALSE, FALSE, TRUE))
})

test_that("a game log for another season is refused", {
  local_cebl(cebl_routes(list("/players/570965/gamelog/" = cebl_text("gamelog_570965_2025.json"))))
  expect_identical(nrow(cebl_player_gamelog(player_id = 570965, season = 2025)), 3L)
  expect_error(cebl_player_gamelog(player_id = 570965, season = 2026), class = "hoopR_asset_fetch",
               regexp = "another\\s+season")
})

test_that("contact fields are dropped from every body", {
  body <- lapply(cebl_body("roster_14_2025.json"), function(r) {
    c(r, list(email = "a@b.c", phone_number = "1", home_address = "x"))
  })
  local_cebl(cebl_routes(list("/teams/14/roster/2025/" = jsonlite::toJSON(body, auto_unbox = TRUE, null = "null"))))
  raw <- .cebl_get("roster", team_id = 14, season = 2025)
  keep <- names(cebl_body("roster_14_2025.json")[[1]])
  for (r in raw$rows) expect_identical(names(r), keep)
})

test_that("a connection failure is a transient failed fetch naming the cause class only", {
  local_cebl(function(req) stop(paste("HTTPSConnectionPool: X-Api-Key:", .CEBL_FALLBACK_KEY, CEBL_BUNDLE_KEY)))
  err <- expect_error(cebl_seasons(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  msg <- conditionMessage(err)
  expect_match(msg, "fetch failed after 3 attempts")
  expect_false(grepl(.CEBL_FALLBACK_KEY, msg, fixed = TRUE))
  expect_false(grepl(CEBL_BUNDLE_KEY, msg, fixed = TRUE))
  expect_null(err$parent)
})

test_that("an empty or malformed payload parses to a zero-row frame with the documented columns", {
  dtypes <- jsonlite::read_json(cebl_fixture("parity", "dtypes.json"))
  kind_case <- c(seasons = "cebl_seasons", teams = "cebl_teams", standings = "cebl_standings", roster = "cebl_roster",
                 team_stats = "cebl_team_stats", games = "cebl_games", player_stats = "cebl_player_stats",
                 player_leaders = "cebl_player_leaders", player_seasons = "cebl_player_seasons",
                 player = "cebl_player", player_gamelog = "cebl_player_gamelog", news = "cebl_news")
  expect_setequal(names(kind_case), names(.cebl_specs))
  empty <- stats::setNames(list(), character())
  for (kind in names(kind_case)) {
    dt <- dtypes[[kind_case[[kind]]]]
    for (payload in list(list(), empty, NULL, "x", 7L, list(1L, 2L), list(rows = list()),
                         list(rows = list(), `_request` = list(kind = "x")))) {
      out <- .cebl_parse(kind, payload)
      expect_identical(nrow(out), 0L, label = kind)
      expect_identical(names(out), names(dt), label = kind)
      expect_identical(unname(vapply(out, cebl_type, character(1))), unname(CEBL_RTYPE[unlist(dt)]), label = kind)
    }
  }
  expect_identical(nrow(.cebl_parse("player", lapply(cebl_body("player_570965.json"), function(v) NULL))), 0L)
})

test_that("no fixture holds the header key", {
  for (f in list.files(cebl_fixture(), recursive = TRUE, full.names = TRUE)) {
    text <- paste(readLines(f, warn = FALSE), collapse = "\n")
    expect_false(grepl(.CEBL_FALLBACK_KEY, text, fixed = TRUE), label = f)
    expect_false(grepl("X-Api-Key", text, fixed = TRUE), label = f)
  }
})

test_that("live: CEBL seasons and the 2025 standings", {
  skip_intl_live()
  seasons <- cebl_seasons()
  expect_true(all(2019:2025 %in% seasons$season))
  standings <- cebl_standings(season = 2025)
  expect_identical(unique(standings$season), 2025L)
  expect_type(standings$team_id, "integer")
  expect_gte(nrow(standings), 8L)
})
