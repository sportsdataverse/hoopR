test_that("NBA League Dash Player Tracking - Defense", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguedashptdefend(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "CLOSE_DEF_PERSON_ID",
    "PLAYER_NAME",
    "PLAYER_LAST_TEAM_ID",
    "PLAYER_LAST_TEAM_ABBREVIATION",
    "PLAYER_POSITION",
    "AGE",
    "GP",
    "G",
    "FREQ",
    "D_FGM",
    "D_FGA",
    "D_FG_PCT",
    "NORMAL_FG_PCT",
    "PCT_PLUSMINUS"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
