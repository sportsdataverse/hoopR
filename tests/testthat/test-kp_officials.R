context("KP - Get officials")



test_that("KP - Get officials", {
  skip_on_cran()
  x <- kp_officials(year= 2020)

  cols <- c(
    'Rk', 'OfficialName', 'RefRating', 'Gms',
    'Last.Game', 'Last.Game.1', 'Year'
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
