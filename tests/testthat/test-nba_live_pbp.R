test_that("NBA Live PBP", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_live_pbp(game_id = '0022201086')

  cols_x1 <- c(
    "action_number",
    "clock",
    "time_actual",
    "period",
    "period_type",
    "action_type",
    "sub_type",
    "qualifiers",
    "person_id",
    "x",
    "y",
    "possession",
    "score_home",
    "score_away",
    "edited",
    "order_number",
    "is_target_score_last_period",
    "x_legacy",
    "y_legacy",
    "is_field_goal",
    "side",
    "description",
    "person_ids_filter",
    "team_id",
    "team_tricode",
    "descriptor",
    "jump_ball_recovered_name",
    "jump_ball_recoverd_person_id",
    "player_name",
    "player_name_i",
    "jump_ball_won_player_name",
    "jump_ball_won_person_id",
    "jump_ball_lost_player_name",
    "jump_ball_lost_person_id",
    "area",
    "area_detail",
    "shot_distance",
    "shot_result",
    "points_total",
    "assist_player_name_initial",
    "assist_person_id",
    "assist_total",
    "shot_action_number",
    "rebound_total",
    "rebound_defensive_total",
    "rebound_offensive_total",
    "official_id",
    "foul_personal_total",
    "foul_technical_total",
    "foul_drawn_player_name",
    "foul_drawn_person_id",
    "block_player_name",
    "block_person_id",
    "turnover_total",
    "steal_player_name",
    "steal_person_id"
  )


  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, 'data.frame')

})
