test_that("KP - Get program ratings", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_program_ratings()


  cols <- c(
    "rk",
    "team",
    "conf",
    "rtg",
    "best_rk",
    "best_yr",
    "worst_rk",
    "worst_yr",
    "kp_median",
    "top10",
    "top25",
    "top50",
    "ch",
    "f4",
    "s16",
    "r1",
    "chg"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")
})
