test_that("NBA Assist Tracker", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()
	
  

  x <- nba_assisttracker(league_id = "00")

  cols_x1 <- c(
    "ASSISTS"
  )


  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
