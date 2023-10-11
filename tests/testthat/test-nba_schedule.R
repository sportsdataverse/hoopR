test_that("NBA Schedule", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_schedule(league_id = "00", season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "game_date",
    "game_id",
    "game_code",
    "game_status",
    "game_status_text",
    "game_sequence",
    "game_date_est",
    "game_time_est",
    "game_date_time_est",
    "game_date_utc",
    "game_time_utc",
    "game_date_time_utc",
    "away_team_time",
    "home_team_time",
    "day",
    "month_num",
    "week_number",
    "week_name",
    "if_necessary",
    "series_game_number",
    "series_text",
    "arena_name",
    "arena_state",
    "arena_city",
    "postponed_status",
    "branch_link",
    "game_subtype",
    "home_team_id",
    "home_team_name",
    "home_team_city",
    "home_team_tricode",
    "home_team_slug",
    "home_team_wins",
    "home_team_losses",
    "home_team_score",
    "home_team_seed",
    "away_team_id",
    "away_team_name",
    "away_team_city",
    "away_team_tricode",
    "away_team_slug",
    "away_team_wins",
    "away_team_losses",
    "away_team_score",
    "away_team_seed",
    "season",
    "league_id",
    "season_type_id",
    "season_type_description"
  )

  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
