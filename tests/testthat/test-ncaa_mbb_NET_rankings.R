context("NCAA - Get NET rankings")



test_that("NCAA - Get NET rankings", {
  skip_on_cran()
  x <- ncaa_mbb_NET_rankings()

  cols <- c(
    'Rank', 'Previous', 'School', 'Conference',
    'Record', 'Road', 'Neutral', 'Home',
    'Quad_1', 'Quad_2', 'Quad_3', 'Quad_4'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
