# Offline: the multi-file and single-file NBA release loaders in
# R/load_nba_stats_extra.R (+ load_nba_depthcharts() / load_nba_current_impact()).
# Every reader is mocked, so nothing here touches the network.

# Reader stand-in: records each url and serves a one-row table (or nothing for
# urls matching `absent`).
.mock_reader <- function(env, absent = "^$", rows = function(url) data.table::data.table(x = 1L)) {
  function(url) {
    env$urls <- c(env$urls, url)
    if (grepl(absent, url)) {
      warning("cannot open URL '", url, "': HTTP status was '404 Not Found'")
      return(data.table::data.table())
    }
    rows(url)
  }
}

.local_release <- function(env, ..., .env = parent.frame()) {
  reader <- .mock_reader(env, ...)
  local_mocked_bindings(parquet_from_url = reader, rds_from_url = reader,
                        .release_asset_exists = function(url) TRUE, .env = .env)
}

test_that("synergy reads every published split of a season, keyed by the END year", {
  env <- new.env()
  .local_release(env)
  out <- load_nba_stats_synergy(seasons = 2024)
  expect_length(env$urls, 72)
  expect_true(all(grepl("/nba_stats_synergy/.*_2025[.]parquet$", env$urls)))
  expect_false(any(grepl("_cut_defensive_", env$urls)))
  expect_s3_class(out, "hoopR_data")
  expect_setequal(unique(out$season_type), c("regular-season", "playoffs"))
  expect_setequal(unique(out$per_mode), c("pergame", "totals"))
  expect_identical(unique(out$season), 2025L)

  env$urls <- NULL
  load_nba_stats_synergy(seasons = 2024, season_type = "playoffs", per_mode = "totals",
                         play_type = "isolation")
  expect_identical(basename(env$urls), c("playoffs_isolation_offensive_totals_2025.parquet",
                                         "playoffs_isolation_defensive_totals_2025.parquet"))
})

test_that("synergy validates its selectors", {
  local_mocked_bindings(.release_asset_exists = function(url) TRUE)
  expect_error(load_nba_stats_synergy(2024, per_mode = "per100"), "per_mode")
  expect_error(load_nba_stats_synergy(2024, play_type = "lob"), "play_type")
  expect_error(load_nba_stats_synergy(2024, type_grouping = "defensive", play_type = "cut"),
               "No .* split is published")
  env <- new.env()
  .local_release(env)
  expect_warning(load_nba_stats_synergy(2024, type_grouping = c("offensive", "defensive"),
                                        play_type = "cut", per_mode = "totals",
                                        season_type = "playoffs"),
                 "cut/defensive")
  expect_identical(basename(env$urls), "playoffs_cut_offensive_totals_2025.parquet")
})

test_that("hustle, matchups and draft-combine loaders build the published file names", {
  env <- new.env()
  .local_release(env)
  load_nba_stats_hustle_player(2023, season_type = "regular-season")
  load_nba_stats_hustle_team(2023, per_mode = "pergame")
  expect_identical(basename(env$urls), c(
    "leaguehustlestatsplayer_regular-season_pergame_2024.parquet",
    "leaguehustlestatsplayer_regular-season_totals_2024.parquet",
    "leaguehustlestatsteam_regular-season_pergame_2024.parquet",
    "leaguehustlestatsteam_playoffs_pergame_2024.parquet"
  ))
  env$urls <- NULL
  load_nba_stats_matchups(2023)
  load_nba_stats_matchups_rollup(2023, season_type = "playoffs", per_mode = "totals")
  expect_identical(basename(env$urls), c(
    "leagueseasonmatchups_regular-season_pergame_2024.parquet",
    "leagueseasonmatchups_regular-season_totals_2024.parquet",
    "matchupsrollup_playoffs_totals_2024.parquet"
  ))
  env$urls <- NULL
  load_nba_stats_draft_combine_stats(2024)
  load_nba_stats_draft_combine_anthro(2024)
  load_nba_stats_draft_combine_drills(2024)
  load_nba_stats_draft_combine_spot_shooting(2024)
  load_nba_stats_draft_combine_nonstationary_shooting(2024)
  expect_identical(basename(env$urls), paste0(c(
    "draftcombinestats", "draftcombineplayeranthro", "draftcombinedrillresults",
    "draftcombinespotshooting", "draftcombinenonstationaryshooting"
  ), "_2025.parquet"))
})

test_that("single-file loaders read the rds asset of the right tag and year", {
  env <- new.env()
  .local_release(env)
  load_nba_stats_game_matchups(2024)
  load_nba_stats_injury_report(2024)
  load_nba_stats_metric_curves(1996)
  load_nba_stats_rolling_windows(2024)
  load_nba_current_impact(2026)
  expect_identical(sub(".*/download/", "", env$urls), c(
    "nba_stats_game_matchups/game_matchups_2025.rds",
    "nba_stats_injury_report/injury_report_2025.rds",
    "nba_stats_metric_curves/metric_curves_1997.rds",
    "nba_stats_rolling_windows/rolling_windows_2025.rds",
    "nba_current_impact/nba_current_impact_2026.rds"
  ))
  env$urls <- NULL
  load_nba_depthcharts(2027)
  expect_identical(sub(".*/download/", "", env$urls), "espn_nba_depthcharts/depthcharts_2027.parquet")
})

test_that("season floors match the first season each tag publishes", {
  local_mocked_bindings(.release_asset_exists = function(url) TRUE)
  expect_error(load_nba_stats_synergy(2014), "Published seasons: 2015-")
  expect_error(load_nba_stats_hustle_player(2014), "Published seasons: 2015-")
  expect_error(load_nba_stats_hustle_team(2014), "Published seasons: 2015-")
  expect_error(load_nba_stats_matchups(2016), "Published seasons: 2017-")
  expect_error(load_nba_stats_matchups_rollup(2016), "Published seasons: 2017-")
  expect_error(load_nba_stats_game_matchups(2016), "Published seasons: 2017-")
  expect_error(load_nba_stats_injury_report(2017), "Published seasons: 2018-")
  expect_error(load_nba_stats_draft_combine_stats(1999), "Published seasons: 2000-")
  expect_error(load_nba_stats_metric_curves(1995), "Published seasons: 1996-")
  expect_error(load_nba_stats_rolling_windows(1995), "Published seasons: 1996-")
  expect_error(load_nba_current_impact(2006), "Published seasons: 2007-")
  expect_error(load_nba_depthcharts(2026), "Published seasons: 2027")
  expect_error(load_nba_stats_synergy(most_recent_nba_stats_season() + 1))
})

test_that("an absent file inside a season is skipped; a season with no file warns", {
  env <- new.env()
  .local_release(env, absent = "playoffs")
  expect_no_warning(out <- load_nba_stats_hustle_player(2024))
  expect_identical(unique(out$season_type), "regular-season")

  env <- new.env()
  .local_release(env, absent = "_2025[.]")
  expect_warning(out <- load_nba_stats_hustle_team(c(2023, 2024)), "no data for season 2024")
  expect_identical(unique(out$season), 2024L)
})

test_that("stamps never overwrite a column the file carries; all-null columns bind", {
  env <- new.env()
  rows <- function(url) {
    if (grepl("_2024[.]", url)) {
      data.table::data.table(season = 1L, per_mode = "kept",
                             z = structure(NA, class = "vctrs_unspecified"))
    } else {
      data.table::data.table(z = 2.5)
    }
  }
  .local_release(env, rows = rows)
  out <- load_nba_stats_matchups(c(2023, 2024), per_mode = "totals")
  expect_identical(out$season, c(1L, 2025L))
  expect_identical(out$per_mode, c("kept", "totals"))
  expect_identical(out$z, c(NA, 2.5))
})

test_that("the new loaders return published rows", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_load_test()

  df <- load_nba_stats_hustle_player(seasons = 2024, season_type = "regular-season", per_mode = "totals")
  if (nrow(df) == 0) skip("No rows returned at test time")
  expect_s3_class(df, "hoopR_data")
  expect_in(c("player_id", "team_id", "deflections", "season", "season_type", "per_mode"), colnames(df))
  expect_identical(unique(df$season), 2025L)

  df <- load_nba_stats_synergy(seasons = 2024, play_type = "isolation", per_mode = "totals")
  if (nrow(df) == 0) skip("No rows returned at test time")
  expect_in(c("player_id", "play_type", "type_grouping", "ppp", "poss"), colnames(df))
})

test_that("the newest season counts as published when any requested file is", {
  last <- most_recent_nba_stats_season()
  newest <- paste0("_", last + 1, "[.]parquet$")
  # newest season: regular-season files only, no playoffs file yet
  probed <- character()
  local_mocked_bindings(.release_asset_exists = function(url) {
    probed <<- c(probed, url)
    !(grepl("playoffs", url) && grepl(newest, url))
  })
  env <- new.env()
  reader <- .mock_reader(env, absent = paste0("playoffs.*", newest))
  local_mocked_bindings(parquet_from_url = reader, rds_from_url = reader)

  out <- load_nba_stats_hustle_player(seasons = TRUE, season_type = c("playoffs", "regular-season"))
  expect_true(as.integer(last + 1) %in% out$season)
  # the probe stopped at the first published file of the newest season
  expect_true(any(grepl(paste0("regular-season.*", newest), probed)))

  expect_no_message(out <- load_nba_stats_hustle_player(season_type = c("playoffs", "regular-season")))
  expect_identical(unique(out$season), as.integer(last + 1))
  expect_identical(unique(out$season_type), "regular-season")

  # with no requested file published, the default still falls back a season
  expect_message(load_nba_stats_hustle_player(season_type = "playoffs"), "not published yet")
})

test_that(".loader_seasons accepts several urls per season", {
  local_mocked_bindings(.release_asset_exists = function(url) grepl("b_2027", url))
  url_for <- function(s) paste0("https://example.invalid/tag/", c("a", "b"), "_", s, ".parquet")
  expect_no_message(out <- .loader_seasons(2027, 2004, 2027, fn = "load_x", url_for = url_for, default = TRUE))
  expect_equal(out, 2027)
  expect_equal(.loader_seasons(TRUE, 2025, 2027, fn = "load_x", url_for = url_for), 2025:2027)
})
