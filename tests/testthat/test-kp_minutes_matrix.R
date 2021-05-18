context("KP - Get minutes matrix")



test_that("KP - Get minutes matrix", {
  skip_on_cran()
  skip_on_ci()
  x <- kp_minutes_matrix(team = 'Florida St.', year = 2020)


  cols_x1 <- c(
    'date', 'opponent_rk', 'opponent', 'result'
  )
  cols_x2 <- c(
    'starting_lineup_number', 'team', 'year'
  )
  expect_equal(colnames(x[1:4]), cols_x1)
  expect_equal(colnames(x[(ncol(x)-2):ncol(x)]), cols_x2)
  expect_s3_class(x, 'data.frame')

})
