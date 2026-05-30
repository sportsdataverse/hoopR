test_that("ESPN - NBA News", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_nba_news(limit = 10)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_news at test time")
  }

  cols <- c(
    "headline",
    "published"
  )

  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
