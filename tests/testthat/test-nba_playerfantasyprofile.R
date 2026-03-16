test_that("NBA Player Fantasy Profile", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_playerfantasyprofile(player_id = "2544")

  cols_x1 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "GP",
    "W",
    "L",
    "W_PCT",
    "MIN",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "FTM",
    "FTA",
    "FT_PCT",
    "OREB",
    "DREB",
    "REB",
    "AST",
    "TOV",
    "STL",
    "BLK",
    "BLKA",
    "PF",
    "PFD",
    "PTS",
    "PLUS_MINUS",
    "DD2",
    "TD3",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS"
  )

  cols_x2 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "GP",
    "W",
    "L",
    "W_PCT",
    "MIN",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "FTM",
    "FTA",
    "FT_PCT",
    "OREB",
    "DREB",
    "REB",
    "AST",
    "TOV",
    "STL",
    "BLK",
    "BLKA",
    "PF",
    "PFD",
    "PTS",
    "PLUS_MINUS",
    "DD2",
    "TD3",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS"
  )

  cols_x3 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "GP",
    "W",
    "L",
    "W_PCT",
    "MIN",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "FTM",
    "FTA",
    "FT_PCT",
    "OREB",
    "DREB",
    "REB",
    "AST",
    "TOV",
    "STL",
    "BLK",
    "BLKA",
    "PF",
    "PFD",
    "PTS",
    "PLUS_MINUS",
    "DD2",
    "TD3",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS"
  )

  cols_x4 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "SEASON_YEAR",
    "GP",
    "W",
    "L",
    "W_PCT",
    "MIN",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "FTM",
    "FTA",
    "FT_PCT",
    "OREB",
    "DREB",
    "REB",
    "AST",
    "TOV",
    "STL",
    "BLK",
    "BLKA",
    "PF",
    "PFD",
    "PTS",
    "PLUS_MINUS",
    "DD2",
    "TD3",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS"
  )

  cols_x5 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "GP",
    "W",
    "L",
    "W_PCT",
    "MIN",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "FTM",
    "FTA",
    "FT_PCT",
    "OREB",
    "DREB",
    "REB",
    "AST",
    "TOV",
    "STL",
    "BLK",
    "BLKA",
    "PF",
    "PFD",
    "PTS",
    "PLUS_MINUS",
    "DD2",
    "TD3",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS"
  )

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(cols_x2), sort(colnames(x[[2]])))
  expect_s3_class(x[[2]], "data.frame")
  expect_in(sort(cols_x3), sort(colnames(x[[3]])))
  expect_s3_class(x[[3]], "data.frame")
  expect_in(sort(cols_x4), sort(colnames(x[[4]])))
  expect_s3_class(x[[4]], "data.frame")
  expect_in(sort(cols_x5), sort(colnames(x[[5]])))
  expect_s3_class(x[[5]], "data.frame")

  Sys.sleep(3)

})
