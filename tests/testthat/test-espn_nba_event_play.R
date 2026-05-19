test_that("ESPN - NBA Event Play Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_event_play(event_id = 401283399, play_id = "4012833997")

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_event_play at test time")
  }

  required_cols <- c(
    "league",
    "event_id",
    "play_id"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

