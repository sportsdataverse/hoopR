test_that("NBA Player Career by College", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playercareerbycollege(college = "Florida State",
                                 league_id = "00",
                                 per_mode = "Totals",
                                 season = year_to_season(most_recent_nba_season() - 1),
                                 season_type = "Regular Season")

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "COLLEGE",
    "GP",
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
    "PF",
    "PTS"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
