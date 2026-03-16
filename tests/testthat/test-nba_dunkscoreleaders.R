test_that("NBA Dunk Score Leaders", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_dunkscoreleaders(season = "2025-26")

  cols_dunk_score <- c(
    "game_id",
    "game_date",
    "matchup",
    "period",
    "game_clock_time",
    "event_num",
    "player_id",
    "player_name",
    "first_name",
    "last_name",
    "team_id",
    "team_name",
    "team_city",
    "team_abbreviation",
    "dunk_score",
    "jump_subscore",
    "power_subscore",
    "style_subscore",
    "defensive_contest_subscore",
    "max_ball_height",
    "ball_speed_through_rim",
    "player_vertical",
    "hang_time",
    "takeoff_distance",
    "reverse_dunk",
    "dunk360",
    "through_the_legs",
    "alley_oop",
    "tip_in",
    "self_oop",
    "player_rotation",
    "player_lateral_speed",
    "ball_distance_traveled",
    "ball_reach_back",
    "total_ball_acceleration",
    "dunking_hand",
    "jumping_foot",
    "pass_length",
    "catching_hand",
    "catch_distance",
    "lateral_catch_distance",
    "passer_id",
    "passer_name",
    "passer_first_name",
    "passer_last_name",
    "pass_release_point",
    "shooter_id",
    "shooter_name",
    "shooter_first_name",
    "shooter_last_name",
    "shot_release_point",
    "shot_length",
    "defensive_contest_level",
    "possible_attempted_charge",
    "video_available"
  )
  expect_in(sort(cols_dunk_score), sort(colnames(x$DunkScoreLeaders)))
  expect_s3_class(x$DunkScoreLeaders, "data.frame")
  expect_gt(nrow(x$DunkScoreLeaders), 0)

  Sys.sleep(3)
})
