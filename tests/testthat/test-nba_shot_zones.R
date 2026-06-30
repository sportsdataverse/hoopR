## Tests for NBA shot-zone classification helpers and public API.
##
## These test the internal (unexported) .add_shot_zones() helper — accessible
## via hoopR:::.add_shot_zones() after devtools::load_all() — and a live-gated
## smoke test for nba_shot_zones().
##
## Classification contract mirrors sdv-py add_shot_zones() (Phase 6d port):
##   FG rows: event_type %in% c("1", "2")
##   Rule 1: NOT FG → NA
##   Rule 2: shot_value == 3 & abs(x_legacy) >= 220 & y_legacy <= 87.5 → "corner_3"
##   Rule 3: shot_value == 3 (other) → "above_the_break_3"
##   Rule 4: shot_distance < 4 → "restricted_area"
##   Rule 5: shot_distance < 8 & abs(x_legacy) <= 80 → "in_the_paint_non_ra"
##   Rule 6: else → "mid_range"

# ---------------------------------------------------------------------------
# Classification unit test (hand-checkable, one row per zone + non-FG)
# ---------------------------------------------------------------------------

test_that(".add_shot_zones classifies all zones correctly", {
  # Build minimal fixture — only columns required by .add_shot_zones
  df <- data.frame(
    event_type    = c("1",   "2",    "1",  "1",   "2",   "3"),
    shot_value    = c(3L,    3L,     2L,   2L,    2L,    0L),
    x_legacy      = c(230,   50,     10,   40,    100,   NA_real_),
    y_legacy      = c(50,    250,    10,   60,    150,   NA_real_),
    shot_distance = c(24,    26,     2,    6,     15,    NA_real_),
    stringsAsFactors = FALSE
  )

  result <- .add_shot_zones(df)

  expect_true("shot_zone" %in% colnames(result),
              label = "shot_zone column present in result")

  # Row 1: corner_3 — shot_value=3, abs(x_legacy)=230 >= 220, y_legacy=50 <= 87.5
  expect_equal(result$shot_zone[1], "corner_3",
               label = "corner_3: abs(x)=230 >= 220 & y=50 <= 87.5")

  # Row 2: above_the_break_3 — shot_value=3, abs(x_legacy)=50 < 220
  expect_equal(result$shot_zone[2], "above_the_break_3",
               label = "above_the_break_3: shot_value=3 but abs(x)=50 < 220")

  # Row 3: restricted_area — shot_distance=2 < 4
  expect_equal(result$shot_zone[3], "restricted_area",
               label = "restricted_area: shot_distance=2 < 4")

  # Row 4: in_the_paint_non_ra — shot_distance=6 < 8, abs(x_legacy)=40 <= 80
  expect_equal(result$shot_zone[4], "in_the_paint_non_ra",
               label = "in_the_paint_non_ra: dist=6<8 & abs(x)=40<=80")

  # Row 5: mid_range — shot_distance=15 >= 8 (falls through all 2PT rules)
  expect_equal(result$shot_zone[5], "mid_range",
               label = "mid_range: shot_distance=15, not corner/ra/paint")

  # Row 6: non-FG (event_type="3", FreeThrow) → NA
  expect_true(is.na(result$shot_zone[6]),
              label = "non-FG row (event_type=3) → NA shot_zone")
})

# ---------------------------------------------------------------------------
# Corner-3 boundary — abs(x_legacy) exactly at threshold (negative x)
# ---------------------------------------------------------------------------

test_that(".add_shot_zones handles negative x_legacy (left corner) correctly", {
  df <- data.frame(
    event_type    = c("1",   "2",   "1"),
    shot_value    = c(3L,    3L,    3L),
    x_legacy      = c(-220,  -219,  -221),
    y_legacy      = c(50,    50,    50),
    shot_distance = c(22,    22,    22),
    stringsAsFactors = FALSE
  )
  result <- .add_shot_zones(df)

  # abs(x)=220 >= 220 & y=50 <= 87.5 → corner_3
  expect_equal(result$shot_zone[1], "corner_3",
               label = "abs(x)=220 is at threshold → corner_3")
  # abs(x)=219 < 220 → above_the_break_3
  expect_equal(result$shot_zone[2], "above_the_break_3",
               label = "abs(x)=219 < threshold → above_the_break_3")
  # abs(x)=221 >= 220 → corner_3
  expect_equal(result$shot_zone[3], "corner_3",
               label = "abs(x)=221 > threshold → corner_3")
})

# ---------------------------------------------------------------------------
# Fixture partition test — load pbp_0022200001.rds, check coverage invariants
# ---------------------------------------------------------------------------

test_that(".add_shot_zones partitions all FG rows to exactly one zone (fixture)", {
  pbp <- readRDS(test_path("fixtures", "nba_engine", "pbp_0022200001.rds"))

  result <- .add_shot_zones(pbp)

  # shot_zone column must be present
  expect_true("shot_zone" %in% colnames(result),
              label = "shot_zone column present after .add_shot_zones on fixture")

  is_fg     <- result$event_type %in% c("1", "2")
  fg_zones  <- result$shot_zone[is_fg]
  nonfg_zones <- result$shot_zone[!is_fg]

  # Every FG row → non-NA zone
  expect_true(all(!is.na(fg_zones)),
              label = "every FG row has a non-NA shot_zone")

  # Every non-FG row → NA zone
  expect_true(all(is.na(nonfg_zones)),
              label = "every non-FG row has NA shot_zone")

  # Count of non-NA shot_zone rows == count of FG rows (1:1 partition)
  expect_equal(sum(!is.na(result$shot_zone)), sum(is_fg),
               label = "non-NA shot_zone count equals FG row count")

  # All shot_zone values are in the valid set
  valid_zones <- c("corner_3", "above_the_break_3",
                   "restricted_area", "in_the_paint_non_ra", "mid_range")
  expect_true(all(fg_zones %in% valid_zones),
              label = "all shot_zone values are in the 5-zone canonical set")

  # Zone distribution sanity: each zone appears at least once in a ~162-FGA game
  # (real game data — at least restricted_area, mid_range, above_the_break_3 expected)
  expect_true(length(unique(fg_zones)) >= 3L,
              label = "at least 3 distinct zones appear in a full game")
})

# ---------------------------------------------------------------------------
# Empty / never-raise test
# ---------------------------------------------------------------------------

test_that(".add_shot_zones never-raises on 0-row input", {
  pbp   <- readRDS(test_path("fixtures", "nba_engine", "pbp_0022200001.rds"))
  empty <- head(pbp, 0)

  result <- .add_shot_zones(empty)

  # Should return 0-row frame (not error)
  expect_equal(nrow(result), 0L,
               label = "0-row result from empty input")

  # shot_zone column must be present even on empty input
  expect_true("shot_zone" %in% colnames(result),
              label = "shot_zone column present on 0-row result")

  # Column should be character type
  expect_true(is.character(result$shot_zone),
              label = "shot_zone column is character type on empty result")
})

# ---------------------------------------------------------------------------
# nba_shot_zones() — gated live test (NBA_STATS_TESTS=1)
# ---------------------------------------------------------------------------

test_that("nba_shot_zones() returns a valid shot-zone frame (live)", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()
  df <- nba_shot_zones(game_id = "0022200001")
  skip_if(nrow(df) == 0, "nba_shot_zones returned empty frame (live API unavailable)")
  expect_true(nrow(df) > 0,
              label = "nba_shot_zones returns non-empty frame")
  expect_true("shot_zone" %in% colnames(df),
              label = "shot_zone column present in live result")
  valid_zones <- c("corner_3", "above_the_break_3",
                   "restricted_area", "in_the_paint_non_ra", "mid_range")
  # Non-NA shot_zone values must all be in the valid zone set
  nonna_zones <- df$shot_zone[!is.na(df$shot_zone)]
  expect_true(all(nonna_zones %in% valid_zones),
              label = "all non-NA live shot_zone values are in the valid zone set")
  # At least some FG rows are present and classified
  expect_true(length(nonna_zones) > 0,
              label = "nba_shot_zones classifies at least one FG in a real game")
  Sys.sleep(3)
})
