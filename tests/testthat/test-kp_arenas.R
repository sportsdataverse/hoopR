test_that("KP - Get arenas", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_arenas(year = 2020)

  cols <- c(
    "rk",
    "team",
    "conf",
    "arena",
    "alternate",
    "year"
  )


  expect_named(x, cols)
  expect_s3_class(x, "data.frame")
  Sys.sleep(3)
})
