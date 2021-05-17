context("KP - Get kpoy")



test_that("KP - Get kpoy", {
  skip_on_cran()
  x <- kp_kpoy(year=2020)
  x1 <- x[[1]]
  x2 <- x[[2]]

  cols_x1 <- c(
    "rk", "player", "kpoy_rating", "team",
    "hgt", "wgt", "exp", "home_town", "year", "group"
  )

  cols_x2 <- c(
    "rk", "player", "game_mv_ps", "team",
    "hgt", "wgt", "exp", "home_town", "year", "group"
  )
  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)
})
