test_that("ESPN - NBA Week Ranking Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_week_ranking(ranking_id = 16, week = 1, season = 2024)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_week_ranking at test time")
  }

  required_cols <- c(
    "ranking_id",
    "rank",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

