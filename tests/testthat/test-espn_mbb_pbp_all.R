context("ESPN - Get MBB play by play all")



test_that("ESPN - Get MBB play by play all", {
  skip_on_cran()
  x <- espn_mbb_game_all(game_id = 401256760)
  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]

  cols_x1 <- c(
    'shooting_play', 'sequence_number',
    'home_score', 'scoring_play', 'away_score',
    'id', 'text', 'score_value',
    'period_display_value', 'period_number',
    'clock_display_value', 'team_id',
    'type_id', 'type_text', 'play_id',
    'athlete1_id', 'athlete2_id'
  )
  cols_x2 <- c(
    "game_id", "season", "season_type", "game_date",
    "team_short_display_name", "team_uid", "team_alternate_color",
    "team_color", "team_display_name", "team_name", "team_logo",
    "team_location", "team_id", "team_abbreviation", "team_slug",
    "field_goals_made_field_goals_attempted", "field_goal_pct",
    "three_point_field_goals_made_three_point_field_goals_attempted",
    "three_point_field_goal_pct", "free_throws_made_free_throws_attempted",
    "free_throw_pct", "total_rebounds", "offensive_rebounds",
    "defensive_rebounds", "team_rebounds", "assists",
    "steals", "blocks", "turnovers", "team_turnovers",
    "total_turnovers", "technical_fouls", "total_technical_fouls",
    "flagrant_fouls", "fouls", "largest_lead", "team", "opponent_id",
    "opponent_name", "opponent_mascot", "opponent_abbrev"
  )
  cols_x3 <- c(
    "athlete_display_name", "team_short_display_name",
    "min", "fg", "fg3", "ft", "oreb", "dreb", "reb",
    "ast", "stl", "blk", "to", "pf", "pts",
    "starter", "ejected", "did_not_play", "active",
    "athlete_jersey", "athlete_id", "athlete_short_name",
    "athlete_headshot_href", "athlete_position_name",
    "athlete_position_abbreviation", "team_name", "team_logo",
    "team_id", "team_abbreviation", "team_color", "team_alternate_color"
  )
  expect_equal(colnames(x1), cols_x1)
  expect_s3_class(x1, 'data.frame')

  expect_equal(colnames(x2), cols_x2)
  expect_s3_class(x2, 'data.frame')

  expect_equal(colnames(x3), cols_x3)
  expect_s3_class(x3, 'data.frame')

})
