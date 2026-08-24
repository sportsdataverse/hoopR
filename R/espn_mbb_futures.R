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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season year. \cr
#'       league \tab character \tab League slug. \cr
#'       market_id \tab character \tab ESPN futures-market identifier. \cr
#'       market_name \tab character \tab Internal market name. \cr
#'       market_type \tab character \tab Market type code. \cr
#'       market_display \tab character \tab Human-readable market name. \cr
#'       provider_id \tab character \tab Sportsbook provider identifier. \cr
#'       provider_name \tab character \tab Sportsbook provider name. \cr
#'       team_id \tab character \tab ESPN team id. \cr
#'       odds_value \tab character \tab American odds for the team. \cr
#'       team_ref \tab character \tab \verb{$ref} to the per-season team resource. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
