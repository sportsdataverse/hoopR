# test-mbb_crosswalk_sources.R
# Offline tests for the season-correct sources behind mbb_team_crosswalk()
# (R port of sportsdataverse-py #604 / #605). No network: every source is
# served from a recorded fixture in fixtures/crosswalk_basketball/:
#   * fox_cbk_*.json, mbb_*group_seasons*.parquet, mbb_torvik_teams_2026.parquet
#     -- real captures (Fox Bifrost cbk payloads, the mbb_groups release assets,
#     Torvik's 2026 team/conf), copied from sportsdataverse-py
#     tests/fixtures/crosswalk_basketball (captured 2026-09-27).
#   * torvik_mbb_2025_403.html -- barttorvik.com's CloudFront 403 body, as a
#     blocked egress receives it (captured 2026-09-27).
#   * torvik_mbb_2017_head.csv -- the header and first three rows of Torvik's
#     2017_team_results.csv (captured 2026-09-27).

.xw_fixture <- function(name) testthat::test_path("fixtures", "crosswalk_basketball", name)

.xw_json <- function(name) {
  jsonlite::fromJSON(.xw_fixture(name), simplifyVector = FALSE,
                     simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
}

# Serve the committed mbb_groups assets; an absent one reads as a 404.
.serve_groups <- function(env = parent.frame()) {
  testthat::local_mocked_bindings(
    .bb_release_parquet = function(file, missing_ok = FALSE) {
      f <- .xw_fixture(basename(file))
      if (!file.exists(f)) {
        if (missing_ok) return(NULL)
        .bb_source_error(paste("release asset", file, "answered HTTP 404"))
      }
      as.data.frame(arrow::read_parquet(f))
    },
    .env = env
  )
}

# Serve the real cbk conference catalog, and standings[[groupId]] (else Fox's {}).
.serve_fox <- function(standings, calls = new.env(), env = parent.frame()) {
  catalog <- .xw_json("fox_cbk_conferences.json")
  testthat::local_mocked_bindings(
    .fox_bb_get = function(path, query = list(), missing_ok = FALSE) {
      calls$log <- c(calls$log, list(list(path = path, query = query)))
      if (endsWith(path, "league/conferences")) return(catalog)
      standings[[as.character(query$groupId)]] %||% list()
    },
    .env = env
  )
  calls
}

.serve_torvik_2026 <- function(env = parent.frame()) {
  bart <- as.data.frame(arrow::read_parquet(.xw_fixture("mbb_torvik_teams_2026.parquet")))
  testthat::local_mocked_bindings(torvik_ratings = function(year) bart, .env = env)
}

.espn_stub <- function(ids, names, locations, confs) {
  data.frame(team_id = ids, abbreviation = "X", display_name = names,
             short_name = locations, team = locations, mascot = "X",
             conference_name = confs, stringsAsFactors = FALSE)
}

# ---------------------------------------------------------------------------
# (b) Torvik: a blocked or empty answer fails the build
# ---------------------------------------------------------------------------

test_that("a blocked or empty Torvik answer fails the build, never NA bart_*", {
  skip_on_cran()
  blocked <- paste(readLines(.xw_fixture("torvik_mbb_2025_403.html"), warn = FALSE), collapse = "\n")
  local_mocked_bindings(.bb_espn_team_directory = function(...) {
    .espn_stub("2", "Auburn Tigers", "Auburn", "Southeastern Conference")
  })
  for (body in c(blocked, "")) {
    local_mocked_bindings(.torvik_text = function(path) body)
    expect_error(
      suppressMessages(mbb_team_crosswalk(season = 2025, fox = data.frame())),
      class = "crosswalk_source_error"
    )
  }
})

test_that("Torvik is not called before its first season (2008)", {
  skip_on_cran()
  boom <- function(...) stop("Torvik must not be called")
  expect_equal(nrow(.bb_torvik_teams(boom, 2007L, .mbb_torvik_first_season)), 0L)
  expect_error(.bb_torvik_teams(boom, 2008L, .mbb_torvik_first_season), "must not be called")
})

test_that("torvik_ratings() keeps a season whose header fread has to re-quote", {
  skip_on_cran()
  # 2008-2021 files quote one header ("Fun Rk, adjt"); fread warns, and that
  # warning used to discard the whole season as an empty frame.
  csv <- paste(readLines(.xw_fixture("torvik_mbb_2017_head.csv"), warn = FALSE), collapse = "\n")
  local_mocked_bindings(.torvik_text = function(path) csv)
  out <- torvik_ratings(year = 2017)
  expect_equal(out$team, c("Gonzaga", "North Carolina", "Villanova"))
  expect_equal(out$conf, c("WCC", "ACC", "BE"))
})

# ---------------------------------------------------------------------------
# (c) KenPom: no fallback to the newest bundled season
# ---------------------------------------------------------------------------

test_that("the bundled KenPom directory has no rows for a season it lacks", {
  skip_on_cran()
  expect_equal(nrow(.mbb_kenpom_teams(2026)), 365L)
  expect_equal(nrow(.mbb_kenpom_teams(2002)), 327L)
  expect_equal(nrow(suppressMessages(.mbb_kenpom_teams(1999))), 0L)
  expect_equal(nrow(suppressMessages(.mbb_kenpom_teams(2030))), 0L)
})

test_that("a season the KenPom bundle lacks gets NA kp_*, not the newest season's labels", {
  skip_on_cran()
  skip_if_not_installed("arrow")
  .serve_torvik_2026()
  local_mocked_bindings(.bb_espn_team_directory = function(...) {
    .espn_stub("2", "Auburn Tigers", "Auburn", "Southeastern Conference")
  })
  ok <- mbb_team_crosswalk(season = 2026, fox = data.frame())
  expect_equal(ok$kp_conf, "SEC")
  out <- suppressMessages(mbb_team_crosswalk(season = 2030, fox = data.frame()))
  expect_true(is.na(out$kp_team))
  expect_true(is.na(out$kp_conf))
})

# ---------------------------------------------------------------------------
# (a) Fox: the requested season's standings, confirmed against the reference
# ---------------------------------------------------------------------------

test_that("Fox standings are read for the requested season (START-year key)", {
  skip_on_cran()
  calls <- .serve_fox(list("17" = .xw_json("fox_cbk_standings_17_2017.json")))
  out <- .bb_fox_season_teams("cbk", 2018L, .mbb_fox_first_season)
  expect_equal(names(out), c("fox_team_id", "fox_team_name", "fox_section"))
  expect_true(is.character(out$fox_team_id))
  expect_equal(nrow(out), 14L)  # the 2017-18 Big Ten had 14 teams (18 today)
  expect_equal(unique(out$fox_section), "Big Ten")
  standings <- Filter(function(x) endsWith(x$path, "league/standings"), calls$log)
  expect_equal(length(standings), 33L)  # one call per catalogued conference
  expect_equal(unique(vapply(standings, function(x) as.integer(x$query$season), 1L)), 2017L)
})

test_that("Fox standings labelled with another season do not stamp this one", {
  skip_on_cran()
  # Fox answers a season it lacks with another one; a real table labelled
  # 2025-26 must not stamp 2017-18.
  .serve_fox(list("17" = .xw_json("fox_cbk_standings_31_2025.json")))
  expect_error(.bb_fox_season_teams("cbk", 2018L, .mbb_fox_first_season),
               "no 2017-18 standings", class = "crosswalk_source_error")
})

test_that("Fox is not called before its first season (2017-18)", {
  skip_on_cran()
  local_mocked_bindings(.fox_bb_get = function(...) stop("Fox must not be called"))
  expect_equal(nrow(.bb_fox_season_teams("cbk", 2017L, .mbb_fox_first_season)), 0L)
})

test_that("fox_section is NA for teams Fox filed a season early", {
  skip_on_cran()
  skip_if_not_installed("arrow")
  # Real capture: Fox's 2022-23 Big 12 table lists BYU and Houston, who joined in 2023-24.
  .serve_fox(list("13" = .xw_json("fox_cbk_standings_13_2022.json")))
  .serve_torvik_2026()
  # Movers left empty on purpose: the majority vote alone must catch these.
  local_mocked_bindings(
    .bb_next_season_movers = function(...) character(),
    .bb_espn_team_directory = function(...) .espn_stub(
      c("2305", "239", "248", "252"),
      c("Kansas Jayhawks", "Baylor Bears", "Houston Cougars", "BYU Cougars"),
      c("Kansas", "Baylor", "Houston", "BYU"),
      c("Big 12 Conference", "Big 12 Conference", "American Athletic Conference", "West Coast Conference")
    )
  )
  out <- mbb_team_crosswalk(season = 2023)
  expect_equal(stats::setNames(out$fox_section, out$espn_location),
               c(Kansas = "Big 12", Baylor = "Big 12", Houston = NA, BYU = NA))
  expect_false(anyNA(out$fox_team_id))
})

test_that("a Fox conference made of next-season arrivals is NA for all its teams", {
  skip_on_cran()
  skip_if_not_installed("arrow")
  # Real capture: Fox's 2025-26 Pac-12 table is the 2026-27 Pac-12; five of its
  # nine teams were Mountain West that season, so a vote alone would keep it.
  .serve_groups()
  .serve_fox(list("31" = .xw_json("fox_cbk_standings_31_2025.json")))
  .serve_torvik_2026()
  pac <- c("68", "36", "278", "2250", "204", "21", "326", "328", "265")
  members <- as.data.frame(arrow::read_parquet(.xw_fixture("mbb_team_group_seasons_2026.parquet")))
  members <- members[members$team_id %in% pac, ]
  names26 <- as.data.frame(arrow::read_parquet(.xw_fixture("mbb_group_seasons.parquet")))
  names26 <- names26[names26$season == 2026, ]
  local_mocked_bindings(.bb_espn_team_directory = function(...) .espn_stub(
    members$team_id, members$team_name, members$team_name,
    names26$name[match(members$conference_id, names26$group_id)]
  ))
  out <- mbb_team_crosswalk(season = 2026)
  expect_equal(nrow(out), 9L)
  expect_false(anyNA(out$fox_team_id))
  expect_true(all(is.na(out$fox_section)))
})

test_that("a Fox conference needs two agreeing teams", {
  skip_on_cran()
  # Fox's 2021-22 Independents table held only Chicago State, then in the WAC.
  x <- data.frame(
    espn_team_id = c(2130L, 2305L, 239L),
    espn_conference = c("Western Athletic Conference", "Big 12 Conference", "Big 12 Conference"),
    fox_section = c("Independents (DI)", "Big 12", "Big 12"),
    stringsAsFactors = FALSE
  )
  out <- .bb_drop_unconfirmed_fox_sections(x)
  expect_equal(names(out), names(x))
  expect_equal(out$fox_section, c(NA, "Big 12", "Big 12"))
})

test_that("teams with no ESPN conference do not vote", {
  skip_on_cran()
  x <- data.frame(espn_team_id = 1:3,
                  espn_conference = c(NA, NA, "Big South Conference"),
                  fox_section = "Big South", stringsAsFactors = FALSE)
  expect_true(all(is.na(.bb_drop_unconfirmed_fox_sections(x)$fox_section)))
})

test_that("a mover Fox still lists correctly keeps its fox_section", {
  skip_on_cran()
  # 2335 Liberty (Big South, leaving) is listed correctly; 2916 (ASUN, arriving) is not.
  x <- data.frame(
    espn_team_id = c(2561L, 2272L, 2335L, 2916L),
    espn_conference = c(rep("Big South Conference", 3), "ASUN Conference"),
    fox_section = "Big South", stringsAsFactors = FALSE
  )
  out <- .bb_drop_unconfirmed_fox_sections(x, movers = c("2335", "2916"))
  expect_equal(out$fox_section, c("Big South", "Big South", "Big South", NA))
})

test_that("next-season movers come from both seasons' reference assets", {
  skip_on_cran()
  skip_if_not_installed("arrow")
  .serve_groups()
  movers <- .bb_next_season_movers("mbb", 2026L)
  expect_true(all(c("68", "36", "278", "2250", "204", "21", "326", "328", "265") %in% movers))
  expect_false("23" %in% movers)  # San Jose State stayed in the MWC
  expect_equal(.bb_next_season_movers("mbb", 2027L), character())  # no 2028 asset yet
})

# ---------------------------------------------------------------------------
# (e) espn_conference: that season's conference under that season's name
# ---------------------------------------------------------------------------

test_that("the conference map names each conference as of the season", {
  skip_on_cran()
  skip_if_not_installed("arrow")
  .serve_groups()
  out <- .bb_conference_map("mbb", 2025L)
  expect_equal(names(out), c("team_id", "conference_name"))
  expect_true(is.character(out$team_id))
  expect_equal(nrow(out), 364L)
  named <- stats::setNames(out$conference_name, out$team_id)
  expect_equal(unname(named[c("3101", "2000")]), rep("Western Athletic Conference", 2))
  expect_false("United Athletic Conference" %in% out$conference_name)
  expect_error(.bb_conference_map("mbb", 2031L), "team_group_seasons_2031",
               class = "crosswalk_source_error")
})
