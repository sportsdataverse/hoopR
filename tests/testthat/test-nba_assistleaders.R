test_that("NBA Assist Leaders", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()
	
  

  x <- nba_assistleaders(league_id = "00")

  cols_x1 <- c(
    "RANK",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "AST"
  )


  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
