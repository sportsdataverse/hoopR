# espn_mbb_powerindex.R

#' **Get ESPN MBB Season Power Index (Long Format)**
#' @name espn_mbb_powerindex
NULL
#' @title
#' **Get ESPN MBB Season Power Index (Long Format)**
#' @rdname espn_mbb_powerindex
#' @author Saiem Gilani
#' @description
#' Returns ESPN's Basketball Power Index (BPI) and related per-team
#' metrics for one MBB season, in long format: one row per (team x stat).
#' Auto-paginates through all teams.
#'
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param season_type Integer (1=preseason, 2=regular (default), 3=postseason).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_mbb_powerindex", unit = "team and statistic")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examplesIf interactive()
#' \donttest{
#'   # Interactive only: every team's power index for a season, 2-5 s.
#'   espn_mbb_powerindex(season = 2025)
#' }
espn_mbb_powerindex <- function(season = most_recent_mbb_season(),
                                 season_type = c(2L, 3L), ...) {
  .espn_basketball_powerindex(league = "mens-college-basketball",
                                season = season,
                                season_type = season_type, ...)
}
