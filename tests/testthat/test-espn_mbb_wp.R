test_that("ESPN - Get MBB Win Probability", {
  skip_on_cran()
  x <- espn_mbb_wp(game_id = 401256760)


  cols <- c(
    "game_id", "play_id", "period", "time_left",
    "period_seconds_left", "game_seconds_left",
    "home_win_percentage", "away_win_percentage", "tie_percentage"
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
