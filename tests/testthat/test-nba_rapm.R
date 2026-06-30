## Tests for .build_rapm_design — RAPM sparse design matrix builder.
##
## All tests run offline (no network calls).  `.build_rapm_design` is an
## internal unexported function; access it after devtools::load_all() via
## hoopR:::.build_rapm_design().

# ---------------------------------------------------------------------------
# Helper: construct a possessions data.frame from a list of row specs
# ---------------------------------------------------------------------------

.poss_df <- function(rows) {
  d <- list()
  for (i in 1:5) {
    d[[paste0("off_player_", i)]] <- vapply(rows, function(r) r$off[i], integer(1))
  }
  for (i in 1:5) {
    d[[paste0("def_player_", i)]] <- vapply(rows, function(r) r$def[i], integer(1))
  }
  d[["points"]] <- vapply(rows, function(r) r$pts, numeric(1))
  as.data.frame(d)
}

# ---------------------------------------------------------------------------
# Core encoding test — mirrors Python test_design_matrix_encoding
# ---------------------------------------------------------------------------

test_that(".build_rapm_design encodes offense/defense indicators correctly", {
  rows <- list(
    list(off = c(1L, 2L, 3L, 4L, 5L),    def = c(11L, 12L, 13L, 14L, 15L), pts = 2),
    list(off = c(11L, 12L, 13L, 14L, 15L), def = c(1L,  2L,  3L,  4L,  5L),  pts = 0)
  )
  des <- .build_rapm_design(.poss_df(rows))

  # player_ids: sorted distinct across all 10 lineup cols → c(1:5, 11:15), P=10
  expect_equal(des$player_ids, c(1L, 2L, 3L, 4L, 5L, 11L, 12L, 13L, 14L, 15L))
  P <- length(des$player_ids)
  expect_equal(P, 10L)

  # Matrix dimensions: 2 possessions × 2P columns
  expect_equal(dim(des$X), c(2L, 2L * P))

  # Convert to dense for hand-checking
  Xd <- as.matrix(des$X)

  # Named index: player_id -> column (1-based)
  idx <- setNames(seq_along(des$player_ids), as.character(des$player_ids))

  # Possession 1: players 1-5 on OFFENSE (cols 1..P), players 11-15 on DEFENSE (cols P+1..2P)
  for (p in as.character(1:5)) {
    expect_equal(Xd[1, idx[[p]]],       1,
                 label = paste0("poss1 offense player ", p, " col=", idx[[p]]))
  }
  for (p in as.character(11:15)) {
    expect_equal(Xd[1, P + idx[[p]]],   1,
                 label = paste0("poss1 defense player ", p, " col=", P + idx[[p]]))
  }

  # Possession 1: exactly 10 ones (5 offense + 5 defense), no bleed into wrong half
  expect_equal(sum(Xd[1, ]),            10)
  expect_equal(sum(Xd[1, 1:P]),          5)   # offense half
  expect_equal(sum(Xd[1, (P + 1):(2 * P)]), 5)  # defense half

  # Possession 2 (roles flipped): players 11-15 on offense, 1-5 on defense
  for (p in as.character(11:15)) {
    expect_equal(Xd[2, idx[[p]]],       1,
                 label = paste0("poss2 offense player ", p))
  }
  for (p in as.character(1:5)) {
    expect_equal(Xd[2, P + idx[[p]]],   1,
                 label = paste0("poss2 defense player ", p))
  }
  expect_equal(sum(Xd[2, ]), 10)

  # y vector
  expect_equal(des$y, c(2, 0))
})

# ---------------------------------------------------------------------------
# Empty input — never-raise, returns 0-by-0 matrix + empty player_ids
# ---------------------------------------------------------------------------

test_that(".build_rapm_design handles empty possessions without raising", {
  empty <- data.frame(
    off_player_1 = integer(0), off_player_2 = integer(0),
    off_player_3 = integer(0), off_player_4 = integer(0),
    off_player_5 = integer(0),
    def_player_1 = integer(0), def_player_2 = integer(0),
    def_player_3 = integer(0), def_player_4 = integer(0),
    def_player_5 = integer(0),
    points       = numeric(0)
  )

  des <- .build_rapm_design(empty)

  # Never raises
  expect_true(is.list(des))

  # player_ids empty
  expect_equal(length(des$player_ids), 0L)

  # y empty
  expect_equal(length(des$y), 0L)

  # X: 0 rows (Matrix sparseMatrix with 0×0 dims)
  expect_equal(nrow(des$X), 0L)
  expect_equal(ncol(des$X), 0L)
})

# ---------------------------------------------------------------------------
# NA lineup drop — possessions with any NA in the 10 lineup cols are dropped
# ---------------------------------------------------------------------------

test_that(".build_rapm_design drops possessions with NA lineup cells (never-raise)", {
  # Two possessions: first has NA in off_player_3; second is fully valid
  df <- data.frame(
    off_player_1 = c(NA_integer_, 1L),
    off_player_2 = c(2L,         2L),
    off_player_3 = c(3L,         3L),
    off_player_4 = c(4L,         4L),
    off_player_5 = c(5L,         5L),
    def_player_1 = c(11L,        11L),
    def_player_2 = c(12L,        12L),
    def_player_3 = c(13L,        13L),
    def_player_4 = c(14L,        14L),
    def_player_5 = c(15L,        15L),
    points       = c(2,           0)
  )

  des <- .build_rapm_design(df)

  # Only the fully-valid possession survives → 1 row
  expect_equal(nrow(des$X), 1L)
  expect_equal(length(des$y), 1L)

  # Points of the surviving possession = 0 (the second row)
  expect_equal(des$y, 0)

  # All-NA rows → empty result (never-raise)
  df_all_na <- data.frame(
    off_player_1 = NA_integer_, off_player_2 = NA_integer_,
    off_player_3 = NA_integer_, off_player_4 = NA_integer_,
    off_player_5 = NA_integer_,
    def_player_1 = NA_integer_, def_player_2 = NA_integer_,
    def_player_3 = NA_integer_, def_player_4 = NA_integer_,
    def_player_5 = NA_integer_,
    points       = NA_real_
  )
  des2 <- .build_rapm_design(df_all_na)
  expect_equal(length(des2$player_ids), 0L)
  expect_equal(nrow(des2$X), 0L)
})
