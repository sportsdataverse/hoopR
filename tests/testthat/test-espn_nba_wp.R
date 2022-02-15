test_that("ESPN - Get NBA Win Probability", {
  skip_on_cran()
  x <- espn_nba_wp(game_id = 401283399)


  cols <- c(
    "game_id", "play_id", "home_win_percentage",
    "away_win_percentage", "tie_percentage",
    "sequence_number", "text", "away_score",
    "home_score", "scoring_play", "score_value",
    "participants", "shooting_play", "type_id",
    "type_text", "period_number", "period_display_value",
    "clock_display_value",
    "team_id", "coordinate_x", "coordinate_y"
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
