# espn_mbb_positions.R
# Public NBA shims for the ESPN position dictionary.

# ---------------------------------------------------------------------------
# espn_mbb_positions
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Positions Index**
#' @name espn_mbb_positions
NULL
#' @title
#' **Get ESPN MBB Positions Index**
#' @rdname espn_mbb_positions
#' @author Saiem Gilani
#' @description
#' Returns the MBB position dictionary index. One row per position with
#' its id and the canonical `$ref` URL — pass an id to
#' [espn_mbb_position()] for full details (display name, abbreviation,
#' leaf flag, parent link).
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per position.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_positions()
#' }
espn_mbb_positions <- function(...) {
  .espn_basketball_positions(league = "mens-college-basketball", ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_position
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Position Detail**
#' @name espn_mbb_position
NULL
#' @title
#' **Get ESPN MBB Position Detail**
#' @rdname espn_mbb_position
#' @author Saiem Gilani
#' @description
#' Returns metadata for a single MBB position. Useful for dereferencing
#' position `$ref` URLs embedded in athlete records, and for navigating
#' parent/leaf relationships in the position taxonomy.
#'
#' @param position_id ESPN position identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_position(position_id = 1)
#' }
espn_mbb_position <- function(position_id, ...) {
  .espn_basketball_position(league = "mens-college-basketball",
                              position_id = position_id, ...)
}
