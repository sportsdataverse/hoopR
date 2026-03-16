test_that("NBA Franchise Leaders", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()



  x <- nba_franchiseleaders(league_id = "00", team_id = "1610612739")

  cols_x1 <- c(
    "TEAM_ID",
    "PTS",
    "PTS_PERSON_ID",
    "PTS_PLAYER",
    "AST",
    "AST_PERSON_ID",
    "AST_PLAYER",
    "REB",
    "REB_PERSON_ID",
    "REB_PLAYER",
    "BLK",
    "BLK_PERSON_ID",
    "BLK_PLAYER",
    "STL",
    "STL_PERSON_ID",
    "STL_PLAYER"
  )


  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
