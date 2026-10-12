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

test_that("a past season with no published box scores errors instead of using today's roster", {
  rm(list = ls(hoopR:::.espn_past_roster_cache), envir = hoopR:::.espn_past_roster_cache)
  local_mocked_bindings(
    most_recent_nba_season = function() 2027,
    load_nba_player_box = function(...) data.frame(),
    .retry_request = function(...) stop("the live roster endpoint must not be called")
  )
  expect_error(espn_nba_team_roster(team_id = 13, season = 2025), "No nba player box scores")
})
