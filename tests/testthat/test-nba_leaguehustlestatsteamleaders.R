test_that("NBA League Hustle Stats Team Leaders", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguehustlestatsteamleaders(league_id = '00')

  cols_x1 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "RANK",
    "CONTESTED_SHOTS"
  )

  cols_x2 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "RANK",
    "CHARGES_DRAWN"
  )

  cols_x3 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "RANK",
    "DEFLECTIONS"
  )

  cols_x4 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "RANK",
    "LOOSE_BALLS_RECOVERED"
  )

  cols_x5 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "RANK",
    "SCREEN_ASSISTS"
  )

  cols_x6 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "RANK",
    "BOX_OUTS"
  )

  cols_x7 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "RANK",
    "BOX_OUTS"
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

  Sys.sleep(3)

})
