context("KP - Get efficiency")



test_that("KP - Get efficiency", {
  skip_on_cran()
  x <- kp_efficiency(min_year = 2020, max_year = 2020)
  cols <- c(
    'Team', 'Conf', 'AdjT', 'AdjT.Rk',
    'RawT', 'RawT.Rk', 'AvgPossLengthOff',
    'AvgPossLengthOff.Rk', 'AvgPossLengthDef',
    'AvgPossLengthDef.Rk', 'AdjO', 'AdjO.Rk',
    'RawO', 'RawO.Rk', 'AdjD', 'AdjD.Rk',
    'RawD', 'RawD.Rk', 'NCAA_Seed', 'Year'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
