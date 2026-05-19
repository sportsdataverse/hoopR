test_that("ESPN - NBA Event Competitor Score", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_event_competitor_score(event_id = 401283399, team_id = 29)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_event_competitor_score at test time")
  }

  required_cols <- c(
    "league",
    "event_id",
    "team_id",
    "value"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

