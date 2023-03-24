test_that("ESPN - Get MBB play by play only (no coordinate data)", {
  skip_on_cran()
  x <- espn_mbb_pbp(game_id = 401256760)


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
    "clock_display_value",
    "team_id",
    "type_id",
    "type_text",
    "play_id",
    "athlete_id_1",
    "athlete_id_2",
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

test_that("ESPN - Get MBB play by play only (with coordinate data)", {
  skip_on_cran()
  x <- espn_mbb_pbp(game_id = 401479672)


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
    "clock_display_value",
    "team_id",
    "type_id",
    "type_text",
    "play_id",
    "athlete_id_1",
    "athlete_id_2",
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
    "game_date",
    "coordinate_x",
    "coordinate_y",
    "coordinate_x_raw",
    "coordinate_y_raw",
    "wallclock"
  )

  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, 'data.frame')

})
