test_that("ESPN - NBA Positions Index", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_positions()

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_positions at test time")
  }

  required_cols <- c(
    "position_id",
    "ref",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

