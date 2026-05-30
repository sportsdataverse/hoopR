test_that("ESPN - NBA Seasons", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_nba_seasons()

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_seasons at test time")
  }

  cols_x <- c(
    "season", "start_date", "end_date",
    "display_name", "season_type_count"
  )

  expect_in(sort(cols_x), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
