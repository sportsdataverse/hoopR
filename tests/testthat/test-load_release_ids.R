# Offline: release loaders' season floors, lossless play ids and integer join
# ids. Every reader is mocked onto fixtures/release_ids (a few real rows of the
# sportsdataverse-data release assets, provenance in its README), so nothing
# here touches the network.

.fx <- function(name) testthat::test_path("fixtures", "release_ids", name)

# rds_from_url() stand-in that serves release_ids/<asset basename> and records
# every url it was asked for.
.mock_rds <- function(env) {
  function(url) {
    env$urls <- c(env$urls, url)
    f <- .fx(basename(url))
    if (!file.exists(f)) return(data.table::data.table())
    data.table::setDT(readRDS(f))
  }
}

test_that("loader floors match the first season each release publishes", {
  env <- new.env()
  local_mocked_bindings(rds_from_url = .mock_rds(env))
  local_mocked_bindings(pbp_from_url = function(url, type) {
    env$urls <- c(env$urls, url)
    data.table::data.table()
  })

  # published 2003 MBB pbp season, previously refused (floor was 2006)
  expect_no_error(load_mbb_pbp(seasons = 2003))
  expect_match(env$urls, "play_by_play_2003$")
  # 2004-2005 MBB pbp/shots were never published
  expect_error(load_mbb_pbp(seasons = 2004), "Published seasons: 2003, 2006-")
  expect_error(load_mbb_shots(seasons = 2005), "Published seasons: 2003, 2006-")
  # rosters / officials / player season stats only exist from 2025
  expect_error(load_mbb_rosters(seasons = 2024), "Published seasons: 2025-")
  expect_error(load_mbb_officials(seasons = 2002), "Published seasons: 2025-")
  expect_error(load_mbb_player_stats(seasons = 2010), "Published seasons: 2025-")
  expect_error(load_nba_rosters(seasons = 2024), "Published seasons: 2025-")
  expect_error(load_mbb_team_stats(seasons = 2002), "Published seasons: 2003-")
  expect_error(load_mbb_standings(seasons = 2002), "Published seasons: 2003-")
  expect_error(load_mbb_game_rosters(seasons = 2010), "Published seasons: 2002, 2025-")
  expect_error(load_mbb_schedule_crosswalk(seasons = 2007), "Published seasons: 2008-")
  expect_error(load_mbb_player_crosswalk(seasons = 2024), "Published seasons: 2025-")
  expect_error(load_mbb_pbp(seasons = "2025"))
  expect_error(load_mbb_pbp(seasons = most_recent_mbb_season() + 1))

  # NBA box / schedule / player stats / player core publish back to 1994
  env$urls <- NULL
  expect_no_error(load_nba_team_box(seasons = 1994))
  expect_no_error(load_nba_schedule(seasons = 1994))
  expect_match(env$urls, "_1994[.]rds$")
  expect_error(load_nba_team_box(seasons = 1993), "Published seasons: 1994-")

  # seasons = TRUE asks only for published seasons
  env$urls <- NULL
  load_mbb_officials(seasons = TRUE)
  expect_identical(
    sub(".*officials_([0-9]+)[.]rds$", "\\1", env$urls),
    as.character(2025:most_recent_mbb_season())
  )
  env$urls <- NULL
  load_mbb_pbp(seasons = TRUE)
  yrs <- as.integer(sub(".*play_by_play_", "", env$urls))
  expect_identical(yrs, c(2003L, 2006:most_recent_mbb_season()))
})

test_that("pbp play ids are exact character strings when arrow is installed", {
  skip_if_not_installed("arrow")
  base <- paste0("file:///", normalizePath(.fx("play_by_play_2025"), winslash = "/", mustWork = FALSE))
  pbp <- pbp_from_url(base, "ESPN MBB pbp from hoopR data repository")

  expect_type(pbp$id, "character")
  # four plays whose ids all round to 401700174101828032 in the .rds asset
  expect_identical(pbp$id, paste0("4017001741018280", sprintf("%02d", 1:4)))
  expect_identical(attr(pbp, "hoopR_type"), "ESPN MBB pbp from hoopR data repository")
})

test_that("without arrow the .rds fallback returns character ids and warns about rounding", {
  local_mocked_bindings(is_installed = function(pkg) FALSE)
  local_mocked_bindings(rds_from_url = function(url) data.table::setDT(readRDS(.fx(basename(url)))))

  expect_warning(pbp <- pbp_from_url("x/play_by_play_2025", "t"), "2\\^53")
  expect_type(pbp$id, "character")
  expect_identical(unique(pbp$id), "401700174101828032")
  expect_false(any(grepl("e[+]", pbp$id)))
})

test_that("ESPN join ids come back integer from every loader", {
  env <- new.env()
  local_mocked_bindings(rds_from_url = .mock_rds(env))

  gr <- load_mbb_game_rosters(seasons = 2026)
  expect_type(gr$game_id, "integer")
  expect_type(gr$athlete_id, "integer")
  sched <- load_mbb_schedule(seasons = 2026)
  expect_identical(class(gr$game_id), class(sched$game_id))
  joined <- dplyr::inner_join(as.data.frame(gr), as.data.frame(sched), by = c("game_id", "season"))
  expect_gt(nrow(joined), 0)

  ro <- load_mbb_rosters(seasons = 2026)
  expect_type(ro$athlete_id, "integer")
  expect_type(ro$team_id, "integer")

  cw <- load_mbb_schedule_crosswalk(seasons = 2026)
  expect_type(cw$espn_game_id, "integer")
  expect_type(cw$kp_game_id, "character")
  pc <- load_mbb_player_crosswalk(seasons = 2026)
  expect_type(pc$espn_athlete_id, "integer")

  tb <- load_ncaa_mbb_team_box(seasons = 2026)
  for (k in c("espn_game_id", "home_espn_team_id", "away_espn_team_id", "team_espn_team_id")) {
    expect_type(tb[[k]], "integer")
  }
  # NCAA ids are opaque and stay character
  expect_type(tb$contest_id, "character")
  expect_type(tb$team_ncaa_team_id, "character")
})
