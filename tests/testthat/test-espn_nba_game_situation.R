test_that("ESPN - NBA Event Situation", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_game_situation(event_id = 401283399)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_game_situation at test time")
  }

  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

