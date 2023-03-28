test_that("NBA Cume Stats Player Games", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_cumestatsplayergames(player_id = '2544')

  cols_x1 <- c(
    "MATCHUP",
    "GAME_ID"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
