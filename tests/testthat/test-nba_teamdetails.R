test_that("NBA Team Details", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_teamdetails(team_id = '1610612749')


  cols_x1 <- c(
    "TEAM_ID",
    "ABBREVIATION",
    "NICKNAME",
    "YEARFOUNDED",
    "CITY",
    "ARENA",
    "ARENACAPACITY",
    "OWNER",
    "GENERALMANAGER",
    "HEADCOACH",
    "DLEAGUEAFFILIATION"
  )

  cols_x2 <- c(
    "TEAM_ID",
    "CITY",
    "NICKNAME",
    "YEARFOUNDED",
    "YEARACTIVETILL"
  )

  cols_x3 <- c(
    "ACCOUNTTYPE",
    "WEBSITE_LINK"
  )

  cols_x4 <- c(
    "YEARAWARDED",
    "OPPOSITETEAM"
  )

  cols_x5 <- c(
    "YEARAWARDED",
    "OPPOSITETEAM"
  )

  cols_x6 <- c(
    "YEARAWARDED",
    "OPPOSITETEAM"
  )

  cols_x7 <- c(
    "PLAYERID",
    "PLAYER",
    "POSITION",
    "JERSEY",
    "SEASONSWITHTEAM",
    "YEAR"
  )

  cols_x8 <- c(
    "PLAYERID",
    "PLAYER",
    "POSITION",
    "JERSEY",
    "SEASONSWITHTEAM",
    "YEAR"
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

})
