test_that("NBA Player Tracking Dashboard - Defense", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_playerdashptshotdefend(player_id = "2544", season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "MATCHUPID",
    "GP",
    "G",
    "DEFENSE_CATEGORY",
    "FREQ",
    "D_FGM",
    "D_FGA",
    "D_FG_PCT",
    "NORMAL_FG_PCT",
    "PCT_PLUSMINUS"
  )

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
