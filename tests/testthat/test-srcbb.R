test_that("Sports-Reference - School Stats", {
  skip_on_cran()
  skip_on_ci()

  x <- srcbb_school_stats(season = 2024, table = "basic")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No school stats returned at test time")

  cols <- c("school", "g", "wins", "losses", "srs", "season", "table")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")
  expect_equal(unique(x$season), 2024L)
  expect_gt(nrow(x), 100)  # all Division-I schools

  Sys.sleep(4)
})

test_that("Sports-Reference - AP Rankings", {
  skip_on_cran()
  skip_on_ci()

  x <- srcbb_rankings(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No AP poll returned at test time")

  cols <- c("school", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(4)
})
