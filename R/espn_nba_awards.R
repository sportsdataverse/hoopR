# espn_nba_awards.R
# Public NBA shims for ESPN season-awards endpoints.

# ---------------------------------------------------------------------------
# espn_nba_season_awards
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Awards Index**
#' @rdname espn_mbb_season_awards
#' @name espn_nba_season_awards
NULL
#' @title
#' **Get ESPN NBA Season Awards Index**
#' @rdname espn_mbb_season_awards
#' @author Saiem Gilani
#' @description
#' Returns the list of award IDs given out in an NBA season from
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/awards`.
#' The index only contains IDs and `$ref` URLs - pass an ID to
#' [espn_nba_award()] for the award name, description, and winners.
#'
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_season_awards", unit = "award")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_nba_season_awards(season = 2024)
#' }
espn_nba_season_awards <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_season_awards(league = "nba", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_award
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Award Detail**
#' @rdname espn_mbb_award
#' @name espn_nba_award
NULL
#' @title
#' **Get ESPN NBA Season Award Detail**
#' @rdname espn_mbb_award
#' @author Saiem Gilani
#' @description
#' Returns the name, description, and winners of one NBA season award.
#' Most awards have a single winner; multi-recipient awards (e.g. All-NBA
#' First Team) return one row per winner.
#'
#' @param award_id ESPN award identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_award", unit = "winner")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   # MVP award id = 33
#'   espn_nba_award(award_id = 33, season = 2024)
#' }
espn_nba_award <- function(award_id,
                            season = most_recent_nba_season(),
                            ...) {
  .espn_basketball_award(
    league   = "nba",
    season   = season,
    award_id = award_id,
    ...
  )
}
