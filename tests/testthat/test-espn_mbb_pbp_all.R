context("ESPN - Get play by play all")



test_that("ESPN - Get play by play all", {
  skip_on_cran()
  x <- espn_mbb_game_all(game_id = 401256760)
  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]

  cols_x1 <- c(
    'shootingPlay', 'sequenceNumber',
    'homeScore', 'scoringPlay', 'awayScore',
    'id', 'text', 'scoreValue',
    'period.displayValue', 'period.number',
    'clock.displayValue', 'team.id',
    'type.id', 'type.text', 'play.id',
    'athlete1.id', 'athlete2.id'
  )
  cols_x2 <- c(
    'Home', 'label', 'Away'
  )
  cols_x3 <- c(
    'athlete.displayName', 'team.shortDisplayName',
    'MIN', 'FG', '3PT', 'FT', 'OREB', 'DREB',
    'REB', 'AST', 'STL', 'BLK', 'TO', 'PF',
    'PTS', 'starter', 'ejected', 'didNotPlay',
    'active', 'athlete.jersey', 'athlete.id',
    'athlete.shortName', 'athlete.headshot.href',
    'athlete.position.name',
    'athlete.position.abbreviation',
    'team.name', 'team.logo', 'team.id',
    'team.abbreviation',
    'team.color', 'team.alternateColor'
  )
  expect_equal(colnames(x1), cols_x1)
  expect_s3_class(x1, 'data.frame')

  expect_equal(colnames(x2), cols_x2)
  expect_s3_class(x2, 'data.frame')

  expect_equal(colnames(x3), cols_x3)
  expect_s3_class(x3, 'data.frame')

})
