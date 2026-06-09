test_that("Torvik - T-Rank Ratings", {
  skip_on_cran()
  skip_on_ci()

  x <- torvik_ratings(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No T-Rank ratings returned at test time")

  cols <- c("rank", "team", "conf", "record", "adjoe", "adjde", "barthag", "wab", "adjt", "year")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("Torvik - Team Four Factors", {
  skip_on_cran()
  skip_on_ci()

  x <- torvik_team_factors(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team four factors returned at test time")

  cols <- c("team_name", "e_fg_percent", "ftr", "or_percent", "to_percent", "x3p_percent", "year")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
