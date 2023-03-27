test_that("NBA Boxscore Summary V2", {
  skip_on_cran()
  skip_on_ci()
  x <- nba_boxscoresummaryv2(game_id = "0022200021")

  cols_x1 <- c(
    "GAME_DATE_EST",
    "GAME_SEQUENCE",
    "GAME_ID",
    "GAME_STATUS_ID",
    "GAME_STATUS_TEXT",
    "GAMECODE",
    "HOME_TEAM_ID",
    "VISITOR_TEAM_ID",
    "SEASON",
    "LIVE_PERIOD",
    "LIVE_PC_TIME",
    "NATL_TV_BROADCASTER_ABBREVIATION",
    "LIVE_PERIOD_TIME_BCAST",
    "WH_STATUS"
  )

  cols_x2 <- c(
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "PTS_PAINT",
    "PTS_2ND_CHANCE",
    "PTS_FB",
    "LARGEST_LEAD",
    "LEAD_CHANGES",
    "TIMES_TIED",
    "TEAM_TURNOVERS",
    "TOTAL_TURNOVERS",
    "TEAM_REBOUNDS",
    "PTS_OFF_TO"
  )

  cols_x3 <- c(
    "OFFICIAL_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "JERSEY_NUM"
  )

  cols_x4 <- c(
    "PLAYER_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "JERSEY_NUM",
    "TEAM_ID",
    "TEAM_CITY",
    "TEAM_NAME",
    "TEAM_ABBREVIATION"
  )

  cols_x5 <- c(
    "GAME_DATE",
    "ATTENDANCE",
    "GAME_TIME"
  )

  cols_x6 <- c(
    "GAME_DATE_EST",
    "GAME_SEQUENCE",
    "GAME_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_CITY_NAME",
    "TEAM_NICKNAME",
    "TEAM_WINS_LOSSES",
    "PTS_QTR1",
    "PTS_QTR2",
    "PTS_QTR3",
    "PTS_QTR4",
    "PTS_OT1",
    "PTS_OT2",
    "PTS_OT3",
    "PTS_OT4",
    "PTS_OT5",
    "PTS_OT6",
    "PTS_OT7",
    "PTS_OT8",
    "PTS_OT9",
    "PTS_OT10",
    "PTS"
  )

  cols_x7 <- c(
    "GAME_ID",
    "LAST_GAME_ID",
    "LAST_GAME_DATE_EST",
    "LAST_GAME_HOME_TEAM_ID",
    "LAST_GAME_HOME_TEAM_CITY",
    "LAST_GAME_HOME_TEAM_NAME",
    "LAST_GAME_HOME_TEAM_ABBREVIATION",
    "LAST_GAME_HOME_TEAM_POINTS",
    "LAST_GAME_VISITOR_TEAM_ID",
    "LAST_GAME_VISITOR_TEAM_CITY",
    "LAST_GAME_VISITOR_TEAM_NAME",
    "LAST_GAME_VISITOR_TEAM_CITY1",
    "LAST_GAME_VISITOR_TEAM_POINTS"
  )

  cols_x8 <- c(
    "GAME_ID",
    "HOME_TEAM_ID",
    "VISITOR_TEAM_ID",
    "GAME_DATE_EST",
    "HOME_TEAM_WINS",
    "HOME_TEAM_LOSSES",
    "SERIES_LEADER"
  )

  cols_x9 <- c(
    "GAME_ID",
    "VIDEO_AVAILABLE_FLAG",
    "PT_AVAILABLE",
    "PT_XYZ_AVAILABLE",
    "WH_STATUS",
    "HUSTLE_STATUS",
    "HISTORICAL_STATUS"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], 'data.frame')
  expect_equal(sort(colnames(x[[5]])), sort(cols_x5))
  expect_s3_class(x[[5]], 'data.frame')
  expect_equal(sort(colnames(x[[6]])), sort(cols_x6))
  expect_s3_class(x[[6]], 'data.frame')
  expect_equal(sort(colnames(x[[7]])), sort(cols_x7))
  expect_s3_class(x[[7]], 'data.frame')
  expect_equal(sort(colnames(x[[8]])), sort(cols_x8))
  expect_s3_class(x[[8]], 'data.frame')
  expect_equal(sort(colnames(x[[9]])), sort(cols_x9))
  expect_s3_class(x[[9]], 'data.frame')

})
