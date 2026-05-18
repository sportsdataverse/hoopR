# espn_mbb_franchise.R
# Public MBB shims for ESPN franchise endpoints.

# ---------------------------------------------------------------------------
# espn_mbb_franchises
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Franchises Index**
#' @name espn_mbb_franchises
NULL
#' @title
#' **Get ESPN MBB Franchises Index**
#' @rdname espn_mbb_franchises
#' @author Saiem Gilani
#' @description
#' Returns the full MBB franchises index from
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/franchises`.
#' Each row is one franchise with its ID and the canonical `$ref` URL —
#' pass an ID to [espn_mbb_franchise()] for full franchise detail.
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per franchise.
#'
#'    |col_name     |types     |description                                |
#'    |:------------|:---------|:------------------------------------------|
#'    |franchise_id |character |ESPN franchise identifier.                 |
#'    |ref          |character |Full `$ref` URL for franchise detail.      |
#'    |league       |character |League slug (`"mens-college-basketball"`). |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_franchises()
#' }
espn_mbb_franchises <- function(...) {
  .espn_basketball_franchises(league = "mens-college-basketball", ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_franchise
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Franchise Detail**
#' @name espn_mbb_franchise
NULL
#' @title
#' **Get ESPN MBB Franchise Detail**
#' @rdname espn_mbb_franchise
#' @author Saiem Gilani
#' @description
#' Returns franchise-level metadata for a men's college basketball program.
#' Franchise IDs are stable across program reorganization or rebrands.
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
#'    |nickname           |character |Common nickname.                           |
#'    |abbreviation       |character |Short abbreviation.                        |
#'    |display_name       |character |Full display name.                         |
#'    |short_display_name |character |Short display name.                        |
#'    |color              |character |Primary color (hex, no leading '#').       |
#'    |is_active          |logical   |Whether franchise is currently active.     |
#'    |league             |character |League slug.                               |
#'    |logo               |character |Primary logo URL.                          |
#'    |logo_dark          |character |Dark-mode logo URL.                        |
#'    |venue_ref          |character |`$ref` to franchise's primary venue.       |
#'    |team_ref           |character |`$ref` to the current team for franchise.  |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_franchise(franchise_id = 150)
#' }
espn_mbb_franchise <- function(franchise_id, ...) {
  .espn_basketball_franchise(
    league       = "mens-college-basketball",
    franchise_id = franchise_id,
    ...
  )
}
