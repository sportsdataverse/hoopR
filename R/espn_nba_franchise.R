# espn_nba_franchise.R
# Public NBA shims for ESPN franchise endpoints.

# ---------------------------------------------------------------------------
# espn_nba_franchises
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Franchises Index**
#' @name espn_nba_franchises
NULL
#' @title
#' **Get ESPN NBA Franchises Index**
#' @rdname espn_nba_franchises
#' @author Saiem Gilani
#' @description
#' Returns the full NBA franchises index from
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/franchises`.
#' Each row is one franchise with its ID and the canonical `$ref` URL —
#' pass an ID to [espn_nba_franchise()] for full franchise detail.
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per franchise.
#'
#'    |col_name     |types     |description                            |
#'    |:------------|:---------|:--------------------------------------|
#'    |franchise_id |character |ESPN franchise identifier.             |
#'    |ref          |character |Full `$ref` URL for franchise detail.  |
#'    |league       |character |League slug (`"nba"`).                 |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_franchises()
#' }
espn_nba_franchises <- function(...) {
  .espn_basketball_franchises(league = "nba", ...)
}

# ---------------------------------------------------------------------------
# espn_nba_franchise
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Franchise Detail**
#' @name espn_nba_franchise
NULL
#' @title
#' **Get ESPN NBA Franchise Detail**
#' @rdname espn_nba_franchise
#' @author Saiem Gilani
#' @description
#' Returns franchise-level metadata for an NBA franchise. Franchise IDs are
#' stable across relocations and rebrands — useful for tracking franchise
#' history independent of current team identity.
#'
#' @param franchise_id ESPN franchise identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab character \tab ESPN franchise identifier. \cr
#'       uid \tab character \tab ESPN UID string. \cr
#'       slug \tab character \tab URL-safe identifier. \cr
#'       location \tab character \tab Franchise location. \cr
#'       name \tab character \tab Franchise name. \cr
#'       nickname \tab character \tab Common nickname (often same as name). \cr
#'       abbreviation \tab character \tab Short abbreviation. \cr
#'       display_name \tab character \tab Full display name. \cr
#'       short_display_name \tab character \tab Short display name. \cr
#'       color \tab character \tab Primary color (hex, no leading '#'). \cr
#'       is_active \tab logical \tab Whether franchise is currently active. \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'       logo \tab character \tab Primary logo URL. \cr
#'       logo_dark \tab character \tab Dark-mode logo URL. \cr
#'       venue_ref \tab character \tab \verb{$ref} to franchise's primary venue. \cr
#'       team_ref \tab character \tab \verb{$ref} to the current team for franchise. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_franchise(franchise_id = 13)
#' }
espn_nba_franchise <- function(franchise_id, ...) {
  .espn_basketball_franchise(
    league       = "nba",
    franchise_id = franchise_id,
    ...
  )
}
