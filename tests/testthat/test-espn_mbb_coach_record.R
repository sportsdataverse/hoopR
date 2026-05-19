test_that("ESPN - MBB Coach Career Record (Long Format)", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_coach_record(coach_id = 32116, record_type = 0)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_coach_record at test time")
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

