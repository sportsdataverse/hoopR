# test-mbb_crosswalk.R
# Offline assembler tests for .bb_assemble_team_crosswalk_mbb().
# Live gate: asserts Fox/Torvik/KenPom >= 0.9 only when
# SDV_HOOPR_LIVE_TESTS=1.

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

.make_espn <- function(ids, display_names, locations, mascots, confs,
                       abbrs = NULL, short_names = NULL) {
  n <- length(ids)
  data.frame(
    team_id        = as.integer(ids),
    abbreviation   = if (!is.null(abbrs)) abbrs else toupper(substr(locations, 1, 3)),
    display_name   = display_names,
    short_name     = if (!is.null(short_names)) short_names else display_names,
    team           = locations,
    mascot         = mascots,
    conference_name = confs,
    stringsAsFactors = FALSE
  )
}

.make_fox <- function(ids, names, sections) {
  data.frame(
    fox_team_id   = as.character(ids),
    fox_team_name = names,
    fox_section   = sections,
    stringsAsFactors = FALSE
  )
}

.make_bart <- function(teams, confs) {
  data.frame(team = teams, conf = confs, stringsAsFactors = FALSE)
}

.make_kp <- function(teams, confs) {
  data.frame(Team = teams, Conf = confs, stringsAsFactors = FALSE)
}

# ---------------------------------------------------------------------------
# Offline: exact matches (all four sources align)
# ---------------------------------------------------------------------------

test_that("assembler handles exact four-source match", {
  espn <- .make_espn(
    ids           = 333L,
    display_names = "Alabama Crimson Tide",
    locations     = "Alabama",
    mascots       = "Crimson Tide",
    confs         = "SEC"
  )
  fox  <- .make_fox(1L, "Alabama Crimson Tide", "SEC")
  bart <- .make_bart("Alabama", "SEC")
  kp   <- .make_kp("Alabama", "SEC")

  out <- .bb_assemble_team_crosswalk_mbb(
    espn = espn, fox = fox, bart = bart, kp = kp, season = 2025L
  )

  expect_equal(nrow(out), 1L)
  expect_equal(out$espn_team_id, 333L)
  expect_equal(out$fox_team_id, "1")
  expect_equal(out$bart_team, "Alabama")
  expect_equal(out$kp_team, "Alabama")
  expect_equal(out$match_method, "fox+bart+kp")
  expect_equal(out$fox_match_confidence,  1)
  expect_equal(out$bart_match_confidence, 1)
  expect_equal(out$kp_match_confidence,   1)
})

# ---------------------------------------------------------------------------
# Offline: Torvik alias (e.g. "Connecticut" -> "UConn")
# ---------------------------------------------------------------------------

test_that("assembler resolves Torvik alias Connecticut -> UConn", {
  espn <- .make_espn(
    ids           = 41L,
    display_names = "UConn Huskies",
    locations     = "UConn",
    mascots       = "Huskies",
    confs         = "Big East"
  )
  fox  <- .make_fox(99L, "UConn Huskies", "Big East")
  bart <- .make_bart("Connecticut", "BE")
  kp   <- .make_kp("Connecticut", "BE")

  out <- .bb_assemble_team_crosswalk_mbb(
    espn = espn, fox = fox, bart = bart, kp = kp, season = 2025L
  )

  expect_equal(out$bart_team, "Connecticut")
  expect_equal(out$kp_team,   "Connecticut")
  expect_equal(out$match_method, "fox+bart+kp")
})

# ---------------------------------------------------------------------------
# Offline: Fox alias (e.g. "American Eagles" -> "American University Eagles")
# ---------------------------------------------------------------------------

test_that("assembler resolves Fox alias American Eagles", {
  espn <- .make_espn(
    ids           = 44L,
    display_names = "American University Eagles",
    locations     = "American University",
    mascots       = "Eagles",
    confs         = "Patriot League"
  )
  fox  <- .make_fox(104L, "American Eagles", "Patriot League")
  bart <- .make_bart("American", "PL")
  kp   <- .make_kp("American", "PL")

  out <- .bb_assemble_team_crosswalk_mbb(
    espn = espn, fox = fox, bart = bart, kp = kp, season = 2025L
  )

  expect_equal(out$fox_team_id, "104")
  expect_equal(out$match_method, "fox+bart+kp")
})

# ---------------------------------------------------------------------------
# Offline: KenPom-specific alias (CSUN -> Cal State Northridge)
# ---------------------------------------------------------------------------

test_that("assembler resolves KenPom CSUN alias", {
  espn <- .make_espn(
    ids           = 2463L,
    display_names = "Cal State Northridge Matadors",
    locations     = "Cal State Northridge",
    mascots       = "Matadors",
    confs         = "Big West"
  )
  fox  <- .make_fox(200L, "Cal State Northridge Matadors", "Big West")
  bart <- .make_bart("Cal St. Northridge", "BW")
  kp   <- .make_kp("CSUN", "BW")

  out <- .bb_assemble_team_crosswalk_mbb(
    espn = espn, fox = fox, bart = bart, kp = kp, season = 2025L
  )

  expect_equal(out$kp_team, "CSUN")
  expect_equal(out$bart_team, "Cal St. Northridge")
  expect_equal(out$match_method, "fox+bart+kp")
})

# ---------------------------------------------------------------------------
# Offline: unmatched Fox + ESPN-only fallback
# ---------------------------------------------------------------------------

test_that("assembler labels espn_only when all three sources absent", {
  espn <- .make_espn(
    ids           = 9999L,
    display_names = "New Haven Chargers",
    locations     = "New Haven",
    mascots       = "Chargers",
    confs         = "NEC"
  )
  out <- .bb_assemble_team_crosswalk_mbb(
    espn = espn, fox = NULL, bart = .make_bart(character(), character()),
    kp   = .make_kp(character(), character()), season = 2025L
  )

  expect_equal(out$match_method, "espn_only")
  expect_true(is.na(out$fox_team_id))
  expect_true(is.na(out$bart_team))
  expect_true(is.na(out$kp_team))
})

# ---------------------------------------------------------------------------
# Offline: duplicate ESPN team_ids are deduped
# ---------------------------------------------------------------------------

test_that("assembler dedupes duplicate ESPN team_ids", {
  espn <- rbind(
    .make_espn(1L, "Duke Blue Devils",  "Duke",  "Blue Devils", "ACC"),
    .make_espn(1L, "Duke Blue Devils",  "Duke",  "Blue Devils", "ACC")
  )
  out <- .bb_assemble_team_crosswalk_mbb(
    espn = espn, fox = NULL,
    bart = .make_bart(character(), character()),
    kp   = .make_kp(character(), character()),
    season = 2025L
  )
  expect_equal(nrow(out), 1L)
})

# ---------------------------------------------------------------------------
# Offline: season stamp propagates
# ---------------------------------------------------------------------------

test_that("assembler stamps the season column correctly", {
  espn <- .make_espn(
    333L, "Alabama Crimson Tide", "Alabama", "Crimson Tide", "SEC"
  )
  out <- .bb_assemble_team_crosswalk_mbb(
    espn = espn, fox = NULL,
    bart = .make_bart(character(), character()),
    kp   = .make_kp(character(), character()),
    season = 2024L
  )
  expect_equal(out$season, 2024L)
})

# ---------------------------------------------------------------------------
# Live gate: Fox / Torvik / KenPom match rates >= 90 %
# ---------------------------------------------------------------------------

skip_if_no_live <- function() {
  if (!identical(Sys.getenv("SDV_HOOPR_LIVE_TESTS"), "1"))
    testthat::skip("Set SDV_HOOPR_LIVE_TESTS=1 to run live crosswalk tests")
}

test_that("mbb_team_crosswalk() >= 90% match rate all sources [live]", {
  skip_if_no_live()
  xw <- mbb_team_crosswalk(season = most_recent_mbb_season())
  n  <- nrow(xw)
  expect_gt(n, 300L)

  fox_rate  <- mean(!is.na(xw$fox_team_id))
  bart_rate <- mean(!is.na(xw$bart_team))
  kp_rate   <- mean(!is.na(xw$kp_team))

  expect_gte(fox_rate,  0.9,
    label = paste0("Fox match rate = ", round(fox_rate * 100, 1), "%"))
  expect_gte(bart_rate, 0.9,
    label = paste0("Torvik match rate = ", round(bart_rate * 100, 1), "%"))
  expect_gte(kp_rate,   0.9,
    label = paste0("KenPom match rate = ", round(kp_rate * 100, 1), "%"))
})
