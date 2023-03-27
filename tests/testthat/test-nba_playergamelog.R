test_that("NBA Player Game Log", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playergamelog(player_id = '2544',
                         season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "SEASON_ID",
    "Player_ID",
    "Game_ID",
    "GAME_DATE",
    "MATCHUP",
    "WL",
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
    "PTS",
    "PLUS_MINUS",
    "VIDEO_AVAILABLE"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
