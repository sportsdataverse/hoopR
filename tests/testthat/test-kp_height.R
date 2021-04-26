context("KP - Get heights")



test_that("KP - Get heights", {
  skip_on_cran()
  x <- kp_height(min_year = 2020, max_year = 2020)

  cols <- c(
    'Team', 'Conf', 'Avg.Hgt', 'Avg.Hgt.Rk',
    'Eff.Hgt', 'Eff.Hgt.Rk', 'C.Hgt', 'C.Hgt.Rk',
    'PF.Hgt', 'PF.Hgt.Rk', 'SF.Hgt', 'SF.Hgt.Rk',
    'SG.Hgt', 'SG.Hgt.Rk', 'PG.Hgt', 'PG.Hgt.Rk',
    'Experience', 'Experience.Rk', 'Bench',
    'Bench.Rk', 'Continuity',
    'Continuity.Rk', 'NCAA_Seed', 'Year'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
