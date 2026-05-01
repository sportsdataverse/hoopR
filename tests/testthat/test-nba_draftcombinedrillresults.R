test_that("NBA Draft Combine Drill Results", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()



  x <- nba_draftcombinedrillresults(league_id = "00",
                                    season_year = most_recent_nba_season() - 1)

  if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) || nrow(x[[1]]) == 0) {
    skip("No rows returned from endpoint at test time")
  }

  cols_x1 <- c(
    "TEMP_PLAYER_ID",
    "PLAYER_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "PLAYER_NAME",
    "POSITION",
    "STANDING_VERTICAL_LEAP",
    "MAX_VERTICAL_LEAP",
    "LANE_AGILITY_TIME",
    "MODIFIED_LANE_AGILITY_TIME",
    "THREE_QUARTER_SPRINT",
    "BENCH_PRESS"
  )


  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
