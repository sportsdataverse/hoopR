context("KP - Get foul trouble")



test_that("KP - Get foul trouble", {
  skip_on_cran()
  x <- kp_foul_trouble(min_year = 2020, max_year = 2020)

  cols <- c(
    'Team', 'Conf', 'TwoFoulParticpation.Pct',
    'TwoFoulParticpation.Pct.Rk', 'Adj2FP',
    'Adj2FP.Rk', 'TwoFoulTotalTime',
    'TwoFoulTotalTime.Rk', 'TwoFoulTimeOn',
    'TwoFoulTimeOn.Rk', 'Bench.Pct',
    'Bench.Pct.Rk', 'NCAA_Seed', 'Year'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
