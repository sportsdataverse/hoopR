test_that("ESPN - MBB Team Record Detail (Long Format)", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_team_record_detail(team_id = 52, season = 2024, record_id = 0)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_team_record_detail at test time")
  }

  required_cols <- c(
    "league",
    "team_id",
    "record_name",
    "stat_name"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

