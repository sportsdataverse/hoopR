# espn_nba_positions.R
# Public NBA shims for the ESPN position dictionary.

# ---------------------------------------------------------------------------
# espn_nba_positions
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Positions Index**
#' @rdname espn_mbb_positions
#' @name espn_nba_positions
NULL
#' @title
#' **Get ESPN NBA Positions Index**
#' @rdname espn_mbb_positions
#' @author Saiem Gilani
#' @description
#' Returns the NBA position dictionary index. One row per position with
#' its id and the canonical `$ref` URL — pass an id to
#' [espn_nba_position()] for full details (display name, abbreviation,
#' leaf flag, parent link).
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per position.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_positions()
#' }
espn_nba_positions <- function(...) {
  .espn_basketball_positions(league = "nba", ...)
}

# ---------------------------------------------------------------------------
# espn_nba_position
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Position Detail**
#' @rdname espn_mbb_position
#' @name espn_nba_position
NULL
#' @title
#' **Get ESPN NBA Position Detail**
#' @rdname espn_mbb_position
#' @author Saiem Gilani
#' @description
#' Returns metadata for a single NBA position. Useful for dereferencing
#' position `$ref` URLs embedded in athlete records, and for navigating
#' parent/leaf relationships in the position taxonomy.
#'
#' @param position_id ESPN position identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_position(position_id = 1)
#' }
espn_nba_position <- function(position_id, ...) {
  .espn_basketball_position(league = "nba",
                              position_id = position_id, ...)
}
