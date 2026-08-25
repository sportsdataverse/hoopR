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
#' Each row is one contract year — pass the season to
#' [espn_nba_player_contract()] for the full contract record.
#'
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per contract year.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       athlete_id \tab character \tab ESPN athlete identifier. \cr
#'       season \tab integer \tab Contract season year. \cr
#'       ref \tab character \tab Full \verb{$ref} URL for the contract detail. \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   # LeBron James — athlete id 1966
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
#' @return A single-row tibble.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       athlete_id \tab character \tab ESPN athlete identifier. \cr
#'       season \tab integer \tab Contract season year. \cr
#'       bird_status \tab integer \tab Bird-rights tier (0 = Non, 1 = Early, 2 = Full). \cr
#'       salary \tab numeric \tab Total cap-counting salary for the season ($). \cr
#'       salary_remaining \tab numeric \tab Remaining salary owed. \cr
#'       years_remaining \tab integer \tab Years left on the contract. \cr
#'       incoming_trade_value \tab numeric \tab Trade value if receiving this contract ($). \cr
#'       outgoing_trade_value \tab numeric \tab Trade value if sending out this contract ($). \cr
#'       option_type \tab integer \tab Option type code (e.g. team / player option). \cr
#'       minimum_salary_exception \tab logical \tab Signed under the minimum-salary exception. \cr
#'       trade_restriction \tab logical \tab Whether a trade restriction is active. \cr
#'       unsigned_foreign_pick \tab logical \tab Unsigned-foreign-pick flag. \cr
#'       active \tab logical \tab Whether the contract is currently active. \cr
#'       base_year_compensation_active \tab logical \tab Base-year-compensation rule active. \cr
#'       poison_pill_provision_active \tab logical \tab Poison-pill provision active. \cr
#'       trade_kicker_active \tab logical \tab Trade kicker active. \cr
#'       trade_kicker_percentage \tab numeric \tab Trade kicker percentage of salary. \cr
#'       trade_kicker_value \tab numeric \tab Trade kicker dollar value. \cr
#'       trade_kicker_trade_value \tab numeric \tab Trade kicker post-trade dollar value. \cr
#'       season_ref \tab character \tab \verb{$ref} to the season resource. \cr
#'       team_ref \tab character \tab \verb{$ref} to the team-in-season resource. \cr
#'       team_id \tab character \tab ESPN team id parsed from \code{team_ref}. \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
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
