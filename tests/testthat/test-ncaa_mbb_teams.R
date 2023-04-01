test_that("NCAA - Get MBB Teams", {
  skip_on_cran()
  skip_on_ci()
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
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
