test_that("NBA Schedule League V2 Int", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_scheduleleaguev2int(league_id = "00", season = "2025-26")

  # SeasonGames - validate core columns
  expect_s3_class(x$SeasonGames, "data.frame")
  core_game_cols <- c(
    "game_date",
    "game_id",
    "game_status",
    "game_status_text",
    "home_team_id",
    "home_team_name",
    "away_team_id",
    "away_team_name",
    "season",
    "league_id"
  )
  expect_true(all(core_game_cols %in% colnames(x$SeasonGames)))

  # SeasonWeeks
  cols_weeks <- c(
    "league_id",
    "season_year",
    "week_number",
    "week_name",
    "start_date",
    "end_date"
  )
  expect_s3_class(x$SeasonWeeks, "data.frame")

  # BroadcasterList
  cols_broadcasters <- c(
    "league_id",
    "season_year",
    "broadcaster_abbreviation",
    "broadcaster_display",
    "broadcaster_id",
    "region_id"
  )
  expect_s3_class(x$BroadcasterList, "data.frame")

  Sys.sleep(3)
})
