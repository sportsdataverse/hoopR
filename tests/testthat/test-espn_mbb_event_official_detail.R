test_that("ESPN - MBB Event Official Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_event_official_detail(event_id = 401256760, order = 1)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_event_official_detail at test time")
  }

  required_cols <- c(
    "league",
    "event_id",
    "full_name",
    "position_name"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

