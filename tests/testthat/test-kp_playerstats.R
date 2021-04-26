context("KP - Get player stats")



test_that("KP - Get player stats", {
  skip_on_cran()
  x <- kp_playerstats(metric = 'eFG', conf_only = FALSE, year=2020)

  cols_x1 <- c(
    'Rk', 'Player', 'Team'
  )

  cols_x2 <- c(
    'Hgt', 'Wgt', 'Yr', 'Year'
  )
  expect_equal(colnames(x[1:3]), cols_x1)
  expect_equal(colnames(x[5:8]), cols_x2)
  expect_s3_class(x, 'data.frame')


})
