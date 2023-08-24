test_that("KP - Get officials", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_officials(year = 2020)

  cols <- c(
    "rk",
    "official_name",
    "ref_rating",
    "gms",
    "last_game",
    "last_game_1",
    "year"
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
