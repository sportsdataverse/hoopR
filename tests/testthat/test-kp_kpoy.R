context("KP - Get kpoy")



test_that("KP - Get kpoy", {
  skip_on_cran()
  x <- kp_kpoy(year=2020)
  x1 <- x[[1]]
  x2 <- x[[2]]

  cols_x1 <- c(
    'Rk', 'Player', 'kpoyRating', 'Team', 'Hgt',
    'Wgt', 'Exp', 'HomeTown', 'Year', 'Group'
  )

  cols_x2 <- c(
    'Rk', 'Player', 'GameMVPs', 'Team', 'Hgt', 'Wgt',
    'Exp', 'HomeTown', 'Year', 'Group'
  )
  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)
})
