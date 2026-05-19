test_that("ESPN - NBA Tournaments Index", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_tournaments()

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_tournaments at test time")
  }

  required_cols <- c(
    "tournament_id",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

