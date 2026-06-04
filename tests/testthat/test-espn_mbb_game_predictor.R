test_that("ESPN - MBB Event Predictor", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_game_predictor(event_id = 401256760)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_game_predictor at test time")
  }

  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

