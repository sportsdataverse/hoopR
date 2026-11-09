# espn_nba_player_contracts.R
# Public NBA shims for ESPN athlete-contract endpoints.
# ESPN's core-v2 surface only populates contract data for NBA athletes
# (WNBA contract index returns 0 items), so these wrappers are NBA-only.

# ---------------------------------------------------------------------------
# espn_nba_player_contracts
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Contracts Index**
#' @name espn_nba_player_contracts
NULL
#' @title
#' **Get ESPN NBA Athlete Contracts Index**
#' @rdname espn_nba_player_contracts
#' @author Saiem Gilani
#' @description
#' Returns the index of contract seasons recorded for an NBA athlete from
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/athletes/{athlete_id}/contracts`.
#' Each row is one contract year - pass the season to
#' [espn_nba_player_contract()] for the full contract record.
#'
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_player_contracts", unit = "contract year")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   # LeBron James - athlete id 1966
#'   espn_nba_player_contracts(athlete_id = 1966)
#' }
espn_nba_player_contracts <- function(athlete_id, ...) {
  .espn_basketball_athlete_contracts(
    league     = "nba",
    athlete_id = athlete_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_player_contract
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Contract (Single Season)**
#' @rdname espn_nba_player_contracts
#' @name espn_nba_player_contract
NULL
#' @title
#' **Get ESPN NBA Athlete Contract (Single Season)**
#' @rdname espn_nba_player_contracts
#' @author Saiem Gilani
#' @description
#' Returns the full contract record for one NBA athlete in one season,
#' including salary, cap-rule flags, option type, Bird status, and trade
#' protections. Backed by
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/athletes/{athlete_id}/contracts/{season}`.
#'
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_player_contract", unit = "contract")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
#' @examples
#' \donttest{
#'   # LeBron James 2025 contract
#'   espn_nba_player_contract(athlete_id = 1966, season = 2025)
#' }
espn_nba_player_contract <- function(athlete_id,
                                       season = most_recent_nba_season(),
                                       ...) {
  .espn_basketball_athlete_contract(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}
