test_that("ESPN - NBA Draft Rounds", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_draft_rounds(season = 2024)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_draft_rounds at test time")
  }

  required_cols <- c(
    "league",
    "season",
    "round"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

