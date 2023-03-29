test_that("NBA Cume Stats Team Games", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_cumestatsteamgames(
    team_id = 1610612739,
    season = year_to_season(most_recent_nba_season() - 1)
  )

  cols_x1 <- c(
    "MATCHUP",
    "GAME_ID"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
