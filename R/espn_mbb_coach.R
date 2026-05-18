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
#'   espn_mbb_coach(coach_id = 269)
#' }
espn_mbb_coach <- function(coach_id, ...) {
  .espn_basketball_coach(league = "mens-college-basketball",
                          coach_id = coach_id, ...)
}
