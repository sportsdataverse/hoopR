test_that("CBD - Games", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_games(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No games returned at test time")

  cols <- c("id", "season", "start_date", "home_team", "away_team", "venue")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Game Media", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_games_media(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No game media returned at test time")

  cols <- c("game_id", "season", "home_team", "away_team")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Team Box Scores", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_games_teams(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team box scores returned at test time")

  cols <- c("game_id", "season", "team_id", "team", "opponent")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Player Box Scores", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_games_players(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player box scores returned at test time")

  cols <- c("game_id", "season", "team_id", "team", "players")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Scoreboard", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  # The scoreboard only returns live / same-day games, so it is empty in the
  # off-season -- skip rather than fail when there are no current games.
  x <- cbbd_scoreboard(conference = "ACC")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No current scoreboard games at test time")

  cols <- c("id", "start_date", "status", "venue")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
