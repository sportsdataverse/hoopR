test_that("NBA Today's Scoreboard", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_todays_scoreboard()


  cols_x1 <- c(
    "game_id",
    "game_code",
    "game_status",
    "game_status_text",
    "period",
    "game_clock",
    "game_time_utc",
    "game_et",
    "regulation_periods",
    "if_necessary",
    "series_game_number",
    "series_text",
    "series_conference",
    "po_round_desc",
    "game_subtype",
    "home_team_id",
    "home_team_name",
    "home_team_city",
    "home_team_tricode",
    "home_wins",
    "home_losses",
    "home_score",
    "home_seed",
    "home_in_bonus",
    "home_timeouts_remaining",
    "home_periods",
    "away_team_id",
    "away_team_name",
    "away_team_city",
    "away_team_tricode",
    "away_wins",
    "away_losses",
    "away_score",
    "away_seed",
    "away_in_bonus",
    "away_timeouts_remaining",
    "away_periods",
    "home_leaders_person_id",
    "home_leaders_name",
    "home_leaders_jersey_num",
    "home_leaders_position",
    "home_leaders_team_tricode",
    "home_leaders_player_slug",
    "home_leaders_points",
    "home_leaders_rebounds",
    "home_leaders_assists",
    "away_leaders_person_id",
    "away_leaders_name",
    "away_leaders_jersey_num",
    "away_leaders_position",
    "away_leaders_team_tricode",
    "away_leaders_player_slug",
    "away_leaders_points",
    "away_leaders_rebounds",
    "away_leaders_assists",
    "pb_odds_team",
    "pb_odds_odds",
    "pb_odds_suspended"
  )

  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, 'data.frame')

  Sys.sleep(3)

})
