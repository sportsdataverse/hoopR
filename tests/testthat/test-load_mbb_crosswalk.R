test_that("load_mbb_team_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  skip_espn_test()

  out <- load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
  expect_s3_class(out, "hoopR_data")
  expect_true(all(c("season", "espn_team_id") %in% names(out)))
})

test_that("load_mbb_schedule_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  skip_espn_test()

  out <- load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
  expect_s3_class(out, "hoopR_data")
  expect_true("season" %in% names(out))
})

test_that("load_mbb_player_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  skip_espn_test()

  out <- load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
  expect_s3_class(out, "hoopR_data")
  expect_true("season" %in% names(out))
})
