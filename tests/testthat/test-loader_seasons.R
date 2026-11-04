# Offline unit tests for the release-loader season helper in R/utils.R (ported
# from wehoop). The asset existence check is mocked, so nothing here touches the network.

url_for <- function(s) paste0("https://example.invalid/tag/play_by_play_", s, ".rds")

# .release_asset_exists() stand-in: TRUE for every url except those in `missing`.
mock_assets <- function(missing = character()) {
  function(url) !url %in% missing
}

test_that(".loader_seasons falls back to the newest published season only for the default", {
  local_mocked_bindings(.release_asset_exists = mock_assets(url_for(2027)))

  expect_message(
    out <- .loader_seasons(2027, 2004, 2027, fn = "load_x", url_for = url_for, default = TRUE),
    "2027 is not published yet; loading 2026"
  )
  expect_equal(out, 2026)

  # An explicit request for the unpublished season is kept as asked.
  expect_no_message(
    out <- .loader_seasons(2027, 2004, 2027, fn = "load_x", url_for = url_for, default = FALSE)
  )
  expect_equal(out, 2027)
})

test_that(".loader_seasons keeps the default season when it is published", {
  local_mocked_bindings(.release_asset_exists = mock_assets())
  expect_no_message(
    out <- .loader_seasons(2027, 2004, 2027, fn = "load_x", url_for = url_for, default = TRUE)
  )
  expect_equal(out, 2027)
})

test_that(".loader_seasons falls back past a gap", {
  local_mocked_bindings(.release_asset_exists = mock_assets(url_for(2027)))
  expect_message(
    out <- .loader_seasons(2027, 2004, 2027, gaps = 2025:2026, fn = "load_x",
                           url_for = url_for, default = TRUE)
  )
  expect_equal(out, 2024)
})

test_that(".loader_seasons accepts a .parquet sibling when parquet = TRUE", {
  local_mocked_bindings(.release_asset_exists = mock_assets(url_for(2027)))
  expect_no_message(
    out <- .loader_seasons(2027, 2004, 2027, fn = "load_x", url_for = url_for,
                           default = TRUE, parquet = TRUE)
  )
  expect_equal(out, 2027)

  pq <- sub("\\.rds$", ".parquet", url_for(2027))
  local_mocked_bindings(.release_asset_exists = mock_assets(c(url_for(2027), pq)))
  expect_message(
    out <- .loader_seasons(2027, 2004, 2027, fn = "load_x", url_for = url_for,
                           default = TRUE, parquet = TRUE)
  )
  expect_equal(out, 2026)
})

test_that(".loader_seasons(TRUE) expands to published seasons only", {
  local_mocked_bindings(.release_asset_exists = mock_assets(url_for(2027)))
  expect_equal(
    .loader_seasons(TRUE, 2004, 2027, gaps = 2005, fn = "load_x", url_for = url_for),
    c(2004L, 2006:2026)
  )

  local_mocked_bindings(.release_asset_exists = mock_assets())
  expect_equal(.loader_seasons(TRUE, 2024, 2027, fn = "load_x", url_for = url_for), 2024:2027)
  # Without url_for there is no existence check at all.
  expect_equal(.loader_seasons(TRUE, 2024, 2027, fn = "load_x"), 2024:2027)
})

test_that(".loader_seasons rejects unpublished seasons and lists the real range", {
  local_mocked_bindings(.release_asset_exists = mock_assets(url_for(2027)))
  expect_error(
    .loader_seasons(2005, 2004, 2027, gaps = 2005, fn = "load_x", url_for = url_for),
    "Published seasons: 2004, 2006-2026\\."
  )
  expect_error(.loader_seasons(2003, 2004, 2027, fn = "load_x"), "Published seasons: 2004-2027\\.")
  expect_error(.loader_seasons(2028, 2004, 2027, fn = "load_x"), "You requested: 2028")
  expect_error(.loader_seasons(2024.5, 2004, 2027, fn = "load_x"), "must be seasons published")
  expect_error(.loader_seasons("2024", 2004, 2027, fn = "load_x"), "must be seasons published")
  expect_error(.loader_seasons(NA_real_, 2004, 2027, fn = "load_x"), "must be seasons published")
  expect_error(.loader_seasons(numeric(), 2004, 2027, fn = "load_x"), "must be seasons published")
})

test_that(".loader_seasons passes multi-season requests through without a check", {
  local_mocked_bindings(.release_asset_exists = function(url) stop("no network expected"))
  expect_equal(.loader_seasons(c(2025, 2026), 2004, 2027, fn = "load_x", url_for = url_for,
                               default = TRUE), c(2025, 2026))
})

test_that("the in-season default of each lagging loader reads the newest published season", {
  urls <- NULL
  local_mocked_bindings(
    # nothing for the default season is published yet
    .release_asset_exists = function(url) {
      !grepl(paste0("_(", most_recent_nba_season(), "|", most_recent_mbb_season(), ")[.]"), url)
    },
    rds_from_url = function(url) {
      urls <<- c(urls, url)
      data.table::data.table(x = 1)
    },
    .ncaa_mbb_rds = function(url) {
      urls <<- c(urls, url)
      data.table::data.table(x = 1)
    }
  )
  nba <- most_recent_nba_season() - 1
  mbb <- most_recent_mbb_season() - 1
  expect_message(load_nba_standings(), paste0("loading[[:space:]]+", nba))
  expect_message(load_mbb_standings(), paste0("loading[[:space:]]+", mbb))
  expect_message(load_mbb_team_crosswalk(), paste0("loading[[:space:]]+", mbb))
  expect_message(load_mbb_schedule_crosswalk(), paste0("loading[[:space:]]+", mbb))
  expect_message(load_mbb_player_crosswalk(), paste0("loading[[:space:]]+", mbb))
  expect_message(load_nba_team_crosswalk(), paste0("loading[[:space:]]+", nba))
  expect_message(load_ncaa_mbb_rapm(), paste0("loading[[:space:]]+", mbb))
  expect_message(load_ncaa_mbb_rapm_within_team(), paste0("loading[[:space:]]+", mbb))
  expect_true(all(grepl(paste0("_(", nba, "|", mbb, ")[.]rds$"), urls)))
  expect_length(urls, 8L)

  # an explicit request is kept as asked
  urls <- NULL
  expect_no_message(load_nba_standings(seasons = most_recent_nba_season()))
  expect_match(urls, paste0("standings_", most_recent_nba_season(), "[.]rds$"))
})
