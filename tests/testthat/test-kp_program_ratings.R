context("KP - Get program ratings")



test_that("KP - Get program ratings", {
  skip_on_cran()
  x <- kp_program_ratings()


  cols <- c(
    "Rk", "Team", "Conf", "Rtg",
    "Best.Rk", "Best.Yr", "Worst.Rk", "Worst.Yr",
    "KP.Median", "Top10", "Top25", "Top50",
    "CH", "F4", "S16", "R1", "Chg"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")
})
