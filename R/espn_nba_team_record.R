# espn_nba_team_record.R

#' **Get ESPN NBA Team Record (Per Season Type)**
#' @rdname espn_mbb_team_record
#' @name espn_nba_team_record
NULL
#' @title
#' **Get ESPN NBA Team Record (Per Season Type)**
#' @rdname espn_mbb_team_record
#' @author Saiem Gilani
#' @description
#' Returns the long-format record breakdown for an NBA team in one season
#' and season-type. Each row is one record type (Overall, Home, Road,
#' vs Conference, vs Division, etc.). Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/types/{season_type}/teams/{team_id}/record`.
#'
#' @param team_id ESPN team identifier.
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_team_record", unit = "record category")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_nba_team_record(team_id = 13, season = 2025)
#' }
espn_nba_team_record <- function(team_id,
                                  season = most_recent_nba_season(),
                                  season_type = c(2L, 3L), ...) {
  .espn_basketball_team_record(league = "nba", team_id = team_id,
                                 season = season,
                                 season_type = season_type, ...)
}
