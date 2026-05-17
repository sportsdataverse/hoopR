# espn_nba_league.R
# Public NBA shims for ESPN league-wide catalog endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_league_helpers.R.

# ---------------------------------------------------------------------------
# espn_nba_leaders
# ---------------------------------------------------------------------------

#' **Get ESPN NBA League Leaders**
#' @name espn_nba_leaders
NULL
#' @title
#' **Get ESPN NBA League Leaders**
#' @rdname espn_nba_leaders
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent NBA season.
#' @param season_type Integer season type: 1 = preseason, 2 = regular
#'   (default), 3 = postseason.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per category-athlete
#'   pair.
#'
#'    |col_name      |types     |description                                                                                                        |
#'    |:-------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |season        |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type   |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |category      |character |Category label.                                                                                                    |
#'    |abbreviation  |character |Short abbreviation.                                                                                                |
#'    |athlete_id    |character |Unique athlete identifier (ESPN).                                                                                  |
#'    |athlete_name  |character |Athlete display name (ESPN).                                                                                       |
#'    |team_id       |character |Unique team identifier.                                                                                            |
#'    |team_abbrev   |character |                                                                                                                   |
#'    |value         |numeric   |Numeric or string value field.                                                                                     |
#'    |rank          |integer   |Rank.                                                                                                              |
#'    |display_value |character |Human-readable display value.                                                                                      |
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
#' @name espn_nba_venues
NULL
#' @title
#' **Get ESPN NBA Venues**
#' @rdname espn_nba_venues
#' @author Saiem Gilani
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per venue.
#'
#'    |col_name      |types     |description              |
#'    |:-------------|:---------|:------------------------|
#'    |venue_id      |character |Unique venue identifier. |
#'    |name          |character |Display name.            |
#'    |full_name     |character |Player's full name.      |
#'    |address_city  |character |                         |
#'    |address_state |character |                         |
#'    |capacity      |integer   |                         |
#'    |indoor        |logical   |                         |
#'    |grass         |logical   |                         |
#'    |images_url    |character |                         |
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
#' @name espn_nba_coaches
NULL
#' @title
#' **Get ESPN NBA Coaches**
#' @rdname espn_nba_coaches
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent NBA season.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per coach.
#'
#'    |col_name   |types     |description                       |
#'    |:----------|:---------|:---------------------------------|
#'    |coach_id   |character |                                  |
#'    |first_name |character |Player's first name.              |
#'    |last_name  |character |Player's last name.               |
#'    |full_name  |character |Player's full name.               |
#'    |experience |integer   |Years of professional experience. |
#'    |team_id    |character |Unique team identifier.           |
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
#' @name espn_nba_athletes_index
NULL
#' @title
#' **Get ESPN NBA Athletes Index**
#' @rdname espn_nba_athletes_index
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent NBA season.
#' @param active logical. When `TRUE` (default) only active athletes are
#'   returned. Set to `FALSE` for the full historical roster.
#' @param limit integer. Maximum number of rows to return. Default 5000.
#'   Pass a small value (e.g. `limit = 50`) in tests to keep execution fast.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per athlete.
#'
#'    |col_name   |types     |description                             |
#'    |:----------|:---------|:---------------------------------------|
#'    |athlete_id |character |Unique athlete identifier (ESPN).       |
#'    |full_name  |character |Player's full name.                     |
#'    |jersey     |character |Jersey number worn by the player.       |
#'    |position   |character |Listed roster position (G, F, C, etc.). |
#'    |team_id    |character |Unique team identifier.                 |
#'    |headshot   |character |Headshot image URL.                     |
#'    |status     |character |Status label.                           |
#'    |link       |character |                                        |
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
#' @name espn_nba_seasons
NULL
#' @title
#' **Get ESPN NBA Seasons**
#' @rdname espn_nba_seasons
#' @author Saiem Gilani
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A single `hoopR_data` tibble with one row per season.
#'
#'    |col_name          |types     |description                                           |
#'    |:-----------------|:---------|:-----------------------------------------------------|
#'    |season            |integer   |Season identifier (4-digit year or 'YYYY-YY' string). |
#'    |start_date        |character |Start date (YYYY-MM-DD).                              |
#'    |end_date          |character |End date (YYYY-MM-DD).                                |
#'    |display_name      |character |Display name.                                         |
#'    |season_type_count |integer   |                                                      |
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
#' @name espn_nba_season_info
NULL
#' @title
#' **Get ESPN NBA Season Info**
#' @rdname espn_nba_season_info
#' @author Saiem Gilani
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent NBA season.
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
#'    |col_name     |types     |description                |
#'    |:------------|:---------|:--------------------------|
#'    |year         |integer   |4-digit year.              |
#'    |start_date   |character |Start date (YYYY-MM-DD).   |
#'    |end_date     |character |End date (YYYY-MM-DD).     |
#'    |display_name |character |Display name.              |
#'    |type_id      |character |Type identifier (numeric). |
#'    |type_name    |character |                           |
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
