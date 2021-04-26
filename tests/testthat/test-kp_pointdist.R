context("KP - Get point distribution")



test_that("KP - Get point distribution", {
  skip_on_cran()
  x <- kp_pointdist(min_year = 2020, max_year = 2020)

  cols <- c(
    'Team', 'Conf', 'Off.FT.Pct',
    'Off.FT.Pct.Rk', 'Off.FG_2.Pct',
    'Off.FG_2.Pct.Rk', 'Off.FG_3.Pct',
    'Off.FG_3.Pct.Rk', 'Def.FT.Pct',
    'Def.FT.Pct.Rk', 'Def.FG_2.Pct',
    'Def.FG_2.Pct.Rk', 'Def.FG_3.Pct',
    'Def.FG_3.Pct.Rk', 'NCAA_Seed', 'Year'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
