test_that("ESPN - NBA Coach Career Record (Long Format)", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_coach_record(coach_id = 52120, record_type = 0)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_coach_record at test time")
  }

  required_cols <- c(
    "league",
    "coach_id",
    "record_name",
    "stat_name"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

