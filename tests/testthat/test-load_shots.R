test_that("load_nba_shots returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_nba_shots(seasons = most_recent_nba_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("game_id", "season", "coordinate_x", "coordinate_y", "athlete_id_1")), sort(colnames(df)))
})

test_that("load_nba_shots accepts a multi-season vector", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  season <- most_recent_nba_season()
  df <- load_nba_shots(seasons = c(season - 1, season))

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_gte(length(unique(df$season)), 2)
})

test_that("load_mbb_shots returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_mbb_shots(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("game_id", "season", "coordinate_x", "coordinate_y", "athlete_id_1")), sort(colnames(df)))
})

test_that("load_mbb_shots rejects the documented 2004/2005 gap seasons", {
  expect_error(load_mbb_shots(seasons = 2004))
  expect_error(load_mbb_shots(seasons = 2005))
})
