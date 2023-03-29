test_that("NBA Synergy Play Types", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_synergyplaytypes(league_id = "00", season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "SEASON_ID",
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "PLAY_TYPE",
    "TYPE_GROUPING",
    "PERCENTILE",
    "GP",
    "POSS_PCT",
    "PPP",
    "FG_PCT",
    "FT_POSS_PCT",
    "TOV_POSS_PCT",
    "SF_POSS_PCT",
    "PLUSONE_POSS_PCT",
    "SCORE_POSS_PCT",
    "EFG_PCT",
    "POSS",
    "PTS",
    "FGM",
    "FGA",
    "FGMX"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
