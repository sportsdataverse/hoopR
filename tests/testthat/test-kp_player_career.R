context("KP - Get player career")



test_that("KP - Get player career", {
  skip_on_cran()
  x <- kp_player_career(player_id = '41180')
  x1 <- x[[1]]
  x2 <- x[[2]]

  cols_x1 <- c(
    'Year', 'Team.Rk', 'Team', 'Number',
    'Name', 'Position', 'Hgt', 'Wgt', 'Yr', 'G',
    'Min.Pct', 'ORtg', 'Poss.Pct', 'Shots.Pct',
    'eFG.Pct', 'TS.Pct', 'OR.Pct', 'DR.Pct',
    'ARate', 'TORate', 'Blk.Pct', 'Stl.Pct',
    'FCper40', 'FDper40', 'FTRate', 'FTM', 'FTA',
    'FT.Pct', 'FGM_2', 'FGA_2', 'FG_2.Pct',
    'FGM_3', 'FGA_3', 'FG_3.Pct', 'GroupRank',
    'Team.Finish', 'NCAASeed', 'Hometown',
    'DateOfBirth', 'Age', 'Comparisons'
  )
  cols_x2 <- c(
    'Year', 'Team', 'Name', 'Position',
    'Opponent.Tier', 'Date', 'Opponent.Rk',
    'Opponent', 'Result', 'OT', 'Location',
    'GameType', 'MVP', 'Start', 'MinutesPlayed',
    'ORtg', 'Poss.Pct', 'Pts', 'FGM_2', 'FGA_2',
    'FGM_3', 'FGA_3', 'FTM', 'FTA',
    'OR', 'DR', 'A', 'TO', 'Blk', 'Stl', 'PF'
  )
  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)


})
