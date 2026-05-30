test_that("ESPN - MBB Calendar", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_mbb_calendar(season = 2025)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_calendar at test time")
  }

  cols <- c(
    "season",
    "season_type",
    "season_type_label",
    "start_date",
    "end_date"
  )

  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
