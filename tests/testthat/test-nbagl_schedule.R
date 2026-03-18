test_that("NBA G-League Schedule", {
  skip_on_cran()
  skip_on_ci()
  skip_nbagl_stats_test()

  x <- nbagl_schedule(season = most_recent_nba_season() - 1)

  cols_x1 <- c(
    "game_date",
    "game_id",
    "game_code",
    "game_status",
    "game_status_text",
    "game_time_est",
    "game_date_utc",
    "game_time_utc",
    "arena_name",
    "arena_city",
    "arena_state",
    "home_team_id",
    "home_team_name",
    "home_team_tricode",
    "home_team_score",
    "away_team_id",
    "away_team_name",
    "away_team_tricode",
    "away_team_score",
    "season",
    "league_id",
    "season_type_id",
    "season_type_description"
  )


  expect_in(sort(cols_x1), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)
})
