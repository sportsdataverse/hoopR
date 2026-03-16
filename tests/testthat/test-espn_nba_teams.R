test_that("ESPN - Get NBA teams", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_nba_teams()

  cols <- c(
    "team_id",
    "abbreviation",
    "display_name",
    "short_name",
    "mascot",
    "nickname",
    "team",
    "color",
    "alternate_color",
    "logo",
    "logo_dark"
  )
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

})
