test_that("NBA Scoreboard", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_scoreboard(league_id = "00", game_date = "2021-07-20")


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
    "GAME_DATE_EST",
    "GAME_SEQUENCE",
    "GAME_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_CITY_NAME",
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
    "PTS",
    "FG_PCT",
    "FT_PCT",
    "FG3_PCT",
    "AST",
    "REB",
    "TOV"
  )

  cols_x3 <- c(
    "GAME_ID",
    "HOME_TEAM_ID",
    "VISITOR_TEAM_ID",
    "GAME_DATE_EST",
    "HOME_TEAM_WINS",
    "HOME_TEAM_LOSSES",
    "SERIES_LEADER"
  )

  cols_x4 <- c(
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

  cols_x5 <- c(
    "TEAM_ID",
    "LEAGUE_ID",
    "SEASON_ID",
    "STANDINGSDATE",
    "CONFERENCE",
    "TEAM",
    "G",
    "W",
    "L",
    "W_PCT",
    "HOME_RECORD",
    "ROAD_RECORD"
  )

  cols_x6 <- c(
    "TEAM_ID",
    "LEAGUE_ID",
    "SEASON_ID",
    "STANDINGSDATE",
    "CONFERENCE",
    "TEAM",
    "G",
    "W",
    "L",
    "W_PCT",
    "HOME_RECORD",
    "ROAD_RECORD"
  )

  cols_x7 <- c(
    "GAME_ID",
    "PT_AVAILABLE"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], "data.frame")
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], "data.frame")
  expect_equal(sort(colnames(x[[5]])), sort(cols_x5))
  expect_s3_class(x[[5]], "data.frame")
  expect_equal(sort(colnames(x[[6]])), sort(cols_x6))
  expect_s3_class(x[[6]], "data.frame")
  expect_equal(sort(colnames(x[[7]])), sort(cols_x7))
  expect_s3_class(x[[7]], "data.frame")

  Sys.sleep(3)

})
