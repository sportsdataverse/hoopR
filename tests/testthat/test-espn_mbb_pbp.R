context("ESPN - Get MBB play by play only")



test_that("ESPN - Get MBB play by play only", {
  skip_on_cran()
  x <- espn_mbb_pbp(game_id = 401256760)


  cols <- c(
    'shooting_play', 'sequence_number',
    'home_score', 'scoring_play', 'away_score',
    'id', 'text', 'score_value',
    'period_display_value', 'period_number',
    'clock_display_value', 'team_id',
    'type_id', 'type_text', 'play_id',
    'athlete1_id', 'athlete2_id'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
