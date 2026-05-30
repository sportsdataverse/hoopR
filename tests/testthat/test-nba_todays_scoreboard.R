test_that("NBA Todays Scoreboard", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_todays_scoreboard()

  # No games on the schedule (off-day / off-season) returns an empty frame.
  # The *_leaders_* and pb_odds_* columns are also absent when no player
  # leaders or betting odds are posted. Skip if empty and assert only the
  # universally-present identity columns.
  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0 || ncol(x) == 0) {
    skip("No games on the schedule today")
  }

  cols_x1 <- c(
    "game_id",
    "game_code",
    "game_status",
    "home_team_id",
    "away_team_id"
  )

  expect_in(sort(cols_x1), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
