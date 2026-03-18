test_that("NBA Leaders Tiles", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()
  skip("Deprecated: nba_leaderstiles() now errors by design; use nba_leagueleaders().")



  x <- nba_leaderstiles(league_id = "00")

  cols_x1 <- c(
    "RANK",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "PTS"
  )

  cols_x2 <- c(
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "SEASON_YEAR",
    "PTS"
  )

  cols_x3 <- c(
    "RANK",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "PTS"
  )

  cols_x4 <- c(
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "SEASON_YEAR",
    "PTS"
  )

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(cols_x2), sort(colnames(x[[2]])))
  expect_s3_class(x[[2]], "data.frame")
  expect_in(sort(cols_x3), sort(colnames(x[[3]])))
  expect_s3_class(x[[3]], "data.frame")
  expect_in(sort(cols_x4), sort(colnames(x[[4]])))
  expect_s3_class(x[[4]], "data.frame")

  Sys.sleep(3)

})
