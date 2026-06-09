test_that("CBD - Conferences", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_conferences()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No conferences returned at test time")

  cols <- c("id", "name", "abbreviation", "short_name")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Conference History", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_conferences_history(conference = "ACC")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No conference history returned at test time")

  cols <- c("id", "name", "abbreviation", "teams")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
