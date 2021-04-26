context("KP - Get pomeroy archive ratings")



test_that("KP - Get pomeroy archive ratings", {
  skip_on_cran()
  x <- kp_pomeroy_archive_ratings(date='2018-11-22')


  cols <- c(
    "AdjEM.Rk", "Team", "Conf", "AdjEM",
    "AdjO", "AdjO.Rk", "AdjD", "AdjD.Rk",
    "AdjT", "AdjT.Rk", "Final.Rk", "Final.AdjEM",
    "Final.AdjO", "Final.AdjO.Rk", "Final.AdjD",
    "Final.AdjD.Rk", "Final.AdjT", "Final.AdjT.Rk",
    "Rk.Chg", "EM.Chg", "AdjT.Chg", "NCAA_Seed"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")
})
