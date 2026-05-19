test_that("ESPN - NBA Season Types", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_season_types(season = 2024)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_season_types at test time")
  }

  required_cols <- c(
    "league",
    "season",
    "season_type"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

