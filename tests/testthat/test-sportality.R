# Offline tests of the Basketligaen (Sportality) family: R/sportality.R, R/sportality_runtime.R,
# R/sportality_parsers.R. Every request is mocked through httr2, so the throttle, the season mapping,
# the refusals and the error vocabulary run end to end; sleeps are never slept. Parity:
# tests/testthat/fixtures/sportality/parity/<case>.csv is sdv-py's frame of the same wrapper on the same
# fixture (see fixtures/sportality/README.md).

dbl_fixture <- function(...) test_path("fixtures", "sportality", ...)
dbl_text <- function(name) paste(readLines(dbl_fixture(name), encoding = "UTF-8", warn = FALSE), collapse = "\n")
dbl_json <- function(name) jsonlite::parse_json(dbl_text(name), simplifyVector = FALSE)

dbl_resp <- function(body, status = 200L, type = "application/json") {
  text <- if (is.character(body)) body else as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null", digits = NA))
  httr2::response(status, headers = list("Content-Type" = type), body = charToRaw(enc2utf8(text)))
}

# Serve layout-info from the fixture and everything else from `api` (a function(req) -> response);
# `seen` records the non-layout requests and counts the layout calls. The directory cache and the
# throttle clock are cleared before and after.
local_dbl <- function(api, layout = dbl_text("layout.json"), env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$layout <- 0L
  clear <- function() {
    rm(list = ls(.sportality_cache), envir = .sportality_cache)
    rm(list = ls(.intl_clock), envir = .intl_clock)
  }
  clear()
  withr::defer(clear(), envir = env)
  withr::local_options(cli.width = 10000L, .local_envir = env) # one-line messages for the regexps
  local_mocked_bindings(.intl_sleep = function(seconds) NULL, .intl_now = function() 0, .env = env)
  httr2::local_mocked_responses(function(req) {
    if (grepl("/statistics-v2/layout-info", req$url, fixed = TRUE) && !isTRUE(seen$serve_layout)) {
      seen$layout <- seen$layout + 1L
      return(dbl_resp(layout))
    }
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    api(req)
  }, env = env)
  seen
}
serve <- function(name) function(req) dbl_resp(dbl_text(name))
serve_body <- function(body) function(req) dbl_resp(body)

G <- "c4hh5nig6t"
TM <- "rfo82vr830"
S <- "xs07bd3fmp"
# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator, see the README)
DBL_CASES <- list(
  athlete_career = list("athlete_career.json", list(athlete_uuid = "dpu0901c0t")),
  athlete_details = list("athlete_details.json", list(athlete_uuid = "dpu0901c0t")),
  athlete_profile = list("athlete_profile.json", list(athlete_uuid = "dpu0901c0t", master_site_instance_id = "dbl1_dbl")),
  boxscore = list("boxscore.json", list(game_uuid = G)),
  game_header = list("game_header.json", list(game_uuid = G)),
  game_overview = list("game_overview.json", list(game_uuid = G)),
  game_summary = list("game_summary.json", list(game_uuid = G)),
  last_game_day = list("last_game_day.json", list()),
  layout_info = list("layout.json", list()),
  next_game_day = list("next_game_day.json", list()),
  pbp = list("pbp.json", list(game_uuid = G)),
  player_box = list("player_stats.json", list(game_uuid = G)),
  player_h2h = list("player_h2h.json", list(ssgt_uuid = S, home_team_uuid = TM, away_team_uuid = "gvvuxe9ysw", game_uuid = G)),
  post_game_team_stats = list("post_game_team_stats.json",
                              list(game_uuid = G, ssgt_uuid = S, home_team_uuid = TM, away_team_uuid = "gvvuxe9ysw")),
  roster = list("roster.json", list(team_uuid = TM)),
  schedule = list("schedule.json", list(season = 2026)),
  season_filter = list("season_filter.json", list()),
  sites = list("sites.json", list(ssgt_uuid = S)),
  ssgt_provider = list(NULL, list(ssgt_uuid = S)),
  standings = list("standings.json", list(ssgt_uuid = S)),
  stats_info__players_summary = list("players_summary.json", list(module = "players_summary", season = 2026)),
  stats_info__teams_summary = list("teams_summary_2003.json", list(module = "teams_summary", season = 2003)),
  stats_info__games_games = list("games_games.json", list(module = "games_games", season = 2026)),
  team = list("team.json", list(team_uuid = TM)),
  team_played_games = list("played_games.json", list(team_uuid = TM)),
  team_stats = list("team_stats.json", list(game_uuid = G)),
  team_upcoming_games = list("upcoming_games.json", list(team_uuid = TM)),
  player_crosswalk = list("players_summary.json", list(season = 2026))
)
DBL_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character")

run_dbl <- function(case, env = parent.frame()) {
  spec <- DBL_CASES[[case]]
  api <- if (is.null(spec[[1]])) function(req) dbl_resp("genius-basketball", type = "text/plain") else serve(spec[[1]])
  seen <- local_dbl(api, env = env)
  if (case == "layout_info") seen$serve_layout <- TRUE
  out <- do.call(paste0("sportality_", sub("__.*$", "", case)), spec[[2]])
  list(out = out, seen = seen)
}

# cells that differ, NA-vs-value counted as a mismatch
dbl_mismatches <- function(got, want_chr) {
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

# polars writes null as an empty field and "" as a quoted empty field: keep the two apart
read_oracle <- function(case) {
  path <- dbl_fixture("parity", paste0(case, ".csv"))
  lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
  marked <- gsub('(^|,)""(?=,|$)', "\\1\"\001\"", lines, perl = TRUE)
  want <- utils::read.csv(text = marked, colClasses = "character", na.strings = "", check.names = FALSE,
                          encoding = "UTF-8")
  want[] <- lapply(want, function(x) ifelse(!is.na(x) & x == "\001", "", x))
  want
}

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, types, cells, request)", {
  dtypes <- jsonlite::read_json(dbl_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(dbl_fixture("parity", "requests.json"))
  expect_setequal(names(DBL_CASES), names(dtypes))
  for (case in names(DBL_CASES)) {
    res <- run_dbl(case)
    got <- res$out
    want <- read_oracle(case)
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    types <- vapply(got, function(x) if (is.double(x)) "numeric" else class(x)[[1]], character(1))
    want_types <- stats::setNames(unname(DBL_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    expect_identical(types, want_types[names(got)], label = case)
    bad <- vapply(names(got), function(n) dbl_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same request sdv-py sends: path and query
    req <- res$seen$reqs[[length(res$seen$reqs)]] %||% list(url = "https://www.basketligaen.dk/api/statistics-v2/layout-info")
    want_req <- requests[[case]]
    expect_identical(sub("\\?.*$", "", req$url), want_req$url, label = case)
    q <- httr2::url_parse(req$url)$query %||% list()
    flat <- function(q) {
      if (!length(q)) return("")
      q <- q[order(names(q))]
      paste(names(q), vapply(q, as.character, ""), sep = "=", collapse = "&")
    }
    expect_identical(flat(q), flat(want_req$query), label = case)
  }
})

test_that("Genius ids are integers and platform uuids are character", {
  pbp <- run_dbl("pbp")$out
  for (col in c("game_id", "game_source_id", "event_id", "player_id", "home_team_id", "event_team_id")) {
    expect_type(pbp[[col]], "integer")
  }
  expect_type(pbp$game_uuid, "character")
  expect_identical(unique(pbp$game_id), 2868126L)
  box <- run_dbl("boxscore")$out
  expect_type(box$player_id, "integer")
  expect_type(box$team_id, "integer")
  expect_false(any(grepl("\\.0$", as.character(box$player_id[!is.na(box$player_id)]))))
  stats <- run_dbl("stats_info__players_summary")$out
  expect_type(stats$player_id, "integer")
  expect_type(stats$info_team_id, "integer")
  expect_type(stats$info_uuid, "character")
  xw <- run_dbl("player_crosswalk")$out
  expect_type(xw$player_id, "integer")
  expect_type(xw$athlete_uuid, "character")
})

test_that("season is the END year, mapped to the ssgt through layout-info (fetched once)", {
  seen <- local_dbl(function(req) stop("no request expected"))
  expect_identical(sportality_ssgt_uuid(2026), "qzw34da6jg")
  expect_identical(sportality_ssgt_uuid(2026, "finals"), "al4a0u2go5")
  expect_identical(sportality_ssgt_uuid("2003"), "rejluryl18") # 2002/03, the earliest season
  expect_identical(sportality_ssgt_uuid(2027), S) # 2026/27, the active season
  expect_identical(seen$layout, 1L)
  for (bad in list(list(2028, "regular"), list(2002, "regular"), list(2026, "allstar"))) {
    expect_error(sportality_ssgt_uuid(bad[[1]], bad[[2]]), class = "hoopR_no_data", regexp = "covers 2003-2027")
  }
  for (bad in list("twenty", 2026.5, NA, TRUE, c(2025, 2026))) {
    expect_error(sportality_ssgt_uuid(bad), class = "hoopR_bad_request", regexp = "END year")
  }
  # stats-info: ssgtUuid + count=1000, never season / gameType
  seen <- local_dbl(serve("players_summary.json"))
  sportality_stats_info("players_summary", 2026)
  q <- httr2::url_parse(seen$reqs[[1]]$url)$query
  expect_identical(q[order(names(q))], list(count = "1000", ssgtUuid = "qzw34da6jg"))
  # game-schedule: the three uuids
  seen <- local_dbl(serve("schedule.json"))
  sportality_schedule(2026)
  q <- httr2::url_parse(seen$reqs[[1]]$url)$query
  expect_identical(q[order(names(q))], list(gameTypeUuid = "aprlbjgxlp", seasonUuid = "ggp2aapun2", seriesUuid = "m1ay3mpa4t"))
  # match days without a season: the active ssgt
  seen <- local_dbl(serve("last_game_day.json"))
  sportality_last_game_day()
  expect_identical(httr2::url_parse(seen$reqs[[1]]$url)$query, list(seasonSeriesGameType = S))
})

test_that("arguments are checked before any request", {
  seen <- local_dbl(function(req) stop("no request expected"))
  expect_error(sportality_stats_info("players_bogus", 2026), class = "hoopR_bad_request")
  expect_error(sportality_schedule(2026, game_type = "allstar"), class = "hoopR_bad_request")
  expect_error(sportality_schedule(2026, game_type = NULL), class = "hoopR_bad_request")
  expect_error(sportality_schedule("x"), class = "hoopR_bad_request")
  expect_error(sportality_pbp(c("a", "b")), class = "hoopR_bad_request")
  expect_error(sportality_team(NA_character_), class = "hoopR_bad_request")
  expect_error(sportality_player_h2h(S, TM, "gvvuxe9ysw", game_uuid = 1), class = "hoopR_bad_request")
  expect_identical(length(seen$reqs), 0L)
  expect_identical(seen$layout, 0L)
})

test_that("the error vocabulary matches sdv-py; a 500 is not retried", {
  team <- paste0(.SPORTALITY_BASE, "/sports-v2/teams/", TM)
  cases <- list(
    list(dbl_resp('{"message":"x"}', 404L), "hoopR_no_data"),
    list(dbl_resp('{"message":"x"}', 400L), "hoopR_bad_request"),
    list(dbl_resp('{"message":"x"}', 422L), "hoopR_bad_request"),
    list(dbl_resp('{"message":"x"}', 500L), "hoopR_asset_fetch"),
    list(dbl_resp("{}"), "hoopR_no_data"),
    list(dbl_resp("[]"), "hoopR_no_data"),
    list(dbl_resp('{"statusCode":500,"message":"Internal server error"}'), "hoopR_asset_fetch"),
    list(dbl_resp("<!doctype html><html></html>", type = "text/html"), "hoopR_asset_fetch"),
    list(httr2::response(200, body = raw()), "hoopR_asset_fetch")
  )
  for (cs in cases) {
    seen <- local_dbl(function(req) cs[[1]])
    expect_error(.sportality_get(team), class = cs[[2]], label = paste(httr2::resp_status(cs[[1]]), cs[[2]]))
    expect_identical(length(seen$reqs), 1L) # a 500 is the API's answer for an unknown uuid
  }
  seen <- local_dbl(function(req) dbl_resp("{}", 503L))
  err <- expect_error(.sportality_get(team), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_identical(length(seen$reqs), 3L) # 503 is retried: three attempts
  nf <- local_dbl(function(req) dbl_resp("x", 404L))
  err <- expect_error(sportality_team(TM), class = "hoopR_error")
  expect_false(inherits(err, "hoopR_asset_fetch"))
})

test_that("an empty gameday body is no data (games before 2023/24, unknown games)", {
  local_dbl(function(req) dbl_resp(""))
  expect_error(sportality_pbp("qqqqqqqqqq"), class = "hoopR_no_data", regexp = "2023/24")
  local_dbl(serve_body(list(gameInfo = list(gameUuid = NULL, extId = NULL, state = NULL))))
  expect_error(sportality_game_header("qqqqqqqqqq"), class = "hoopR_no_data", regexp = "no rows")
  local_dbl(serve_body(list(upcomingGames = list())))
  expect_error(sportality_team_upcoming_games(TM), class = "hoopR_no_data", regexp = "no rows")
})

test_that("stats-info refuses a cut table, an unknown module and another ssgt's teams", {
  body <- dbl_json("players_summary.json")
  cut <- body
  cut[[1]]$totalCount <- 164L
  local_dbl(serve_body(cut))
  expect_error(sportality_stats_info("players_summary", 2026), class = "hoopR_asset_fetch", regexp = "of totalCount=164")
  full <- body
  full[[1]]$stats <- rep(full[[1]]$stats[1], .SPORTALITY_STATS_COUNT)
  full[[1]]$totalCount <- NULL
  local_dbl(serve_body(full))
  expect_error(sportality_stats_info("players_summary", 2026), class = "hoopR_asset_fetch", regexp = "may be cut")
  local_dbl(serve("games_games.json"))
  expect_error(.sportality_get(paste0(.SPORTALITY_BASE, "/statistics-v2/stats-info/players_bogus"), list(season = 2026)),
               class = "hoopR_asset_fetch", regexp = "unknown module answers the games table")
  local_dbl(serve("players_summary.json"))
  expect_error(sportality_stats_info("players_summary", 2027), class = "hoopR_asset_fetch", regexp = "not teams of the ssgt")
  short <- dbl_json("layout.json")
  short[[1]]$seasonSeriesGameTypeTeams <- short[[1]]$seasonSeriesGameTypeTeams[1:5]
  local_dbl(function(req) stop("unused"), layout = as.character(jsonlite::toJSON(short, auto_unbox = TRUE, null = "null")))
  expect_error(sportality_ssgt_uuid(2026), class = "hoopR_asset_fetch", regexp = "expected the 40")
})

test_that("a body for another game, team, athlete, ssgt or season is refused", {
  local_dbl(serve("team.json"))
  expect_error(sportality_team("zzzzzzzzzz"), class = "hoopR_asset_fetch", regexp = "not the data asked for")
  local_dbl(serve("played_games.json"))
  expect_error(sportality_team_played_games("zzzzzzzzzz"), class = "hoopR_asset_fetch", regexp = "does not involve team")
  local_dbl(serve("athlete_career.json"))
  expect_error(sportality_athlete_career("zzzzzzzzzz"), class = "hoopR_asset_fetch", regexp = "requested athlete")
  local_dbl(serve("athlete_profile.json"))
  expect_error(sportality_athlete_profile("zzzzzzzzzz"), class = "hoopR_asset_fetch", regexp = "not the data asked for")
  local_dbl(serve("sites.json"))
  expect_error(sportality_sites("qzw34da6jg"), class = "hoopR_asset_fetch", regexp = "not layout-info's")
  local_dbl(serve("player_h2h.json"))
  expect_error(sportality_player_h2h(S, "gvvuxe9ysw", TM), class = "hoopR_asset_fetch", regexp = "not the data asked for")
  local_dbl(serve("next_game_day.json"))
  expect_error(sportality_next_game_day(season = 2026), class = "hoopR_asset_fetch", regexp = "not the data asked for")
  sched <- dbl_json("schedule.json")
  other <- sched
  other$ssgtUuid <- "m8izm7whkk"
  for (i in seq_along(other$gameInfo)) other$gameInfo[[i]]$ssgtUuid <- "m8izm7whkk"
  local_dbl(serve_body(other))
  expect_error(sportality_schedule(2026), class = "hoopR_asset_fetch", regexp = "not the data asked for")
  late <- sched
  late$gameInfo[[1]]$rawStartDateTime <- "2019-10-01T17:00:00.000Z"
  local_dbl(serve_body(late))
  expect_error(sportality_schedule(2026), class = "hoopR_asset_fetch", regexp = "outside the season window")
  few <- sched
  few$teamList <- few$teamList[1:3]
  local_dbl(serve_body(few))
  expect_error(sportality_schedule(2026), class = "hoopR_asset_fetch", regexp = "team list")
  ov <- dbl_json("game_overview.json")
  ov$gameUuid <- NULL
  local_dbl(serve_body(ov))
  expect_error(sportality_game_overview(G), class = "hoopR_asset_fetch", regexp = "cannot be verified")
  ts <- dbl_json("team_stats.json")
  ts$away$gameUuid <- "zzzzzzzzzz"
  local_dbl(serve_body(ts))
  expect_error(sportality_team_stats(G), class = "hoopR_asset_fetch", regexp = "not the data asked for")
})

test_that("play-by-play must be one whole, finished game", {
  pbp <- dbl_json("pbp.json")
  is_end <- vapply(pbp, function(e) identical(e$type, "game") && identical(e$subType, "end"), logical(1))
  local_dbl(serve("pbp.json"))
  expect_error(sportality_pbp("zzzzzzzzzz"), class = "hoopR_asset_fetch", regexp = "gameUuid='c4hh5nig6t'")
  local_dbl(serve_body(pbp[!is_end]))
  expect_error(sportality_pbp(G), class = "hoopR_asset_fetch", regexp = "truncated feed")
  live <- pbp
  live[[which(is_end)]]$gameState <- "ongoing"
  local_dbl(serve_body(live))
  expect_error(sportality_pbp(G), class = "hoopR_asset_fetch", regexp = "unfinished game")
  side <- function(e) if (is.list(e$eventTeam)) e$eventTeam$place else ""
  home <- which(vapply(pbp, function(e) identical(side(e), "home") && is.list(e$player), logical(1)))[1]
  away <- which(vapply(pbp, function(e) identical(side(e), "away") && is.list(e$player), logical(1)))[1]
  both <- pbp
  both[[away]]$player$playerId <- both[[home]]$player$playerId
  local_dbl(serve_body(both))
  expect_error(sportality_pbp(G), class = "hoopR_asset_fetch", regexp = "plays for both teams")
  wrong <- pbp
  wrong[[home]]$eventTeam$teamId <- "999"
  local_dbl(serve_body(wrong))
  expect_error(sportality_pbp(G), class = "hoopR_asset_fetch", regexp = "eventTeam 'home'")
  two <- pbp
  two[[3]]$gameSourceId <- "999"
  local_dbl(serve_body(two))
  expect_error(sportality_pbp(G), class = "hoopR_asset_fetch", regexp = "Genius match ids")
})

test_that("box scores need one totals row per side, own-side players and nobody on both sides", {
  box <- dbl_json("boxscore.json")
  foreign <- box
  i <- which(vapply(foreign$stats$homeTeamValue, function(r) !identical(r$info$playerId, ""), logical(1)))[1]
  foreign$stats$homeTeamValue[[i]]$info$playerId <- 1L
  local_dbl(serve_body(foreign))
  expect_error(sportality_boxscore(G), class = "hoopR_asset_fetch", regexp = "not in the homeTeamValue players map")
  no_totals <- box
  no_totals$stats$awayTeamValue <- Filter(function(r) !identical(r$info$label, "sports.stats.team_totals"),
                                          no_totals$stats$awayTeamValue)
  local_dbl(serve_body(no_totals))
  expect_error(sportality_boxscore(G), class = "hoopR_asset_fetch", regexp = "0 team_totals rows")
  twice <- box
  pid <- names(twice$players$homeTeamValue)[1]
  twice$players$awayTeamValue[[pid]] <- twice$players$homeTeamValue[[pid]]
  local_dbl(serve_body(twice))
  expect_error(sportality_boxscore(G), class = "hoopR_asset_fetch", regexp = "both sides")
  ov <- dbl_json("game_overview.json")
  ov$state <- "GameOngoing"
  local_dbl(serve_body(ov))
  expect_error(sportality_game_overview(G), class = "hoopR_asset_fetch", regexp = "unfinished game")
})

test_that("the provider route answers a bare word; anything else is refused", {
  local_dbl(function(req) dbl_resp("<!doctype html><html>app shell</html>", type = "text/html"))
  expect_error(sportality_ssgt_provider(S), class = "hoopR_asset_fetch", regexp = "not a provider name")
})

test_that("personal data never reaches a frame", {
  body <- dbl_json("athlete_details.json")
  body$athleteData$dateOfBirth <- "2007-03-01"
  body$athleteData$contactInfo <- list(email = "x@y.z")
  local_dbl(serve_body(body))
  out <- sportality_athlete_details("dpu0901c0t")
  expect_false(any(grepl("birth|dob|mail|phone|address|contact", names(out))))
  expect_identical(.sportality_scrub(list(a = list(birthDate = "x", tel = "1", keep = 1L))), list(a = list(keep = 1L)))
})

test_that("an empty or malformed payload parses to a zero-row frame with the documented columns", {
  parsers <- c(
    athlete_career = ".sportality_parse_stats_info", athlete_details = ".sportality_parse_athlete",
    athlete_profile = ".sportality_parse_page", boxscore = ".sportality_parse_player_box",
    game_header = ".sportality_parse_page", game_overview = ".sportality_parse_page",
    game_summary = ".sportality_parse_page", last_game_day = ".sportality_parse_schedule",
    layout_info = ".sportality_parse_layout", next_game_day = ".sportality_parse_schedule",
    pbp = ".sportality_parse_pbp", player_box = ".sportality_parse_player_box",
    player_h2h = ".sportality_parse_h2h", post_game_team_stats = ".sportality_parse",
    roster = ".sportality_parse_roster", schedule = ".sportality_parse_schedule",
    season_filter = ".sportality_parse_filter", sites = ".sportality_parse", ssgt_provider = ".sportality_parse",
    standings = ".sportality_parse_standings", stats_info = ".sportality_parse_stats_info",
    team = ".sportality_parse_page", team_played_games = ".sportality_parse_schedule",
    team_stats = ".sportality_parse_team_stats", team_upcoming_games = ".sportality_parse_schedule"
  )
  expect_setequal(names(parsers), names(.sportality_schemas))
  rtype <- c(i = "integer", f = "numeric", s = "character", b = "logical")
  for (short in names(parsers)) {
    schema <- .sportality_schemas[[short]]
    for (payload in list(list(), stats::setNames(list(), character()), NULL, "<html>", 3L, list(NULL),
                         list(stats = NULL))) {
      out <- get(parsers[[short]])(payload, schema)
      expect_identical(nrow(out), 0L, label = short)
      expect_identical(names(out), names(schema), label = short)
      got <- vapply(out, function(x) if (is.double(x)) "numeric" else class(x)[[1]], character(1))
      expect_identical(unname(got), unname(rtype[schema]), label = short)
    }
  }
  expect_identical(ncol(.sportality_parse_player_crosswalk(list())), 0L)
})

test_that("parser details: qualifiers, JSON cells, the provider word", {
  a <- .sportality_parse_pbp(list(list(type = "2pt", qualifiers = list("fastbreak", "pointsinthepaint"))))
  b <- .sportality_parse_pbp(list(list(type = "2pt", qualifiers = "fastbreak;pointsinthepaint")))
  expect_identical(a$qualifiers, "fastbreak;pointsinthepaint")
  expect_identical(b$qualifiers, a$qualifiers)
  expect_identical(.sportality_pyjson(list(b = 1.5, a = list(1L, TRUE, NULL, "x\"y"))),
                   '{"a": [1, true, null, "x\\"y"], "b": 1.5}')
  expect_identical(.sportality_pyfloat(20), "20.0")
  expect_identical(.sportality_column("FG%"), "fg_perc")
  expect_identical(.sportality_column("+/-"), "plus_minus")
  expect_identical(.sportality_parse("genius-basketball")$provider, "genius-basketball")
})

test_that("live: the season directory and one stats table", {
  skip_intl_live()
  expect_match(sportality_ssgt_uuid(2026), "^[a-z0-9]{10}$")
  teams <- sportality_stats_info("teams_summary", 2026)
  expect_gt(nrow(teams), 8L)
  expect_type(teams$info_team_id, "integer")
})
