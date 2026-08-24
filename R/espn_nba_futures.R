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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       season \tab integer \tab Season year. \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'       market_id \tab character \tab ESPN futures-market identifier. \cr
#'       market_name \tab character \tab Internal market name (e.g. "NBA - Winner"). \cr
#'       market_type \tab character \tab Market type code (\code{winLeague}, \code{winConference}, \code{winDivision}, ...). \cr
#'       market_display \tab character \tab Human-readable name (e.g. "NBA Championship Winner"). \cr
#'       provider_id \tab character \tab Sportsbook provider identifier. \cr
#'       provider_name \tab character \tab Sportsbook provider name (e.g. "ESPN BET"). \cr
#'       team_id \tab character \tab ESPN team id (parsed from \code{team_ref}). \cr
#'       odds_value \tab character \tab American odds for the team (e.g. "-250", "+800"). \cr
#'       team_ref \tab character \tab \verb{$ref} to the per-season team resource. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
