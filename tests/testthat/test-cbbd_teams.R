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
