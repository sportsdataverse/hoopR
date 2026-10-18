# Offline tests of the TPBL family: R/tpbl.R, R/tpbl_runtime.R, R/tpbl_parsers.R. Every request is mocked
# through httr2, so the season mapping, the game checks, the scope checks, the retries and the error
# vocabulary run end to end; the throttle is recorded, never slept. Parity:
# tests/testthat/fixtures/tpbl/parity/<case>.csv is sdv-py's frame of the same wrapper on the same fixture
# (see fixtures/tpbl/README.md).

tpbl_fixture <- function(...) test_path("fixtures", "tpbl", ...)
tpbl_text <- function(rel) paste(readLines(tpbl_fixture(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
tpbl_body <- function(rel) jsonlite::parse_json(tpbl_text(rel), simplifyVector = FALSE)

TPBL_API <- "https://api.tpbl.basketball/api"

# route -> fixture, the same table as the sdv-py generator
TPBL_ROUTES <- c(
  "/seasons" = "seasons.json", "/events/3/divisions" = "divisions_3.json", "/events/2/teams" = "teams_2.json",
  "/seasons/3/games" = "games_3.json", "/divisions/2/games/standings" = "standings_2.json",
  "/games/6" = "game_6.json", "/games/6/stats" = "box_6.json", "/divisions/2/teams/4/players" = "roster_2_4.json",
  "/divisions/2/teams/4/shooting-spots" = "team_shots_2_4.json",
  "/divisions/2/players/75/shooting-spots" = "player_shots_2_75.json",
  "/players/75/games/stats" = "player_games_75_2.json"
)

tpbl_resp <- function(body, status = 200L, ctype = "application/json", headers = list()) {
  text <- if (is.character(body)) body else {
    as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null", digits = NA))
  }
  httr2::response(status, headers = c(list("Content-Type" = ctype), headers), body = charToRaw(enc2utf8(text)))
}
tpbl_path <- function(req) sub(paste0("^", TPBL_API), "", sub("\\?.*$", "", req$url))
tpbl_query <- function(req) httr2::url_parse(req$url)$query %||% list()

# The default answer of a request: the route's fixture (the team-3 game list and the first-quarter shots
# answer their own files, as in the sdv-py generator).
tpbl_default <- function(req) {
  path <- tpbl_path(req)
  q <- tpbl_query(req)
  if (path == "/seasons/3/games" && identical(q$team_id, "3")) return("games_3_team3.json")
  if (path == "/divisions/2/teams/4/shooting-spots" && identical(unname(unlist(q)), "1")) {
    return("team_shots_2_4_r1.json")
  }
  if (path %in% names(TPBL_ROUTES)) return(TPBL_ROUTES[[path]])
  stop("unexpected request ", path)
}

# Mock the API. `over` replaces routes: a fixture name, an R body, an httr2 response, a list of those
# (answered in turn, see tpbl_turns) or a function(req). `seen` records every request and every throttle
# wait; the session cache is cleared before and after.
local_tpbl <- function(over = list(), env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$waits <- list()
  .tpbl_clear_cache()
  withr::defer(.tpbl_clear_cache(), envir = env)
  withr::local_options(cli.width = 10000, .local_envir = env)
  local_mocked_bindings(
    .intl_wait = function(url, min_interval = 1) {
      seen$waits[[length(seen$waits) + 1L]] <- list(url = url, interval = min_interval)
      invisible(0)
    },
    .package = "hoopR", .env = env
  )
  answers <- new.env()
  httr2::local_mocked_responses(function(req) {
    path <- tpbl_path(req)
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    ans <- if (path %in% names(over)) over[[path]] else tpbl_default(req)
    if (is.list(ans) && !is.null(attr(ans, "turns"))) {
      i <- (answers[[path]] %||% 0L) + 1L
      answers[[path]] <- i
      ans <- ans[[min(i, length(ans))]]
    }
    if (is.function(ans)) ans <- ans(req)
    if (inherits(ans, "httr2_response")) return(ans)
    if (is.character(ans) && length(ans) == 1L && endsWith(ans, ".json")) return(tpbl_resp(tpbl_text(ans)))
    tpbl_resp(ans)
  }, env = env)
  seen
}
tpbl_turns <- function(...) structure(list(...), turns = TRUE)
tpbl_paths <- function(seen) vapply(seen$reqs, tpbl_path, character(1))

# the wrapper calls of the parity CSVs (the same calls as the sdv-py generator)
TPBL_CASES <- list(
  tpbl_seasons = list(),
  tpbl_divisions = list(season = 2027),
  tpbl_teams = list(season = 2026),
  tpbl_games = list(season = 2027),
  tpbl_games__team3 = list(season = 2027, team_id = 3),
  tpbl_standings = list(division_id = 2),
  tpbl_standings_against = list(division_id = 2),
  tpbl_game = list(game_id = 6),
  tpbl_referees = list(game_id = 6),
  tpbl_box_players = list(game_id = 6),
  tpbl_box_player_periods = list(game_id = 6),
  tpbl_box_teams = list(game_id = 6),
  tpbl_box_team_periods = list(game_id = 6),
  tpbl_roster = list(division_id = 2, team_id = 4),
  tpbl_team_shots = list(division_id = 2, team_id = 4),
  tpbl_team_shots__r1 = list(division_id = 2, team_id = 4, rounds = 1),
  tpbl_player_shots = list(division_id = 2, player_id = 75),
  tpbl_player_games = list(player_id = 75, division_id = 2)
)
TPBL_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character", Date = "Date",
                "Datetime(time_unit='us', time_zone=None)" = "POSIXct")

tpbl_run_case <- function(case, over = list(), env = parent.frame()) {
  seen <- local_tpbl(over, env = env)
  out <- do.call(sub("__.*$", "", case), TPBL_CASES[[case]])
  list(out = out, seen = seen)
}
tpbl_type <- function(x) {
  if (inherits(x, "POSIXct")) "POSIXct" else if (is.double(x) && !inherits(x, "Date")) "numeric" else class(x)[[1]]
}

# cells that differ, NA-vs-value counted as a mismatch
tpbl_mismatches <- function(got, want_chr) {
  if (inherits(got, "POSIXct")) {
    got <- format(got, "%Y-%m-%d %H:%M:%S", tz = "Asia/Taipei")
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

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, order, types, cells, requests)", {
  dtypes <- jsonlite::read_json(tpbl_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(tpbl_fixture("parity", "requests.json"))
  expect_setequal(names(TPBL_CASES), names(dtypes))
  exports <- getNamespaceExports("hoopR")
  expect_setequal(unique(sub("__.*$", "", names(TPBL_CASES))), exports[startsWith(exports, "tpbl_")])
  for (case in names(TPBL_CASES)) {
    res <- tpbl_run_case(case)
    got <- res$out
    want <- utils::read.csv(tpbl_fixture("parity", paste0(case, ".csv")), colClasses = "character",
                            na.strings = "\\N", check.names = FALSE, encoding = "UTF-8")
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(nrow(got), nrow(want), label = case)
    want_types <- stats::setNames(unname(TPBL_RTYPE[unlist(dtypes[[case]])]), names(dtypes[[case]]))
    expect_identical(vapply(got, tpbl_type, character(1)), want_types[names(got)], label = case)
    bad <- vapply(names(got), function(n) tpbl_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the same requests, in the same order, with the same query as sdv-py
    want_req <- requests[[case]]
    expect_identical(paste0("/api", tpbl_paths(res$seen)), vapply(want_req, function(r) r$route, character(1)),
                     label = case)
    flat <- function(x) sort(paste(names(x), vapply(x, function(v) paste(unlist(v), collapse = ","), ""), sep = "="))
    for (i in seq_along(want_req)) {
      expect_identical(flat(tpbl_query(res$seen$reqs[[i]])), flat(want_req[[i]]$params), label = paste(case, i))
    }
  }
})

test_that("ids are integers, tipoff is Taiwan-local POSIXct, the box score adds up", {
  games <- tpbl_run_case("tpbl_games")$out
  for (col in c("season", "season_id", "game_id", "gohoops_game_id", "division_id", "home_team_id", "attendance")) {
    expect_type(games[[col]], "integer")
  }
  expect_identical(attr(games$tipoff, "tzone"), "Asia/Taipei")
  expect_identical(format(games$tipoff[[1]], "%Y-%m-%d %H:%M", tz = "UTC"), "2026-10-09 06:30") # 14:30 UTC+8
  expect_s3_class(games$game_date, "Date")
  box <- tpbl_run_case("tpbl_box_players")$out
  expect_type(box$gohoops_roster_id, "integer")
  expect_type(box$number, "character")
  expect_type(box$efg, "double")
  expect_identical(anyDuplicated(box$gohoops_roster_id), 0L)
  expect_identical(c(sum(box$score[box$side == "home"], na.rm = TRUE), sum(box$score[box$side == "away"],
                                                                         na.rm = TRUE)), c(111L, 108L))
  expect_true(all(is.na(box$score[!box$entered])))
  teams <- tpbl_run_case("tpbl_box_teams")$out
  expect_identical(teams$side, c("home", "away"))
  expect_identical(teams$opponent_team_id, rev(teams$team_id))
  roster <- tpbl_run_case("tpbl_roster")$out
  expect_type(roster$gohoops_roster_id, "integer")
  expect_type(roster$weight_kg, "double")
  # the box score joins the roster on gohoops_roster_id (both integer; game 6 is the 2024-25 preseason, the
  # roster the regular season of the same event, so the ids are the same registrations)
  expect_true(all(roster$gohoops_roster_id %in% box$gohoops_roster_id))
})

test_that("season is the END year, mapped to the API's own season id through /seasons (read once)", {
  seen <- local_tpbl()
  divisions <- tpbl_divisions(season = 2027)
  expect_identical(unique(divisions$season), 2027L)
  expect_identical(unique(divisions$season_id), 3L)
  teams <- tpbl_teams(season = "2026")
  expect_identical(unique(teams$season_id), 2L)
  expect_identical(tpbl_paths(seen), c("/seasons", "/events/3/divisions", "/events/2/teams"))
  # a year the list lacks: the list is re-read once, then hoopR_no_data
  seen <- local_tpbl()
  expect_error(tpbl_teams(season = 2024), class = "hoopR_no_data")
  expect_identical(tpbl_paths(seen), c("/seasons", "/seasons"))
  # a non-integer season is refused before any request
  seen <- local_tpbl()
  for (bad in list(2026.5, "2026-27", TRUE, NA, c(2025, 2026))) {
    expect_error(tpbl_teams(season = bad), class = "hoopR_bad_request")
  }
  expect_length(seen$reqs, 0L)
  # a label that is not 'YYYY-YYYY ...' is layout drift
  rows <- tpbl_body("seasons.json")
  rows[[1]]$name <- "2024 season"
  local_tpbl(list("/seasons" = rows))
  expect_error(tpbl_seasons(), class = "hoopR_asset_fetch")
})

test_that("an empty valid answer raises hoopR_no_data; the parsers give the documented zero-row frame", {
  for (route in list(
    list("/events/3/divisions", quote(tpbl_divisions(2027))),
    list("/seasons/3/games", quote(tpbl_games(2027))),
    list("/divisions/2/games/standings", quote(tpbl_standings(2))),
    list("/divisions/2/games/standings", quote(tpbl_standings_against(2))),
    list("/divisions/2/teams/4/players", quote(tpbl_roster(2, 4))),
    list("/divisions/2/teams/4/shooting-spots", quote(tpbl_team_shots(2, 4))),
    list("/divisions/2/players/75/shooting-spots", quote(tpbl_player_shots(2, 75))),
    list("/players/75/games/stats", quote(tpbl_player_games(75, 2)))
  )) {
    local_tpbl(stats::setNames(list("[]"), route[[1]]))
    expect_error(eval(route[[2]]), class = "hoopR_no_data", label = deparse(route[[2]]))
  }
  dtypes <- jsonlite::read_json(tpbl_fixture("parity", "dtypes.json"))
  for (short in names(.tpbl_specs)) {
    out <- get(paste0(".tpbl_parse_", short))(list(), list())
    want <- dtypes[[paste0("tpbl_", short)]]
    expect_identical(nrow(out), 0L, label = short)
    expect_identical(names(out), names(want), label = short)
    expect_identical(unname(vapply(out, tpbl_type, "")), unname(TPBL_RTYPE[unlist(want)]), label = short)
  }
})

test_that("the HTTP vocabulary: 404 no_data, 400 / 422 bad_request, 5xx retried then asset_fetch", {
  seen <- local_tpbl(list("/games/6" = tpbl_resp("<html>Not Found</html>", 404L, "text/html; charset=UTF-8")))
  expect_error(tpbl_game(6), class = "hoopR_no_data")
  expect_length(seen$reqs, 1L)
  for (status in c(400L, 422L)) {
    local_tpbl(list("/players/75/games/stats" = tpbl_resp("{}", status)))
    expect_error(tpbl_player_games(75, 2), class = "hoopR_bad_request")
  }
  seen <- local_tpbl(list("/seasons" = tpbl_resp("down", 503L, "text/plain")))
  err <- expect_error(tpbl_seasons(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_length(seen$reqs, 3L)
  expect_length(seen$waits, 3L)
  # HTTP 500 is retried on every route but the player game log ...
  seen <- local_tpbl(list("/games/6" = tpbl_turns(tpbl_resp("oops", 500L, "text/plain"), "game_6.json")))
  expect_identical(nrow(tpbl_game(6)), 1L)
  expect_identical(tpbl_paths(seen), c("/games/6", "/games/6"))
  # ... where an unknown division_id answers 500 deterministically: one request, not retried
  seen <- local_tpbl(list("/players/75/games/stats" = tpbl_resp("Server Error", 500L, "text/html")))
  err <- expect_error(tpbl_player_games(75, 999), class = "hoopR_asset_fetch")
  expect_identical(err$status, 500L)
  expect_match(conditionMessage(err), "unknown division_id", fixed = TRUE)
  expect_length(seen$reqs, 1L)
  expect_identical(tpbl_query(seen$reqs[[1]]), list(division_id = "999"))
  # the game log needs division_id (the API answers 422 without it): refused before the request
  seen <- local_tpbl()
  expect_error(tpbl_player_games(75, NULL), class = "hoopR_bad_request")
  expect_length(seen$reqs, 0L)
})

test_that("a non-JSON, empty or error-envelope body is hoopR_asset_fetch", {
  local_tpbl(list("/seasons" = tpbl_resp("<html></html>", ctype = "text/html; charset=UTF-8")))
  expect_error(tpbl_seasons(), "not JSON", class = "hoopR_asset_fetch")
  local_tpbl(list("/seasons" = tpbl_resp("  ")))
  expect_error(tpbl_seasons(), "empty body", class = "hoopR_asset_fetch")
  local_tpbl(list("/seasons" = tpbl_resp("{not json")))
  expect_error(tpbl_seasons(), class = "hoopR_asset_fetch")
  local_tpbl(list("/events/2/teams" = list(message = "Server Error")))
  expect_error(tpbl_teams(2026), "expected a JSON list", class = "hoopR_asset_fetch")
})

test_that("game routes serve finished games only, and the box score must agree with the game detail", {
  game <- tpbl_body("game_6.json")
  unfinished <- utils::modifyList(game, list(status = "NOT_STARTED"))
  local_tpbl(list("/games/6" = unfinished))
  expect_error(tpbl_game(6), "not finished", class = "hoopR_asset_fetch")
  local_tpbl(list("/games/6" = utils::modifyList(game, list(is_live = TRUE))))
  expect_error(tpbl_referees(6), "not finished", class = "hoopR_asset_fetch")
  local_tpbl(list("/games/6" = utils::modifyList(game, list(id = 7L))))
  expect_error(tpbl_game(6), "is not 6", class = "hoopR_asset_fetch")
  local_tpbl(list("/games/6" = utils::modifyList(game, list(id = "6"))))
  expect_error(tpbl_game(6), class = "hoopR_asset_fetch") # type-strict
  local_tpbl(list("/games/6" = utils::modifyList(game, list(round = 3L))))
  expect_error(tpbl_game(6), "quarter count", class = "hoopR_asset_fetch")
  # the detail is cached: two box-score wrappers read /games/6 once
  seen <- local_tpbl()
  tpbl_box_players(6)
  tpbl_box_team_periods(6)
  expect_identical(tpbl_paths(seen), c("/games/6", "/games/6/stats", "/games/6/stats"))
  box <- tpbl_body("box_6.json")
  swapped <- box
  swapped$home_team <- box$away_team
  swapped$away_team <- box$home_team
  local_tpbl(list("/games/6/stats" = swapped))
  expect_error(tpbl_box_players(6), "home/away order", class = "hoopR_asset_fetch")
  wrong_final <- box
  wrong_final$home_team$teams$rounds[["4"]]$total_won_score <- 110L
  local_tpbl(list("/games/6/stats" = wrong_final))
  expect_error(tpbl_box_teams(6), "final score", class = "hoopR_asset_fetch")
  three <- box
  three$away_team$teams$rounds[["4"]] <- NULL
  three$away_team$teams$rounds[["3"]]$total_won_score <- 108L
  local_tpbl(list("/games/6/stats" = three))
  expect_error(tpbl_box_team_periods(6), "quarters", class = "hoopR_asset_fetch")
  short_points <- box
  first <- names(Filter(function(p) isTRUE(p$score > 0), box$home_team$players$total))[[1]]
  short_points$home_team$players$total[[first]]$score <- short_points$home_team$players$total[[first]]$score - 1L
  local_tpbl(list("/games/6/stats" = short_points))
  expect_error(tpbl_box_player_periods(6), "players score", class = "hoopR_asset_fetch")
  local_tpbl()
  expect_error(tpbl_game("six"), class = "hoopR_bad_request")
})

test_that("the season game list is scoped to its season, team and divisions", {
  games <- tpbl_body("games_3.json")
  other <- games
  other[[2]]$away_team$gohoops_season_id <- 213L
  local_tpbl(list("/seasons/3/games" = other))
  expect_error(tpbl_games(2027), "gohoops season 275", class = "hoopR_asset_fetch")
  dup <- games
  dup[[3]]$id <- dup[[1]]$id
  local_tpbl(list("/seasons/3/games" = dup))
  expect_error(tpbl_games(2027), "duplicate game ids", class = "hoopR_asset_fetch")
  twice <- games
  twice[[2]]$gohoops_division_id <- 910L
  local_tpbl(list("/seasons/3/games" = twice))
  expect_error(tpbl_games(2027), "two GoHoops divisions", class = "hoopR_asset_fetch")
  local_tpbl(list("/seasons/3/games" = games))
  expect_error(tpbl_games(2027, team_id = 3), "does not involve team 3", class = "hoopR_asset_fetch")
})

test_that("verify = TRUE checks completed games against the standings (or the team lists)", {
  seen <- local_tpbl()
  expect_error(tpbl_games(2027, team_id = 3, verify = TRUE), class = "hoopR_bad_request")
  expect_error(tpbl_games(2027, verify = "yes"), class = "hoopR_bad_request")
  expect_length(seen$reqs, 0L)
  # the 3 completed games of division 655 = 6 matches in its standings
  standings <- function(won, lost) {
    lapply(seq_along(won), function(i) {
      list(team = list(id = i, gohoops_event_id = 613L), score_won_matches = won[[i]],
           score_lost_matches = lost[[i]], score_draw_matches = 0L, against_result = list())
    })
  }
  seen <- local_tpbl(list("/divisions/655/games/standings" = standings(c(2L, 1L), c(1L, 2L))))
  expect_identical(nrow(tpbl_games(2027, verify = TRUE)), 3L)
  expect_identical(tpbl_paths(seen), c("/seasons", "/seasons/3/games", "/events/3/divisions",
                                       "/divisions/655/games/standings"))
  local_tpbl(list("/divisions/655/games/standings" = standings(c(2L, 1L), c(1L, 1L))))
  expect_error(tpbl_games(2027, verify = TRUE), "standings count", class = "hoopR_asset_fetch")
  # empty standings (a playoff bracket): every team's own list must hold the same games of the division
  games <- tpbl_body("games_3.json")
  team_list <- function(drop = NULL) {
    function(req) {
      q <- tpbl_query(req)
      if (is.null(q$team_id)) return("games_3.json")
      tid <- as.integer(q$team_id)
      keep <- Filter(function(g) tid %in% c(g$home_team$id, g$away_team$id) && !identical(tid, drop), games)
      if (length(keep)) keep else "[]"
    }
  }
  seen <- local_tpbl(list("/divisions/655/games/standings" = "[]", "/seasons/3/games" = team_list()))
  expect_identical(nrow(tpbl_games(2027, verify = TRUE)), 3L)
  expect_identical(sum(tpbl_paths(seen) == "/seasons/3/games"), 7L) # the list + one per team (6)
  local_tpbl(list("/divisions/655/games/standings" = "[]", "/seasons/3/games" = team_list(drop = 5L)))
  expect_error(tpbl_games(2027, verify = TRUE), "team 5's own game list", class = "hoopR_asset_fetch")
  # a game naming a division the season does not hold
  local_tpbl(list("/events/3/divisions" = list(list(id = 656L, gohoops_id = 910L, gohoops_event_id = 613L))))
  expect_error(tpbl_games(2027, verify = TRUE), "not a division of season 3", class = "hoopR_asset_fetch")
})

test_that("rosters, game logs and shot lists are refused when they disagree with the request", {
  roster <- tpbl_body("roster_2_4.json")
  local_tpbl(list("/divisions/2/teams/5/players" = "roster_2_4.json"))
  expect_error(tpbl_roster(2, 5), "not 5", class = "hoopR_asset_fetch")
  mixed <- roster
  mixed[[2]]$gohoops_event_id <- 490L
  local_tpbl(list("/divisions/2/teams/4/players" = mixed))
  expect_error(tpbl_roster(2, 4), "more than one GoHoops event", class = "hoopR_asset_fetch")
  log <- tpbl_body("player_games_75_2.json")
  local_tpbl(list("/players/76/games/stats" = log))
  expect_error(tpbl_player_games(76, 2), "not 76", class = "hoopR_asset_fetch")
  two_div <- log
  two_div[[3]]$game$gohoops_division_id <- 66L
  local_tpbl(list("/players/75/games/stats" = two_div))
  expect_error(tpbl_player_games(75, 2), "same GoHoops division", class = "hoopR_asset_fetch")
  twice <- log
  twice[[2]]$game$id <- twice[[1]]$game$id
  local_tpbl(list("/players/75/games/stats" = twice))
  expect_error(tpbl_player_games(75, 2), "appears twice", class = "hoopR_asset_fetch")
  shots <- tpbl_body("team_shots_2_4.json")
  off_court <- shots
  off_court[[1]]$point_x <- 28001L
  local_tpbl(list("/divisions/2/teams/4/shooting-spots" = off_court))
  expect_error(tpbl_team_shots(2, 4), "outside the 28000 x 15000 mm court", class = "hoopR_asset_fetch")
  extra <- shots
  extra[[2]]$player_id <- 75L
  local_tpbl(list("/divisions/2/players/75/shooting-spots" = extra))
  expect_error(tpbl_player_shots(2, 75), "is not \\{is_made", class = "hoopR_asset_fetch")
  basket <- shots
  basket[[3]]$offense_basket <- TRUE
  local_tpbl(list("/divisions/2/players/75/shooting-spots" = basket))
  expect_error(tpbl_player_shots(2, 75), "offense_basket", class = "hoopR_asset_fetch")
  standings <- tpbl_body("standings_2.json")
  standings[[2]]$team$id <- standings[[1]]$team$id
  local_tpbl(list("/divisions/2/games/standings" = standings))
  expect_error(tpbl_standings(2), "unique integer ids", class = "hoopR_asset_fetch")
  divisions <- tpbl_body("divisions_3.json")
  divisions[[2]]$id <- divisions[[1]]$id
  local_tpbl(list("/events/3/divisions" = divisions))
  expect_error(tpbl_divisions(2027), "duplicate division ids", class = "hoopR_asset_fetch")
})

test_that("rounds is sent as the repeatable rounds[] and stamped as a sorted list", {
  seen <- local_tpbl(list("/divisions/2/teams/4/shooting-spots" = "team_shots_2_4_r1.json"))
  out <- tpbl_team_shots(2, 4, rounds = c(4, 1, 1))
  expect_identical(unique(out$rounds), "1,4")
  expect_match(seen$reqs[[1]]$url, "rounds%5B%5D=1&rounds%5B%5D=4$|rounds\\[\\]=1&rounds\\[\\]=4$")
  out <- tpbl_team_shots(2, 4, rounds = list(2))
  expect_identical(unique(out$rounds), "2")
  seen <- local_tpbl()
  expect_error(tpbl_team_shots(2, 4, rounds = 0), class = "hoopR_bad_request")
  expect_error(tpbl_team_shots(2, 4, rounds = integer()), class = "hoopR_bad_request")
  expect_length(seen$reqs, 0L)
})

test_that("live: the season list and one finished game", {
  skip_intl_live()
  seasons <- tpbl_seasons()
  expect_true(all(c(2025L, 2026L) %in% seasons$season))
  box <- tpbl_box_teams(game_id = 6)
  expect_identical(box$won_score, c(111L, 108L))
})
