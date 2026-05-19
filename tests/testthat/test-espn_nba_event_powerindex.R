test_that("ESPN - NBA Event Power Index", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_event_powerindex(event_id = 401283399)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_event_powerindex at test time")
  }

  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

