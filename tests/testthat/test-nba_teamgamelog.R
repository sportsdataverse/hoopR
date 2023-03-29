test_that("NBA Team Game Log", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_teamgamelog(team_id = "1610612749")


  cols_x1 <- c(
    "Team_ID",
    "Game_ID",
    "GAME_DATE",
    "MATCHUP",
    "WL",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
