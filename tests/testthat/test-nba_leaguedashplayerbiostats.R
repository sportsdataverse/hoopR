test_that("NBA League Dash Bio Stats", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguedashplayerbiostats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "AGE",
    "PLAYER_HEIGHT",
    "PLAYER_HEIGHT_INCHES",
    "PLAYER_WEIGHT",
    "COLLEGE",
    "COUNTRY",
    "DRAFT_YEAR",
    "DRAFT_ROUND",
    "DRAFT_NUMBER",
    "GP",
    "PTS",
    "REB",
    "AST",
    "NET_RATING",
    "OREB_PCT",
    "DREB_PCT",
    "USG_PCT",
    "TS_PCT",
    "AST_PCT"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
