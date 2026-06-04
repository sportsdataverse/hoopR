test_that("ESPN - NBA Athlete Eventlog v2", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_player_eventlog_v2(athlete_id = "1966", season = 2024)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_player_eventlog_v2 at test time")
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

