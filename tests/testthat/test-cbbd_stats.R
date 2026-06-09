test_that("CBD - Team Season Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_stats_team_season(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team season stats returned at test time")

  cols <- c("season", "team_id", "team", "conference", "games", "wins", "losses")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Team Stats Leaderboard", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_stats_team_leaderboard(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team stats leaderboard returned at test time")

  cols <- c("season", "team_id", "team")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Team Shooting Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_stats_team_shooting_season(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team shooting stats returned at test time")

  cols <- c("season", "team_id", "team", "conference", "tracked_shots")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Player Season Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_stats_player_season(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player season stats returned at test time")

  cols <- c("season", "team_id", "team", "athlete_id", "name", "position")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Player Shooting Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_stats_player_shooting_season(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player shooting stats returned at test time")

  cols <- c("season", "team_id", "team", "athlete_id", "athlete_name", "tracked_shots")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
