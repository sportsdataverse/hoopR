# espn_mbb_awards.R
# Public MBB shims for ESPN season-awards endpoints.

# ---------------------------------------------------------------------------
# espn_mbb_season_awards
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Awards Index**
#' @name espn_mbb_season_awards
NULL
#' @title
#' **Get ESPN MBB Season Awards Index**
#' @rdname espn_mbb_season_awards
#' @author Saiem Gilani
#' @description
#' Returns the list of award IDs given out in an MBB season from
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/{season}/awards`.
#' The index only contains IDs and `$ref` URLs — pass an ID to
#' [espn_mbb_award()] for the award name, description, and winners.
#'
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per award.
#'
#'    |col_name |types     |description                                |
#'    |:--------|:---------|:------------------------------------------|
#'    |season   |integer   |Season year.                               |
#'    |award_id |character |ESPN award identifier.                     |
#'    |ref      |character |Full `$ref` URL for the award detail.      |
#'    |league   |character |League slug (`"mens-college-basketball"`). |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_awards(season = 2024)
#' }
espn_mbb_season_awards <- function(season = most_recent_mbb_season(), ...) {
  .espn_basketball_season_awards(league = "mens-college-basketball",
                                  season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_award
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Award Detail**
#' @name espn_mbb_award
NULL
#' @title
#' **Get ESPN MBB Season Award Detail**
#' @rdname espn_mbb_award
#' @author Saiem Gilani
#' @description
#' Returns the name, description, and winners of one MBB season award.
#'
#' @param award_id ESPN award identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per winner.
#'
#'    |col_name    |types     |description                                              |
#'    |:-----------|:---------|:--------------------------------------------------------|
#'    |league      |character |League slug.                                             |
#'    |season      |integer   |Season year.                                             |
#'    |award_id    |character |ESPN award identifier.                                   |
#'    |name        |character |Award name.                                              |
#'    |description |character |Award description.                                       |
#'    |athlete_id  |character |ESPN athlete id of winner.                               |
#'    |team_id     |character |ESPN team id.                                            |
#'    |athlete_ref |character |`$ref` to winner's per-season athlete resource.          |
#'    |team_ref    |character |`$ref` to winner's per-season team resource.             |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_award(award_id = 33, season = 2024)
#' }
espn_mbb_award <- function(award_id,
                            season = most_recent_mbb_season(),
                            ...) {
  .espn_basketball_award(
    league   = "mens-college-basketball",
    season   = season,
    award_id = award_id,
    ...
  )
}
