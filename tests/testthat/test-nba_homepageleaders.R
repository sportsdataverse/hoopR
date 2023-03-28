test_that("NBA Home Page Leaders", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_homepageleaders(league_id = '00')

  cols_x1 <- c(
    "RANK",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "PTS",
    "FG_PCT",
    "FG3_PCT",
    "FT_PCT",
    "EFG_PCT",
    "TS_PCT",
    "PTS_PER48"
  )

  cols_x2 <- c(
    "PTS",
    "FG_PCT",
    "FG3_PCT",
    "FT_PCT",
    "EFG_PCT",
    "TS_PCT",
    "PTS_PER48"
  )
  cols_x3 <- c(
    "PTS",
    "FG_PCT",
    "FG3_PCT",
    "FT_PCT",
    "EFG_PCT",
    "TS_PCT",
    "PTS_PER48"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')

  Sys.sleep(3)

})
