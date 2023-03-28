test_that("NBA Team Dashboard Player Tracking - Rebounding", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_teamdashptreb(team_id = '1610612749',
                         season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "G",
    "OVERALL",
    "REB_FREQUENCY",
    "OREB",
    "DREB",
    "REB",
    "C_OREB",
    "C_DREB",
    "C_REB",
    "C_REB_PCT",
    "UC_OREB",
    "UC_DREB",
    "UC_REB",
    "UC_REB_PCT"
  )

  cols_x2 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "SORT_ORDER",
    "G",
    "SHOT_TYPE_RANGE",
    "REB_FREQUENCY",
    "OREB",
    "DREB",
    "REB",
    "C_OREB",
    "C_DREB",
    "C_REB",
    "C_REB_PCT",
    "UC_OREB",
    "UC_DREB",
    "UC_REB",
    "UC_REB_PCT"
  )

  cols_x3 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "SORT_ORDER",
    "G",
    "REB_NUM_CONTESTING_RANGE",
    "REB_FREQUENCY",
    "OREB",
    "DREB",
    "REB",
    "C_OREB",
    "C_DREB",
    "C_REB",
    "C_REB_PCT",
    "UC_OREB",
    "UC_DREB",
    "UC_REB",
    "UC_REB_PCT"
  )

  cols_x4 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "SORT_ORDER",
    "G",
    "SHOT_DIST_RANGE",
    "REB_FREQUENCY",
    "OREB",
    "DREB",
    "REB",
    "C_OREB",
    "C_DREB",
    "C_REB",
    "C_REB_PCT",
    "UC_OREB",
    "UC_DREB",
    "UC_REB",
    "UC_REB_PCT"
  )

  cols_x5 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "SORT_ORDER",
    "G",
    "REB_DIST_RANGE",
    "REB_FREQUENCY",
    "OREB",
    "DREB",
    "REB",
    "C_OREB",
    "C_DREB",
    "C_REB",
    "C_REB_PCT",
    "UC_OREB",
    "UC_DREB",
    "UC_REB",
    "UC_REB_PCT"
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

  Sys.sleep(3)

})
