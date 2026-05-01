test_that("KP - Get player stats", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_playerstats(metric = "eFG", conf_only = FALSE, year = 2020)

  cols_x1 <- c(
    "rk",
    "player",
    "team"
  )

  cols_x2 <- c(
    "hgt",
    "wgt",
    "yr",
    "year"
  )
  expect_in(cols_x1, colnames(x[1:3]))
  expect_in(cols_x2, colnames(x[5:8]))
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
