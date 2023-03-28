test_that("NBA Hustle Stats Boxscore", {
  skip_on_cran()
  skip_on_ci()
  x <- nba_hustlestatsboxscore(game_id = "0022200021")

  cols_x1 <- c(
    "GAME_ID",
    "HUSTLE_STATUS"
  )

  cols_x2 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "PLAYER_ID",
    "PLAYER_NAME",
    "START_POSITION",
    "COMMENT",
    "MINUTES",
    "PTS",
    "CONTESTED_SHOTS",
    "CONTESTED_SHOTS_2PT",
    "CONTESTED_SHOTS_3PT",
    "DEFLECTIONS",
    "CHARGES_DRAWN",
    "SCREEN_ASSISTS",
    "SCREEN_AST_PTS",
    "OFF_LOOSE_BALLS_RECOVERED",
    "DEF_LOOSE_BALLS_RECOVERED",
    "LOOSE_BALLS_RECOVERED",
    "OFF_BOXOUTS",
    "DEF_BOXOUTS",
    "BOX_OUT_PLAYER_TEAM_REBS",
    "BOX_OUT_PLAYER_REBS",
    "BOX_OUTS"
  )


  cols_x3 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "MINUTES",
    "PTS",
    "CONTESTED_SHOTS",
    "CONTESTED_SHOTS_2PT",
    "CONTESTED_SHOTS_3PT",
    "DEFLECTIONS",
    "CHARGES_DRAWN",
    "SCREEN_ASSISTS",
    "SCREEN_AST_PTS",
    "OFF_LOOSE_BALLS_RECOVERED",
    "DEF_LOOSE_BALLS_RECOVERED",
    "LOOSE_BALLS_RECOVERED",
    "OFF_BOXOUTS",
    "DEF_BOXOUTS",
    "BOX_OUT_PLAYER_TEAM_REBS",
    "BOX_OUT_PLAYER_REBS",
    "BOX_OUTS"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')

  Sys.sleep(3)

})
