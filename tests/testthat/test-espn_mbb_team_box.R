context("ESPN - Get MBB team box score only")



test_that("ESPN - Get MBB team box score only", {
  skip_on_cran()
  x <- espn_mbb_team_box(game_id = 401256760)

  cols <- c(
    'Home', 'label', 'Away'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
