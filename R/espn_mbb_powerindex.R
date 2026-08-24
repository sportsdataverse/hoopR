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
#' @return A long tibble with one row per (team x stat).
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League slug. \cr
#'       season \tab integer \tab Season year. \cr
#'       season_type \tab integer \tab 1=preseason, 2=regular, 3=postseason. \cr
#'       team_id \tab character \tab ESPN team id. \cr
#'       stat_name \tab character \tab Internal stat key. \cr
#'       abbreviation \tab character \tab Short stat abbreviation. \cr
#'       display_name \tab character \tab Human-readable stat name. \cr
#'       description \tab character \tab Stat description. \cr
#'       value \tab numeric \tab Stat value. \cr
#'       display_value \tab character \tab Display-formatted value. \cr
#'       last_updated \tab character \tab Last-updated timestamp. \cr
#'       team_ref \tab character \tab \verb{$ref} to the team-in-season resource. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_powerindex(season = 2025)
#' }
espn_mbb_powerindex <- function(season = most_recent_mbb_season(),
                                 season_type = c(2L, 3L), ...) {
  .espn_basketball_powerindex(league = "mens-college-basketball",
                                season = season,
                                season_type = season_type, ...)
}
