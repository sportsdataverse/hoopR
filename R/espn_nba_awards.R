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
#' The index only contains IDs and `$ref` URLs — pass an ID to
#' [espn_nba_award()] for the award name, description, and winners.
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per award.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season year. \cr
#'       award_id \tab character \tab ESPN award identifier. \cr
#'       ref \tab character \tab Full \verb{$ref} URL for the award detail. \cr
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
#' @return A tibble with one row per winner.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'       season \tab integer \tab Season year. \cr
#'       award_id \tab character \tab ESPN award identifier. \cr
#'       name \tab character \tab Award name (e.g. "MVP"). \cr
#'       description \tab character \tab Award description. \cr
#'       athlete_id \tab character \tab ESPN athlete id of winner (parsed from \code{athlete_ref}). \cr
#'       team_id \tab character \tab ESPN team id (parsed from \code{team_ref}). \cr
#'       athlete_ref \tab character \tab \verb{$ref} to winner's per-season athlete resource. \cr
#'       team_ref \tab character \tab \verb{$ref} to winner's per-season team resource. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
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
