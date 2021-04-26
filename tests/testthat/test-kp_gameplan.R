context("KP - Get gameplan")



test_that("KP - Get gameplan", {
  skip_on_cran()
  x <- kp_gameplan(team = 'Florida St.', year= 2020)
  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]

  cols_x1 <- c(
    'Date', 'Opponent.Rk', 'Opponent',
    'Result', 'Location', 'Pace', 'Off.Eff',
    'Off.Eff.Rk', 'Off.eFG.Pct', 'Off.TO.Pct',
    'Off.OR.Pct', 'Off.FTR', 'Off.FGM_2',
    'Off.FGA_2', 'Off.FG_2.Pct', 'Off.FGM_3',
    'Off.FGA_3', 'Off.FG_3.Pct',
    'Off.FG_3A.Pct', 'Def.Eff', 'Def.Eff.Rk',
    'Def.eFG.Pct', 'Def.TO.Pct', 'Def.OR.Pct',
    'Def.FTR', 'Def.FGM_2', 'Def.FGA_2',
    'Def.FG_2.Pct', 'Def.FGM_3', 'Def.FGA_3',
    'Def.FG_3.Pct', 'Def.FG_3A.Pct',
    'WL', 'TeamScore',
    'OpponentScore', 'Day.Date', 'GameDate'
  )
  cols_x2 <- c(
    'Correlations (R x 100)', 'Pace', 'Off.eFG.Pct',
    'Off.TO.Pct', 'Off.OR.Pct', 'Off.FTR',
    'Def.eFG.Pct', 'Def.TO.Pct',
    'Def.OR.Pct', 'Def.FTR'
  )
  cols_x3 <- c(
    'Team', 'Category', 'C.Pct',
    'PF.Pct', 'SF.Pct', 'SG.Pct',
    'PG.Pct', 'C.Pct.Rk', 'PF.Pct.Rk',
    'SF.Pct.Rk', 'SG.Pct.Rk', 'PG.Pct.Rk',
    'C.Pct.D1.Avg', 'PF.Pct.D1.Avg', 'SF.Pct.D1.Avg',
    'SG.Pct.D1.Avg', 'PG.Pct.D1.Avg'
  )
  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)
  expect_equal(colnames(x3), cols_x3)
})
