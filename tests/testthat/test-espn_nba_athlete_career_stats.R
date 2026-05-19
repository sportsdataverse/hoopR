test_that("ESPN - NBA Athlete Career Stats (Long Format)", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_athlete_career_stats(athlete_id = "1966")

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_athlete_career_stats at test time")
  }

  required_cols <- c(
    "league",
    "athlete_id",
    "stat_name",
    "value"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

