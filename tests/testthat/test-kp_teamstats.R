context("KP - Get team stats")



test_that("KP - Get team stats", {
  skip_on_cran()
  x <- kp_teamstats(min_year = 2019, max_year = 2020, defense = FALSE)

  cols <- c(
    'Team', 'Conf', 'Off.FG_3.Pct',
    'Off.FG_3.Pct.Rk', 'Off.FG_2.Pct',
    'Off.FG_2.Pct.Rk', 'Off.FT.Pct',
    'Off.FT.Pct.Rk', 'Off.Blk.Pct',
    'Off.Blk.Pct.Rk', 'Off.Stl.Pct',
    'Off.Stl.Pct.Rk', 'Off.NonStl.Pct',
    'Off.NonStl.Pct.Rk', 'Off.A.Pct',
    'Off.A.Pct.Rk', 'Off.FG_3A.Pct',
    'Off.FG_3A.Pct.Rk', 'AdjO', 'AdjO.Rk',
    'NCAA_Seed', 'Year', 'Def.FG_3.Pct',
    'Def.FG_3.Pct.Rk', 'Def.FG_2.Pct',
    'Def.FG_2.Pct.Rk', 'Def.FT.Pct',
    'Def.FT.Pct.Rk', 'Def.Blk.Pct',
    'Def.Blk.Pct.Rk', 'Def.Stl.Pct',
    'Def.Stl.Pct.Rk', 'Def.NonStl.Pct',
    'Def.NonStl.Pct.Rk', 'Def.A.Pct',
    'Def.A.Pct.Rk', 'Def.FG_3A.Pct',
    'Def.FG_3A.Pct.Rk', 'AdjD', 'AdjD.Rk'
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
