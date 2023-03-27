test_that("NBA Franchise Leaders with Rank", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_franchiseleaderswrank(league_id = '00', team_id = '1610612739')

  cols_x1 <- c(
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM",
    "PERSON_ID",
    "PLAYER",
    "SEASON_TYPE",
    "ACTIVE_WITH_TEAM",
    "GP",
    "MINUTES",
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
    "PTS",
    "F_RANK_GP",
    "F_RANK_MINUTES",
    "F_RANK_FGM",
    "F_RANK_FGA",
    "F_RANK_FG_PCT",
    "F_RANK_FG3M",
    "F_RANK_FG3A",
    "F_RANK_FG3_PCT",
    "F_RANK_FTM",
    "F_RANK_FTA",
    "F_RANK_FT_PCT",
    "F_RANK_OREB",
    "F_RANK_DREB",
    "F_RANK_REB",
    "F_RANK_AST",
    "F_RANK_PF",
    "F_RANK_STL",
    "F_RANK_TOV",
    "F_RANK_BLK",
    "F_RANK_PTS"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
