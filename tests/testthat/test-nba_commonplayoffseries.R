test_that("NBA Common Playoff Series", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_commonplayoffseries(league_id = "00", season = year_to_season(most_recent_nba_season() - 2))

  cols_x1 <- c(
    "GAME_ID",
    "HOME_TEAM_ID",
    "VISITOR_TEAM_ID",
    "SERIES_ID",
    "GAME_NUM"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
