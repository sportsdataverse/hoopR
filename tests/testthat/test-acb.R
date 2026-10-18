# Offline tests of the ACB (Liga Endesa) family: R/acb.R, R/acb_runtime.R, R/acb_parsers.R.
# Every request is mocked through httr2 (the API and, for the key re-read, acb.com and its bundle), so
# the key header, the re-read, the season mapping, the scope checks and the error vocabulary run end to
# end; sleeps are recorded, never slept. Parity: tests/testthat/fixtures/acb/parity/<case>.csv is
# sdv-py's frame of the same wrapper on the same fixture (see fixtures/acb/README.md).

acb_fixture <- function(...) test_path("fixtures", "acb", ...)
acb_text <- function(rel) {
  con <- if (endsWith(rel, ".gz")) gzfile(acb_fixture(rel), encoding = "UTF-8") else file(acb_fixture(rel), encoding = "UTF-8")
  on.exit(close(con))
  paste(readLines(con, warn = FALSE), collapse = "\n")
}
acb_json <- function(rel) jsonlite::parse_json(acb_text(rel), simplifyVector = FALSE)
acb_to_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

ACB_JSON <- "application/json; charset=utf-8"
acb_resp <- function(body, status = 200L, ctype = ACB_JSON, headers = list()) {
  text <- if (is.character(body)) body else acb_to_json(body)
  hdr <- c(if (!is.null(ctype)) list("Content-Type" = ctype), headers)
  httr2::response(status, headers = hdr, body = charToRaw(enc2utf8(text)))
}

# Mock every request. `api` is a function(req) returning an httr2 response; `seen` records each API
# request (acb.com requests are answered by `site`). The throttle is mocked; the key cache is cleared.
local_acb <- function(api, site = function(req) acb_resp("<html></html>", ctype = "text/html"), env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$site <- 0L
  seen$slept <- numeric()
  withr::local_options(cli.width = 10000, .local_envir = env) # condition messages unwrapped for regexp
  rm(list = ls(.intl_clock), envir = .intl_clock)
  rm(list = ls(.acb_key), envir = .acb_key)
  withr::defer(rm(list = ls(.acb_key), envir = .acb_key), envir = env)
  withr::local_envvar(ACB_API_KEY = NA, .local_envir = env)
  local_mocked_bindings(.intl_sleep = function(seconds) seen$slept <- c(seen$slept, seconds),
                        .intl_now = function() 0, .env = env)
  httr2::local_mocked_responses(function(req) {
    if (startsWith(req$url, "https://www.acb.com")) {
      seen$site <- seen$site + 1L
      return(site(req))
    }
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    api(req)
  }, env = env)
  seen
}
fixture_api <- function(rel) {
  text <- acb_text(rel)
  function(req) acb_resp(text)
}

REQUESTS <- jsonlite::read_json(acb_fixture("parity", "requests.json"))
DTYPES <- jsonlite::read_json(acb_fixture("parity", "dtypes.json"))
ACB_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character", Date = "Date",
               "Datetime(time_unit='us', time_zone=None)" = "POSIXct")

run_case <- function(case, env = parent.frame()) {
  spec <- REQUESTS[[case]]
  seen <- local_acb(fixture_api(spec$fixture), env = env)
  args <- lapply(spec$kwargs, function(v) if (is.list(v)) unlist(v) else v)
  out <- do.call(paste0("acb_", sub("__.*$", "", case)), args)
  list(out = out, seen = seen)
}

# cells that differ, NA-vs-value counted as a mismatch
parity_mismatches <- function(got, want_chr) {
  if (inherits(got, "POSIXct")) {
    got <- format(got, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
  } else if (inherits(got, "Date")) {
    got <- format(got, "%Y-%m-%d")
  }
  want <- if (is.logical(got)) {
    ifelse(is.na(want_chr), NA, want_chr == "true")
  } else if (is.numeric(got)) {
    suppressWarnings(as.numeric(want_chr))
  } else {
    want_chr
  }
  na_diff <- is.na(got) != is.na(want)
  both <- !is.na(got) & !is.na(want)
  val_diff <- if (is.double(got)) abs(got[both] - want[both]) > 1e-9 else got[both] != want[both]
  sum(na_diff) + sum(val_diff)
}
r_type <- function(x) {
  if (inherits(x, "POSIXct")) "POSIXct" else if (inherits(x, "Date")) "Date" else if (is.double(x)) "numeric" else class(x)[[1]]
}
flat_query <- function(q) {
  if (!length(q)) return("")
  paste(unlist(Map(function(k, v) paste(k, vapply(v, function(x) {
    if (is.logical(x)) tolower(x) else as.character(x)
  }, ""), sep = "="), names(q), q)), collapse = "&")
}

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, types, cells, request)", {
  expect_setequal(names(REQUESTS), names(DTYPES))
  wrappers <- unique(sub("__.*$", "", names(REQUESTS)))
  expect_setequal(paste0("acb_", wrappers), grep("^acb_", getNamespaceExports("hoopR"), value = TRUE))
  for (case in names(REQUESTS)) {
    res <- run_case(case)
    got <- res$out
    want <- utils::read.csv(acb_fixture("parity", paste0(case, ".csv")), colClasses = "character",
                            na.strings = "", check.names = FALSE, encoding = "UTF-8")
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(names(got), .acb_fields[[sub("__.*$", "", case)]]$col, label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    want_types <- stats::setNames(unname(ACB_RTYPE[unlist(DTYPES[[case]])]), names(DTYPES[[case]]))
    expect_identical(vapply(got, r_type, character(1)), want_types[names(got)], label = case)
    bad <- vapply(names(got), function(n) parity_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same request sdv-py sends: path and wire query, one request
    expect_identical(length(res$seen$reqs), 1L, label = case)
    req <- res$seen$reqs[[1]]
    expect_identical(sub("\\?.*$", "", req$url), REQUESTS[[case]]$url, label = case)
    expect_identical(flat_query(httr2::url_parse(req$url)$query), flat_query(REQUESTS[[case]]$query), label = case)
  }
})

test_that("ids keep one integer type; shirt numbers stay strings, never float-origin", {
  for (case in c("player_box", "pbp", "shots", "round_matches", "team_stats", "current_roster", "search")) {
    out <- run_case(case)$out
    ids <- grep("(_id$|^season$|^edition_id$)", names(out), value = TRUE)
    expect_true(length(ids) > 0, label = case)
    for (id in ids) expect_type(out[[id]], "integer")
    if ("shirt_number" %in% names(out)) {
      expect_type(out$shirt_number, "character")
      expect_false(any(grepl("\\.0$", out$shirt_number)), label = case)
    }
  }
  stats <- run_case("team_stats")$out # whole-number averages arrive as JSON integers: doubles here
  expect_type(stats$avg_points, "double")
  expect_type(stats$total_three_pointers_percentage, "double")
  expect_type(stats$total_points, "integer")
})

test_that("season is the END year, sent as editionId = season - 1936", {
  expect_identical(vapply(list(1984, 2017L, 2027, "2027"), .acb_edition_id, integer(1)), c(48L, 81L, 91L, 91L))
  for (bad in list(1983, 0, -1, TRUE, 1.5, NA, "abc", c(2026, 2027), NULL)) {
    expect_error(.acb_edition_id(bad), class = "hoopR_bad_request")
  }
  res <- run_case("standings") # season = 2027
  expect_match(res$seen$reqs[[1]]$url, "editionId=91")
  expect_false(grepl("season=", res$seen$reqs[[1]]$url))
  expect_identical(unique(res$out$season), 2027L)
  expect_identical(unique(res$out$edition_id), 91L)
})

test_that("arguments are checked before any request; whole doubles are accepted", {
  seen <- local_acb(function(req) stop("no request expected"))
  bad_calls <- list(
    function() acb_pbp(match_id = NULL), function() acb_pbp(match_id = "abc"), function() acb_pbp(match_id = TRUE),
    function() acb_pbp(match_id = 1.5), function() acb_pbp(match_id = -3), function() acb_pbp(match_id = c(1, 2)),
    function() acb_standings(season = 1983), function() acb_standings(season = "x"),
    function() acb_standings(competition_id = c(1, 2)), function() acb_round_matches(is_round_selected = "yes"),
    function() acb_search(search_term = "  "), function() acb_competition_current(competition_ids = integer()),
    function() acb_team_leaders(club_id = 2, number_of_players = NULL)
  )
  for (f in bad_calls) expect_error(f(), class = "hoopR_bad_request")
  expect_identical(length(seen$reqs), 0L)
  err <- expect_error(acb_pbp(match_id = "abc"), class = "hoopR_bad_request")
  expect_identical(err$call[[1]], quote(acb_pbp)) # the wrapper is named
  expect_error(.acb_get("/matchdata/Nope/nope", list(matchId = 1)), class = "hoopR_bad_request")
  expect_error(.acb_get("/matchdata/PlayByPlay/play-by-play", list(matchId = 1, editionId = 91)),
               class = "hoopR_bad_request", regexp = "Unsupported")
  expect_identical(.acb_normalise("/matchdata/PlayByPlay/play-by-play", list(matchId = 105401)),
                   list(matchId = 105401L))
})

test_that("the key header: built-in value, Accept json, env override without a re-read", {
  seen <- local_acb(fixture_api("full/lead-tracker.json"))
  acb_lead_tracker(match_id = 105401)
  req <- seen$reqs[[1]]
  expect_identical(unclass(req$headers[["X-APIKEY"]]), .ACB_DEFAULT_KEY)
  expect_identical(unclass(req$headers[["Accept"]]), "application/json")
  seen <- local_acb(function(req) acb_resp("", status = 401L))
  withr::local_envvar(ACB_API_KEY = "env-key-0123456789abcdef")
  err <- expect_error(acb_pbp(match_id = 105401), class = "hoopR_asset_fetch")
  expect_identical(unclass(seen$reqs[[1]]$headers[["X-APIKEY"]]), "env-key-0123456789abcdef")
  expect_identical(length(seen$reqs), 1L)
  expect_identical(seen$site, 0L)
  expect_false(grepl("env-key-0123456789abcdef", conditionMessage(err), fixed = TRUE))
  expect_false(grepl(.ACB_DEFAULT_KEY, conditionMessage(err), fixed = TRUE))
})

test_that("a 401 re-reads the key from the live bundle once, then the renewed key is cached", {
  new_key <- "11111111-2222-3333-4444-555555555555"
  chunk <- "/_next/static/chunks/app-1234.js"
  js <- paste0('x,"sharedServicesConfigDotnet",0,{baseUrl:"https://api2.acb.com",apiKey:"', new_key, '"},y')
  site <- function(req) {
    if (endsWith(req$url, chunk)) return(acb_resp(js, ctype = "application/javascript"))
    acb_resp(paste0('<script src="', chunk, '"></script>'), ctype = "text/html")
  }
  lt <- acb_text("full/lead-tracker.json")
  api <- function(req) if (identical(unclass(req$headers[["X-APIKEY"]]), new_key)) acb_resp(lt) else acb_resp("", 401L)
  seen <- local_acb(api, site = site)
  expect_identical(nrow(acb_lead_tracker(match_id = 105401)), 97L)
  keys <- vapply(seen$reqs, function(r) unclass(r$headers[["X-APIKEY"]]), "")
  expect_identical(keys, c(.ACB_DEFAULT_KEY, new_key))
  expect_identical(seen$site, 2L) # home page + the chunk
  acb_lead_tracker(match_id = 105401)
  expect_identical(unclass(seen$reqs[[3]]$headers[["X-APIKEY"]]), new_key)
  expect_identical(seen$site, 2L)
})

test_that("a key the API keeps rejecting is a failed fetch that never names the key", {
  local_acb(function(req) acb_resp("", status = 401L))
  err <- expect_error(acb_lead_tracker(match_id = 105401), class = "hoopR_asset_fetch", regexp = "HTTP 401")
  expect_false(grepl(.ACB_DEFAULT_KEY, conditionMessage(err), fixed = TRUE))
})

test_that("the status vocabulary matches sdv-py", {
  local_acb(function(req) acb_resp("not found", status = 404L, ctype = "text/plain"))
  expect_error(acb_lineup(match_id = 1), class = "hoopR_no_data")
  local_acb(function(req) httr2::response(204))
  expect_error(acb_serie(match_id = 105401), class = "hoopR_no_data", regexp = "204")
  local_acb(function(req) acb_resp('{"title":"Bad Request","status":400}', 400L, "application/problem+json"))
  expect_error(acb_team_leaders(club_id = 2, number_of_players = 0), class = "hoopR_bad_request", regexp = "HTTP 400")
  local_acb(function(req) acb_resp("{}", 422L))
  expect_error(acb_lineup(match_id = 1), class = "hoopR_bad_request")
  local_acb(function(req) acb_resp("x", 403L, "text/plain"))
  err <- expect_error(acb_lineup(match_id = 1), class = "hoopR_asset_fetch")
  expect_false(err$transient)
})

test_that("429 / 5xx are retried, waiting their turn and honouring Retry-After", {
  n <- 0L
  lt <- acb_text("full/lead-tracker.json")
  seen <- local_acb(function(req) {
    n <<- n + 1L
    if (n == 1L) return(acb_resp("", 429L, headers = list("Retry-After" = "7")))
    if (n == 2L) return(acb_resp("", 503L))
    acb_resp(lt)
  })
  expect_identical(nrow(acb_lead_tracker(match_id = 105401)), 97L)
  expect_identical(length(seen$reqs), 3L)
  expect_true(max(seen$slept) >= 7)
  seen <- local_acb(function(req) acb_resp("", 500L))
  err <- expect_error(acb_shots(match_id = 105401), class = "hoopR_asset_fetch", regexp = "HTTP 500")
  expect_true(err$transient)
  expect_identical(length(seen$reqs), 3L) # HTTP 500 is retried for ACB, three attempts
})

test_that("error envelopes, stubs, other shapes and non-JSON bodies are refused, never empty frames", {
  bodies <- list(
    list("", ACB_JSON), list("not json", ACB_JSON), list('{"title":"Bad","status":500,"traceId":"t"}', ACB_JSON),
    list('{"error":"x"}', ACB_JSON), list("[1,2]", ACB_JSON), list("{}", ACB_JSON),
    list('{"plays":[],"matchFinished":null,"homeTeam":null}', ACB_JSON),
    list('{"teamBoxscores":[null],"arena":"","referees":[]}', ACB_JSON),
    list('{"x":1}', "text/html"), list('{"x":1}', "application/problem+json"), list('{"x":1}', NULL)
  )
  for (b in bodies) {
    local_acb(function(req) acb_resp(b[[1]], ctype = b[[2]]))
    expect_error(acb_player_box(match_id = 105401), class = "hoopR_error", label = b[[1]])
  }
  local_acb(function(req) acb_resp('{"something":[1,2,3]}'))
  expect_error(acb_player_box(match_id = 105401), class = "hoopR_asset_fetch", regexp = "not this route's shape")
  local_acb(function(req) acb_resp('{"error":"x"}'))
  expect_error(acb_player_box(match_id = 105401), class = "hoopR_asset_fetch", regexp = "error envelope")
  local_acb(function(req) acb_resp('{"teamBoxscores":[null],"arena":"","referees":[]}'))
  expect_error(acb_player_box(match_id = 105401), class = "hoopR_asset_fetch", regexp = "empty stub")
})

test_that("empty rows are no data: pre-2016 play-by-play and shots, a club with no games", {
  pbp <- acb_json("cap/play-by-play__2016.json")
  pbp$plays <- list()
  pbp$matchFinished <- FALSE
  local_acb(function(req) acb_resp(pbp))
  expect_error(acb_pbp(match_id = 12559), class = "hoopR_no_data", regexp = "no rows")
  shots <- acb_json("cap/match-shots__2016.json")
  shots$shotPoints <- list()
  local_acb(function(req) acb_resp(shots))
  expect_error(acb_shots(match_id = 12559), class = "hoopR_no_data")
  tm <- acb_json("cap/team-matches.json")
  tm$matches <- list()
  local_acb(function(req) acb_resp(tm))
  expect_error(acb_team_matches(club_id = 2, season = 2027), class = "hoopR_no_data")
})

test_that("a game that is not finished is refused, not returned partial", {
  box <- acb_json("full/boxscores.json")
  box$matchFinished <- FALSE
  local_acb(function(req) acb_resp(box))
  expect_error(acb_player_box(match_id = 105401), class = "hoopR_asset_fetch", regexp = "not finished")
  pbp <- acb_json("full/play-by-play.json.gz")
  pbp$matchFinished <- FALSE
  local_acb(function(req) acb_resp(pbp))
  expect_error(acb_pbp(match_id = 105401), class = "hoopR_asset_fetch", regexp = "not finished")
})

test_that("a body for another season, round, match, club, player or term is refused", {
  cases <- list(
    list("full/standings.json", function() acb_standings(season = 2026)),
    list("full/standings.json", function() acb_standings(season = 2027, competition_id = 2)),
    list("full/standings.json", function() acb_standings(season = 2027, round_id = 1)),
    list("full/match-header.json", function() acb_match_header(match_id = 105402)),
    list("cap/team-matches.json", function() acb_team_matches(club_id = 9, season = 2027)),
    list("cap/next-matches.json", function() acb_next_matches(club_id = 9)),
    list("cap/team-records.json", function() acb_team_records(club_id = 9)),
    list("cap/club-data.json", function() acb_club_data(club_id = 9)),
    list("full/team-stats.json", function() acb_team_stats(club_id = 9, season = 2027)),
    list("cap/player-data.json", function() acb_player_data(player_id = 20212243)),
    list("cap/player-stats.json", function() acb_player_stats(player_id = 20212243)),
    list("cap/search.json", function() acb_search(search_term = "zzz")),
    list("cap/league-zones.json", function() acb_league_zones(season = 2026)),
    list("cap/teams.json", function() acb_teams(season = 2026)),
    list("cap/season-calendar.json", function() acb_calendar(season = 2026)),
    list("cap/bracket.json", function() acb_bracket(season = 2027)),
    list("cap/competition-data.json", function() acb_competition_current(competition_ids = 10))
  )
  for (cs in cases) {
    local_acb(fixture_api(cs[[1]]))
    expect_error(cs[[2]](), class = "hoopR_asset_fetch", regexp = "out of scope", label = cs[[1]])
  }
  # type-strict: an echoed "91" (string) is not the asked 91
  st <- acb_json("full/standings.json")
  st$selectedFilters$season <- "91"
  local_acb(function(req) acb_resp(st))
  expect_error(acb_standings(season = 2027), class = "hoopR_asset_fetch", regexp = "out of scope")
})

test_that("scope checks accept the matching bodies (search is accent- and case-insensitive)", {
  local_acb(fixture_api("cap/team-matches.json"))
  expect_identical(nrow(acb_team_matches(club_id = 2, season = 2027)), 3L)
  local_acb(fixture_api("cap/search.json"))
  expect_identical(nrow(acb_search(search_term = "T\u00c1VARES ")), 1L)
  local_acb(fixture_api("cap/player-data.json"))
  expect_identical(nrow(acb_player_data(player_id = 20209407)), 1L)
})

test_that("bool and list params are encoded as sdv-py sends them", {
  two <- acb_json("cap/competition-data.json")
  two$competitions <- list(two$competitions[[1]], utils::modifyList(two$competitions[[1]], list(id = 2L)))
  seen <- local_acb(function(req) acb_resp(two))
  acb_competition_rounds(competition_ids = c(1, 2))
  expect_identical(lengths(regmatches(seen$reqs[[1]]$url, gregexpr("competitionIds=", seen$reqs[[1]]$url))), 2L)
  seen <- local_acb(fixture_api("full/matches.json"))
  acb_round_matches(season = 2027, round_id = 6017, is_round_selected = TRUE)
  expect_match(seen$reqs[[1]]$url, "isRoundSelected=true")
  expect_match(seen$reqs[[1]]$url, "roundId=6017")
})

test_that("the request is stamped in snake_case with the END-year season", {
  local_acb(fixture_api("full/standings.json"))
  body <- .acb_get("/seasondata/Competition/standings", list(season = 2027))
  expect_identical(body[["_request"]], list(edition_id = 91L, season = 2027L))
  local_acb(fixture_api("full/match-header.json"))
  body <- .acb_get("/matchdata/MatchHeader/match-header", list(matchId = 105401))
  expect_identical(body[["_request"]], list(match_id = 105401L))
})

test_that("a connection failure is a transient failed fetch, never empty", {
  local_acb(function(req) stop("connection reset"))
  err <- expect_error(acb_pbp(match_id = 105401), class = "hoopR_asset_fetch")
  expect_true(err$transient)
})

test_that("an empty or malformed payload parses to a zero-row frame with the documented columns and types", {
  expect_setequal(names(.ACB_EXTRACT), names(.acb_fields))
  for (short in names(.acb_fields)) {
    for (payload in list(list(), stats::setNames(list(), character()), NULL, "x", list(1L, "a"))) {
      out <- .acb_parse(short, payload)
      expect_identical(nrow(out), 0L, label = short)
      expect_identical(names(out), .acb_fields[[short]]$col, label = short)
    }
    case <- short
    want <- stats::setNames(unname(ACB_RTYPE[unlist(DTYPES[[case]])]), names(DTYPES[[case]]))
    expect_identical(vapply(out, r_type, character(1)), want[names(out)], label = short)
  }
})

test_that("casts follow sdv-py: no float-origin id strings, decimal commas, mm:ss, DD-MM-YYYY", {
  expect_identical(.acb_i(4467), 4467L)
  expect_identical(.acb_i(4467.5), NA_integer_)
  expect_identical(.acb_i(TRUE), NA_integer_)
  expect_identical(.acb_i(" 12 "), 12L)
  expect_identical(.acb_s(123), "123")
  expect_identical(.acb_s(1.5), "1.5")
  expect_identical(.acb_s(TRUE), "True")
  expect_identical(.acb_s("  "), NA_character_)
  expect_identical(.acb_f("2,20"), 2.2)
  expect_identical(.acb_pct("79,17%"), 79.17)
  expect_identical(.acb_pct("19/24"), NA_real_)
  expect_identical(.acb_mmss("8665:53"), 8665L * 60L + 53L)
  expect_identical(.acb_dmy("22-03-1992"), as.double(as.Date("1992-03-22")))
  expect_identical(.acb_dmy("31-02-1992"), NA_real_)
  expect_identical(.acb_utc("2026-10-11T17:00:00Z"), as.double(as.POSIXct("2026-10-11 17:00:00", tz = "UTC")))
  expect_identical(.acb_join(list("a", NULL, " b ")), "a; b")
})

test_that("live: Liga Endesa standings", {
  skip_intl_live()
  st <- acb_standings(season = 2026)
  expect_gt(nrow(st), 10L)
  expect_identical(unique(st$season), 2026L)
})
