test_that("ESPN - NBA Event Official Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_event_official_detail(event_id = 401283399, order = 1)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_event_official_detail at test time")
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

