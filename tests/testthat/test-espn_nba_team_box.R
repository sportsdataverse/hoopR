
test_that("ESPN - Get NBA team box score only", {
  skip_on_cran()
  x <- espn_nba_team_box(game_id = 401283399)

  cols <- c(
    "game_id",
    "season",
    "season_type",
    "game_date",
    "team_short_display_name",
    "team_uid",
    "team_alternate_color",
    "team_color",
    "team_display_name",
    "team_name",
    "team_logo",
    "team_location",
    "team_id",
    "team_abbreviation",
    "team_slug",
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
    "turnover_points",
    "fast_break_points",
    "points_in_paint",
    "fouls",
    "largest_lead",
    "home_away",
    "opponent_id",
    "opponent_name",
    "opponent_mascot",
    "opponent_abbrev"
  )
  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, 'data.frame')

})
