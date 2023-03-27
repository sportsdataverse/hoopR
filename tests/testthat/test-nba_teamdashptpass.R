test_that("NBA Team Dashboard Player Tracking - Passing", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_teamdashptpass(team_id = '1610612749',
                           season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "PASS_TYPE",
    "G",
    "PASS_FROM",
    "PASS_TEAMMATE_PLAYER_ID",
    "FREQUENCY",
    "PASS",
    "AST",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  cols_x2 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "PASS_TYPE",
    "G",
    "PASS_TO",
    "PASS_TEAMMATE_PLAYER_ID",
    "FREQUENCY",
    "PASS",
    "AST",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
