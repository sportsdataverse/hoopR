test_that("NBA Game Rotation", {
  skip_on_cran()
  skip_on_ci()
  x <- nba_gamerotation(game_id = "0022200021")

  cols_x1 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_CITY",
    "TEAM_NAME",
    "PERSON_ID",
    "PLAYER_FIRST",
    "PLAYER_LAST",
    "IN_TIME_REAL",
    "OUT_TIME_REAL",
    "PLAYER_PTS",
    "PT_DIFF",
    "USG_PCT"
  )

  cols_x2 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_CITY",
    "TEAM_NAME",
    "PERSON_ID",
    "PLAYER_FIRST",
    "PLAYER_LAST",
    "IN_TIME_REAL",
    "OUT_TIME_REAL",
    "PLAYER_PTS",
    "PT_DIFF",
    "USG_PCT"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")

  Sys.sleep(3)

})
