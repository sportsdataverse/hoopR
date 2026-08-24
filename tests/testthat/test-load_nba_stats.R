test_that("most_recent_nba_stats_season is one less than most_recent_nba_season", {
  expect_equal(most_recent_nba_stats_season(), most_recent_nba_season() - 1)
})

test_that("load_nba_stats_schedule returns a hoopR_data tibble for the most recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_load_test()

  df <- load_nba_stats_schedule(seasons = most_recent_nba_stats_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_s3_class(df, "data.frame")

  core_cols <- c("game_id", "season", "home_team_id", "away_team_id", "home_pts", "away_pts")
  expect_in(sort(core_cols), sort(colnames(df)))
})

test_that("load_nba_stats_rosters accepts a multi-season vector", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_load_test()

  season <- most_recent_nba_stats_season()
  df <- load_nba_stats_rosters(seasons = c(season - 1, season))

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_gte(length(unique(df$season)), 2)
})

test_that("load_nba_stats_possessions returns a hoopR_data tibble with the expected core columns", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_load_test()

  df <- load_nba_stats_possessions(seasons = most_recent_nba_stats_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  core_cols <- c("game_id", "season", "possession_number", "offense_team_id", "defense_team_id")
  expect_in(sort(core_cols), sort(colnames(df)))
})

test_that("load_nba_stats_leaguedash rejects an invalid table", {
  expect_error(load_nba_stats_leaguedash(seasons = most_recent_nba_stats_season(), table = "not_a_table"))
})

test_that("load_nba_stats_leaguedash returns a hoopR_data tibble for a valid table", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_load_test()

  df <- load_nba_stats_leaguedash(seasons = most_recent_nba_stats_season(), table = "player_bio")

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
})

test_that("update_nba_stats_db validates its datasets argument", {
  expect_error(update_nba_stats_db(datasets = NULL))
  expect_error(update_nba_stats_db(datasets = "not_a_dataset"))
})
