test_that("ESPN - Get NBA play by play only", {
  skip_on_cran()
  x <- espn_nba_pbp(game_id = 401283399)


  cols <- c(
    "shooting_play",
    "sequence_number",
    "home_score",
    "scoring_play",
    "away_score",
    "id",
    "text",
    "score_value",
    "period_display_value",
    "period_number",
    "coordinate_x",
    "coordinate_x_raw",
    "coordinate_y",
    "coordinate_y_raw",
    "clock_display_value",
    "team_id",
    "type_id",
    "type_text",
    "wallclock",
    "play_id",
    "athlete_id_1",
    "athlete_id_2",
    "athlete_id_3",
    "home_team_id",
    "home_team_mascot",
    "home_team_name",
    "home_team_abbrev",
    "home_team_logo",
    "home_team_logo_dark",
    "home_team_full_name",
    "home_team_color",
    "home_team_alternate_color",
    "home_team_score",
    "home_team_winner",
    "home_team_record",
    "away_team_id",
    "away_team_mascot",
    "away_team_name",
    "away_team_abbrev",
    "away_team_logo",
    "away_team_logo_dark",
    "away_team_full_name",
    "away_team_color",
    "away_team_alternate_color",
    "away_team_score",
    "away_team_winner",
    "away_team_record",
    "game_id",
    "season",
    "season_type",
    "game_date"
  )
  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, 'data.frame')

})
