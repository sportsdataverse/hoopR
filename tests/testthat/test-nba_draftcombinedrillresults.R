test_that("NBA Draft Combine Drill Results", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_draftcombinedrillresults(league_id = "00",
                                    season_year = most_recent_nba_season() - 1)

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


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
