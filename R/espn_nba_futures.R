# espn_nba_futures.R
# Public NBA shim for ESPN season-futures endpoint.

# ---------------------------------------------------------------------------
# espn_nba_futures
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Futures (Long Format)**
#' @rdname espn_mbb_futures
#' @name espn_nba_futures
NULL
#' @title
#' **Get ESPN NBA Season Futures (Long Format)**
#' @rdname espn_mbb_futures
#' @author Saiem Gilani
#' @description
#' Returns the full futures-betting board for an NBA season, in long
#' format: one row per (market x team). Markets include championship
#' winner, conference winner, division winner, MVP odds, etc. Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/futures`.
#'
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_futures", unit = "futures market entry")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_nba_futures(season = 2025)
#' }
espn_nba_futures <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_futures(league = "nba", season = season, ...)
}
