context("KP - Get conference statistics")



test_that("KP - Get conference statistics", {
  skip_on_cran()
  x <- kp_confstats(year='2020')

  cols <- c(
    'Conf', 'Eff', 'Eff.Rk', 'Tempo',
    'Tempo.Rk', 'eFG.Pct', 'eFG.Pct.Rk',
    'TO.Pct', 'TO.Pct.Rk', 'OR.Pct',
    'OR.Pct.Rk', 'FTRate', 'FTRate.Rk',
    'Blk.Pct', 'Blk.Pct.Rk', 'Stl.Pct',
    'Stl.Pct.Rk', 'FG_2.Pct', 'FG_2.Pct.Rk',
    'FG_3.Pct', 'FG_3.Pct.Rk', 'FT.Pct', 'FT.Pct.Rk',
    'FG_3A.Pct', 'FG_3A.Pct.Rk', 'A.Pct',
    'A.Pct.Rk', 'HomeW-L', 'HomeW-L.Pct',
    'HomeW-L.Rk', 'Close', 'Close.Rk',
    'Blowouts', 'Blowouts.Rk', 'Year')

  expect_equal(colnames(x), cols)
  expect_s3_class(x,'data.frame')
})
