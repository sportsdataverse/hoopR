# espn_nba_league.R
# Public NBA shims for ESPN league-wide catalog endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_league_helpers.R.

# ---------------------------------------------------------------------------
# espn_nba_leaders
# ---------------------------------------------------------------------------

#' **Get ESPN NBA League Leaders**
#' @rdname espn_mbb_leaders
#' @name espn_nba_leaders
NULL
#' @title
#' **Get ESPN NBA League Leaders**
#' @rdname espn_mbb_leaders
#' @author Saiem Gilani
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_leaders(season = 2024, season_type = 2)
#' }
espn_nba_leaders <- function(season      = most_recent_nba_season(),
                               season_type = 2,
                               ...) {
  .espn_basketball_leaders(
    league      = "nba",
    season      = season,
    season_type = season_type,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_venues
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Venues**
#' @rdname espn_mbb_venues
#' @name espn_nba_venues
NULL
#' @title
#' **Get ESPN NBA Venues**
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_venues()
#' }
espn_nba_venues <- function(...) {
  .espn_basketball_venues(
    league = "nba",
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_coaches
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Coaches**
#' @rdname espn_mbb_coaches
#' @name espn_nba_coaches
NULL
#' @title
#' **Get ESPN NBA Coaches**
#' @rdname espn_mbb_coaches
#' @author Saiem Gilani
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_coaches(season = 2025)
#' }
espn_nba_coaches <- function(season = most_recent_nba_season(),
                               ...) {
  .espn_basketball_coaches(
    league = "nba",
    season = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athletes_index
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athletes Index**
#' @rdname espn_mbb_athletes_index
#' @name espn_nba_athletes_index
NULL
#' @title
#' **Get ESPN NBA Athletes Index**
#' @rdname espn_mbb_athletes_index
#' @author Saiem Gilani
#' @param active logical. When `TRUE` (default) only active athletes are
#'   returned. Set to `FALSE` for the full historical roster.
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athletes_index(season = 2025, limit = 50)
#' }
espn_nba_athletes_index <- function(season = most_recent_nba_season(),
                                      active = TRUE,
                                      limit  = 5000L,
                                      ...) {
  .espn_basketball_athletes_index(
    league = "nba",
    season = season,
    active = active,
    limit  = limit,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Seasons**
#' @rdname espn_mbb_seasons
#' @name espn_nba_seasons
NULL
#' @title
#' **Get ESPN NBA Seasons**
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_seasons()
#' }
espn_nba_seasons <- function(...) {
  .espn_basketball_seasons(
    league = "nba",
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_season_info
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Info**
#' @rdname espn_mbb_season_info
#' @name espn_nba_season_info
NULL
#' @title
#' **Get ESPN NBA Season Info**
#' @rdname espn_mbb_season_info
#' @author Saiem Gilani
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_season_info(season = 2025)
#' }
espn_nba_season_info <- function(season = most_recent_nba_season(),
                                   ...) {
  .espn_basketball_season_info(
    league = "nba",
    season = season,
    ...
  )
}
