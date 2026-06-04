test_that("ESPN - MBB Athlete Eventlog v2", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_player_eventlog_v2(athlete_id = "4432809", season = 2024)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_player_eventlog_v2 at test time")
  }

  required_cols <- c(
    "athlete_id",
    "season",
    "event_id",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

