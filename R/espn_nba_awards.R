# espn_nba_awards.R
# Public NBA shims for ESPN season-awards endpoints.

# ---------------------------------------------------------------------------
# espn_nba_season_awards
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Awards Index**
#' @name espn_nba_season_awards
NULL
#' @title
#' **Get ESPN NBA Season Awards Index**
#' @rdname espn_nba_season_awards
#' @author Saiem Gilani
#' @description
#' Returns the list of award IDs given out in an NBA season from
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/awards`.
#' The index only contains IDs and `$ref` URLs — pass an ID to
#' [espn_nba_award()] for the award name, description, and winners.
#'
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per award.
#'
#'    |col_name |types     |description                            |
#'    |:--------|:---------|:--------------------------------------|
#'    |season   |integer   |Season year.                           |
#'    |award_id |character |ESPN award identifier.                 |
#'    |ref      |character |Full `$ref` URL for the award detail.  |
#'    |league   |character |League slug (`"nba"`).                 |
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
#' @name espn_nba_award
NULL
#' @title
#' **Get ESPN NBA Season Award Detail**
#' @rdname espn_nba_award
#' @author Saiem Gilani
#' @description
#' Returns the name, description, and winners of one NBA season award.
#' Most awards have a single winner; multi-recipient awards (e.g. All-NBA
#' First Team) return one row per winner.
#'
#' @param award_id ESPN award identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per winner.
#'
#'    |col_name    |types     |description                                              |
#'    |:-----------|:---------|:--------------------------------------------------------|
#'    |league      |character |League slug (`"nba"`).                                   |
#'    |season      |integer   |Season year.                                             |
#'    |award_id    |character |ESPN award identifier.                                   |
#'    |name        |character |Award name (e.g. "MVP").                                 |
#'    |description |character |Award description.                                       |
#'    |athlete_id  |character |ESPN athlete id of winner (parsed from `athlete_ref`).   |
#'    |team_id     |character |ESPN team id (parsed from `team_ref`).                   |
#'    |athlete_ref |character |`$ref` to winner's per-season athlete resource.          |
#'    |team_ref    |character |`$ref` to winner's per-season team resource.             |
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
