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
