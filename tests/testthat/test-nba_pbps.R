test_that("NBA PBPs", {
  skip_on_cran()
  skip_on_ci()
  y <- c("0022201086", "0022200021")
  x <- nba_pbps(game_ids = y)

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


  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
