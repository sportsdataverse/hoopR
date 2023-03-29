test_that("NBA Cume Stats Team", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_cumestatsteam(
    game_ids = "0022201094",
    league_id = "00",
    season = "2022-23",
    season_type = "Regular Season",
    team_id = "1610612739"
  )

  cols_x1 <- c(
    "JERSEY_NUM",
    "PLAYER",
    "PERSON_ID",
    "TEAM_ID",
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
    "MAX_BLKP",
    "MAX_PTS",
    "AVG_ACTUAL_MINUTES",
    "AVG_ACTUAL_SECONDS",
    "AVG_REB",
    "AVG_AST",
    "AVG_STL",
    "AVG_TURNOVERS",
    "AVG_BLKP",
    "AVG_PTS",
    "PER_MIN_REB",
    "PER_MIN_AST",
    "PER_MIN_STL",
    "PER_MIN_TURNOVERS",
    "PER_MIN_BLK",
    "PER_MIN_PTS"
  )

  cols_x2 <- c(
    "CITY",
    "NICKNAME",
    "TEAM_ID",
    "W",
    "L",
    "W_HOME",
    "L_HOME",
    "W_ROAD",
    "L_ROAD",
    "TEAM_TURNOVERS",
    "TEAM_REBOUNDS",
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
    "STL",
    "TOTAL_TURNOVERS",
    "BLK",
    "PTS",
    "AVG_REB",
    "AVG_PTS",
    "DQ"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")

  Sys.sleep(3)

})
