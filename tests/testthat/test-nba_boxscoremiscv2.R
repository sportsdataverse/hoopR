test_that("NBA Boxscore Misc V2", {
  skip_on_cran()
  skip_on_ci()
  x <- nba_boxscoremiscv2(game_id = "0022200021")

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
    "PTS_OFF_TOV",
    "PTS_2ND_CHANCE",
    "PTS_FB",
    "PTS_PAINT",
    "OPP_PTS_OFF_TOV",
    "OPP_PTS_2ND_CHANCE",
    "OPP_PTS_FB",
    "OPP_PTS_PAINT",
    "BLK",
    "BLKA",
    "PF",
    "PFD"
  )

  cols_x2 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "MIN",
    "PTS_OFF_TOV",
    "PTS_2ND_CHANCE",
    "PTS_FB",
    "PTS_PAINT",
    "OPP_PTS_OFF_TOV",
    "OPP_PTS_2ND_CHANCE",
    "OPP_PTS_FB",
    "OPP_PTS_PAINT",
    "BLK",
    "BLKA",
    "PF",
    "PFD"
  )
  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
