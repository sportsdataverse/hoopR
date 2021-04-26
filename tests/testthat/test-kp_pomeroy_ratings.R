context("KP - Get Pomeroy ratings")



test_that("KP - Get Pomeroy ratings", {
  skip_on_cran()
  x <- kp_pomeroy_ratings(min_year = 2020, max_year = 2020)

  cols <- c(
    'Year', 'Rk', 'Team', 'Conf', 'W-L',
    'AdjEM', 'AdjO', 'AdjO.Rk', 'AdjD',
    'AdjD.Rk', 'AdjT', 'AdjT.Rk',
    'Luck', 'Luck.Rk', 'SOS.AdjEM',
    'SOS.AdjEM.Rk', 'SOS.OppO',
    'SOS.OppO.Rk', 'SOS.OppD',
    'SOS.OppD.Rk', 'NCSOS.AdjEM',
    'NCSOS.AdjEM.Rk', 'NCAA_Seed'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
