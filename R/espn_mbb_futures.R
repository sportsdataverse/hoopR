# espn_mbb_futures.R
# Public MBB shim for ESPN season-futures endpoint.

# ---------------------------------------------------------------------------
# espn_mbb_futures
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Futures (Long Format)**
#' @name espn_mbb_futures
NULL
#' @title
#' **Get ESPN MBB Season Futures (Long Format)**
#' @rdname espn_mbb_futures
#' @author Saiem Gilani
#' @description
#' Returns the full futures-betting board for a men's college basketball
#' season, in long format: one row per (market x team). Markets typically
#' cover the NCAA tournament champion and conference winners. Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/{season}/futures`.
#'
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_mbb_futures", unit = "futures market entry")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_futures(season = 2025)
#' }
espn_mbb_futures <- function(season = most_recent_mbb_season(), ...) {
  .espn_basketball_futures(league = "mens-college-basketball",
                            season = season, ...)
}
