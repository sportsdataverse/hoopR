test_that("NBA Player Next N Games", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playernextngames(player_id = '2544')

  cols_x1 <- c(
    "GAME_ID",
    "GAME_DATE",
    "HOME_TEAM_ID",
    "VISITOR_TEAM_ID",
    "HOME_TEAM_NAME",
    "VISITOR_TEAM_NAME",
    "HOME_TEAM_ABBREVIATION",
    "VISITOR_TEAM_ABBREVIATION",
    "HOME_TEAM_NICKNAME",
    "VISITOR_TEAM_NICKNAME",
    "GAME_TIME",
    "HOME_WL",
    "VISITOR_WL"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
