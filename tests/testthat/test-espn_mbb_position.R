test_that("ESPN - MBB Position Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_position(position_id = 1)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_position at test time")
  }

  required_cols <- c(
    "position_id",
    "name",
    "display_name",
    "abbreviation",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

