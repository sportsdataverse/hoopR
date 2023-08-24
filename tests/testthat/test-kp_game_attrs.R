test_that("KP - Get game attributes", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_game_attrs(year = 2020, attr = "Excitement")

  cols <- c(
    "rk",
    "data",
    "game",
    "location",
    "conf",
    "excitement",
    "year"
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
