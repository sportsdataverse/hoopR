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
#' @return A tibble with one row per record category.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'       team_id \tab character \tab ESPN team identifier. \cr
#'       season \tab integer \tab Season year. \cr
#'       season_type \tab integer \tab Season type (1/2/3). \cr
#'       record_id \tab character \tab Record sub-id. \cr
#'       name \tab character \tab Internal record name (e.g. "overall"). \cr
#'       abbreviation \tab character \tab Abbreviation (e.g. "Total"). \cr
#'       display_name \tab character \tab Display name (e.g. "Overall"). \cr
#'       short_display_name \tab character \tab Short display (e.g. "OVER"). \cr
#'       description \tab character \tab Description (e.g. "Overall Record"). \cr
#'       type \tab character \tab Record type code (\code{total}, \code{home}, ...). \cr
#'       summary \tab character \tab W-L summary (e.g. "50-32"). \cr
#'       display_value \tab character \tab Same as summary in most cases. \cr
#'       value \tab numeric \tab Win percentage (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
                                  season_type = c(2L, 3L), ...) {
  .espn_basketball_team_record(league = "nba", team_id = team_id,
                                 season = season,
                                 season_type = season_type, ...)
}
