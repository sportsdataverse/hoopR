test_that("NBA Player Game Streak Finder", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_playergamestreakfinder()

  cols_x1 <- c(
    "PLAYER_NAME_LAST_FIRST",
    "PLAYER_ID",
    "GAMESTREAK",
    "STARTDATE",
    "ENDDATE",
    "ACTIVESTREAK",
    "NUMSEASONS",
    "LASTSEASON",
    "FIRSTSEASON"
  )


  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
