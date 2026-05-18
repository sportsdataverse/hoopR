# espn_nba_team_record.R

#' **Get ESPN NBA Team Record (Per Season Type)**
#' @name espn_nba_team_record
NULL
#' @title
#' **Get ESPN NBA Team Record (Per Season Type)**
#' @rdname espn_nba_team_record
#' @author Saiem Gilani
#' @description
#' Returns the long-format record breakdown for an NBA team in one season
#' and season-type. Each row is one record type (Overall, Home, Road,
#' vs Conference, vs Division, etc.). Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/types/{season_type}/teams/{team_id}/record`.
#'
#' @param team_id ESPN team identifier.
#' @param season Season year (numeric). Defaults to most recent NBA season.
#' @param season_type Integer (2 = regular season default; 3 = postseason).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per record category.
#'
#'    |col_name           |types     |description                                |
#'    |:------------------|:---------|:------------------------------------------|
#'    |league             |character |League slug (`"nba"`).                     |
#'    |team_id            |character |ESPN team identifier.                      |
#'    |season             |integer   |Season year.                               |
#'    |season_type        |integer   |Season type (1/2/3).                       |
#'    |record_id          |character |Record sub-id.                             |
#'    |name               |character |Internal record name (e.g. "overall").     |
#'    |abbreviation       |character |Abbreviation (e.g. "Total").               |
#'    |display_name       |character |Display name (e.g. "Overall").             |
#'    |short_display_name |character |Short display (e.g. "OVER").               |
#'    |description        |character |Description (e.g. "Overall Record").       |
#'    |type               |character |Record type code (`total`, `home`, ...).   |
#'    |summary            |character |W-L summary (e.g. "50-32").                |
#'    |display_value      |character |Same as summary in most cases.             |
#'    |value              |numeric   |Win percentage (0-1).                      |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team_record(team_id = 13, season = 2025)
#' }
espn_nba_team_record <- function(team_id,
                                  season = most_recent_nba_season(),
                                  season_type = 2L, ...) {
  .espn_basketball_team_record(league = "nba", team_id = team_id,
                                 season = season,
                                 season_type = season_type, ...)
}
