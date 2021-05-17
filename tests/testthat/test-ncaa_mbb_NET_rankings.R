context("NCAA - Get MBB NET rankings")



test_that("NCAA - Get MBB NET rankings", {
  skip_on_cran()
  x <- ncaa_mbb_NET_rankings()

  cols <- c(
    'rank', 'previous', 'school', 'conference',
    'record', 'road', 'neutral', 'home',
    'quad_1', 'quad_2', 'quad_3', 'quad_4'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
