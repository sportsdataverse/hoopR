# ESPN's /teams/{id}/roster ignores ?season=, so a past season is built from that
# season's player box scores. Fixture: real 2024-25 Duke (150) and North Carolina
# (153) rows from hoopR-mbb-data player_box_2025.parquet, trimmed to 11 columns.

box_2025 <- function() readRDS(test_path("fixtures", "espn_team_roster", "mbb_player_box_2025_duke_unc.rds"))

test_that("a past season's roster comes from that season's box scores, not the live endpoint", {
  rm(list = ls(hoopR:::.espn_past_roster_cache), envir = hoopR:::.espn_past_roster_cache)
  calls <- 0L
  local_mocked_bindings(
    most_recent_mbb_season = function() 2027,
    load_mbb_player_box = function(seasons, ...) {
      calls <<- calls + 1L
      expect_equal(seasons, 2025L)
      box_2025()
    },
    .retry_request = function(...) stop("the live roster endpoint must not be called")
  )
  duke <- espn_mbb_team_roster(team_id = 150, season = 2025)
  expect_equal(nrow(duke), 15L)
  expect_true(all(duke$team_id == "150") && all(duke$season == 2025L))
  flagg <- duke[duke$full_name == "Cooper Flagg", ]
  expect_equal(c(flagg$athlete_id, flagg$jersey, flagg$position_abbrev), c("5041939", "2", "F"))
  unc <- espn_mbb_team_roster(team_id = "153", season = 2025)
  expect_gt(nrow(unc), 0L)
  expect_false(any(unc$athlete_id %in% duke$athlete_id))
  expect_equal(calls, 1L) # one release read per season, cached across teams
})

roster_cols <- c("athlete_id", "full_name", "jersey", "position_abbrev", "position_name", "height", "weight",
                 "age", "birth_date", "birth_place", "headshot", "link_web", "status", "team_id", "season")

# Run `code`, returning its value and every warning message it raised.
with_warnings <- function(code) {
  msgs <- character()
  value <- withCallingHandlers(code, warning = function(w) {
    msgs <<- c(msgs, conditionMessage(w))
    invokeRestart("muffleWarning")
  })
  list(value = value, warnings = msgs)
}

test_that("a past season with no published box scores warns and returns an empty roster, not today's", {
  rm(list = ls(hoopR:::.espn_past_roster_cache), envir = hoopR:::.espn_past_roster_cache)
  local_mocked_bindings(
    most_recent_nba_season = function() 2027,
    load_nba_player_box = function(...) data.frame(),
    .retry_request = function(...) stop("the live roster endpoint must not be called")
  )
  res <- with_warnings(espn_nba_team_roster(team_id = 13, season = 2025))
  expect_true(any(grepl("No nba player box scores could be read for season 2025", res$warnings, fixed = TRUE)))
  expect_s3_class(res$value, "hoopR_data")
  expect_equal(nrow(res$value), 0L)
  expect_equal(names(res$value), roster_cols)
  expect_null(hoopR:::.espn_past_roster_cache[["nba 2025"]]) # an empty read is not cached
})

test_that("offline: a failed box-score download warns and returns an empty roster instead of erroring", {
  rm(list = ls(hoopR:::.espn_past_roster_cache), envir = hoopR:::.espn_past_roster_cache)
  reads <- 0L
  local_mocked_bindings(
    most_recent_mbb_season = function() 2027,
    .release_asset_exists = function(...) TRUE,
    .read_rds_url = function(url) {
      reads <<- reads + 1L
      stop("Could not connect to server [github.com]")
    },
    .retry_request = function(...) stop("the live roster endpoint must not be called")
  )
  res <- with_warnings(espn_mbb_team_roster(team_id = "150", season = 2025))
  expect_gt(reads, 0L) # the real loader ran and its download failed
  expect_true(any(grepl("player_box_2025.rds", res$warnings, fixed = TRUE)))
  expect_true(any(grepl("No mens-college-basketball player box scores could be read", res$warnings, fixed = TRUE)))
  expect_equal(nrow(res$value), 0L)
  expect_equal(names(res$value), roster_cols)
})

test_that("a loader error becomes the roster warning, with the error's text", {
  rm(list = ls(hoopR:::.espn_past_roster_cache), envir = hoopR:::.espn_past_roster_cache)
  local_mocked_bindings(
    most_recent_mbb_season = function() 2027,
    load_mbb_player_box = function(...) stop("release index unreadable"),
    .retry_request = function(...) stop("the live roster endpoint must not be called")
  )
  res <- with_warnings(espn_mbb_team_roster(team_id = "150", season = 2025))
  expect_true(any(grepl("release index unreadable", res$warnings, fixed = TRUE)))
  expect_equal(nrow(res$value), 0L)
})
