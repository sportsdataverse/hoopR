test_that("NBA League Hustle Stats Player", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguehustlestatsplayer(league_id = '00')

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "AGE",
    "G",
    "MIN",
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
    "PCT_LOOSE_BALLS_RECOVERED_OFF",
    "PCT_LOOSE_BALLS_RECOVERED_DEF",
    "OFF_BOXOUTS",
    "DEF_BOXOUTS",
    "BOX_OUT_PLAYER_TEAM_REBS",
    "BOX_OUT_PLAYER_REBS",
    "BOX_OUTS",
    "PCT_BOX_OUTS_OFF",
    "PCT_BOX_OUTS_DEF",
    "PCT_BOX_OUTS_TEAM_REB",
    "PCT_BOX_OUTS_REB"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
