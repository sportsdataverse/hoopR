test_that("ESPN - MBB Tournament Season Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_tournament_season(tournament_id = 3, season = 2024)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_tournament_season at test time")
  }

  required_cols <- c(
    "league",
    "tournament_id",
    "season",
    "display_name"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

