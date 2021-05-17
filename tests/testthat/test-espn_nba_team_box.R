context("ESPN - Get NBA team box score only")



test_that("ESPN - Get NBA team box score only", {
  skip_on_cran()
  x <- espn_nba_team_box(game_id = 401283399)

  cols <- c(
    'home', 'label', 'away'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
