# espn_mbb_coach.R

#' **Get ESPN MBB Single-Coach Detail**
#' @name espn_mbb_coach
NULL
#' @title
#' **Get ESPN MBB Single-Coach Detail**
#' @rdname espn_mbb_coach
#' @author Saiem Gilani
#' @description
#' Returns biography, current team / college refs, and counts of career
#' record entries + per-season coaching entries for one MBB head coach.
#'
#' @param coach_id ESPN coach identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble. See [espn_nba_coach()] for column schema.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_coach(coach_id = 32116)
#' }
espn_mbb_coach <- function(coach_id, ...) {
  .espn_basketball_coach(league = "mens-college-basketball",
                          coach_id = coach_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_coach_record
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Coach Career Record (Long Format)**
#' @name espn_mbb_coach_record
NULL
#' @title
#' **Get ESPN MBB Coach Career Record (Long Format)**
#' @rdname espn_mbb_coach_record
#' @author Saiem Gilani
#' @description
#' Returns a coach's career record by type in long format (one row per
#' stat in the record's `stats[]` array). `record_type` codes commonly
#' populated: 0 = Total, 1 = Pre Season, 2 = Regular Season, 3 = Post
#' Season. Use [espn_mbb_coaches()] to discover coach_ids for a season.
#'
#' @param coach_id ESPN coach identifier (use [espn_mbb_coaches()] to find).
#' @param record_type Integer record type: 0 = Total (default), 1 = Pre Season,
#'   2 = Regular Season, 3 = Post Season.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_coach_record(coach_id = 32116, record_type = 2)
#' }
espn_mbb_coach_record <- function(coach_id, record_type = 0L, ...) {
  .espn_basketball_coach_record(league = "mens-college-basketball",
                                  coach_id = coach_id,
                                  record_type = record_type, ...)
}
