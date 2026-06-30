## ---------------------------------------------------------------------------
## test-nba_tracking.R
##
## Tests for .aggregate_tracking_frames and nba_tracking_aggregate.
##
## Four gate contracts (Phase 6d TDD):
##   1. Identity gate  — single-season aggregation gives counts identical to
##      source per player; recomputed *_FG_PCT / *_FT_PCT match within
##      rounding tolerance; "% of total" *_PCT columns DROPPED.
##   2. Additivity gate — two-season aggregation: each additive count equals
##      season-A count + season-B count for players present in both seasons.
##   3. ID-NOT-SUMMED gate (keystone) — team_id / player_id in the output
##      are VALID ids (in the union of both seasons), NOT doubled values.
##   4. Never-raise — empty list and 0-row frame inputs return 0-row frames.
##
## All offline tests run from fixture files saved under
##   tests/testthat/fixtures/nba_tracking/
## The live smoke test is gated by NBA_STATS_TESTS=1.
##
## Column note: nba_stats_map_result_sets returns ALL columns as character.
## The internal helper coerces numeric-like columns before summing.
## ---------------------------------------------------------------------------

FIXTURE_DIR <- testthat::test_path("fixtures", "nba_tracking")
FRAME_2324  <- readRDS(file.path(FIXTURE_DIR, "ptstats_drives_player_2324.rds"))
FRAME_2223  <- readRDS(file.path(FIXTURE_DIR, "ptstats_drives_player_2223.rds"))

## ── helpers ─────────────────────────────────────────────────────────────────

## Columns that should be DROPPED (% of total, non-additive rates)
PCT_DROP_COLS <- grep("_PCT$", colnames(FRAME_2324), value = TRUE) |>
  setdiff(grep("_FG_PCT$|_FT_PCT$", colnames(FRAME_2324), value = TRUE))

## Identity columns (id + name string cols)
IDENTITY_COLS <- c("PLAYER_ID", "PLAYER_NAME", "TEAM_ID", "TEAM_ABBREVIATION")

## Recomputed pct columns
FG_PCT_COLS <- grep("_FG_PCT$", colnames(FRAME_2324), value = TRUE)  # DRIVE_FG_PCT
FT_PCT_COLS <- grep("_FT_PCT$", colnames(FRAME_2324), value = TRUE)  # DRIVE_FT_PCT

## Additive count columns (everything that is not identity / pct-drop / pct-recompute)
ADDITIVE_COLS <- setdiff(
  colnames(FRAME_2324),
  c(IDENTITY_COLS, FG_PCT_COLS, FT_PCT_COLS, PCT_DROP_COLS)
)

## ===========================================================================
## 1. IDENTITY GATE — single season aggregation
## ===========================================================================

test_that("identity gate: single-season aggregate equals source counts", {
  skip_if(!file.exists(file.path(FIXTURE_DIR, "ptstats_drives_player_2324.rds")),
          "fixture not found")

  out <- hoopR:::.aggregate_tracking_frames(list(FRAME_2324), "PLAYER_ID")

  ## Same number of players
  expect_equal(nrow(out), nrow(FRAME_2324),
               label = "row count matches source for single season")

  ## All source PLAYER_IDs are present in output
  expect_true(all(FRAME_2324$PLAYER_ID %in% out$PLAYER_ID),
              label = "all source PLAYER_IDs present in single-season output")

  ## "% of total" *_PCT columns are DROPPED
  dropped_check <- intersect(PCT_DROP_COLS, colnames(out))
  expect_true(length(dropped_check) == 0L,
              label = "non-recomputable *_PCT columns dropped from output")

  ## FG_PCT and FT_PCT are PRESENT (recomputed)
  expect_true(all(c("DRIVE_FG_PCT", "DRIVE_FT_PCT") %in% colnames(out)),
              label = "recomputed DRIVE_FG_PCT and DRIVE_FT_PCT present in output")

  ## Additive counts match source (join on PLAYER_ID)
  merged <- merge(
    out[, c("PLAYER_ID", ADDITIVE_COLS)],
    FRAME_2324[, c("PLAYER_ID", ADDITIVE_COLS)],
    by = "PLAYER_ID", suffixes = c("_agg", "_src")
  )
  for (col in ADDITIVE_COLS) {
    agg_vals <- as.numeric(merged[[paste0(col, "_agg")]])
    src_vals <- as.numeric(merged[[paste0(col, "_src")]])
    expect_equal(
      agg_vals, src_vals,
      tolerance = 1e-6,
      label = paste0("identity gate: additive col ", col, " matches source")
    )
  }

  ## Recomputed DRIVE_FG_PCT is within rounding tolerance of source
  ##   (source is 3-dp rounded string; recomputed is more precise)
  merged_pct <- merge(
    out[, c("PLAYER_ID", "DRIVE_FG_PCT", "DRIVE_FGM", "DRIVE_FGA")],
    FRAME_2324[, c("PLAYER_ID", "DRIVE_FG_PCT")],
    by = "PLAYER_ID", suffixes = c("_agg", "_src")
  )
  ## Only check rows where FGA > 0 (denom non-zero)
  valid_rows <- as.numeric(merged_pct$DRIVE_FGA) > 0
  if (any(valid_rows)) {
    agg_pct <- merged_pct$DRIVE_FG_PCT_agg[valid_rows]
    src_pct <- as.numeric(merged_pct$DRIVE_FG_PCT_src[valid_rows])
    max_diff <- max(abs(agg_pct - src_pct), na.rm = TRUE)
    expect_lt(max_diff, 0.01,
              label = "recomputed DRIVE_FG_PCT within 0.01 of source for single season")
  }
})

## ===========================================================================
## 2. ADDITIVITY GATE — two-season aggregation
## ===========================================================================

test_that("additivity gate: two-season counts sum correctly", {
  skip_if(!file.exists(file.path(FIXTURE_DIR, "ptstats_drives_player_2223.rds")),
          "fixture not found")

  out <- hoopR:::.aggregate_tracking_frames(list(FRAME_2223, FRAME_2324), "PLAYER_ID")

  ## Players present in BOTH seasons
  players_both <- intersect(FRAME_2223$PLAYER_ID, FRAME_2324$PLAYER_ID)
  expect_true(length(players_both) > 0L,
              label = "there are players present in both fixture seasons")

  ## For each additive col, agg == A_val + B_val
  for (col in ADDITIVE_COLS) {
    a_sub <- FRAME_2223[FRAME_2223$PLAYER_ID %in% players_both,
                         c("PLAYER_ID", col)]
    b_sub <- FRAME_2324[FRAME_2324$PLAYER_ID %in% players_both,
                         c("PLAYER_ID", col)]
    ab   <- merge(a_sub, b_sub, by = "PLAYER_ID", suffixes = c("_a", "_b"))
    ab$expected <- as.numeric(ab[[paste0(col, "_a")]]) +
                   as.numeric(ab[[paste0(col, "_b")]])

    out_sub <- out[out$PLAYER_ID %in% players_both, c("PLAYER_ID", col)]
    merged  <- merge(out_sub, ab[, c("PLAYER_ID", "expected")], by = "PLAYER_ID")
    agg_vals <- as.numeric(merged[[col]])

    expect_equal(
      agg_vals, merged$expected,
      tolerance = 1e-6,
      label = paste0("additivity gate: ", col, " sums correctly across 2 seasons")
    )
  }
})

## ===========================================================================
## 3. ID-NOT-SUMMED GATE (keystone) — team_id / player_id are VALID ids
## ===========================================================================

test_that("ID-NOT-SUMMED gate: team_id and player_id are valid (not doubled)", {
  skip_if(!file.exists(file.path(FIXTURE_DIR, "ptstats_drives_player_2223.rds")),
          "fixture not found")

  out <- hoopR:::.aggregate_tracking_frames(list(FRAME_2223, FRAME_2324), "PLAYER_ID")

  ## All PLAYER_IDs in output must be in the union of both seasons
  valid_player_ids <- union(FRAME_2223$PLAYER_ID, FRAME_2324$PLAYER_ID)
  expect_true(
    all(out$PLAYER_ID %in% valid_player_ids),
    label = "PLAYER_ID-NOT-SUMMED: all output PLAYER_IDs are valid source IDs"
  )

  ## All TEAM_IDs in output must be in the union of both seasons
  valid_team_ids <- union(FRAME_2223$TEAM_ID, FRAME_2324$TEAM_ID)
  expect_true(
    all(out$TEAM_ID %in% valid_team_ids),
    label = "TEAM_ID-NOT-SUMMED: all output TEAM_IDs are valid source IDs (not doubled)"
  )

  ## Confirm no PLAYER_ID was doubled (sanity: no 2x real id)
  ##   A doubled id would be a numeric string that equals 2 × some valid id.
  ##   The easiest proxy: every output PLAYER_ID must appear in the valid set.
  ##   (The above union check already guarantees this, but we state it explicitly.)
  doubled_players <- out$PLAYER_ID[!out$PLAYER_ID %in% valid_player_ids]
  expect_true(length(doubled_players) == 0L,
              label = "no doubled (summed) PLAYER_IDs in output")

  doubled_teams <- out$TEAM_ID[!out$TEAM_ID %in% valid_team_ids]
  expect_true(length(doubled_teams) == 0L,
              label = "no doubled (summed) TEAM_IDs in output")
})

## ===========================================================================
## 4. NEVER-RAISE GATE — empty and 0-row inputs
## ===========================================================================

test_that("never-raise: empty list returns 0-row data.frame", {
  out <- hoopR:::.aggregate_tracking_frames(list(), "PLAYER_ID")
  expect_s3_class(out, "data.frame")
  expect_equal(nrow(out), 0L)
})

test_that("never-raise: list of 0-row frame returns 0-row data.frame", {
  empty_frame <- FRAME_2324[0L, ]
  out <- hoopR:::.aggregate_tracking_frames(list(empty_frame), "PLAYER_ID")
  expect_s3_class(out, "data.frame")
  expect_equal(nrow(out), 0L)
})

## ===========================================================================
## Live smoke test — gated by NBA_STATS_TESTS=1
## ===========================================================================

test_that("nba_tracking_aggregate works live (2 seasons)", {
  skip_nba_stats_test()

  out <- nba_tracking_aggregate(
    seasons         = c("2022-23", "2023-24"),
    per_mode        = "Totals",
    pt_measure_type = "Drives",
    player_or_team  = "Player"
  )

  expect_s3_class(out, "data.frame")
  expect_true(nrow(out) > 0L,
              label = "live nba_tracking_aggregate returns non-empty frame")
  expect_true("PLAYER_ID" %in% colnames(out),
              label = "PLAYER_ID present in live output")
  expect_true("DRIVES" %in% colnames(out),
              label = "DRIVES present in live output")
  expect_true("DRIVE_FG_PCT" %in% colnames(out),
              label = "DRIVE_FG_PCT present (recomputed) in live output")
  ## No non-recomputable *_PCT columns present
  dropped <- intersect(PCT_DROP_COLS, colnames(out))
  expect_true(length(dropped) == 0L,
              label = "non-recomputable *_PCT columns absent from live output")
})
