test_that("ESPN - Get MBB rankings", {
  skip_on_cran()
  x <- espn_mbb_rankings()

  cols <- c(
    "id",
    "name",
    "short_name",
    "type",
    "headline",
    "short_headline",
    "current",
    "previous",
    "points",
    "first_place_votes",
    "trend",
    "date",
    "last_updated",
    "record_summary",
    "team_id",
    "team_uid",
    "team_location",
    "team_name",
    "team_nickname",
    "team_abbreviation",
    "team_color",
    "team_logos",
    "team_logo",
    "occurrence_number",
    "occurrence_type",
    "occurrence_last",
    "occurrence_value",
    "occurrence_display_value",
    "season_year",
    "season_start_date",
    "season_end_date",
    "season_display_name",
    "season_type_type",
    "season_type_name",
    "season_type_abbreviation",
    "season_futures_ref",
    "first_occurrence_type",
    "first_occurrence_value"
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

})
