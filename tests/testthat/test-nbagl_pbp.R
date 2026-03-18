test_that("NBA G-League PBP", {
  skip_on_cran()
  skip_on_ci()
  skip_nbagl_stats_test()

  x <- nbagl_pbp(game_id = "2052500034")
  x_no_on_court <- nbagl_pbp(game_id = "2052500034", on_court = FALSE)

  cols_x1 <- c(
    "game_id",
    "action_number",
    "clock",
    "period",
    "team_id",
    "person_id",
    "player_name",
    "x_legacy",
    "y_legacy",
    "shot_distance",
    "shot_result",
    "is_field_goal",
    "score_home",
    "score_away",
    "points_total",
    "location",
    "description",
    "action_type",
    "sub_type",
    "video_available",
    "shot_value",
    "action_id",
    "away_player1",
    "away_player2",
    "away_player3",
    "away_player4",
    "away_player5",
    "home_player1",
    "home_player2",
    "home_player3",
    "home_player4",
    "home_player5"
  )


  expect_in(sort(cols_x1), sort(colnames(x)))
  expect_s3_class(x, "data.frame")
  expect_false(any(c("away_player1", "home_player1") %in% colnames(x_no_on_court)))

  Sys.sleep(3)
})
