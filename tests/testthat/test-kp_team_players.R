context("KP - Get team players (roster)")



test_that("KP - Get team players (roster)", {
  skip_on_cran()
  x <- kp_team_players(team = 'Florida St.', year= 2020)


  cols <- c(
    'Role', 'Number', 'Player', 'Ht',
    'Wt', 'Yr', 'G', 'S',
    'Min.Pct', 'ORtg', 'Poss.Pct',
    'Shots.Pct', 'eFG.Pct', 'TS.Pct',
    'OR.Pct', 'DR.Pct', 'ARate', 'TORate',
    'Blk.Pct', 'Stl.Pct', 'FCper40', 'FDper40',
    'FTRate', 'FTM', 'FTA', 'FT.Pct', 'FGM_2',
    'FGA_2', 'FG_2.Pct', 'FGM_3',
    'FGA_3', 'FG_3.Pct', 'Min.Pct.Rk', 'ORtg.Rk',
    'Poss.Pct.Rk', 'Shots.Pct.Rk', 'eFG.Pct.Rk',
    'TS.Pct.Rk', 'OR.Pct.Rk', 'DR.Pct.Rk',
    'ARate.Rk', 'TORate.Rk', 'Blk.Pct.Rk',
    'Stl.Pct.Rk', 'FCper40.Rk', 'FDper40.Rk',
    'FTRate.Rk', 'FT.Pct.Rk', 'FG_2.Pct.Rk',
    'FG_3.Pct.Rk', 'NationalRank',
    'Team', 'Year', 'PlayerId'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
