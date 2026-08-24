test_that("load_ncaa_mbb_pbp returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_ncaa_mbb_pbp(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_s3_class(df, "data.frame")
  expect_in(sort(c("contest_id", "season", "event_type", "poss_num")), sort(colnames(df)))
})

test_that("load_ncaa_mbb_shots returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_ncaa_mbb_shots(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("contest_id", "season", "shot_x", "shot_y", "made")), sort(colnames(df)))
})

test_that("load_ncaa_mbb_lineups returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_ncaa_mbb_lineups(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("lineup_key", "season", "team", "poss", "plus_minus")), sort(colnames(df)))
})

test_that("load_ncaa_mbb_rapm returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_ncaa_mbb_rapm(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("player_id", "person_id", "season", "rapm_net")), sort(colnames(df)))
})

test_that("load_ncaa_mbb_rapm accepts a multi-season vector", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  season <- most_recent_mbb_season()
  df <- load_ncaa_mbb_rapm(seasons = c(season - 1, season))

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_gte(length(unique(df$season)), 2)
})

test_that("load_ncaa_mbb_player_box returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_ncaa_mbb_player_box(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("contest_id", "season", "player_id", "pts")), sort(colnames(df)))
})

test_that("load_ncaa_mbb_team_ids returns a hoopR_data tibble for a recent season", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  df <- load_ncaa_mbb_team_ids(seasons = most_recent_mbb_season())

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_in(sort(c("team", "conference", "id", "season")), sort(colnames(df)))
})

test_that("load_ncaa_mbb_team_ids accepts a multi-season vector", {
  skip_on_cran()
  skip_on_ci()
  skip_load_test()

  season <- most_recent_mbb_season()
  df <- load_ncaa_mbb_team_ids(seasons = c(season - 1, season))

  if (length(df) == 0 || nrow(df) == 0) {
    skip("No rows returned at test time -- release may not exist yet")
  }

  expect_s3_class(df, "hoopR_data")
  expect_gte(length(unique(df$season)), 2)
})
