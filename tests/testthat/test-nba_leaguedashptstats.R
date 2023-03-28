test_that("NBA League Dash Player Tracking Stats", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguedashptstats(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "GP",
    "W",
    "L",
    "MIN",
    "DRIVES",
    "DRIVE_FGM",
    "DRIVE_FGA",
    "DRIVE_FG_PCT",
    "DRIVE_FTM",
    "DRIVE_FTA",
    "DRIVE_FT_PCT",
    "DRIVE_PTS",
    "DRIVE_PTS_PCT",
    "DRIVE_PASSES",
    "DRIVE_PASSES_PCT",
    "DRIVE_AST",
    "DRIVE_AST_PCT",
    "DRIVE_TOV",
    "DRIVE_TOV_PCT",
    "DRIVE_PF",
    "DRIVE_PF_PCT"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
