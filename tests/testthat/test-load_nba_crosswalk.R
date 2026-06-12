test_that("load_nba_team_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  skip_on_ci()
  if (Sys.getenv("HOOPR_LOAD_TESTS") != "1") skip("load_* crosswalk tests require published release artifacts")

  out <- load_nba_team_crosswalk(seasons = most_recent_nba_season())
  if (is.null(out) || !is.data.frame(out) || nrow(out) == 0) {
    skip("No rows returned from published release artifact")
  }
  expect_s3_class(out, "hoopR_data")
  expect_in(sort(c("season", "espn_team_id", "nba_team_id")), sort(names(out)))
})

test_that("load_nba_schedule_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  skip_on_ci()
  if (Sys.getenv("HOOPR_LOAD_TESTS") != "1") skip("load_* crosswalk tests require published release artifacts")

  out <- load_nba_schedule_crosswalk(seasons = most_recent_nba_season())
  if (is.null(out) || !is.data.frame(out) || nrow(out) == 0) {
    skip("No rows returned from published release artifact")
  }
  expect_s3_class(out, "hoopR_data")
  expect_in("season", names(out))
})

test_that("load_nba_player_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  skip_on_ci()
  if (Sys.getenv("HOOPR_LOAD_TESTS") != "1") skip("load_* crosswalk tests require published release artifacts")

  out <- load_nba_player_crosswalk(seasons = most_recent_nba_season())
  if (is.null(out) || !is.data.frame(out) || nrow(out) == 0) {
    skip("No rows returned from published release artifact")
  }
  expect_s3_class(out, "hoopR_data")
  expect_in("season", names(out))
})
