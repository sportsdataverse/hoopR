# espn_nba_coach.R

#' **Get ESPN NBA Single-Coach Detail**
#' @rdname espn_mbb_coach
#' @name espn_nba_coach
NULL
#' @title
#' **Get ESPN NBA Single-Coach Detail**
#' @rdname espn_mbb_coach
#' @author Saiem Gilani
#' @description
#' Returns biography, current team / college refs, and counts of career
#' record entries + per-season coaching entries for one NBA coach. Backed
#' by `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/coaches/{coach_id}`.
#'
#' @param coach_id ESPN coach identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_coach", unit = "coach")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_nba_coach(coach_id = 52120)
#' }
espn_nba_coach <- function(coach_id, ...) {
  .espn_basketball_coach(league = "nba", coach_id = coach_id, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_coach_record
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Coach Career Record (Long Format)**
#' @rdname espn_mbb_coach_record
#' @name espn_nba_coach_record
NULL
#' @title
#' **Get ESPN NBA Coach Career Record (Long Format)**
#' @rdname espn_mbb_coach_record
#' @author Saiem Gilani
#' @description
#' Returns a coach's career record by type in long format (one row per
#' stat in the record's `stats[]` array). `record_type` codes commonly
#' populated: 0 = Total, 1 = Pre Season, 2 = Regular Season, 3 = Post
#' Season. Use [espn_nba_coaches()] to discover coach_ids for a season.
#'
#' @param record_type Integer record type: 0 = Total (default), 1 = Pre Season,
#'   2 = Regular Season, 3 = Post Season.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble.
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_nba_coach_record(coach_id = 52120, record_type = 2)
#' }
espn_nba_coach_record <- function(coach_id, record_type = 0L, ...) {
  .espn_basketball_coach_record(league = "nba",
                                  coach_id = coach_id,
                                  record_type = record_type, ...)
}
