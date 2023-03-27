test_that("NBA Shot Chart Lineup Detail", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_shotchartlineupdetail(group_id = '-202689-203493-203501-1626174-1627827-',
                                 season = year_to_season(most_recent_nba_season() - 1))


  cols_x1 <- c(
    "GRID_TYPE",
    "GAME_ID",
    "GAME_EVENT_ID",
    "GROUP_ID",
    "GROUP_NAME",
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_NAME",
    "PERIOD",
    "MINUTES_REMAINING",
    "SECONDS_REMAINING",
    "EVENT_TYPE",
    "ACTION_TYPE",
    "SHOT_TYPE",
    "SHOT_ZONE_BASIC",
    "SHOT_ZONE_AREA",
    "SHOT_ZONE_RANGE",
    "SHOT_DISTANCE",
    "LOC_X",
    "LOC_Y",
    "SHOT_ATTEMPTED_FLAG",
    "SHOT_MADE_FLAG",
    "GAME_DATE",
    "HTM",
    "VTM"
  )

  cols_x2 <- c(
    "GRID_TYPE",
    "SHOT_ZONE_BASIC",
    "SHOT_ZONE_AREA",
    "SHOT_ZONE_RANGE",
    "FGA",
    "FGM",
    "FG_PCT"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
