test_that("ESPN - NBA Franchises Index", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_franchises()

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_franchises at test time")
  }

  required_cols <- c(
    "franchise_id",
    "ref",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

