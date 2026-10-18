# Offline tests of the BNXT League (Sportpress) family: R/sportpress.R, R/sportpress_runtime.R,
# R/sportpress_parsers.R. Every request is mocked through httr2 (the bnxtleague.com bundle and the API),
# so the header key, the renewal, the redirect policy, the finished-game gate and the error vocabulary
# run end to end; sleeps are mocked, never slept. Parity: fixtures/sportpress/parity/<wrapper>.csv is
# sdv-py's frame of the same wrapper on the same fixture (see fixtures/sportpress/README.md).

sp_fixture <- function(...) test_path("fixtures", "sportpress", ...)
sp_text <- function(rel) {
  con <- if (endsWith(rel, ".gz")) gzfile(sp_fixture(rel), encoding = "UTF-8") else file(sp_fixture(rel), encoding = "UTF-8")
  on.exit(close(con))
  paste(readLines(con, warn = FALSE), collapse = "\n")
}
sp_json <- function(rel) jsonlite::parse_json(sp_text(rel), simplifyVector = FALSE)
sp_dump <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

SP_KEY <- paste0(strrep("A", 12), strrep("b", 12), strrep("7", 12)) # 36 letters / digits, not the fallback
SP_HOME <- '<html><script src="/js/app.0a1b2c.js"></script></html>'
SP_JS <- paste0('var h={};h["X-Authorization"] = "', SP_KEY, '";')

json_resp <- function(body, status = 200L, ctype = "application/json") {
  text <- if (is.character(body)) body else sp_dump(body)
  httr2::response(status, headers = list("Content-Type" = ctype), body = charToRaw(enc2utf8(text)))
}

# Mock the bundle and the API. `routes` maps an API path (under /api/v1) to a fixture path, a parsed
# body, or a function(req) returning a response; `seen$api` records every API request. The session's
# key and finished-game cache are cleared before and after.
local_sportpress <- function(routes = list(), home = SP_HOME, js = SP_JS, env = parent.frame()) {
  seen <- new.env()
  seen$api <- list()
  seen$site <- 0L
  withr::local_options(cli.width = 10000, .local_envir = env) # one-line messages for the regex matches
  local_intl_clock(env)
  rm(list = ls(.sportpress_state), envir = .sportpress_state)
  withr::defer(rm(list = ls(.sportpress_state), envir = .sportpress_state), envir = env)
  local_mocked_bindings(.intl_sleep = function(seconds) NULL, .intl_now = function() 0, .package = "hoopR", .env = env)
  httr2::local_mocked_responses(function(req) {
    if (startsWith(req$url, .SPORTPRESS_SITE)) {
      seen$site <- seen$site + 1L
      if (is.function(home)) return(home(req))
      body <- if (grepl("/js/app", req$url, fixed = TRUE)) js else home
      return(httr2::response(200, headers = list("Content-Type" = "text/html"), body = charToRaw(body)))
    }
    seen$api[[length(seen$api) + 1L]] <- req
    path <- sub("\\?.*$", "", substring(req$url, nchar(.SPORTPRESS_API) + 1L))
    r <- routes[[path]]
    if (is.null(r)) return(json_resp(list(data = list())))
    if (is.function(r)) return(r(req))
    json_resp(if (is.character(r)) sp_text(r) else r)
  }, env = env)
  seen
}

FIND <- list(`/schedule/find/11295` = "full/game_find.json")
# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator, see README.md)
SP_CASES <- list(
  ui_strings = list(list(), list(`/server-config` = "cap/server_config.json")),
  club_seasons = list(list(), list(`/competition-team/club/seasons` = "cap/club_seasons.json")),
  referees = list(list(), list(`/staff/list` = "cap/staff_list.json")),
  phases = list(list(season = 2026), list(`/phase/season/2026` = "cap/phase_season.json")),
  competition_teams = list(list(competition_id = 24), list(`/competition-team/all` = "cap/competition_teams.json")),
  competition_staff = list(list(competition_id = 24), list(`/competition-team/all` = "cap/competition_teams.json")),
  standings = list(list(competition_id = 24, phase_id = 169),
                   list(`/standings/competition/24/phase/169` = "cap/standings.json")),
  schedule = list(list(season = 2027), list(`/schedule/club/2027` = "full/schedule.json")),
  game_slider = list(list(competition_id = 25), list(`/schedule/game-slider/25` = "full/game_slider.json")),
  team_rankings = list(list(competition_id = 24),
                       list(`/competition-team/average-rankings/24` = "cap/team_rankings.json")),
  player_rankings = list(list(competition_id = 24), list(`/player/average-rankings/24` = "cap/player_rankings.json")),
  season_roster = list(list(season = 2027), list(`/roster/season-players/2027` = "full/season_roster.json")),
  nationality_codes = list(list(season = 2026),
                           list(`/roster/season-nationality-codes/2026` = "cap/nationality_codes.json")),
  team_roster = list(list(competition_team_id = 506), list(`/roster/team-players/506` = "cap/team_roster.json")),
  team_find = list(list(competition_team_id = 506), list(`/competition-team/find/506` = "cap/team_find.json")),
  team_player_averages = list(list(competition_team_id = 541),
                              list(`/competition-team/player-averages/541` = "full/team_player_averages.json")),
  team_games = list(list(competition_team_id = 506),
                    list(`/competition-team/statistics-by-game/total/506` = "cap/team_games.json")),
  roster_find = list(list(roster_id = 10609), list(`/roster/find/10609` = "cap/roster_find.json")),
  player_career = list(list(roster_id = 10609), list(`/player/career-averages/10609` = "cap/player_career.json")),
  player_games = list(list(roster_id = 10609), list(`/boxscore/player/season-games/10609` = "cap/player_games.json")),
  game_find = list(list(game_id = 11295), FIND),
  game_periods = list(list(game_id = 11295), FIND),
  game_overview = list(list(game_id = 11295), c(FIND, list(`/schedule/overview/11295` = "full/overview.json"))),
  game_top_performers = list(list(game_id = 11295), c(FIND, list(`/schedule/overview/11295` = "full/overview.json"))),
  game_leaders = list(list(game_id = 11295), c(FIND, list(`/schedule/overview/11295` = "full/overview.json"))),
  game_box = list(list(competition_id = 25, game_id = 11295), c(FIND, list(`/boxscore/game/25/11295` = "full/box.json"))),
  game_team_box = list(list(competition_id = 25, game_id = 11295),
                       c(FIND, list(`/boxscore/game/25/11295` = "full/box.json"))),
  game_film = list(list(competition_id = 25, game_id = 11295), c(FIND, list(`/film/game/25/11295` = "full/film.json.gz")))
)
SP_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character", Date = "Date")

run_case <- function(short, env = parent.frame()) {
  spec <- SP_CASES[[short]]
  seen <- local_sportpress(spec[[2]], env = env)
  out <- do.call(paste0("sportpress_", short), spec[[1]])
  list(out = out, seen = seen)
}

# cells that differ, NA-vs-value counted as a mismatch
parity_mismatches <- function(got, want_chr) {
  if (inherits(got, "POSIXct")) got <- format(got, "%Y-%m-%d %H:%M:%S")
  if (inherits(got, "Date")) got <- format(got, "%Y-%m-%d")
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

r_type <- function(x) {
  if (inherits(x, "POSIXct")) return("POSIXct")
  if (inherits(x, "Date")) return("Date")
  if (is.double(x)) "numeric" else class(x)[[1]]
}

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, types, cells, requests)", {
  manifest <- jsonlite::read_json(sp_fixture("parity", "manifest.json"))
  expect_setequal(paste0("sportpress_", names(SP_CASES)), names(manifest$dtypes))
  expect_setequal(names(SP_CASES), names(.SPORTPRESS_SPECS))
  for (short in names(SP_CASES)) {
    fn <- paste0("sportpress_", short)
    res <- run_case(short)
    got <- res$out
    want <- utils::read.csv(sp_fixture("parity", paste0(fn, ".csv")), colClasses = "character",
                            na.strings = "\\N", check.names = FALSE, encoding = "UTF-8")
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = short)
    expect_identical(nrow(got), nrow(want), label = short)
    dt <- unlist(manifest$dtypes[[fn]])
    want_types <- ifelse(startsWith(dt, "Datetime"), "POSIXct", SP_RTYPE[dt])
    expect_identical(vapply(got, r_type, character(1)), stats::setNames(unname(want_types), names(dt)), label = short)
    bad <- vapply(names(got), function(n) parity_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(short, "mismatched columns"))
    # the same requests sdv-py sends, in order: path and query
    sent <- lapply(res$seen$api, function(req) {
      parts <- httr2::url_parse(req$url)
      list(path = substring(parts$path, nchar("/api/v1") + 1L), query = parts$query %||% list())
    })
    want_req <- manifest$requests[[fn]]
    expect_identical(length(sent), length(want_req), label = short)
    for (i in seq_along(want_req)) {
      expect_identical(sent[[i]]$path, want_req[[i]]$path, label = short)
      flat <- function(q) paste(names(q), vapply(q, as.character, ""), sep = "=", collapse = "&")
      expect_identical(flat(sent[[i]]$query), flat(want_req[[i]]$query), label = short)
    }
  }
})

test_that("ids keep one integer type; game_time is league local time; genius_id is the Genius match id", {
  for (short in names(.SPORTPRESS_SPECS)) {
    spec <- .SPORTPRESS_SPECS[[short]]
    ids <- names(spec)[endsWith(names(spec), "_id") | names(spec) %in% c("season", "rank", "genius_id")]
    expect_true(all(vapply(spec[ids], `[[`, "", 1) == "i"), label = short)
  }
  slider <- run_case("game_slider")$out
  expect_type(slider$genius_id, "integer")
  expect_false(anyNA(slider$genius_id))
  expect_false("genius_id" %in% names(run_case("schedule")$out))
  game <- run_case("game_find")$out
  expect_s3_class(game$game_time, "POSIXct")
  expect_identical(attr(game$game_time, "tzone"), "Europe/Brussels")
  expect_identical(format(game$game_time, "%Y-%m-%d %H:%M:%S %Z"), "2026-10-10 20:30:00 CEST")
  box <- run_case("game_box")$out
  expect_s3_class(box$birth_date, "Date")
  pts <- vapply(c(home = "home", away = "away"), function(s) sum(box$points[box$team_side == s]), integer(1))
  expect_identical(pts, c(home = 113L, away = 106L))
})

test_that("season is the END year, sent as is; integer arguments accept whole doubles and digit strings", {
  res <- run_case("phases")
  expect_match(res$seen$api[[1]]$url, "/phase/season/2026$")
  expect_identical(unique(res$out$season), 2026L)
  for (season in list(2026L, "2026", " 2026 ")) {
    seen <- local_sportpress(list(`/phase/season/2026` = "cap/phase_season.json"))
    expect_identical(nrow(sportpress_phases(season = season)), 3L)
  }
  seen <- local_sportpress()
  for (bad in list(2026.5, "x", "20a6", TRUE, NA, c(2025, 2026), NULL, list(2026))) {
    err <- expect_error(sportpress_phases(season = bad), class = "hoopR_bad_request")
    expect_match(conditionMessage(err), "season")
    expect_identical(format(err$call[[1]]), "sportpress_phases") # the error names the exported wrapper
  }
  expect_error(sportpress_schedule(season = 2027, month = "May"), class = "hoopR_bad_request")
  expect_error(sportpress_game_box(competition_id = 25, game_id = 1.5), class = "hoopR_bad_request")
  expect_identical(length(seen$api), 0L)
  expect_identical(seen$site, 0L)
})

test_that("the key is read from the bundle once per session, sent with X-Localization, no redirects", {
  seen <- local_sportpress(SP_CASES$club_seasons[[2]])
  sportpress_club_seasons()
  sportpress_club_seasons()
  expect_identical(seen$site, 2L) # the home page and the script, once
  req <- seen$api[[1]]
  expect_identical(unclass(req$headers[["X-Authorization"]]), SP_KEY)
  expect_identical(req$headers[["X-Localization"]], "en")
  expect_identical(req$options$followlocation, 0L)
  expect_identical(.sportpress_state$key_source, "bundle")
})

test_that("the documented fallback key answers any failure to read the bundle", {
  for (home in list("<html>no script</html>", function(req) json_resp("down", 503L, "text/html"))) {
    seen <- local_sportpress(SP_CASES$club_seasons[[2]], home = home)
    sportpress_club_seasons()
    expect_identical(unclass(seen$api[[1]]$headers[["X-Authorization"]]), .SPORTPRESS_FALLBACK_KEY)
    expect_identical(.sportpress_state$key_source, "fallback")
  }
  seen <- local_sportpress(SP_CASES$club_seasons[[2]], js = 'h["X-Authorization"] = "too-short"')
  sportpress_club_seasons()
  expect_identical(.sportpress_state$key_source, "fallback")
})

test_that("a rejected key is renewed once, then refused without leaking it", {
  seen <- local_sportpress(list(`/server-config` = function(req) json_resp(list(message = "Unauthenticated."), 401L)))
  err <- expect_error(sportpress_ui_strings(), class = "hoopR_asset_fetch")
  expect_identical(length(seen$api), 2L)
  expect_identical(seen$site, 4L) # read, then re-read once
  expect_match(conditionMessage(err), "key rotated?", fixed = TRUE)
  expect_identical(err$status, 401L)
  expect_false(grepl(SP_KEY, conditionMessage(err), fixed = TRUE))
  expect_identical(.sportpress_scrub(paste("k", SP_KEY, .SPORTPRESS_FALLBACK_KEY)), "k <key> <key>")
})

test_that("the HTTP status vocabulary: 404, 400 / 422, 5xx after three attempts, a redirect, non-JSON", {
  status_route <- function(s, body = "{}", ctype = "application/json") {
    list(`/staff/list` = function(req) json_resp(body, s, ctype))
  }
  seen <- local_sportpress(status_route(404L))
  expect_error(sportpress_referees(), class = "hoopR_no_data")
  for (s in c(400L, 422L)) {
    local_sportpress(status_route(s))
    expect_error(sportpress_referees(), class = "hoopR_bad_request")
  }
  seen <- local_sportpress(status_route(500L))
  err <- expect_error(sportpress_referees(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_identical(length(seen$api), 3L) # sdv-py retries 500 for this family
  local_sportpress(status_route(302L))
  err <- expect_error(sportpress_referees(), class = "hoopR_asset_fetch")
  expect_false(err$transient)
  local_sportpress(status_route(200L, "<html></html>", "text/html"))
  expect_error(sportpress_referees(), "not JSON", class = "hoopR_asset_fetch")
  local_sportpress(status_route(200L, "  "))
  expect_error(sportpress_referees(), "empty body", class = "hoopR_asset_fetch")
  local_sportpress(status_route(200L, "{not json"))
  expect_error(sportpress_referees(), "not JSON", class = "hoopR_asset_fetch")
})

test_that("envelopes: an empty list is no data, an error or changed envelope is refused", {
  route <- function(body) list(`/staff/list` = body)
  local_sportpress(route(list(data = list())))
  expect_error(sportpress_referees(), class = "hoopR_no_data")
  local_sportpress(route(list(message = "Server Error")))
  expect_error(sportpress_referees(), "error envelope", class = "hoopR_asset_fetch")
  local_sportpress(route(list(data = list(), meta = list(page = 1L))))
  expect_error(sportpress_referees(), "list envelope", class = "hoopR_asset_fetch")
  local_sportpress(route(list(data = list(1L, 2L))))
  expect_error(sportpress_referees(), "not an object", class = "hoopR_asset_fetch")
  local_sportpress(list(`/competition-team/find/506` = list(data = list())))
  expect_error(sportpress_team_find(competition_team_id = 506), class = "hoopR_no_data")
  local_sportpress(list(`/player/average-rankings/24` = list()))
  expect_error(sportpress_player_rankings(competition_id = 24), class = "hoopR_no_data")
  local_sportpress(list(`/roster/season-nationality-codes/2026` = list()))
  expect_error(sportpress_nationality_codes(season = 2026), class = "hoopR_no_data")
  ranks <- sp_json("cap/player_rankings.json")
  local_sportpress(list(`/player/average-rankings/24` = rev(ranks)))
  expect_error(sportpress_player_rankings(competition_id = 24), "nine ranking", class = "hoopR_asset_fetch")
  # one category is fine when `type` asks for it
  seen <- local_sportpress(list(`/player/average-rankings/24` = ranks["points"]))
  pts <- sportpress_player_rankings(competition_id = 24, limit = 3, type = "points")
  expect_identical(unique(pts$category), "points")
  expect_match(seen$api[[1]]$url, "limit=3&type=points", fixed = TRUE)
  local_sportpress(list(`/server-config` = list(available_lang_array = list(list(alpha2 = "en", resources = list(a = "b"))))))
  expect_error(sportpress_ui_strings(), "language tables", class = "hoopR_asset_fetch")
})

test_that("wrong-scope bodies are refused (season, competition, team, roster, game, title)", {
  phase <- sp_json("cap/phase_season.json")
  local_sportpress(list(`/phase/season/2025` = phase))
  expect_error(sportpress_phases(season = 2025), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/competition-team/all` = "cap/competition_teams.json"))
  expect_error(sportpress_competition_teams(competition_id = 25), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/competition-team/find/507` = "cap/team_find.json"))
  expect_error(sportpress_team_find(competition_team_id = 507), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/roster/find/1` = "cap/roster_find.json"))
  expect_error(sportpress_roster_find(roster_id = 1), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/roster/team-players/541` = "cap/team_roster.json"))
  expect_error(sportpress_team_roster(competition_team_id = 541), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/schedule/game-slider/24` = "full/game_slider.json"))
  expect_error(sportpress_game_slider(competition_id = 24), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/schedule/club/2026` = "full/schedule.json"))
  expect_error(sportpress_schedule(season = 2026), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/schedule/club/2027` = "full/schedule.json"))
  expect_error(sportpress_schedule(season = 2027, phase_id = 1), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/schedule/find/1` = "full/game_find.json"))
  expect_error(sportpress_game_find(game_id = 1), "out of scope", class = "hoopR_asset_fetch")
  local_sportpress(list(`/competition-team/statistics-by-game/total/541` = "cap/team_games.json"))
  expect_error(sportpress_team_games(competition_team_id = 541), "out of scope", class = "hoopR_asset_fetch")
  staff <- sp_json("cap/staff_list.json")
  staff$data[[1]]$title$id <- 3L
  local_sportpress(list(`/staff/list` = staff))
  expect_error(sportpress_referees(), "title 2", class = "hoopR_asset_fetch")
})

test_that("the game routes need a finished game of the asked competition, both sides and the final score", {
  find <- sp_json("full/game_find.json")
  live <- find
  live$data$status <- "live"
  seen <- local_sportpress(list(`/schedule/find/11295` = live))
  expect_error(sportpress_game_box(competition_id = 25, game_id = 11295), "not finished", class = "hoopR_asset_fetch")
  expect_identical(length(seen$api), 1L) # refused before the box score is requested
  expect_identical(nrow(sportpress_game_find(game_id = 11295)), 1L) # the game itself is fine
  seen <- local_sportpress(SP_CASES$game_box[[2]])
  expect_error(sportpress_game_box(competition_id = 24, game_id = 11295), "of competition 25", class = "hoopR_asset_fetch")
  # a finished game is read once per session
  sportpress_game_box(competition_id = 25, game_id = 11295)
  sportpress_game_team_box(competition_id = 25, game_id = 11295)
  paths <- vapply(seen$api, function(r) httr2::url_parse(r$url)$path, "")
  expect_identical(sum(paths == "/api/v1/schedule/find/11295"), 1L)
  box <- sp_json("full/box.json")
  box$data[[2]]$team$id <- 1L
  local_sportpress(c(FIND, list(`/boxscore/game/25/11295` = box)))
  expect_error(sportpress_game_box(competition_id = 25, game_id = 11295), "not a side", class = "hoopR_asset_fetch")
  film <- sp_json("full/film.json.gz")
  film$data <- film$data[1:100]
  local_sportpress(c(FIND, list(`/film/game/25/11295` = film)))
  expect_error(sportpress_game_film(competition_id = 25, game_id = 11295), "truncated or foreign",
               class = "hoopR_asset_fetch")
  ov <- sp_json("full/overview.json")
  ov$data$team_totals[[1]]$competitor$finalScore <- 1L
  local_sportpress(c(FIND, list(`/schedule/overview/11295` = ov)))
  expect_error(sportpress_game_overview(game_id = 11295), "final score", class = "hoopR_asset_fetch")
  ov <- list(data = list(team_totals = list(), top_performer = list(), game_leaders = list()))
  local_sportpress(c(FIND, list(`/schedule/overview/11295` = ov)))
  expect_error(sportpress_game_overview(game_id = 11295), class = "hoopR_no_data")
})

test_that("an empty valid result is a zero-row tibble with the documented columns and types", {
  teams <- sp_json("cap/competition_teams.json")
  teams$data <- lapply(teams$data, function(t) {
    t$staffs <- list()
    t
  })
  local_sportpress(list(`/competition-team/all` = teams))
  staff <- sportpress_competition_staff(competition_id = 24)
  expect_identical(nrow(staff), 0L)
  expect_identical(names(staff), names(.SPORTPRESS_SPECS$competition_staff))
  expect_type(staff$staff_id, "integer")
  find <- sp_json("full/game_find.json")
  find$data$competitors <- lapply(find$data$competitors, function(c) {
    c$period_scores <- list()
    c
  })
  local_sportpress(list(`/schedule/find/11295` = find))
  periods <- sportpress_game_periods(game_id = 11295)
  expect_identical(nrow(periods), 0L)
  expect_identical(names(periods), c("game_id", "team_side", "competition_team_id", "period", "score"))
  for (short in names(.SPORTPRESS_SPECS)) { # any malformed body parses to the typed empty frame
    for (bad in list(NULL, list(), "x", list(data = "x"))) {
      df <- .sportpress_parse(short, bad, "t")
      expect_identical(nrow(df), 0L, label = short)
      expect_identical(names(df), names(.SPORTPRESS_SPECS[[short]]), label = short)
    }
  }
})

test_that("contact fields are dropped; only a player's birth date is kept", {
  body <- list(data = list(
    list(id = 1L, email = "a@b", Phone = "1", staff = list(birthdate = "1970-01-01", name = "x"),
         player = list(birthdate = "2000-01-02", instagram = "@p", first_name = "P"))
  ))
  out <- .sportpress_scrub_personal(body)
  expect_identical(names(out$data[[1]]), c("id", "staff", "player"))
  expect_identical(names(out$data[[1]]$staff), "name")
  expect_identical(out$data[[1]]$player, list(birthdate = "2000-01-02", first_name = "P"))
  ref <- run_case("referees")$out
  expect_false(any(grepl("mail|phone|birth", names(ref))))
})

test_that("live: one BNXT schedule and its first game", {
  skip_intl_live()
  sched <- sportpress_schedule(season = 2026)
  expect_true(nrow(sched) > 0)
  expect_type(sched$game_id, "integer")
  game <- sportpress_game_find(game_id = sched$game_id[[1]])
  expect_identical(game$game_id, sched$game_id[[1]])
})
