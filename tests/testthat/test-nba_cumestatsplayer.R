test_that("NBA Cume Stats Player", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_cumestatsplayer(
    game_ids = '0022000756',
    league_id = '00',
    player_id = '1629611',
    season = '2020-21',
    season_type = 'Regular Season',
    team_id = ''
  )

  cols_x1 <- c(
    "DATE_EST",
    "VISITOR_TEAM",
    "HOME_TEAM",
    "GP",
    "GS",
    "ACTUAL_MINUTES",
    "ACTUAL_SECONDS",
    "FG",
    "FGA",
    "FG_PCT",
    "FG3",
    "FG3A",
    "FG3_PCT",
    "FT",
    "FTA",
    "FT_PCT",
    "OFF_REB",
    "DEF_REB",
    "TOT_REB",
    "AVG_TOT_REB",
    "AST",
    "PF",
    "DQ",
    "STL",
    "TURNOVERS",
    "BLK",
    "PTS",
    "AVG_PTS"
  )

  cols_x2 <- c(
    "DISPLAY_FI_LAST",
    "PERSON_ID",
    "JERSEY_NUM",
    "GP",
    "GS",
    "ACTUAL_MINUTES",
    "ACTUAL_SECONDS",
    "FG",
    "FGA",
    "FG_PCT",
    "FG3",
    "FG3A",
    "FG3_PCT",
    "FT",
    "FTA",
    "FT_PCT",
    "OFF_REB",
    "DEF_REB",
    "TOT_REB",
    "AST",
    "PF",
    "DQ",
    "STL",
    "TURNOVERS",
    "BLK",
    "PTS",
    "MAX_ACTUAL_MINUTES",
    "MAX_ACTUAL_SECONDS",
    "MAX_REB",
    "MAX_AST",
    "MAX_STL",
    "MAX_TURNOVERS",
    "MAX_BLK",
    "MAX_PTS",
    "AVG_ACTUAL_MINUTES",
    "AVG_ACTUAL_SECONDS",
    "AVG_TOT_REB",
    "AVG_AST",
    "AVG_STL",
    "AVG_TURNOVERS",
    "AVG_BLK",
    "AVG_PTS",
    "PER_MIN_TOT_REB",
    "PER_MIN_AST",
    "PER_MIN_STL",
    "PER_MIN_TURNOVERS",
    "PER_MIN_BLK",
    "PER_MIN_PTS"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
