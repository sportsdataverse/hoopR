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
