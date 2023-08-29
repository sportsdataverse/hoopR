test_that("NBA PBPs", {
  skip_on_cran()
  skip_on_ci()
  y <- c("0022201086", "0022200021")
  x1 <- nba_pbps(game_ids = y)

  cols_x1 <- c(
    "game_id",
    "event_num",
    "event_type",
    "event_action_type",
    "period",
    "minute_game",
    "time_remaining",
    "wc_time_string",
    "time_quarter",
    "minute_remaining_quarter",
    "seconds_remaining_quarter",
    "home_description",
    "neutral_description",
    "visitor_description",
    "score",
    "away_score",
    "home_score",
    "score_margin",
    "person1type",
    "player1_id",
    "player1_name",
    "player1_team_id",
    "player1_team_city",
    "player1_team_nickname",
    "player1_team_abbreviation",
    "person2type",
    "player2_id",
    "player2_name",
    "player2_team_id",
    "player2_team_city",
    "player2_team_nickname",
    "player2_team_abbreviation",
    "person3type",
    "player3_id",
    "player3_name",
    "player3_team_id",
    "player3_team_city",
    "player3_team_nickname",
    "player3_team_abbreviation",
    "video_available_flag",
    "team_leading"
  )


  expect_equal(sort(colnames(x1)), sort(cols_x1))
  expect_s3_class(x1, "data.frame")

  Sys.sleep(3)

  x2 <- nba_pbps(game_ids = y, on_court = TRUE)

  cols_x2 <- c(
    "game_id",
    "event_num",
    "event_type",
    "event_action_type",
    "period",
    "minute_game",
    "time_remaining",
    "wc_time_string",
    "time_quarter",
    "minute_remaining_quarter",
    "seconds_remaining_quarter",
    "home_description",
    "neutral_description",
    "visitor_description",
    "score",
    "away_score",
    "home_score",
    "score_margin",
    "person1type",
    "player1_id",
    "player1_name",
    "player1_team_id",
    "player1_team_city",
    "player1_team_nickname",
    "player1_team_abbreviation",
    "person2type",
    "player2_id",
    "player2_name",
    "player2_team_id",
    "player2_team_city",
    "player2_team_nickname",
    "player2_team_abbreviation",
    "person3type",
    "player3_id",
    "player3_name",
    "player3_team_id",
    "player3_team_city",
    "player3_team_nickname",
    "player3_team_abbreviation",
    "video_available_flag",
    "team_leading",
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


  expect_equal(sort(colnames(x2)), sort(cols_x2))
  expect_s3_class(x2, "data.frame")

  Sys.sleep(3)

})
