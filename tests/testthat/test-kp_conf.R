context("KP - Get conference (leaderboard)")



test_that("KP - Get conference (leaderboard)", {
  skip_on_cran()
  x <- kp_conf(year='2020',conf='ACC')

  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]
  x4 <- x[[4]]
  x5 <- x[[5]]
  x6 <- x[[6]]
  x7 <- x[[7]]

  cols_x1 <- c(
    'Team', 'Overall', 'Conf', 'AdjEM',
    'AdjEM.Rk', 'AdjO', 'AdjO.Rk', 'AdjD',
    'AdjD.Rk', 'AdjT', 'AdjT.Rk', 'ConfSOS',
    'ConfSOS.Rk', 'NextGame', 'Year')
  cols_x2 <- c(
    'Team', 'OE', 'OE.Rk', 'eFG.Pct',
    'eFG.Pct.Rk', 'TO.Pct', 'TO.Pct.Rk',
    'OR.Pct', 'OR.Pct.Rk', 'FTRate',
    'FTRate.Rk', 'FG_2.Pct', 'FG_2.Pct.Rk',
    'FG_3.Pct', 'FG_3.Pct.Rk', 'FT.Pct',
    'FT.Pct.Rk', 'Tempo', 'Tempo.Rk', 'Year')

  cols_x3 <- c(
    'Team', 'DE', 'DE.Rk', 'eFG.Pct',
    'eFG.Pct.Rk', 'TO.Pct', 'TO.Pct.Rk',
    'OR.Pct', 'OR.Pct.Rk', 'FTRate',
    'FTRate.Rk', 'FG_2.Pct', 'FG_2.Pct.Rk',
    'FG_3.Pct', 'FG_3.Pct.Rk', 'Blk.Pct', 'Blk.Pct.Rk',
    'Stl.Pct', 'Stl.Pct.Rk', 'Year'
  )
  cols_x4 <- c(
    'Rk', 'Player', 'Year'
  )
  cols_x5 <- c(
    'Stat', 'Value', 'Rk', 'Year'
  )
  cols_x6 <- c(
    'Stat', 'Count', 'Value', 'Rk', 'Year'
  )
  cols_x7 <- c(
    'Rk', 'Conference', 'Rating', 'Year'
  )

  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)
  expect_equal(colnames(x3), cols_x3)
  expect_equal(colnames(x4), cols_x4)
  expect_equal(colnames(x5), cols_x5)
  expect_equal(colnames(x6), cols_x6)
  expect_equal(colnames(x7), cols_x7)
})
