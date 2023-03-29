test_that("NBA Draft Combine Non-Stationary Shooting Results", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_draftcombinenonstationaryshooting(league_id = "00",
                                             season_year = most_recent_nba_season() - 1)

  cols_x1 <- c(
    "TEMP_PLAYER_ID",
    "PLAYER_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "PLAYER_NAME",
    "POSITION",
    "OFF_DRIB_FIFTEEN_BREAK_LEFT_MADE",
    "OFF_DRIB_FIFTEEN_BREAK_LEFT_ATTEMPT",
    "OFF_DRIB_FIFTEEN_BREAK_LEFT_PCT",
    "OFF_DRIB_FIFTEEN_TOP_KEY_MADE",
    "OFF_DRIB_FIFTEEN_TOP_KEY_ATTEMPT",
    "OFF_DRIB_FIFTEEN_TOP_KEY_PCT",
    "OFF_DRIB_FIFTEEN_BREAK_RIGHT_MADE",
    "OFF_DRIB_FIFTEEN_BREAK_RIGHT_ATTEMPT",
    "OFF_DRIB_FIFTEEN_BREAK_RIGHT_PCT",
    "OFF_DRIB_COLLEGE_BREAK_LEFT_MADE",
    "OFF_DRIB_COLLEGE_BREAK_LEFT_ATTEMPT",
    "OFF_DRIB_COLLEGE_BREAK_LEFT_PCT",
    "OFF_DRIB_COLLEGE_TOP_KEY_MADE",
    "OFF_DRIB_COLLEGE_TOP_KEY_ATTEMPT",
    "OFF_DRIB_COLLEGE_TOP_KEY_PCT",
    "OFF_DRIB_COLLEGE_BREAK_RIGHT_MADE",
    "OFF_DRIB_COLLEGE_BREAK_RIGHT_ATTEMPT",
    "OFF_DRIB_COLLEGE_BREAK_RIGHT_PCT",
    "ON_MOVE_FIFTEEN_MADE",
    "ON_MOVE_FIFTEEN_ATTEMPT",
    "ON_MOVE_FIFTEEN_PCT",
    "ON_MOVE_COLLEGE_MADE",
    "ON_MOVE_COLLEGE_ATTEMPT",
    "ON_MOVE_COLLEGE_PCT"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
