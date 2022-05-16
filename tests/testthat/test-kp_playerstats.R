test_that("KP - Get player stats", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_playerstats(metric = 'eFG', conf_only = FALSE, year=2020)

  cols_x1 <- c(
    "rk", "player", "team"
  )

  cols_x2 <- c(
    "hgt", "wgt", "yr", "year"
  )
  expect_equal(colnames(x[1:3]), cols_x1)
  expect_equal(colnames(x[5:8]), cols_x2)
  expect_s3_class(x, 'data.frame')


})
