test_that("load_mbb_team_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  if (Sys.getenv("HOOPR_LOAD_TESTS") != "1") skip("load_* crosswalk tests require published release artifacts")

  out <- load_mbb_team_crosswalk(seasons = most_recent_mbb_season())
  expect_s3_class(out, "hoopR_data")
  expect_true(all(c("season", "espn_team_id") %in% names(out)))
})

test_that("load_mbb_schedule_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  if (Sys.getenv("HOOPR_LOAD_TESTS") != "1") skip("load_* crosswalk tests require published release artifacts")

  out <- load_mbb_schedule_crosswalk(seasons = most_recent_mbb_season())
  expect_s3_class(out, "hoopR_data")
  expect_true("season" %in% names(out))
})

test_that("load_mbb_player_crosswalk() loads a cached snapshot", {
  skip_on_cran()
  if (Sys.getenv("HOOPR_LOAD_TESTS") != "1") skip("load_* crosswalk tests require published release artifacts")

  out <- load_mbb_player_crosswalk(seasons = most_recent_mbb_season())
  expect_s3_class(out, "hoopR_data")
  expect_true("season" %in% names(out))
})

test_that("the NCAA-ESPN crosswalk loaders read the static mbb_crosswalk files", {
  urls <- character()
  local_mocked_bindings(parquet_from_url = function(url) {
    urls <<- c(urls, url)
    data.table::data.table(ncaa_team_id = 51431L, espn_team_id = "357",
                           espn_conference_id = c("25"))
  })
  out <- load_mbb_ncaa_espn_team_crosswalk()
  load_mbb_ncaa_espn_schools()
  load_mbb_ncaa_espn_school_seasons()
  expect_identical(sub(".*/download/", "", urls), paste0("mbb_crosswalk/", c(
    "ncaa_espn_team_crosswalk", "ncaa_espn_schools", "ncaa_espn_school_seasons"
  ), ".parquet"))
  expect_s3_class(out, "hoopR_data")
  # ESPN ids are published as character; they come back integer like every ESPN id
  expect_identical(out$espn_team_id, 357L)
  expect_identical(out$espn_conference_id, 25L)
  expect_identical(out$ncaa_team_id, 51431L)
})

test_that("load_mbb_ncaa_espn_team_crosswalk() loads the published table", {
  skip_on_cran()
  if (Sys.getenv("HOOPR_LOAD_TESTS") != "1") skip("load_* crosswalk tests require published release artifacts")

  out <- load_mbb_ncaa_espn_team_crosswalk()
  if (nrow(out) == 0) skip("No rows returned at test time")
  expect_in(c("season", "ncaa_team_id", "ncaa_org_id", "espn_team_id", "match_method"), names(out))
  expect_type(out$espn_team_id, "integer")
  expect_in(c("mbb", "wbb"), unique(load_mbb_ncaa_espn_school_seasons()$sport))
  expect_type(load_mbb_ncaa_espn_schools()$espn_team_id, "integer")
})
