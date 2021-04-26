context("KP - Get box score")



test_that("KP - Get box score", {
  skip_on_cran()
  x <- kp_box(game_id = 1238, year = 2020)
  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]
  x4 <- x[[4]]

  cols_x1 <- c(
    'Hgt', 'Wgt', 'Yr', 'Number', 'Player',
    'Min', 'ORtg', '%Ps', 'Pts', '2PM-A',
    '3PM-A', 'FTM-A', 'OR', 'DR', 'A',
    'TO', 'Blk', 'Stl',
    'PF', 'Team', 'WP.Note', 'GameId', 'Year'
  )
  cols_x3 <- c(
    'Team', 'Q1', 'Q2', 'Q3', 'Q4', 'T'
  )
  cols_x4 <- c(
    'OfficialId', 'OfficialName',
    'Official.Rk', 'GameId', 'Year'
  )
  expect_equal(colnames(x1), cols_x1)
  expect_s3_class(x1, 'data.frame')
  expect_equal(colnames(x2), cols_x1)
  expect_s3_class(x2, 'data.frame')
  expect_equal(colnames(x3), cols_x3)
  expect_s3_class(x3, 'data.frame')
  expect_equal(colnames(x4), cols_x4)
  expect_s3_class(x4, 'data.frame')

})
