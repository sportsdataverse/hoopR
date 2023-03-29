test_that("NBA FanDuel Player Infographic", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_infographicfanduelplayer(game_id = "0022201086")

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "JERSEY_NUM",
    "PLAYER_POSITION",
    "LOCATION",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS",
    "USG_PCT",
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
    "PLUS_MINUS"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
