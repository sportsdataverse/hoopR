test_that("ESPN - MBB Coach Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_coach(coach_id = 32116)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_coach at test time")
  }

  required_cols <- c(
    "coach_id",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

