test_that("KP - Get referee game log", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_referee(referee = 714363, year = 2020)

  cols <- c(
    'game_number',
    'date',
    'time_et',
    'game',
    'location',
    'venue',
    'conference',
    'thrill_score',
    'referee_name',
    'ref_rank',
    'year'
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
