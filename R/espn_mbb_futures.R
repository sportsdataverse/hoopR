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
#' @return A long-format tibble.
#'
#'    |col_name        |types     |description                                                       |
#'    |:---------------|:---------|:-----------------------------------------------------------------|
#'    |season          |integer   |Season year.                                                      |
#'    |league          |character |League slug.                                                      |
#'    |market_id       |character |ESPN futures-market identifier.                                   |
#'    |market_name     |character |Internal market name.                                             |
#'    |market_type     |character |Market type code.                                                 |
#'    |market_display  |character |Human-readable market name.                                       |
#'    |provider_id     |character |Sportsbook provider identifier.                                   |
#'    |provider_name   |character |Sportsbook provider name.                                         |
#'    |team_id         |character |ESPN team id.                                                     |
#'    |odds_value      |character |American odds for the team.                                       |
#'    |team_ref        |character |`$ref` to the per-season team resource.                           |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_futures(season = 2025)
#' }
espn_mbb_futures <- function(season = most_recent_mbb_season(), ...) {
  .espn_basketball_futures(league = "mens-college-basketball",
                            season = season, ...)
}
