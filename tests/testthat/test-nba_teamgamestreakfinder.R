test_that("NBA Team Game Streak Finder", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_teamgamestreakfinder(season = year_to_season(most_recent_nba_season() - 1))


  cols_x1 <- c(
    "TEAM_NAME",
    "TEAM_ID",
    "GAMESTREAK",
    "STARTDATE",
    "ENDDATE",
    "ACTIVESTREAK",
    "NUMSEASONS",
    "LASTSEASON",
    "FIRSTSEASON",
    "ABBREVIATION"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
