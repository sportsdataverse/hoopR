test_that("NBA Boxscore Usage V2", {
  skip_on_cran()
  skip_on_ci()
  x <- nba_boxscoreusagev2(game_id = "0022200021")

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
    "USG_PCT",
    "PCT_FGM",
    "PCT_FGA",
    "PCT_FG3M",
    "PCT_FG3A",
    "PCT_FTM",
    "PCT_FTA",
    "PCT_OREB",
    "PCT_DREB",
    "PCT_REB",
    "PCT_AST",
    "PCT_TOV",
    "PCT_STL",
    "PCT_BLK",
    "PCT_BLKA",
    "PCT_PF",
    "PCT_PFD",
    "PCT_PTS"
  )

  cols_x2 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "MIN",
    "USG_PCT",
    "PCT_FGM",
    "PCT_FGA",
    "PCT_FG3M",
    "PCT_FG3A",
    "PCT_FTM",
    "PCT_FTA",
    "PCT_OREB",
    "PCT_DREB",
    "PCT_REB",
    "PCT_AST",
    "PCT_TOV",
    "PCT_STL",
    "PCT_BLK",
    "PCT_BLKA",
    "PCT_PF",
    "PCT_PFD",
    "PCT_PTS"
  )
  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
