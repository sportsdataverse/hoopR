test_that("ESPN - NBA Draft Pick", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_draft_pick(season = 2024, round = 1, pick = 1)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_draft_pick at test time")
  }

  required_cols <- c(
    "season",
    "round",
    "pick",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

