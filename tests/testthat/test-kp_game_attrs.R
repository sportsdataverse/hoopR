context("KP - Get game attributes")



test_that("KP - Get game attributes", {
  skip_on_cran()
  x <- kp_game_attrs(year=2020, attr = "Excitement")

  cols <- c(
    'Rk', 'Data', 'Game', 'Location', 'Conf',
    'Excitement', 'Year'
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
