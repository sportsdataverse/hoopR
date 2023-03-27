test_that("NBA League Season Matchups", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leagueseasonmatchups(league_id = '00',
                                 season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "SEASON_ID",
    "OFF_PLAYER_ID",
    "OFF_PLAYER_NAME",
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
    "HELP_BLK",
    "HELP_FGM",
    "HELP_FGA",
    "HELP_FG_PERC",
    "MATCHUP_FTM",
    "MATCHUP_FTA",
    "SFL",
    "MATCHUP_TIME_SEC"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
