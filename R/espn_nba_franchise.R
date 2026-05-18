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
#'    |col_name           |types     |description                                |
#'    |:------------------|:---------|:------------------------------------------|
#'    |id                 |character |ESPN franchise identifier.                 |
#'    |uid                |character |ESPN UID string.                           |
#'    |slug               |character |URL-safe identifier.                       |
#'    |location           |character |Franchise location.                        |
#'    |name               |character |Franchise name.                            |
#'    |nickname           |character |Common nickname (often same as name).      |
#'    |abbreviation       |character |Short abbreviation.                        |
#'    |display_name       |character |Full display name.                         |
#'    |short_display_name |character |Short display name.                        |
#'    |color              |character |Primary color (hex, no leading '#').       |
#'    |is_active          |logical   |Whether franchise is currently active.     |
#'    |league             |character |League slug (`"nba"`).                     |
#'    |logo               |character |Primary logo URL.                          |
#'    |logo_dark          |character |Dark-mode logo URL.                        |
#'    |venue_ref          |character |`$ref` to franchise's primary venue.       |
#'    |team_ref           |character |`$ref` to the current team for franchise.  |
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
