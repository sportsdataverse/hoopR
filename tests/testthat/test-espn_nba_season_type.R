test_that("ESPN - NBA Season Type Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_season_type(season = 2024, season_type = 2)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_season_type at test time")
  }

  required_cols <- c(
    "season",
    "type_id",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

