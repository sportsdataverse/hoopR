test_that("NBA Boxscore Scoring V2", {
  skip_on_cran()
  skip_on_ci()
  x <- nba_boxscorescoringv2(game_id = "0022200021")

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
    "PCT_FGA_2PT",
    "PCT_FGA_3PT",
    "PCT_PTS_2PT",
    "PCT_PTS_2PT_MR",
    "PCT_PTS_3PT",
    "PCT_PTS_FB",
    "PCT_PTS_FT",
    "PCT_PTS_OFF_TOV",
    "PCT_PTS_PAINT",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM"
  )

  cols_x2 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "MIN",
    "PCT_FGA_2PT",
    "PCT_FGA_3PT",
    "PCT_PTS_2PT",
    "PCT_PTS_2PT_MR",
    "PCT_PTS_3PT",
    "PCT_PTS_FB",
    "PCT_PTS_FT",
    "PCT_PTS_OFF_TOV",
    "PCT_PTS_PAINT",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM"
  )
  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
