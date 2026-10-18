# Offline tests of the Lega Basket Serie A family (R/lba.R, R/lba_runtime.R, R/lba_parsers.R, R/lba_schema.R).
# Every request is mocked through httr2, so the season mapping, the 2 s throttle (recorded, never slept), the
# retries, the status vocabulary and every refusal run end to end. Parity: fixtures/lba/parity/<case>.csv is
# sdv-py's frame of the same wrapper on the same fixture (see fixtures/lba/README.md). Live checks at the bottom
# (HOOPR_INTL_LIVE_TESTS=1).

# one-line condition messages, so the expected-message regexes see no wrapping
withr::local_options(list(cli.width = 400), .local_envir = testthat::teardown_env())

lba_fx <- function(...) testthat::test_path("fixtures", "lba", ...)
lba_text <- function(rel) paste(readLines(lba_fx(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
lba_body <- function(rel) jsonlite::parse_json(lba_text(rel), simplifyVector = FALSE)
lba_json <- function(body) as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null", digits = NA))
lba_manifest <- jsonlite::read_json(lba_fx("parity", "manifest.json"), simplifyVector = FALSE)
LBA_NULL <- "<NA>"
LBA_RTYPE <- c(Int64 = "integer", Float64 = "double", Boolean = "logical", String = "character")

lba_resp <- function(body, status = 200L, ctype = "application/json", headers = list()) {
  text <- if (is.character(body)) body else lba_json(body)
  httr2::response(status, headers = c(list(`Content-Type` = ctype), headers), body = charToRaw(enc2utf8(text)))
}

# Mock the site: `answer` is a response, a list of responses (one per attempt, the last repeated), a body
# (list / text), or a function(req). `seen` records every request and every throttle wait.
local_lba <- function(answer, env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$waits <- list()
  testthat::local_mocked_bindings(
    .intl_wait = function(url, min_interval = 1) {
      seen$waits[[length(seen$waits) + 1L]] <- min_interval
      invisible(0)
    },
    .package = "hoopR", .env = env
  )
  httr2::local_mocked_responses(function(req) {
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    if (is.function(answer)) return(answer(req))
    if (inherits(answer, "httr2_response")) return(answer)
    if (is.list(answer) && length(answer) && all(vapply(answer, inherits, logical(1), "httr2_response"))) {
      return(answer[[min(length(seen$reqs), length(answer))]])
    }
    lba_resp(answer)
  }, env = env)
  seen
}
lba_query <- function(req) httr2::url_parse(req$url)$query
lba_path <- function(req) httr2::url_parse(req$url)$path

# the sdv-py frame (CSV) vs the R tibble, cell by cell; NA-vs-value is a mismatch
lba_mismatches <- function(got, want) {
  if (is.numeric(got)) {
    w <- suppressWarnings(as.numeric(want))
    bad <- is.na(got) != is.na(w) | (!is.na(got) & !is.na(w) & abs(got - w) > 1e-9)
  } else {
    g <- if (is.logical(got)) tolower(as.character(got)) else as.character(got)
    bad <- is.na(g) != is.na(want) | (!is.na(g) & !is.na(want) & g != want)
  }
  sum(bad)
}

lba_run <- function(case, env = parent.frame()) {
  c <- lba_manifest[[case]]
  seen <- local_lba(lba_text(c$fixture), env = env)
  out <- do.call(c$wrapper, c$args)
  list(out = out, seen = seen)
}

# ------------------------------------------------------------------ parity

test_that("every wrapper matches sdv-py's frame on the same fixture (columns, types, cells, request)", {
  expect_length(lba_manifest, 22L)
  exports <- getNamespaceExports("hoopR")
  expect_setequal(unique(vapply(lba_manifest, `[[`, "", "wrapper")), exports[startsWith(exports, "lba_")])
  expect_length(exports[startsWith(exports, "lba_")], 19L)
  for (case in names(lba_manifest)) {
    c <- lba_manifest[[case]]
    res <- lba_run(case)
    got <- res$out
    want <- utils::read.csv(lba_fx("parity", paste0(case, ".csv")), colClasses = "character",
                            na.strings = LBA_NULL, check.names = FALSE, fileEncoding = "UTF-8")
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = case)
    expect_identical(names(got), names(c$dtypes), label = case)
    expect_identical(nrow(got), as.integer(c$rows), label = case)
    expect_identical(vapply(got, typeof, ""), LBA_RTYPE[unlist(c$dtypes)] |> stats::setNames(names(c$dtypes)),
                     label = case)
    bad <- vapply(names(got), function(n) lba_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(case, "mismatched columns"))
    # the request sdv-py sends: the URL and the wire query (START years)
    expect_length(res$seen$reqs, 1L)
    req <- res$seen$reqs[[1]]
    expect_identical(sub("\\?.*$", "", req$url), c$url, label = case)
    q <- lba_query(req)
    expect_identical(q[order(names(q))], lapply(c$query[order(names(c$query))], as.character), label = case)
    expect_identical(unlist(res$seen$waits), 2, label = case)
  }
})

test_that("ids are integers, never stringified floats, and the documented columns lead", {
  for (case in names(lba_manifest)) {
    got <- lba_run(case)$out
    short <- sub("^lba_", "", lba_manifest[[case]]$wrapper)
    expect_identical(names(got)[seq_along(.LBA_DTYPES[[short]])], names(.LBA_DTYPES[[short]]), label = case)
    for (col in grep("(^|_)id$|^season$", names(got), value = TRUE)) expect_type(got[[col]], "integer")
    expect_false(any(grepl("^[0-9]+\\.0$", unlist(Filter(is.character, got)))), label = case)
  }
  pbp <- lba_run("lba_pbp")$out
  expect_identical(unique(pbp$coord_frame), "court_pct")
  expect_identical(unique(lba_run("lba_pbp__2017")$out$coord_frame), "half_court_px")
  expect_identical(unique(lba_run("lba_teams")$out$season), 2027L)
  cal <- lba_run("lba_calendar")$out
  refs <- jsonlite::parse_json(cal$referees[[1]])
  expect_length(refs, 3L)
  expect_type(refs[[1]], "character")
})

test_that("Python's json.dumps is reproduced for the JSON-string columns", {
  expect_identical(.lba_pyjson(list(a = 1L, b = list("x", NULL, TRUE), c = stats::setNames(list(), character()))),
                   '{"a": 1, "b": ["x", null, true], "c": {}}')
  expect_identical(.lba_pyjson(list(1, 0.1, 1e16, 1.5e-5, 123.456, -2.5)), "[1.0, 0.1, 1e+16, 1.5e-05, 123.456, -2.5]")
  expect_identical(.lba_pyjson("a\"b\\c\nd\001"), '"a\\"b\\\\c\\nd\\u0001"')
  expect_identical(.lba_pyjson("Cantù"), "\"Cantù\"")
})

# ------------------------------------------------------------------ empty answers

test_that("a body the parser finds no rows in is a zero-row tibble with the documented columns", {
  for (short in names(.LBA_DTYPES)) {
    out <- .lba_parse(short, list())
    expect_identical(nrow(out), 0L, label = short)
    expect_identical(names(out), names(.LBA_DTYPES[[short]]), label = short)
    types <- unname(c(i = "integer", f = "double", b = "logical", s = "character")[.LBA_DTYPES[[short]]])
    expect_identical(unname(vapply(out, typeof, "")), types, label = short)
  }
  roster <- lba_body("roster_1764.json")
  roster$coach <- NULL
  local_lba(roster)
  coach <- lba_roster_coach(team_id = 1764)
  expect_s3_class(coach, "hoopR_data")
  expect_identical(nrow(coach), 0L)
  expect_identical(names(coach), names(.LBA_DTYPES$roster_coach))
})

test_that("old seasons answer an empty payload, and that is hoopR_no_data", {
  pbp <- lba_body("pbp_25602.json")
  pbp$pbp$actions <- list()
  local_lba(pbp)
  expect_error(lba_pbp(game_id = 25602), class = "hoopR_no_data", regexp = "pbp.actions")
  rank <- lba_body("ranking_602_3.json")
  rank["standings"] <- list(NULL)
  local_lba(rank)
  expect_error(lba_standings(championship_id = 602), class = "hoopR_no_data", regexp = "standings")
  local_lba(list(competitions = list(), pagination = list(count = 0L)))
  expect_error(lba_championships(season = 2099), class = "hoopR_no_data")
  local_lba(lba_resp("nope", 404L, "text/plain"))
  expect_error(lba_teams(season = 2027), class = "hoopR_no_data")
})

# ------------------------------------------------------------------ season mapping

test_that("the END year goes out as the START year and is stamped for the parsers", {
  seen <- local_lba(lba_text("teams_2027.json"))
  out <- lba_teams(season = 2027)
  expect_identical(lba_query(seen$reqs[[1]])$year, "2026")
  expect_identical(lba_query(seen$reqs[[1]])$items, "50")
  expect_identical(unique(out$season), 2027L)
  seen <- local_lba(lba_text("players_leaderboard_points.json"))
  lba_players_leaderboard(season = "2027", category = "points")
  expect_identical(lba_query(seen$reqs[[1]])[c("s", "cs_id", "cat")], list(s = "2026", cs_id = "1", cat = "points"))
  # no season, no stamp: the season comes from the rows
  seen <- local_lba(lba_text("calendar_602_1.json"))
  expect_identical(unique(lba_calendar(championship_id = 602, round = 1)$season), 2027L)
  expect_null(lba_query(seen$reqs[[1]])$s)
})

test_that("a season that is not an END year is hoopR_bad_request before any request", {
  for (bad in list("abc", 1800, 2300, TRUE, 2026.5, c(2026, 2027), NA)) {
    seen <- local_lba(lba_text("teams_2027.json"))
    expect_error(lba_teams(season = bad), class = "hoopR_bad_request", regexp = "END year")
    expect_length(seen$reqs, 0L)
  }
  seen <- local_lba(lba_text("teams_leaderboard_off.json"))
  expect_error(lba_teams_leaderboard(board = "teams_neutral"), class = "hoopR_bad_request", regexp = "board")
  expect_length(seen$reqs, 0L)
})

# ------------------------------------------------------------------ transport

test_that("an unknown id is a 500 that is not retried; 503 is retried with a 2 s wait per attempt", {
  seen <- local_lba(lba_resp("Internal Server Error", 500L, "text/plain"))
  err <- expect_error(lba_game(game_id = 1), class = "hoopR_asset_fetch", regexp = "500")
  expect_length(seen$reqs, 1L)
  expect_identical(err$status, 500L)
  seen <- local_lba(list(lba_resp("busy", 503L, "text/plain"), lba_resp("busy", 503L, "text/plain"),
                         lba_resp(lba_text("teams_2027.json"))))
  expect_identical(nrow(lba_teams(season = 2027)), 16L)
  expect_length(seen$reqs, 3L)
  expect_identical(unlist(seen$waits), c(2, 2, 2))
})

test_that("a 403 is retried (sdv-py RETRY_STATUSES keeps 403), then raises hoopR_asset_fetch", {
  seen <- local_lba(list(lba_resp("Forbidden", 403L, "text/plain"), lba_resp(lba_text("teams_2027.json"))))
  expect_identical(nrow(lba_teams(season = 2027)), 16L)
  expect_length(seen$reqs, 2L)
  seen <- local_lba(lba_resp("Forbidden", 403L, "text/plain"))
  err <- expect_error(lba_teams(season = 2027), class = "hoopR_asset_fetch", regexp = "403")
  expect_identical(err$status, 403L)
  expect_length(seen$reqs, 3L)
})

test_that("a dead connection is a transient hoopR_asset_fetch after 3 attempts", {
  seen <- local_lba(function(req) stop("Could not resolve host: www.legabasket.it"))
  err <- expect_error(lba_teams(season = 2027), class = "hoopR_asset_fetch", regexp = "3 attempts")
  expect_true(err$transient)
  expect_length(seen$reqs, 3L)
})

test_that("400 / 422 are hoopR_bad_request; a non-JSON, empty, non-object or error-shaped 200 is hoopR_asset_fetch", {
  local_lba(lba_resp("bad", 422L, "text/plain"))
  expect_error(lba_teams(season = 2027), class = "hoopR_bad_request")
  local_lba(lba_resp("<html>maintenance</html>", 200L, "text/html"))
  expect_error(lba_teams(season = 2027), class = "hoopR_asset_fetch", regexp = "non-JSON")
  local_lba(lba_resp("", 200L))
  expect_error(lba_teams(season = 2027), class = "hoopR_asset_fetch", regexp = "empty")
  for (envelope in list('{"error": "x"}', '{"message": "Internal server error", "statusCode": 500}', "[1, 2]")) {
    local_lba(lba_resp(envelope))
    expect_error(lba_teams(season = 2027), class = "hoopR_asset_fetch")
  }
})

# ------------------------------------------------------------------ scope and partial answers

test_that("a body for another game, or a game that is not final, is refused (the header is exempt)", {
  pbp <- lba_body("pbp_25602.json")
  pbp$match$id <- 25603L
  local_lba(pbp)
  expect_error(lba_pbp(game_id = 25602), class = "hoopR_asset_fetch", regexp = "match.id")
  scores <- lba_body("scores_25602.json")
  scores$match <- stats::setNames(list(), character())
  local_lba(scores)
  expect_error(lba_box_score(game_id = 25602), class = "hoopR_asset_fetch", regexp = "match.id")
  shots <- lba_body("shots_25602.json")
  shots$match$id <- 1L
  local_lba(shots)
  expect_error(lba_shots(game_id = 25602), class = "hoopR_asset_fetch", regexp = "match.id")
  # an id sent as a string or a double is not the integer asked for (type-strict)
  shots$match$id <- "25602"
  local_lba(shots)
  expect_error(lba_shots(game_id = 25602), class = "hoopR_asset_fetch", regexp = "match.id")
  for (case in list(list("scores_25602.json", lba_team_box_score), list("pbp_25602.json", lba_pbp_legend),
                    list("shots_25602.json", lba_shots))) {
    body <- lba_body(case[[1]])
    body$match$game_status <- "1"
    local_lba(body)
    expect_error(case[[2]](game_id = body$match$id), class = "hoopR_asset_fetch", regexp = "not final")
  }
  header <- lba_body("game_25602.json")
  header$match$game_status <- "0"
  local_lba(header)
  expect_identical(lba_game(game_id = 25602)$game_status, "0")
})

test_that("wrong season, championship, round, team, player and category are refused", {
  local_lba(lba_text("teams_2027.json"))
  expect_error(lba_teams(season = 2028), class = "hoopR_asset_fetch", regexp = "year")
  local_lba(lba_text("calendar_602_1.json"))
  expect_error(lba_calendar(championship_id = 603, round = 1), class = "hoopR_asset_fetch", regexp = "competition.id")
  local_lba(lba_text("calendar_602_1.json"))
  expect_error(lba_calendar(championship_id = 602, round = 2), class = "hoopR_asset_fetch", regexp = "matches")
  local_lba(lba_text("roster_1764.json"))
  expect_error(lba_roster(team_id = 1), class = "hoopR_asset_fetch", regexp = "team.id")
  local_lba(lba_text("team_players_stats_1764.json"))
  expect_error(lba_team_players_stats(team_id = 1764, season = 2026), class = "hoopR_asset_fetch",
               regexp = "player_season")
  local_lba(lba_text("game_log_969.json"))
  expect_error(lba_game_log(player_id = 970, season = 2027), class = "hoopR_asset_fetch", regexp = "player.id")
  local_lba(lba_text("game_log_969.json"))
  expect_error(lba_game_log(player_id = 969, season = 2025), class = "hoopR_asset_fetch", regexp = "season")
  local_lba(lba_text("player_969.json"))
  expect_error(lba_player(player_id = 970), class = "hoopR_asset_fetch", regexp = "player.id")
  local_lba(lba_text("player_stats_969.json"))
  expect_error(lba_player_stats(player_id = 970), class = "hoopR_asset_fetch", regexp = "player.id")
  local_lba(lba_text("players_leaderboard_points.json"))
  expect_error(lba_players_leaderboard(season = 2027, category = "assists"), class = "hoopR_asset_fetch",
               regexp = "category")
  local_lba(lba_text("teams_leaderboard_off.json"))
  expect_error(lba_teams_leaderboard(board = "teams_offensive", season = 2026), class = "hoopR_asset_fetch",
               regexp = "year")
  local_lba(lba_text("players_2027_p2.json"))
  expect_error(lba_players(season = 2026, page = 2), class = "hoopR_asset_fetch", regexp = "year")
  local_lba(lba_text("championships_2027.json"))
  expect_error(lba_championships(season = 2026), class = "hoopR_asset_fetch", regexp = "competitions")
})

test_that("standings must sit on the round asked for", {
  rank <- lba_body("ranking_602_3.json")
  local_lba(rank)
  expect_identical(nrow(lba_standings(championship_id = 602, round = 3)), 3L)
  local_lba(rank)
  expect_error(lba_standings(championship_id = 602, round = 2), class = "hoopR_asset_fetch", regexp = "past round 2")
  mixed <- rank
  mixed$standings[[1]]$championships_day_id <- 1L
  local_lba(mixed)
  expect_error(lba_standings(championship_id = 602, round = 3), class = "hoopR_asset_fetch", regexp = "several rounds")
  local_lba(rank)
  expect_error(lba_standings(championship_id = 601, round = 3), class = "hoopR_asset_fetch", regexp = "competition.id")
})

test_that("a truncated whole-season page is refused; a requested page is not", {
  teams <- lba_body("teams_2027.json")
  teams$pagination$count <- 40L
  local_lba(teams)
  expect_error(lba_teams(season = 2027), class = "hoopR_asset_fetch", regexp = "truncated")
  .lba_check("t", "/teams/get-teams", list(year = 2026L, page = 1L), teams, call = NULL)
  champs <- lba_body("championships_2027.json")
  champs$pagination$count <- NULL
  local_lba(champs)
  expect_error(lba_championships(season = 2027), class = "hoopR_asset_fetch", regexp = "truncated")
})

# ------------------------------------------------------------------ live

test_that("live: one game and one round of the 2026-27 Serie A answer at parity shape", {
  skip_intl_live()
  cal <- lba_calendar(championship_id = 602, round = 1)
  expect_identical(names(cal)[seq_along(.LBA_DTYPES$calendar)], names(.LBA_DTYPES$calendar))
  expect_type(cal$game_id, "integer")
  box <- lba_box_score(game_id = 25602)
  expect_identical(names(box)[seq_along(.LBA_DTYPES$box_score)], names(.LBA_DTYPES$box_score))
  expect_true(all(box$game_id == 25602L))
  expect_identical(unique(box$season), 2027L)
})
