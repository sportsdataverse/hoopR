# espn_nba_powerindex.R

#' **Get ESPN NBA Season Power Index (Long Format)**
#' @rdname espn_mbb_powerindex
#' @name espn_nba_powerindex
NULL
#' @title
#' **Get ESPN NBA Season Power Index (Long Format)**
#' @rdname espn_mbb_powerindex
#' @author Saiem Gilani
#' @description
#' Returns ESPN's Basketball Power Index (BPI) and related per-team
#' metrics for one NBA season, in long format: one row per (team x stat).
#' Auto-paginates through all teams. Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/powerindex`.
#'
#' @param season_type Integer (1=preseason, 2=regular (default), 3=postseason).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_powerindex", unit = "team and statistic")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_nba_powerindex(season = 2025)
#' }
espn_nba_powerindex <- function(season = most_recent_nba_season(),
                                 season_type = c(2L, 3L), ...) {
  .espn_basketball_powerindex(league = "nba", season = season,
                                season_type = season_type, ...)
}
