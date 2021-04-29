context("ESPN - Get NBA play by play only")



test_that("ESPN - Get NBA play by play only", {
  skip_on_cran()
  x <- espn_nba_pbp(game_id = 401283399)


  cols <- c(
    'shootingPlay', 'sequenceNumber',
    'homeScore', 'scoringPlay', 'awayScore',
    'id', 'text', 'scoreValue',
    'period.displayValue', 'period.number',
    'coordinate.x','coordinate.y',
    'clock.displayValue', 'team.id',
    'type.id', 'type.text', 'play.id',
    'athlete1.id', 'athlete2.id', 'athlete3.id'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
