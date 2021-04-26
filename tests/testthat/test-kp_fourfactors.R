context("KP - Get four factors")



test_that("KP - Get four factors", {
  skip_on_cran()
  x <- kp_fourfactors(min_year = 2020, max_year = 2020)

  cols <- c(
    'Team', 'Conf', 'AdjT', 'AdjT.Rk', 'AdjO',
    'AdjO.Rk', 'Off.eFG.Pct', 'Off.eFG.Pct.Rk',
    'Off.TO.Pct', 'Off.TO.Pct.Rk', 'Off.OR.Pct',
    'Off.OR.Pct.Rk', 'Off.FTRate', 'Off.FTRate.Rk',
    'AdjD', 'AdjD.Rk', 'Def.eFG.Pct',
    'Def.eFG.Pct.Rk', 'Def.TO.Pct',
    'Def.TO.Pct.Rk', 'Def.OR.Pct',
    'Def.OR.Pct.Rk', 'Def.FTRate',
    'Def.FTRate.Rk', 'NCAA_Seed', 'Year'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
