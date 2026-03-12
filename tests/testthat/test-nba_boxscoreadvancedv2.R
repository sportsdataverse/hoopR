test_that("NBA Boxscore Advanced V2", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_boxscoreadvancedv2(game_id = "0022200021")

  cols_x1 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "PLAYER_ID",
    "PLAYER_NAME",
    "NICKNAME",
    "START_POSITION",
    "COMMENT",
    "MIN",
    "OFF_RATING",
    "DEF_RATING",
    "NET_RATING",
    "AST_PCT",
    "AST_TOV",
    "AST_RATIO",
    "OREB_PCT",
    "DREB_PCT",
    "REB_PCT",
    "TM_TOV_PCT",
    "EFG_PCT",
    "TS_PCT",
    "USG_PCT",
    "PACE",
    "PIE"
  )

  cols_x2 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "MIN",
    "OFF_RATING",
    "DEF_RATING",
    "NET_RATING",
    "AST_PCT",
    "AST_TOV",
    "AST_RATIO",
    "OREB_PCT",
    "DREB_PCT",
    "REB_PCT",
    "TM_TOV_PCT",
    "EFG_PCT",
    "TS_PCT",
    "USG_PCT",
    "PACE",
    "PIE"
  )

  # V2 endpoint may return empty results for some games
  if (ncol(x[[1]]) > 0) {
    expect_in(sort(cols_x1), sort(colnames(x[[1]])))
    expect_s3_class(x[[1]], "data.frame")
  }
  if (ncol(x[[2]]) > 0) {
    expect_in(sort(cols_x2), sort(colnames(x[[2]])))
    expect_s3_class(x[[2]], "data.frame")
  }

  # At minimum, expect a named list is returned
  expect_type(x, "list")

  Sys.sleep(3)

})
