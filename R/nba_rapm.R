# ---------------------------------------------------------------------------
# NBA RAPM — Regularized Adjusted Plus-Minus
#
# R port of sportsdataverse-py sportsdataverse/nba/nba_rapm.py::build_rapm_design.
# Task 1: sparse design matrix builder (.build_rapm_design, internal @noRd).
# Task 2: glmnet ridge fit (nba_rapm — TODO).
# Task 3: DESCRIPTION deps + public export (TODO).
# ---------------------------------------------------------------------------

# Column name vectors (mirrors Python _OFF / _DEF)
.RAPM_OFF_COLS <- paste0("off_player_", 1:5)
.RAPM_DEF_COLS <- paste0("def_player_", 1:5)
.RAPM_LINEUP_COLS <- c(.RAPM_OFF_COLS, .RAPM_DEF_COLS)


#' Build a sparse RAPM design matrix from a possession data frame.
#'
#' Internal helper.  Column layout:
#'   * cols 1..P   — offense indicator: 1 when player_ids[i] was on offense.
#'   * cols P+1..2P — defense indicator: 1 when player_ids[i] was on defense.
#'
#' Possessions with any NA in the 10 lineup cells are silently dropped
#' (never-raise; a partial lineup is unreliable for RAPM).
#'
#' @param possessions data.frame with columns off_player_1..5,
#'   def_player_1..5 (integer player ids) and points (numeric).
#' @return A named list with:
#'   * `X` — `Matrix::dgCMatrix` of shape (n_poss, 2P).
#'   * `y` — numeric vector of length n_poss (possession points).
#'   * `player_ids` — integer vector of length P: sorted distinct player ids.
#' @noRd
.build_rapm_design <- function(possessions) {
  # Empty frame → return 0×0 sparse matrix + empty vectors (never-raise)
  if (nrow(possessions) == 0L) {
    return(list(
      X          = Matrix::sparseMatrix(i = integer(0), j = integer(0),
                                        dims = c(0L, 0L)),
      y          = numeric(0),
      player_ids = integer(0)
    ))
  }

  # Drop possessions with any NA in the 10 lineup cells (never inject a
  # phantom id — mirrors Python possessions.drop_nulls(subset=_OFF + _DEF))
  lineup_mat <- as.matrix(possessions[, .RAPM_LINEUP_COLS])
  complete   <- rowSums(is.na(lineup_mat)) == 0L
  possessions <- possessions[complete, , drop = FALSE]

  if (nrow(possessions) == 0L) {
    return(list(
      X          = Matrix::sparseMatrix(i = integer(0), j = integer(0),
                                        dims = c(0L, 0L)),
      y          = numeric(0),
      player_ids = integer(0)
    ))
  }

  # Rebuild lineup matrix after drop
  lineup_mat <- as.matrix(possessions[, .RAPM_LINEUP_COLS])
  off_mat    <- lineup_mat[, 1:5,  drop = FALSE]  # cols 1-5  = offense
  def_mat    <- lineup_mat[, 6:10, drop = FALSE]  # cols 6-10 = defense

  # Sorted distinct player ids across all 10 lineup slots
  all_ids    <- as.integer(lineup_mat)
  player_ids <- sort(unique(all_ids[!is.na(all_ids)]))
  P          <- length(player_ids)
  n          <- nrow(possessions)

  # Build index: player_id -> 1-based column position (1..P)
  pid_idx <- integer(max(player_ids) + 1L)
  for (k in seq_along(player_ids)) {
    pid_idx[player_ids[k] + 1L] <- k
  }

  # Accumulate (row_i, col_j) pairs for sparseMatrix
  # Offense: col = pid_idx[id]        (1..P)
  # Defense: col = P + pid_idx[id]    (P+1..2P)
  row_idx <- integer(n * 10L)
  col_idx <- integer(n * 10L)
  cursor  <- 0L

  for (r in seq_len(n)) {
    for (k in 1:5) {
      cursor <- cursor + 1L
      row_idx[cursor] <- r
      col_idx[cursor] <- pid_idx[off_mat[r, k] + 1L]           # offense col
    }
    for (k in 1:5) {
      cursor <- cursor + 1L
      row_idx[cursor] <- r
      col_idx[cursor] <- P + pid_idx[def_mat[r, k] + 1L]       # defense col
    }
  }

  X <- Matrix::sparseMatrix(
    i    = row_idx,
    j    = col_idx,
    x    = 1.0,
    dims = c(n, 2L * P)
  )

  y <- as.numeric(possessions[["points"]])

  list(X = X, y = y, player_ids = player_ids)
}
