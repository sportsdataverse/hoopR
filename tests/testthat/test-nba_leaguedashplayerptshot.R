test_that("NBA League Dash Player Tracking - Shooting", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguedashplayerptshot(league_id = "00", season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "PLAYER_LAST_TEAM_ID",
    "PLAYER_LAST_TEAM_ABBREVIATION",
    "AGE",
    "GP",
    "G",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
