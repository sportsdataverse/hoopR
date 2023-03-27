test_that("NBA Player Tracking - Shooting", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playerdashptshots(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME_LAST_FIRST",
    "SORT_ORDER",
    "GP",
    "G",
    "SHOT_TYPE",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  cols_x2 <- c(
    "PLAYER_ID",
    "PLAYER_NAME_LAST_FIRST",
    "SORT_ORDER",
    "GP",
    "G",
    "SHOT_TYPE",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  cols_x3 <- c(
    "PLAYER_ID",
    "PLAYER_NAME_LAST_FIRST",
    "SORT_ORDER",
    "GP",
    "G",
    "SHOT_CLOCK_RANGE",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  cols_x4 <- c(
    "PLAYER_ID",
    "PLAYER_NAME_LAST_FIRST",
    "SORT_ORDER",
    "GP",
    "G",
    "DRIBBLE_RANGE",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  cols_x5 <- c(
    "PLAYER_ID",
    "PLAYER_NAME_LAST_FIRST",
    "SORT_ORDER",
    "GP",
    "G",
    "CLOSE_DEF_DIST_RANGE",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  cols_x6 <- c(
    "PLAYER_ID",
    "PLAYER_NAME_LAST_FIRST",
    "SORT_ORDER",
    "GP",
    "G",
    "CLOSE_DEF_DIST_RANGE",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
  )

  cols_x7 <- c(
    "PLAYER_ID",
    "PLAYER_NAME_LAST_FIRST",
    "SORT_ORDER",
    "GP",
    "G",
    "TOUCH_TIME_RANGE",
    "FGA_FREQUENCY",
    "FGM",
    "FGA",
    "FG_PCT",
    "EFG_PCT",
    "FG2A_FREQUENCY",
    "FG2M",
    "FG2A",
    "FG2_PCT",
    "FG3A_FREQUENCY",
    "FG3M",
    "FG3A",
    "FG3_PCT"
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

})
