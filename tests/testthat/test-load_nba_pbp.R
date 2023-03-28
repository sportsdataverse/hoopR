test_that("hoopR Loader NBA Play-by-Play", {
  skip_on_cran()
  x <- load_nba_pbp(seasons = most_recent_nba_season())


  cols <- c(
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
    "participants_0_athlete_id",
    "participants_1_athlete_id",
    "participants_2_athlete_id",
    "wallclock",
    "shooting_play",
    "coordinate_x",
    "coordinate_y",
    "season",
    "season_type",
    "away_team_id",
    "away_team_name",
    "away_team_mascot",
    "away_team_abbrev",
    "away_team_name_alt",
    "home_team_id",
    "home_team_name",
    "home_team_mascot",
    "home_team_abbrev",
    "home_team_name_alt",
    "home_team_spread",
    "game_spread",
    "home_favorite",
    "game_spread_available",
    "game_id",
    "qtr",
    "time",
    "clock_minutes",
    "clock_seconds",
    "half",
    "game_half",
    "lag_qtr",
    "lead_qtr",
    "lag_game_half",
    "lead_game_half",
    "start_quarter_seconds_remaining",
    "start_half_seconds_remaining",
    "start_game_seconds_remaining",
    "game_play_number",
    "end_quarter_seconds_remaining",
    "end_half_seconds_remaining",
    "end_game_seconds_remaining",
    "period",
    "type_abbreviation"
  )

  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, 'data.frame')

})
