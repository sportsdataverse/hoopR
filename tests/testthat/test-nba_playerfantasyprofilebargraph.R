test_that("NBA Player Fantasy Profile Bar Graph", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playerfantasyprofilebargraph(player_id = '2544')

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS",
    "PTS",
    "REB",
    "AST",
    "FG3M",
    "FT_PCT",
    "STL",
    "BLK",
    "TOV",
    "FG_PCT"
  )

  cols_x2 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS",
    "PTS",
    "REB",
    "AST",
    "FG3M",
    "FT_PCT",
    "STL",
    "BLK",
    "TOV",
    "FG_PCT"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
