# espn_nba_powerindex.R

#' **Get ESPN NBA Season Power Index (Long Format)**
#' @name espn_nba_powerindex
NULL
#' @title
#' **Get ESPN NBA Season Power Index (Long Format)**
#' @rdname espn_nba_powerindex
#' @author Saiem Gilani
#' @description
#' Returns ESPN's Basketball Power Index (BPI) and related per-team
#' metrics for one NBA season, in long format: one row per (team x stat).
#' Auto-paginates through all teams. Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/powerindex`.
#'
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param season_type Integer (1=preseason, 2=regular (default), 3=postseason).
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (team x stat).
#'
#'    |col_name      |types     |description                                  |
#'    |:-------------|:---------|:--------------------------------------------|
#'    |league        |character |League slug (`"nba"`).                       |
#'    |season        |integer   |Season year.                                 |
#'    |season_type   |integer   |1=preseason, 2=regular, 3=postseason.        |
#'    |team_id       |character |ESPN team id (parsed from `team_ref`).       |
#'    |stat_name     |character |Internal stat key (e.g. "bpi").              |
#'    |abbreviation  |character |Short stat abbreviation.                     |
#'    |display_name  |character |Human-readable stat name.                    |
#'    |description   |character |Stat description.                            |
#'    |value         |numeric   |Stat value.                                  |
#'    |display_value |character |Display-formatted value.                     |
#'    |last_updated  |character |Last-updated timestamp.                      |
#'    |team_ref      |character |`$ref` to the team-in-season resource.       |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_powerindex(season = 2025)
#' }
espn_nba_powerindex <- function(season = most_recent_nba_season(),
                                 season_type = c(2L, 3L), ...) {
  .espn_basketball_powerindex(league = "nba", season = season,
                                season_type = season_type, ...)
}
