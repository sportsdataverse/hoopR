context("KP - Get win probability")



test_that("KP - Get win probability", {
  skip_on_cran()
  x <- kp_winprob(game_id = 1238, year = 2020)
  x1 <- x[[1]]
  x2 <- x[[2]]


  cols_x1 <- c(
    'Period', 'wp', 'TimeLeft',
    'VisitorScore', 'HomeScore',
    'VisitorScoring', 'HomeScoring',
    'PossessionTeam',
    'PossessionNumber', 'GameId', 'Year'
  )
  cols_x2 <- c(
    'GameId', 'Year', 'Full.Date', 'Date',
    'GameTime', 'Venue', 'City',
    'Team1', 'Team1Score', 'Team1.Rk',
    'Team2', 'Team2Score', 'Team2.Rk',
    'Dominance.Season.Rk', 'Tension.Season.Rk',
    'Excitement.Season.Rk',
    'LeadChanges.Season.Rk',
    'MinimumWP.Season.Rk', 'Dominance.Rk',
    'Tension.Rk', 'Excitement.Rk',
    'LeadChanges.Rk', 'MinimumWP.Rk'
  )
  expect_equal(colnames(x1), cols_x1)
  expect_s3_class(x1, 'data.frame')
  expect_equal(colnames(x2), cols_x2)
  expect_s3_class(x2, 'data.frame')

})
