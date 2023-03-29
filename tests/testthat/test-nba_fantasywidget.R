test_that("NBA Fantasy Widget", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_fantasywidget(league_id = "00", season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "PLAYER_POSITION",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "GP",
    "MIN",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS",
    "PTS",
    "REB",
    "AST",
    "BLK",
    "STL",
    "TOV",
    "FG3M",
    "FGA",
    "FG_PCT",
    "FTA",
    "FT_PCT"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
