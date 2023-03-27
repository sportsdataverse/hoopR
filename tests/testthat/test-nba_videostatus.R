test_that("NBA Video Status", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_videostatus(game_date = '2023-03-10', league_id = '00')

  cols_x1 <- c(
    "GAME_ID",
    "GAME_DATE",
    "VISITOR_TEAM_ID",
    "VISITOR_TEAM_CITY",
    "VISITOR_TEAM_NAME",
    "VISITOR_TEAM_ABBREVIATION",
    "HOME_TEAM_ID",
    "HOME_TEAM_CITY",
    "HOME_TEAM_NAME",
    "HOME_TEAM_ABBREVIATION",
    "GAME_STATUS",
    "GAME_STATUS_TEXT",
    "IS_AVAILABLE",
    "PT_XYZ_AVAILABLE"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
