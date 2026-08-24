# espn_mbb_league.R
# Public MBB shims for ESPN league-wide catalog endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_league_helpers.R.

# ---------------------------------------------------------------------------
# espn_mbb_leaders
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball League Leaders**
#' @name espn_mbb_leaders
NULL
#' @title
#' **Get ESPN Women's College Basketball League Leaders**
#' @rdname espn_mbb_leaders
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent MBB season.
#' @param season_type Integer season type: 1 = preseason, 2 = regular
#'   (default), 3 = postseason.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per category-athlete
#'   pair.
#'
#'    Columns as documented in the shared [espn_mbb_leaders_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_leaders(season = 2025, season_type = 2)
#' }
espn_mbb_leaders <- function(season      = most_recent_mbb_season(),
                              season_type = 2,
                              ...) {
  .espn_basketball_leaders(
    league      = "mens-college-basketball",
    season      = season,
    season_type = season_type,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_venues
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Venues**
#' @name espn_mbb_venues
NULL
#' @title
#' **Get ESPN Women's College Basketball Venues**
#' @rdname espn_mbb_venues
#' @author Saiem Gilani
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per venue.
#'
#'    Columns as documented in the shared [espn_mbb_venues_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_venues()
#' }
espn_mbb_venues <- function(...) {
  .espn_basketball_venues(
    league = "mens-college-basketball",
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_coaches
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Coaches**
#' @name espn_mbb_coaches
NULL
#' @title
#' **Get ESPN Women's College Basketball Coaches**
#' @rdname espn_mbb_coaches
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent MBB season.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per coach.
#'
#'    Columns as documented in the shared [espn_mbb_coaches_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_coaches(season = 2025)
#' }
espn_mbb_coaches <- function(season = most_recent_mbb_season(),
                              ...) {
  .espn_basketball_coaches(
    league = "mens-college-basketball",
    season = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_athletes_index
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Athletes Index**
#' @name espn_mbb_athletes_index
NULL
#' @title
#' **Get ESPN Women's College Basketball Athletes Index**
#' @rdname espn_mbb_athletes_index
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent MBB season.
#' @param active logical. When `TRUE` (default) only active athletes are
#'   returned. Set to `FALSE` for the full historical roster.
#' @param limit integer. Maximum number of rows to return. Default 25000.
#'   MBB can return 6,000-12,000 athletes per season; increase if needed.
#'   Pass a small value (e.g. `limit = 50`) in tests to keep execution fast.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per athlete.
#'
#'    Columns as documented in the shared [espn_mbb_athletes_index_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_athletes_index(season = 2025, limit = 50)
#' }
espn_mbb_athletes_index <- function(season = most_recent_mbb_season(),
                                     active = TRUE,
                                     limit  = 25000L,
                                     ...) {
  .espn_basketball_athletes_index(
    league = "mens-college-basketball",
    season = season,
    active = active,
    limit  = limit,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Seasons**
#' @name espn_mbb_seasons
NULL
#' @title
#' **Get ESPN Women's College Basketball Seasons**
#' @rdname espn_mbb_seasons
#' @author Saiem Gilani
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per season.
#'
#'    Columns as documented in the shared [espn_mbb_seasons_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_seasons()
#' }
espn_mbb_seasons <- function(...) {
  .espn_basketball_seasons(
    league = "mens-college-basketball",
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_season_info
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Season Info**
#' @name espn_mbb_season_info
NULL
#' @title
#' **Get ESPN Women's College Basketball Season Info**
#' @rdname espn_mbb_season_info
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent MBB season.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A named list of `hoopR_data` tibbles:
#'   `Info`, `Types`, `Athletes`, `Coaches`, `Teams`, `Awards`.
#'   `$ref` URL components are returned as character columns and are NOT
#'   auto-resolved -- use targeted endpoint functions for details.
#'
#'    **Info**
#'
#'    Columns as documented in the shared [espn_mbb_season_info_info_schema] table.
#'
#'    **Types / Athletes / Coaches / Teams / Awards**
#'
#'    |col_name |types     |description     |
#'    |:--------|:---------|:---------------|
#'    |count    |integer   |Count of count. |
#'    |ref      |character |                |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_info(season = 2025)
#' }
espn_mbb_season_info <- function(season = most_recent_mbb_season(),
                                  ...) {
  .espn_basketball_season_info(
    league = "mens-college-basketball",
    season = season,
    ...
  )
}
