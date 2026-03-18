test_that("NCAA - Get MBB Teams", {
  skip_on_cran()
  skip_on_ci()
  skip_ncaa_mbb_test()

  x <- ncaa_mbb_teams(year = most_recent_mbb_season(), division = 1)

  cols <- c(
    "team_id",
    "team_name",
    "team_url",
    "conference_id",
    "conference",
    "division",
    "year",
    "season_id"
  )

  if (nrow(x) == 0) {
    skip("No NCAA MBB teams returned for current query.")
  }

  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, 'data.frame')

})
