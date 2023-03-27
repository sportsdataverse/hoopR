test_that("NBA League Hustle Stats Team", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguehustlestatsteam(league_id = '00')

  cols_x1 <- c(
    "TEAM_ID",
    "TEAM_NAME",
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
    "BOX_OUTS",
    "PCT_BOX_OUTS_OFF",
    "PCT_BOX_OUTS_DEF"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
