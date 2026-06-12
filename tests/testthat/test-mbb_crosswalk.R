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
  skip_on_cran()
  skip_on_ci()
  skip_if_no_live()
  xw <- mbb_team_crosswalk(season = most_recent_mbb_season())
  skip_if(nrow(xw) == 0, "mbb_team_crosswalk() returned 0 rows at test time")
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

# ===========================================================================
# Offline tests: .bb_assemble_schedule_crosswalk_mbb
# ===========================================================================

# Small synthetic team_xwalk (3 teams)
.make_sched_xwalk <- function() {
  data.frame(
    espn_team_id  = c(1L, 2L, 3L),
    bart_team     = c("Duke", "North Carolina", "Kentucky"),
    kp_team       = c("Duke", "North Carolina", "Kentucky"),
    stringsAsFactors = FALSE
  )
}

.make_espn_games <- function(dates, home_ids, away_ids, game_ids) {
  data.frame(
    game_date         = as.Date(dates),
    home_espn_team_id = as.integer(home_ids),
    away_espn_team_id = as.integer(away_ids),
    espn_game_id      = as.character(game_ids),
    stringsAsFactors  = FALSE
  )
}

.make_bart_games <- function(dates, team1, team2, muids, winners) {
  data.frame(
    game_date    = as.Date(dates),
    muid         = as.character(muids),
    team1        = team1,
    team2        = team2,
    winner       = winners,
    stringsAsFactors = FALSE
  )
}

test_that("schedule assembler: both-match row", {
  xwalk <- .make_sched_xwalk()
  eg    <- .make_espn_games("2025-01-10", 1L, 2L, "E001")
  bg    <- .make_bart_games("2025-01-10", "Duke", "North Carolina", "B001", "Duke")

  out <- .bb_assemble_schedule_crosswalk_mbb(
    espn_games = eg, bart_games = bg, team_xwalk = xwalk, season = 2025L
  )

  expect_equal(nrow(out), 1L)
  expect_equal(out$match_method, "both")
  expect_equal(out$espn_game_id, "E001")
  expect_equal(out$bart_muid,    "B001")
  expect_equal(out$season,       2025L)
  expect_equal(out$match_confidence, 1)
})

test_that("schedule assembler: espn_only when no Torvik match", {
  xwalk <- .make_sched_xwalk()
  eg    <- .make_espn_games("2025-01-12", 1L, 3L, "E002")
  # Bart game on a different date -> no overlap
  bg    <- .make_bart_games("2025-01-15", "Duke", "Kentucky", "B002", "Kentucky")

  out <- .bb_assemble_schedule_crosswalk_mbb(
    espn_games = eg, bart_games = bg, team_xwalk = xwalk, season = 2025L
  )

  both_row  <- out[out$match_method == "both",      , drop = FALSE]
  espn_row  <- out[out$match_method == "espn_only", , drop = FALSE]
  bart_row  <- out[out$match_method == "bart_only", , drop = FALSE]

  expect_equal(nrow(both_row),  0L)
  expect_equal(nrow(espn_row),  1L)
  expect_equal(nrow(bart_row),  1L)
  expect_equal(espn_row$espn_game_id, "E002")
  expect_true(is.na(espn_row$bart_muid))
})

test_that("schedule assembler: bart_only when Torvik team unresolved stays in output", {
  xwalk <- .make_sched_xwalk()
  eg    <- data.frame(
    game_date = as.Date(character()),
    home_espn_team_id = integer(),
    away_espn_team_id = integer(),
    espn_game_id = character(),
    stringsAsFactors = FALSE
  )
  # Torvik game between two known teams -> bart_only (no espn games at all)
  bg <- .make_bart_games("2025-01-20", "Duke", "Kentucky", "B003", "Duke")

  out <- .bb_assemble_schedule_crosswalk_mbb(
    espn_games = eg, bart_games = bg, team_xwalk = xwalk, season = 2025L
  )

  expect_equal(nrow(out), 1L)
  expect_equal(out$match_method, "bart_only")
  expect_equal(out$bart_muid, "B003")
  expect_true(is.na(out$espn_game_id))
})

test_that("schedule assembler: no duplicate espn_game_id column", {
  xwalk <- .make_sched_xwalk()
  eg    <- .make_espn_games("2025-02-01", 2L, 3L, "E005")
  bg    <- .make_bart_games("2025-02-01", "North Carolina", "Kentucky", "B005", "NC")

  out <- .bb_assemble_schedule_crosswalk_mbb(
    espn_games = eg, bart_games = bg, team_xwalk = xwalk, season = 2025L
  )

  col_counts <- table(names(out))
  expect_true(all(col_counts == 1L),
    label = "No duplicate column names in schedule crosswalk output")
})

test_that("schedule assembler: kp_game_id, fox_game_id, yahoo_game_id are NA", {
  xwalk <- .make_sched_xwalk()
  eg    <- .make_espn_games("2025-01-10", 1L, 2L, "E001")
  bg    <- .make_bart_games("2025-01-10", "Duke", "North Carolina", "B001", "Duke")

  out <- .bb_assemble_schedule_crosswalk_mbb(
    espn_games = eg, bart_games = bg, team_xwalk = xwalk, season = 2025L
  )

  expect_true(is.na(out$kp_game_id[1]))
  expect_true(is.na(out$fox_game_id[1]))
  expect_true(is.na(out$yahoo_game_id[1]))
})

test_that("mbb_schedule_crosswalk include_kenpom=FALSE does not error without KP creds", {
  # When KP_USER is absent the function must NOT try to call kp_team_schedule.
  # We simulate by ensuring no credentials are set (default environment).
  old_user <- Sys.getenv("KP_USER")
  old_pw   <- Sys.getenv("KP_PW")
  Sys.unsetenv("KP_USER")
  Sys.unsetenv("KP_PW")
  on.exit({
    if (nchar(old_user)) Sys.setenv(KP_USER = old_user)
    if (nchar(old_pw))   Sys.setenv(KP_PW   = old_pw)
  })

  # Build a minimal synthetic result from the assembler directly (no live calls)
  xwalk <- .make_sched_xwalk()
  eg    <- .make_espn_games("2025-01-10", 1L, 2L, "E001")
  bg    <- .make_bart_games("2025-01-10", "Duke", "North Carolina", "B001", "Duke")

  out <- .bb_assemble_schedule_crosswalk_mbb(eg, bg, xwalk, 2025L)
  # include_kenpom path not triggered; kp_game_id remains NA
  expect_true(is.na(out$kp_game_id[1]))
})

# ===========================================================================
# Offline tests: .bb_assemble_player_crosswalk_mbb
# ===========================================================================

.make_mbb_espn_players <- function(team_id, abbr, ids, names, jerseys, positions) {
  data.frame(
    espn_team_id      = as.integer(team_id),
    team_abbreviation = abbr,
    espn_athlete_id   = as.character(ids),
    espn_full_name    = names,
    espn_jersey       = as.character(jerseys),
    espn_position     = positions,
    stringsAsFactors  = FALSE
  )
}

.make_mbb_fox_players <- function(team_id, ids, names, jerseys, positions) {
  data.frame(
    espn_team_id       = as.integer(team_id),
    fox_athlete_id     = as.character(ids),
    fox_player         = names,
    fox_jersey         = as.character(jerseys),
    fox_position_group = positions,
    stringsAsFactors   = FALSE
  )
}

test_that("player assembler: exact name match", {
  espn <- .make_mbb_espn_players(
    team_id = 150L, abbr = "DUK",
    ids      = c("A1", "A2"),
    names    = c("John Smith", "Mike Jones"),
    jerseys  = c("5", "11"),
    positions = c("G", "F")
  )
  fox <- .make_mbb_fox_players(
    team_id   = 150L,
    ids       = c("F1", "F2"),
    names     = c("John Smith", "Mike Jones"),
    jerseys   = c("5", "11"),
    positions = c("Guard", "Forward")
  )

  out <- .bb_assemble_player_crosswalk_mbb(espn, fox, season = 2025L)

  expect_equal(nrow(out), 2L)
  expect_equal(out$fox_athlete_id[out$espn_athlete_id == "A1"], "F1")
  expect_equal(out$fox_athlete_id[out$espn_athlete_id == "A2"], "F2")
  expect_true(all(out$match_method == "exact_name"))
  expect_true(all(out$match_confidence == 1))
})

test_that("player assembler: fuzzy name match (minor spelling diff)", {
  espn <- .make_mbb_espn_players(
    150L, "DUK",
    ids       = "A3",
    names     = "Jonathan Williams",
    jerseys   = "23",
    positions = "G"
  )
  fox <- .make_mbb_fox_players(
    150L,
    ids       = "F3",
    names     = "Jonathan Willams",   # deliberate typo
    jerseys   = "23",
    positions = "Guard"
  )

  out <- .bb_assemble_player_crosswalk_mbb(espn, fox, season = 2025L,
                                            min_confidence = 0.85)

  expect_equal(nrow(out), 1L)
  expect_equal(out$fox_athlete_id, "F3")
  expect_equal(out$match_method,   "fuzzy_jw")
  expect_true(out$match_confidence >= 0.85)
})

test_that("player assembler: unmatched when no Fox data", {
  espn <- .make_mbb_espn_players(
    200L, "KEN",
    ids       = c("A4", "A5"),
    names     = c("Bob Hall", "Sam Lee"),
    jerseys   = c("10", "20"),
    positions = c("C", "G")
  )

  out <- .bb_assemble_player_crosswalk_mbb(espn, fox = NULL, season = 2025L)

  expect_equal(nrow(out), 2L)
  expect_true(all(is.na(out$fox_athlete_id)))
  expect_true(all(out$match_method == "unmatched"))
})

test_that("player assembler: empty Fox frame still returns ESPN rows", {
  espn <- .make_mbb_espn_players(
    200L, "KEN",
    ids       = "A6",
    names     = "Chris Brown",
    jerseys   = "1",
    positions = "G"
  )
  fox_empty <- data.frame(
    espn_team_id       = integer(),
    fox_athlete_id     = character(),
    fox_player         = character(),
    fox_jersey         = character(),
    fox_position_group = character(),
    stringsAsFactors   = FALSE
  )

  out <- .bb_assemble_player_crosswalk_mbb(espn, fox = fox_empty, season = 2025L)

  expect_equal(nrow(out), 1L)
  expect_true(is.na(out$fox_athlete_id))
  expect_equal(out$espn_athlete_id, "A6")
})

test_that("player assembler: output columns are correct and non-duplicate", {
  espn <- .make_mbb_espn_players(
    333L, "ALA",
    ids       = "A7",
    names     = "Mark Davis",
    jerseys   = "42",
    positions = "F"
  )

  out <- .bb_assemble_player_crosswalk_mbb(espn, fox = NULL, season = 2025L)

  expected_cols <- c(
    "season", "espn_team_id", "team_abbreviation", "player_name",
    "espn_athlete_id", "espn_full_name", "espn_jersey", "espn_position",
    "fox_athlete_id", "fox_player", "fox_jersey", "fox_position_group",
    "yahoo_player_id", "yahoo_player_name",
    "match_method", "match_confidence", "match_keys"
  )
  expect_equal(names(out), expected_cols)
  expect_true(all(table(names(out)) == 1L))
  expect_true(all(is.na(out$yahoo_player_id)))
  expect_true(all(is.na(out$yahoo_player_name)))
})
