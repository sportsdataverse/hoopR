context("KP - Get coach history")



test_that("KP - Get coach history", {
  skip_on_cran()
  x <- kp_coach_history(
    coach = 'Leonard Hamilton'
  )

  y <- kp_coach_history(
    coach = 'Mike Krzyzewski'
  )

  cols <- c(
    "Year", "Team.Rk", "Team", "Coach",
    "Conf",  "AdjT", "AdjO",
    "AdjD", "Off.eFG.Pct", "Off.TO.Pct",
    "Off.OR.Pct", "Off.FTRate", "Off.FG_2.Pct", "Off.FG_3.Pct",
    "Off.FT.Pct","Off.FG_3A.Pct", "Off.A.Pct", "Off.APL",
    "Def.eFG.Pct", "Def.TO.Pct", "Def.OR.Pct",
    "Def.FTRate", "Def.FG_2.Pct", "Def.FG_3.Pct",
    "Def.Blk.Pct", "Def.FG_3A.Pct", "Def.A.Pct",
    "Def.APL", "Foul2Partic.Pct",
    'WL','WL.Conf','AdjT.Rk','AdjO.Rk','AdjD.Rk',
    'Off.eFG.Pct.Rk',	'Off.TO.Pct.Rk',	'Off.OR.Pct.Rk','Off.FTRate.Rk',
    'Off.FG_2.Pct.Rk',	'Off.FG_3.Pct.Rk',	'Off.FT.Pct.Rk',	'Off.FG_3A.Pct.Rk',
    'Off.A.Pct.Rk',	'Off.APL.Rk',
    'Def.eFG.Pct.Rk', 'Def.TO.Pct.Rk',	'Def.OR.Pct.Rk',	'Def.FTRate.Rk',
    'Def.FG_2.Pct.Rk',	'Def.FG_3.Pct.Rk',
    'Def.Blk.Pct.Rk',	'Def.FG_3A.Pct.Rk',	'Def.A.Pct.Rk',
    'Def.APL.Rk',	'Foul2Partic.Pct.Rk','Team.Finish','NCAA_Seed'
  )

  expect_equal(colnames(x), cols)
  expect_equal(colnames(y), cols)
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})
