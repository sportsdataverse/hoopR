test_that("ESPN - MBB Season Groups Index", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_season_groups(season = 2024, season_type = 2)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_season_groups at test time")
  }

  required_cols <- c(
    "group_id",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

