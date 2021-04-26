context("ESPN - Get play by play only")



test_that("ESPN - Get play by play only", {
  skip_on_cran()
  x <- espn_mbb_pbp(game_id = 401256760)


  cols <- c(
    'shootingPlay', 'sequenceNumber',
    'homeScore', 'scoringPlay', 'awayScore',
    'id', 'text', 'scoreValue',
    'period.displayValue', 'period.number',
    'clock.displayValue', 'team.id',
    'type.id', 'type.text', 'play.id',
    'athlete1.id', 'athlete2.id'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
