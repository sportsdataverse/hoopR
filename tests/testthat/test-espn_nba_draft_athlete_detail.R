test_that("ESPN - NBA Draft Athlete Detail", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_draft_athlete_detail(season = 2024, athlete_id = "108206")

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_draft_athlete_detail at test time")
  }

  required_cols <- c(
    "league",
    "season",
    "full_name",
    "pick_overall"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

