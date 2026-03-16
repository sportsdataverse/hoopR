test_that("NBA Common Team Years", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_commonteamyears(league_id = "00")

  cols_team_years <- c(
    "LEAGUE_ID",
    "TEAM_ID",
    "MIN_YEAR",
    "MAX_YEAR",
    "ABBREVIATION"
  )
  expect_in(sort(cols_team_years), sort(colnames(x$TeamYears)))
  expect_s3_class(x$TeamYears, "data.frame")
  expect_gt(nrow(x$TeamYears), 0)

  Sys.sleep(3)
})
