test_that("KP - Get box score", {
  skip_on_cran()
  skip_on_ci()
  x <- kp_box(game_id = 1238, year = 2020)
  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]
  x4 <- x[[4]]

  cols_x1 <- c(
    'hgt', 'wgt', 'yr', 'number', 'player',
    'min', 'o_rtg', 'percent_ps', 'pts', 'fgm2_a',
    'fgm3_a', 'ftm_a', 'or', 'dr', 'a',
    'to', 'blk', 'stl',
    'pf', 'team', 'wp_note', 'game_id', 'year'
  )
  cols_x3 <- c(
    'team', 'q1', 'q2', 'q3', 'q4', 't'
  )
  cols_x4 <- c(
    'official_id', 'official_name',
    'game_id', 'year'
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
