# espn_mbb_team_record.R

#' **Get ESPN MBB Team Record (Per Season Type)**
#' @name espn_mbb_team_record
NULL
#' @title
#' **Get ESPN MBB Team Record (Per Season Type)**
#' @rdname espn_mbb_team_record
#' @author Saiem Gilani
#' @description
#' Returns the long-format record breakdown for an MBB team in one season
#' and season-type. Each row is one record category.
#'
#' @param team_id ESPN team identifier.
#' @param season Season year. Defaults to most recent MBB season.
#' @param season_type Integer (2 = regular season default).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per record category. See [espn_nba_team_record()]
#'   for the full column schema.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_record(team_id = 150, season = 2025)
#' }
espn_mbb_team_record <- function(team_id,
                                  season = most_recent_mbb_season(),
                                  season_type = 2L, ...) {
  .espn_basketball_team_record(league = "mens-college-basketball",
                                 team_id = team_id, season = season,
                                 season_type = season_type, ...)
}
