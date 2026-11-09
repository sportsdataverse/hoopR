# espn_nba_franchise.R
# Public NBA shims for ESPN franchise endpoints.

# ---------------------------------------------------------------------------
# espn_nba_franchises
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Franchises Index**
#' @rdname espn_mbb_franchises
#' @name espn_nba_franchises
NULL
#' @title
#' **Get ESPN NBA Franchises Index**
#' @rdname espn_mbb_franchises
#' @author Saiem Gilani
#' @description
#' Returns the full NBA franchises index from
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/franchises`.
#' Each row is one franchise with its ID and the canonical `$ref` URL -
#' pass an ID to [espn_nba_franchise()] for full franchise detail.
#'
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_franchises", unit = "franchise")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
#' @rdname espn_mbb_franchise
#' @name espn_nba_franchise
NULL
#' @title
#' **Get ESPN NBA Franchise Detail**
#' @rdname espn_mbb_franchise
#' @author Saiem Gilani
#' @description
#' Returns franchise-level metadata for an NBA franchise. Franchise IDs are
#' stable across relocations and rebrands - useful for tracking franchise
#' history independent of current team identity.
#'
#' @param franchise_id ESPN franchise identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_nba_franchise", unit = "franchise")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
