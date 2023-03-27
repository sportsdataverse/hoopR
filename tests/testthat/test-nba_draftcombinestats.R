test_that("NBA Draft Combine Stats", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_draftcombinestats(league_id = '00',
                             season_year = most_recent_nba_season() - 1)

  cols_x1 <- c(
    "SEASON",
    "PLAYER_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "PLAYER_NAME",
    "POSITION",
    "HEIGHT_WO_SHOES",
    "HEIGHT_WO_SHOES_FT_IN",
    "HEIGHT_W_SHOES",
    "HEIGHT_W_SHOES_FT_IN",
    "WEIGHT",
    "WINGSPAN",
    "WINGSPAN_FT_IN",
    "STANDING_REACH",
    "STANDING_REACH_FT_IN",
    "BODY_FAT_PCT",
    "HAND_LENGTH",
    "HAND_WIDTH",
    "STANDING_VERTICAL_LEAP",
    "MAX_VERTICAL_LEAP",
    "LANE_AGILITY_TIME",
    "MODIFIED_LANE_AGILITY_TIME",
    "THREE_QUARTER_SPRINT",
    "BENCH_PRESS",
    "SPOT_FIFTEEN_CORNER_LEFT",
    "SPOT_FIFTEEN_BREAK_LEFT",
    "SPOT_FIFTEEN_TOP_KEY",
    "SPOT_FIFTEEN_BREAK_RIGHT",
    "SPOT_FIFTEEN_CORNER_RIGHT",
    "SPOT_COLLEGE_CORNER_LEFT",
    "SPOT_COLLEGE_BREAK_LEFT",
    "SPOT_COLLEGE_TOP_KEY",
    "SPOT_COLLEGE_BREAK_RIGHT",
    "SPOT_COLLEGE_CORNER_RIGHT",
    "SPOT_NBA_CORNER_LEFT",
    "SPOT_NBA_BREAK_LEFT",
    "SPOT_NBA_TOP_KEY",
    "SPOT_NBA_BREAK_RIGHT",
    "SPOT_NBA_CORNER_RIGHT",
    "OFF_DRIB_FIFTEEN_BREAK_LEFT",
    "OFF_DRIB_FIFTEEN_TOP_KEY",
    "OFF_DRIB_FIFTEEN_BREAK_RIGHT",
    "OFF_DRIB_COLLEGE_BREAK_LEFT",
    "OFF_DRIB_COLLEGE_TOP_KEY",
    "OFF_DRIB_COLLEGE_BREAK_RIGHT",
    "ON_MOVE_FIFTEEN",
    "ON_MOVE_COLLEGE"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
