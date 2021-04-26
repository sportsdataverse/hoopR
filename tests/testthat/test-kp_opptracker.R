context("KP - Get opponent tracker")



test_that("KP - Get opponent tracker", {
  skip_on_cran()
  x <- kp_opptracker(team='Florida St.', year=2020)
  cols <- c(
    'Date', 'GameDate', 'Day.Date',
    'WL', 'Team', 'TeamScore', 'Opponent',
    'OpponentScore', 'Result', 'AdjOE',
    'AdjOE.Rk', 'Off.eFG.Pct', 'Off.eFG.Pct.Rk',
    'Off.TO.Pct', 'Off.TO.Pct.Rk', 'Off.OR.Pct',
    'Off.OR.Pct.Rk', 'Off.FTRate', 'Off.FTRate.Rk',
    'Off.FG_2.Pct', 'Off.FG_2.Pct.Rk',
    'Off.FG_3.Pct', 'Off.FG_3.Pct.Rk',
    'Off.Blk.Pct', 'Off.Blk.Pct.Rk',
    'Off.FG_3A.Pct', 'Off.FG_3A.Pct.Rk',
    'Off.APL', 'Off.APL.Rk', 'AdjDE',
    'AdjDE.Rk', 'Def.eFG.Pct', 'Def.eFG.Pct.Rk',
    'Def.TO.Pct', 'Def.TO.Pct.Rk', 'Def.OR.Pct',
    'Def.OR.Pct.Rk', 'Def.FTRate', 'Def.FTRate.Rk',
    'Def.FG_2.Pct', 'Def.FG_2.Pct.Rk',
    'Def.FG_3.Pct', 'Def.FG_3.Pct.Rk',
    'Def.Blk.Pct', 'Def.Blk.Pct.Rk',
    'Def.FG_3A.Pct', 'Def.FG_3A.Pct.Rk',
    'Def.APL', 'Def.APL.Rk'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
