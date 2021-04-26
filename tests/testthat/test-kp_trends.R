context("KP - Get trends")



test_that("KP - Get trends", {
  skip_on_cran()
  x <- kp_trends()

  cols <- c(
    'Season', 'Efficiency', 'Tempo',
    'eFG.Pct', 'TO.Pct', 'OR.Pct',
    'FTRate', 'FG_2.Pct', 'FG_3.Pct',
    'FG_3A.Pct', 'FT.Pct', 'A.Pct',
    'Blk.Pct', 'Stl.Pct',
    'NonStl.Pct', 'Avg.Hgt',
    'Continuity', 'HomeWin.Pct', 'PPG'
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
