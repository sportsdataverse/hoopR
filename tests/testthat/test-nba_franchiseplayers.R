test_that("NBA Franchise Players", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_franchiseplayers(league_id = '00', team_id = '1610612739')

  cols_x1 <- c(
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM",
    "PERSON_ID",
    "PLAYER",
    "SEASON_TYPE",
    "ACTIVE_WITH_TEAM",
    "GP",
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
    "PF",
    "STL",
    "TOV",
    "BLK",
    "PTS"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
