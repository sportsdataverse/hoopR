context("KP - Get minutes matrix")



test_that("KP - Get minutes matrix", {
  skip_on_cran()
  x <- kp_minutes_matrix(team = 'Florida St.', year = 2020)


  cols_x1 <- c(
    'Date', 'Opponent.Rk', 'Opponent', 'Result'
  )
  cols_x2 <- c(
    'Starting Lineup #', 'Team', 'Year'
  )
  expect_equal(colnames(x[1:4]), cols_x1)
  expect_equal(colnames(x[(ncol(x)-2):ncol(x)]), cols_x2)
  expect_s3_class(x, 'data.frame')

})
