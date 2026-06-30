# ---------------------------------------------------------------------------
# NBA RAPM — Regularized Adjusted Plus-Minus
#
# R port of sportsdataverse-py sportsdataverse/nba/nba_rapm.py::build_rapm_design.
# Task 1: sparse design matrix builder (.build_rapm_design, internal @noRd).
# Task 2: glmnet ridge fit (nba_rapm — done).
# Task 3: DESCRIPTION deps + public export (TODO).
# ---------------------------------------------------------------------------

# Schema for the 0-row empty sentinel (6 columns, correct types).
# Routed through the standard hoopR pipeline so the empty return also
# carries the hoopR_data class and attributes.
.rapm_empty_frame <- function() {
  data.frame(
    player_id = integer(0),
    o_rapm    = numeric(0),
    d_rapm    = numeric(0),
    rapm      = numeric(0),
    off_poss  = integer(0),
    def_poss  = integer(0)
  ) |>
    dplyr::as_tibble() |>
    janitor::clean_names() |>
    make_hoopR_data("NBA RAPM", Sys.time())
}

#' **Fit a Ridge-Regression RAPM Model from Possession Data**
#' @name nba_rapm
NULL
#' @title
#' **Fit a Ridge-Regression RAPM Model from Possession Data**
#' @rdname nba_rapm
#' @author Saiem Gilani
#' @param possessions A possession-level stint matrix as produced by
#'   \code{nba_possession_lineups()}, with columns \code{off_player_1} through
#'   \code{off_player_5}, \code{def_player_1} through \code{def_player_5}
#'   (integer NBA Stats person IDs), and \code{points} (numeric, points scored
#'   on that possession).
#' @param ... Reserved for future keyword arguments (currently ignored).
#' @return Returns a \code{data.frame} with one row per player:
#'
#'    |col_name   |types   |description                                                                                                                                   |
#'    |:----------|:-------|:---------------------------------------------------------------------------------------------------------------------------------------------|
#'    |player_id  |integer |NBA Stats person ID. Rows are sorted ascending by player_id.                                                                                 |
#'    |o_rapm     |numeric |Offensive RAPM (per-100-possession points added on offense). Positive = better offensive player.                                              |
#'    |d_rapm     |numeric |Defensive RAPM (per-100-possession points saved on defense). Positive = better defensive player (sign is flipped so good defense is positive).|
#'    |rapm       |numeric |Total RAPM = o_rapm + d_rapm. Positive = net positive impact.                                                                                |
#'    |off_poss   |integer |Number of possessions the player appeared on offense.                                                                                        |
#'    |def_poss   |integer |Number of possessions the player appeared on defense.                                                                                        |
#'
#'   Returns a 0-row frame with the same schema when input is empty or all
#'   possessions have NA lineup cells (never-raise).
#'
#'   **Note:** RAPM is expressed in per-100-possession units. A **full season**
#'   of possessions (~5,000–8,000) is needed for statistically meaningful
#'   estimates. Results from a single game (~150–250 possessions) are highly
#'   unstable and are provided here for pipeline illustration only.
#'
#'   Results are **deterministic**: the cross-validation uses fixed,
#'   construction-based folds (not random), so repeated calls on the same
#'   possessions return identical output with no need to set a seed.
#' @keywords NBA Lineup Functions
#' @family NBA Lineup Functions
#' @export
#' @details
#' ```r
#'  poss <- nba_possession_lineups(game_id = "0022200001")
#'  nba_rapm(poss)
#' ```
nba_rapm <- function(possessions, ...) {
  # Build sparse design (handles empty / all-NA → 0-player sentinel)
  des <- .build_rapm_design(possessions)

  P          <- length(des$player_ids)
  player_ids <- des$player_ids

  # Empty design → 0-row frame with correct schema (never-raise)
  if (P == 0L) {
    return(.rapm_empty_frame())
  }

  X <- des$X
  y <- des$y

  # Possession counts = column sums of the design matrix
  cs       <- Matrix::colSums(X)
  off_poss <- as.integer(cs[seq_len(P)])
  def_poss <- as.integer(cs[seq(P + 1L, 2L * P)])

  # Ridge regression: alpha = 0, no intercept, CV selects lambda.min.
  # Deterministic CV folds (no RNG dependence): assign every k-th possession
  # to a different fold so consecutive possessions are spread across folds.
  # This makes nba_rapm() reproducible by construction — identical output on
  # every call without the caller needing set.seed().
  n  <- nrow(X)
  nf <- min(10L, n)                       # 10-fold, or fewer if tiny n

  # Guard: cv.glmnet requires at least 3 unique folds.  For degenerate
  # small inputs (n < 3) fall back to a plain glmnet at a fixed lambda
  # so the function never errors.
  if (n < 3L) {
    fit0 <- glmnet::glmnet(X, y, alpha = 0, intercept = FALSE, lambda = 0.1)
    cf   <- as.numeric(stats::coef(fit0))
    coef <- cf[-1L]
  } else {
    foldid <- ((seq_len(n) - 1L) %% nf) + 1L
    fit    <- glmnet::cv.glmnet(X, y, alpha = 0, intercept = FALSE, foldid = foldid)

    # Extract coefficient vector at lambda.min (length 1 + 2P from glmnet;
    # position 1 is the intercept placeholder even with intercept=FALSE).
    # Use stats::coef S3 dispatch — glmnet registers coef.cv.glmnet internally.
    cf   <- as.numeric(stats::coef(fit, s = "lambda.min"))
    coef <- cf[-1L]  # drop intercept slot → length 2P
  }

  # Sign conventions (matches Python nba_rapm):
  #   o_rapm = coef[1..P]      * 100
  #   d_rapm = -coef[P+1..2P] * 100   (negate: good defender reduces pts)
  #   rapm   = o_rapm + d_rapm
  o_rapm <- coef[seq_len(P)]             * 100
  d_rapm <- -coef[seq(P + 1L, 2L * P)]  * 100
  rapm   <- o_rapm + d_rapm

  # Assemble output sorted by player_id
  ord <- order(player_ids)
  data.frame(
    player_id = player_ids[ord],
    o_rapm    = o_rapm[ord],
    d_rapm    = d_rapm[ord],
    rapm      = rapm[ord],
    off_poss  = off_poss[ord],
    def_poss  = def_poss[ord],
    stringsAsFactors = FALSE
  ) |>
    dplyr::as_tibble() |>
    janitor::clean_names() |>
    make_hoopR_data("NBA RAPM", Sys.time())
}

# Column name vectors (mirrors Python _OFF / _DEF)
.RAPM_OFF_COLS <- paste0("off_player_", 1:5)
.RAPM_DEF_COLS <- paste0("def_player_", 1:5)
.RAPM_LINEUP_COLS <- c(.RAPM_OFF_COLS, .RAPM_DEF_COLS)


#' Build a sparse RAPM design matrix from a possession data frame.
#'
#' Internal helper.  Column layout:
#'   * cols 1..P   — offense indicator: 1 when player_ids\[i\] was on offense.
#'   * cols P+1..2P — defense indicator: 1 when player_ids\[i\] was on defense.
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

  # Vectorized dense mapping: player_id -> 1-based column position (1..P).
  # match() is O(P) and safe regardless of the numeric magnitude of NBA
  # person_ids — no max(player_ids)+1 allocation needed.
  #
  # off_mat is n×5 (column-major in R); as.vector() reads column-major,
  # so the row index that repeats 1..n five times is rep(seq_len(n), 5L).
  # def_mat same shape → defense cols are P + match(id, player_ids).
  off_col <- match(as.integer(as.vector(off_mat)), player_ids)
  def_col <- P + match(as.integer(as.vector(def_mat)), player_ids)

  row_off <- rep(seq_len(n), times = 5L)
  row_def <- rep(seq_len(n), times = 5L)

  row_idx <- c(row_off, row_def)
  col_idx <- c(off_col, def_col)

  X <- Matrix::sparseMatrix(
    i    = row_idx,
    j    = col_idx,
    x    = 1.0,
    dims = c(n, 2L * P)
  )

  y <- as.numeric(possessions[["points"]])

  list(X = X, y = y, player_ids = player_ids)
}
