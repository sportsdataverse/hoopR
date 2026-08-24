test_that("load_nba_player_impact returns a hoopR_data tibble for the most recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_nba_player_impact(seasons = most_recent_nba_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("player_id", "player_name", "season", "rapm", "bpm", "war")), sort(colnames(df)))
})

test_that("load_mbb_player_value returns a hoopR_data tibble for the most recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_mbb_player_value(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("player_id", "player", "season", "team_id", "box_bpm")), sort(colnames(df)))
})

test_that("load_mbb_ratings returns a hoopR_data tibble for the most recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_mbb_ratings(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("team_id", "season", "adj_o", "adj_d", "adj_em", "rank")), sort(colnames(df)))
})

test_that("load_nba_player_impact accepts a multi-season vector", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  season <- most_recent_nba_season()
  df <- load_nba_player_impact(seasons = c(season - 1, season))

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_gte(length(unique(df$season)), 2)
})

test_that("load_mbb_ratings accepts a multi-season vector", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  season <- most_recent_mbb_season()
  df <- load_mbb_ratings(seasons = c(season - 1, season))

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_gte(length(unique(df$season)), 2)
})
