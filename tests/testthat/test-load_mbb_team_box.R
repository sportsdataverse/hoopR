test_that("hoopR Loader MBB Team Box", {
  skip_on_cran()
  x <- load_mbb_team_box(seasons = most_recent_mbb_season())


  cols <- c(
    "team_id",
    "team_uid",
    "team_slug",
    "team_location",
    "team_name",
    "team_abbreviation",
    "team_display_name",
    "team_short_display_name",
    "team_color",
    "team_alternate_color",
    "team_logo",
    "field_goals_made_field_goals_attempted",
    "field_goal_pct",
    "three_point_field_goals_made_three_point_field_goals_attempted",
    "three_point_field_goal_pct",
    "free_throws_made_free_throws_attempted",
    "free_throw_pct",
    "total_rebounds",
    "offensive_rebounds",
    "defensive_rebounds",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "team_turnovers",
    "total_turnovers",
    "technical_fouls",
    "total_technical_fouls",
    "flagrant_fouls",
    "fouls",
    "largest_lead",
    "home_away",
    "opponent_id",
    "opponent_name",
    "opponent_mascot",
    "opponent_abbrev",
    "game_id",
    "season",
    "season_type",
    "game_date"
  )

  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, 'data.frame')

})
