test_that("NBA Data PBP", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_data_pbp(game_id = "0021900001")

  # data.nba.com endpoint may be unavailable
  if (ncol(x) > 0) {
    cols <- c(
      "game_id",
      "league",
      "period",
      "event_num",
      "clock",
      "description"
    )
    expect_in(sort(cols), sort(colnames(x)))
    expect_s3_class(x, "data.frame")
  }

  Sys.sleep(3)

})
