test_that("ESPN - MBB Team Season Statistics (Long Format)", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_team_season_statistics(team_id = 52, season = 2024, season_type = 2)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_team_season_statistics at test time")
  }

  required_cols <- c(
    "league",
    "season",
    "team_id",
    "stat_name"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

