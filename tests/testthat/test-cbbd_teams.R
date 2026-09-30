test_that("CBD - Teams", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_teams(conference = "ACC", season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No teams returned at test time")

  cols <- c("id", "source_id", "school", "mascot", "abbreviation", "conference")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Team Roster", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_teams_roster(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No roster returned at test time")

  cols <- c("team_id", "team", "conference", "season", "players")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Venues", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_venues()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No venues returned at test time")

  cols <- c("id", "source_id", "name", "city", "state", "country")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Team Directory", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_teams_directory(season = 2025)
  if (!is.list(x) || !is.data.frame(x$teams) || nrow(x$teams) == 0) {
    skip("No team directory returned at test time")
  }

  expect_type(x, "list")
  expect_in(c("teams", "conferences"), names(x))
  cols <- c("id", "source_id", "school", "abbreviation", "display_name", "conference_id")
  expect_in(sort(cols), sort(colnames(x$teams)))
  expect_in(c("id", "name", "abbreviation"), colnames(x$conferences))
  expect_s3_class(x$teams, "data.frame")
  expect_equal(attr(x$teams, "season"), 2025)

  Sys.sleep(1)
})

test_that("CBD - Team Season Overview", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_teams_season_overview(team_id = 72, season = 2025)
  if (!is.list(x) || !all(c("team", "players", "schedule") %in% names(x)) ||
      !all(vapply(x[c("team", "players", "schedule")], NROW, integer(1)) > 0)) {
    skip("No team season overview returned at test time")
  }

  expect_type(x, "list")
  expect_in(
    c("team", "record", "ratings", "efficiency", "shooting", "players", "schedule", "sources"),
    names(x)
  )
  expect_in(c("team_id", "season", "school", "conference_id"), colnames(x$team))
  expect_in(c("overall_games", "overall_wins", "overall_losses"), colnames(x$record))
  expect_in(c("athlete_id", "name", "games", "points"), colnames(x$players))
  expect_in(c("id", "opponent_id", "start_date", "team_points"), colnames(x$schedule))
  expect_s3_class(x$players, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - section helpers flatten records and arrays offline", {
  rec <- jsonlite::fromJSON(
    '{"a": 1, "b": {"c": "x", "d": null}, "notes": ["one", "two"], "empty": []}',
    flatten = TRUE
  )
  r <- hoopR:::.cbbd_record_tbl(rec)
  expect_equal(nrow(r), 1L)
  expect_in(c("a", "b_c", "b_d", "notes", "empty"), colnames(r))
  expect_equal(r$notes, "one; two")
  expect_true(is.na(r$b_d) && is.na(r$empty))

  rows <- jsonlite::fromJSON('[{"id": 1, "seasonStats": {"fieldGoals": {"made": 3}}}]', flatten = TRUE)
  expect_in("season_stats_field_goals_made", colnames(hoopR:::.cbbd_rows_tbl(rows)))

  expect_equal(ncol(hoopR:::.cbbd_record_tbl(NULL)), 0L)
  expect_equal(ncol(hoopR:::.cbbd_rows_tbl(list())), 0L)
})

# Serve a captured CBD payload (see fixtures/cbbd/README.md) and record the request,
# so the wrappers run offline and in CI; every live cbbd test is skip_on_ci().
local_cbbd_fixture <- function(file, env = parent.frame()) {
  seen <- new.env()
  local_mocked_bindings(
    check_cbbd_key = function() invisible(TRUE),
    cbbd_key = function() "fixture-key",
    .retry_request = function(url, params = list(), headers = NULL, ...) {
      seen$url <- url
      seen$params <- params
      con <- gzfile(test_path("fixtures", "cbbd", file), "rb")
      on.exit(close(con))
      httr2::response(
        status_code = 200L,
        url = url,
        headers = list(`Content-Type` = "application/json"),
        body = readBin(con, "raw", n = 1e7)
      )
    },
    .env = env
  )
  seen
}

test_that("CBD - Team Directory parses a captured payload offline", {
  seen <- local_cbbd_fixture("teams_directory_2025.json.gz")
  x <- cbbd_teams_directory(season = 2025)

  expect_equal(seen$url, "https://api.collegebasketballdata.com/teams/directory")
  expect_equal(seen$params$season, 2025)
  expect_named(x, c("teams", "conferences"))
  expect_equal(nrow(x$teams), 364L)
  expect_equal(nrow(x$conferences), 31L)
  expect_in(c("id", "source_id", "school", "display_name", "conference_id"), colnames(x$teams))
  expect_in(c("id", "name", "abbreviation"), colnames(x$conferences))
  for (tbl in x) {
    expect_s3_class(tbl, "hoopR_data")
    expect_equal(attr(tbl, "season"), 2025)
    expect_type(attr(tbl, "season_label"), "character")
  }
  expect_equal(attr(x$teams, "season_label"), attr(x$conferences, "season_label"))
  expect_true(all(x$teams$conference_id %in% x$conferences$id))
})

test_that("CBD - Team Season Overview parses a captured payload offline", {
  seen <- local_cbbd_fixture("teams_season_overview_72_2025.json.gz")
  x <- cbbd_teams_season_overview(team_id = 72, season = 2025)

  expect_equal(seen$url, "https://api.collegebasketballdata.com/teams/72/season/2025/overview")
  expect_named(
    x, c("team", "record", "ratings", "efficiency", "shooting", "players", "schedule", "sources")
  )
  expect_equal(
    vapply(x, nrow, integer(1)),
    c(team = 1L, record = 1L, ratings = 1L, efficiency = 1L,
      shooting = 3L, players = 15L, schedule = 39L, sources = 1L)
  )
  expect_equal(x$team$team_id, 72L)
  expect_equal(x$team$school, "Duke")
  expect_in(c("offense_points", "defense_points", "offense_box_score_field_goals_made", "pace"),
            colnames(x$efficiency))
  expect_in(c("athlete_id", "name", "season_stats_field_goals_made"), colnames(x$players))
  expect_type(attr(x$shooting, "tracked_attempts"), "integer")
  expect_in(c("state", "coveredGames"), names(attr(x$players, "coverage")))
  expect_true(all(vapply(x, inherits, logical(1), "hoopR_data")))
})
