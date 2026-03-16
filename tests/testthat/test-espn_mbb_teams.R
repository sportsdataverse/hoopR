test_that("ESPN - Get MBB teams", {
  skip_on_cran()
  skip_espn_test()

  x <- espn_mbb_teams()

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
    "logo_dark",
    "href",
    "conference_url",
    "group_id",
    "conference_short_name",
    "conference_uid",
    "conference_name",
    "conference_logo",
    "parent_group_id",
    "conference_id")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

})
