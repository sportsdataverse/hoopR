context("ESPN - Get MBB teams")



test_that("ESPN - Get MBB teams", {
  skip_on_cran()
  x <- espn_mbb_teams()

  cols <- c(
    "team_id", "team", "mascot", "nickname", "abbreviation",
    "display_name", "short_name",
    "color", "alternate_color", "logo", "logo_dark")
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
