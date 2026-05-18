# espn_nba_futures.R
# Public NBA shim for ESPN season-futures endpoint.

# ---------------------------------------------------------------------------
# espn_nba_futures
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Futures (Long Format)**
#' @name espn_nba_futures
NULL
#' @title
#' **Get ESPN NBA Season Futures (Long Format)**
#' @rdname espn_nba_futures
#' @author Saiem Gilani
#' @description
#' Returns the full futures-betting board for an NBA season, in long
#' format: one row per (market x team). Markets include championship
#' winner, conference winner, division winner, MVP odds, etc. Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/futures`.
#'
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A long-format tibble.
#'
#'    |col_name        |types     |description                                                       |
#'    |:---------------|:---------|:-----------------------------------------------------------------|
#'    |season          |integer   |Season year.                                                      |
#'    |league          |character |League slug (`"nba"`).                                            |
#'    |market_id       |character |ESPN futures-market identifier.                                   |
#'    |market_name     |character |Internal market name (e.g. "NBA - Winner").                       |
#'    |market_type     |character |Market type code (`winLeague`, `winConference`, `winDivision`, ...).|
#'    |market_display  |character |Human-readable name (e.g. "NBA Championship Winner").             |
#'    |provider_id     |character |Sportsbook provider identifier.                                   |
#'    |provider_name   |character |Sportsbook provider name (e.g. "ESPN BET").                       |
#'    |team_id         |character |ESPN team id (parsed from `team_ref`).                            |
#'    |odds_value      |character |American odds for the team (e.g. "-250", "+800").                 |
#'    |team_ref        |character |`$ref` to the per-season team resource.                           |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_futures(season = 2025)
#' }
espn_nba_futures <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_futures(league = "nba", season = season, ...)
}
