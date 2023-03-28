test_that("NBA Matchups Rollup", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_matchupsrollup(league_id = '00',
                          season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "SEASON_ID",
    "POSITION",
    "PERCENT_OF_TIME",
    "DEF_PLAYER_ID",
    "DEF_PLAYER_NAME",
    "GP",
    "MATCHUP_MIN",
    "PARTIAL_POSS",
    "PLAYER_PTS",
    "TEAM_PTS",
    "MATCHUP_AST",
    "MATCHUP_TOV",
    "MATCHUP_BLK",
    "MATCHUP_FGM",
    "MATCHUP_FGA",
    "MATCHUP_FG_PCT",
    "MATCHUP_FG3M",
    "MATCHUP_FG3A",
    "MATCHUP_FG3_PCT",
    "MATCHUP_FTM",
    "MATCHUP_FTA",
    "SFL"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
