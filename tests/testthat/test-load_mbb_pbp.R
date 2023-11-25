test_that("hoopR Loader MBB Play-by-Play", {
  skip_on_cran()
  x <- load_mbb_pbp(seasons = most_recent_mbb_season())


  cols <- c(
    "game_play_number",
    "id",
    "sequence_number",
    "type_id",
    "type_text",
    "text",
    "away_score",
    "home_score",
    "period_number",
    "period_display_value",
    "clock_display_value",
    "scoring_play",
    "score_value",
    "team_id",
    "athlete_id_1",
    "wallclock",
    "shooting_play",
    "game_id",
    "season",
    "season_type",
    "home_team_id",
    "home_team_name",
    "home_team_mascot",
    "home_team_abbrev",
    "home_team_name_alt",
    "away_team_id",
    "away_team_name",
    "away_team_mascot",
    "away_team_abbrev",
    "away_team_name_alt",
    "game_spread",
    "home_favorite",
    "game_spread_available",
    "home_team_spread",
    "half",
    "time",
    "clock_minutes",
    "clock_seconds",
    "home_timeout_called",
    "away_timeout_called",
    "lead_period",
    "lead_half",
    "start_period_seconds_remaining",
    "start_game_seconds_remaining",
    "end_period_seconds_remaining",
    "end_game_seconds_remaining",
    "lag_period",
    "lag_half",
    "athlete_id_2",
    "game_date",
    "game_date_time",
    "media_id",
    "coordinate_x_raw",
    "coordinate_y_raw",
    "coordinate_x",
    "coordinate_y"
  )

  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, "data.frame")

})
