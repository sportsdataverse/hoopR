test_that("NBA Home Page Leaders", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()
  skip("Deprecated: nba_homepageleaders() now errors by design; use nba_leagueleaders().")



  x <- nba_homepageleaders(league_id = "00")

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

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(cols_x2), sort(colnames(x[[2]])))
  expect_s3_class(x[[2]], "data.frame")
  expect_in(sort(cols_x3), sort(colnames(x[[3]])))
  expect_s3_class(x[[3]], "data.frame")

  Sys.sleep(3)

})
