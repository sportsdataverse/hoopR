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
#' @return A single-row tibble.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       coach_id \tab character \tab ESPN coach identifier. \cr
#'       uid \tab character \tab ESPN UID string. \cr
#'       first_name \tab character \tab First name. \cr
#'       last_name \tab character \tab Last name. \cr
#'       date_of_birth \tab character \tab Date of birth (ISO 8601). \cr
#'       birth_city \tab character \tab Birth city. \cr
#'       birth_state \tab character \tab Birth state / region. \cr
#'       n_career_records \tab integer \tab Count of career-records entries. \cr
#'       n_coach_seasons \tab integer \tab Count of seasons coached. \cr
#'       college_ref \tab character \tab \verb{$ref} to the coach's college. \cr
#'       team_ref \tab character \tab \verb{$ref} to the coach's current team. \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_coach_record(coach_id = 52120, record_type = 2)
#' }
espn_nba_coach_record <- function(coach_id, record_type = 0L, ...) {
  .espn_basketball_coach_record(league = "nba",
                                  coach_id = coach_id,
                                  record_type = record_type, ...)
}
