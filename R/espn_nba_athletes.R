# espn_nba_athletes.R
# Public NBA shims for ESPN athlete endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_athlete_helpers.R.

# ---------------------------------------------------------------------------
# espn_nba_athlete_info
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Info**
#' @name espn_nba_athlete_info
NULL
#' @title
#' **Get ESPN NBA Athlete Info**
#' @rdname espn_nba_athlete_info
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A named list of data frames: `Bio`, `Team`, `Position`,
#'   `Status`, `College`, `Draft`.
#'
#'    **Bio**
#'
#'    |col_name      |types     |description                       |
#'    |:-------------|:---------|:---------------------------------|
#'    |id            |character |Id.                               |
#'    |full_name     |character |Player's full name.               |
#'    |display_name  |character |Display name.                     |
#'    |jersey        |character |Jersey number worn by the player. |
#'    |age           |character |Player age (in years).            |
#'    |date_of_birth |character |Date of birth (YYYY-MM-DD).       |
#'    |headshot_href |character |Headshot image URL.               |
#'
#'    **Team**
#'
#'    |col_name     |types     |description         |
#'    |:------------|:---------|:-------------------|
#'    |id           |character |Id.                 |
#'    |abbreviation |character |Short abbreviation. |
#'    |display_name |character |Display name.       |
#'
#'    **Position**
#'
#'    |col_name     |types     |description         |
#'    |:------------|:---------|:-------------------|
#'    |id           |character |Id.                 |
#'    |name         |character |Display name.       |
#'    |abbreviation |character |Short abbreviation. |
#'
#'    **Status**
#'
#'    |col_name |types     |description             |
#'    |:--------|:---------|:-----------------------|
#'    |id       |character |Id.                     |
#'    |name     |character |Display name.           |
#'    |type     |character |Record type / category. |
#'
#'    **College**
#'
#'    |col_name |types     |description   |
#'    |:--------|:---------|:-------------|
#'    |id       |character |Id.           |
#'    |name     |character |Display name. |
#'    |mascot   |character |Team mascot.  |
#'
#'    **Draft**
#'
#'    |col_name  |types     |description                 |
#'    |:---------|:---------|:---------------------------|
#'    |year      |character |4-digit year.               |
#'    |round     |character |Tournament / playoff round. |
#'    |selection |character |                            |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_info(athlete_id = "1966")
#' }
espn_nba_athlete_info <- function(athlete_id, ...) {
  .espn_basketball_athlete_info(
    league     = "nba",
    athlete_id = athlete_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_overview
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Overview**
#' @name espn_nba_athlete_overview
NULL
#' @title
#' **Get ESPN NBA Athlete Overview**
#' @rdname espn_nba_athlete_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A named list of data frames: `Statistics`, `NextGame`,
#'   `Last5Games`, `Headlines`, `FantasyOutlook`.
#'
#'    **Statistics**
#'
#'    |col_name |types     |description |
#'    |:--------|:---------|:-----------|
#'    |(varies) |character |            |
#'
#'    **NextGame**
#'
#'    |col_name   |types     |description                |
#'    |:----------|:---------|:--------------------------|
#'    |id         |character |Id.                        |
#'    |date       |character |Date in YYYY-MM-DD format. |
#'    |name       |character |Display name.              |
#'    |short_name |character |Short display name.        |
#'
#'    **Last5Games**
#'
#'    |col_name |types     |description |
#'    |:--------|:---------|:-----------|
#'    |(varies) |character |            |
#'
#'    **Headlines**
#'
#'    |col_name    |types     |description                       |
#'    |:-----------|:---------|:---------------------------------|
#'    |headline    |character |News headline.                    |
#'    |description |character |Long-form description text.       |
#'    |published   |character |Publication timestamp (ISO 8601). |
#'
#'    **FantasyOutlook**
#'
#'    |col_name |types     |description |
#'    |:--------|:---------|:-----------|
#'    |(varies) |character |            |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_overview(athlete_id = "1966", season = 2024)
#' }
espn_nba_athlete_overview <- function(athlete_id,
                                       season = most_recent_nba_season(),
                                       ...) {
  .espn_basketball_athlete_overview(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_stats
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Stats**
#' @name espn_nba_athlete_stats
NULL
#' @title
#' **Get ESPN NBA Athlete Stats**
#' @rdname espn_nba_athlete_stats
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A named list of per-category tibbles. Default category names are
#'   `General`, `Offensive`, `Defensive`, `Rebounding`, `Shooting`, `Misc`.
#'   Actual names are driven by the ESPN response; additional categories may
#'   appear. Each tibble has columns depending on the category returned by
#'   ESPN.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_stats(athlete_id = "1966", season = 2024)
#' }
espn_nba_athlete_stats <- function(athlete_id,
                                    season = most_recent_nba_season(),
                                    ...) {
  .espn_basketball_athlete_stats(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_gamelog
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Gamelog**
#' @name espn_nba_athlete_gamelog
NULL
#' @title
#' **Get ESPN NBA Athlete Gamelog**
#' @rdname espn_nba_athlete_gamelog
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A single tibble with one row per game. Column names reflect the
#'   stat labels returned by ESPN and will vary by season and player.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_gamelog(athlete_id = "1966", season = 2024)
#' }
espn_nba_athlete_gamelog <- function(athlete_id,
                                      season = most_recent_nba_season(),
                                      ...) {
  .espn_basketball_athlete_gamelog(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_splits
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Splits**
#' @name espn_nba_athlete_splits
NULL
#' @title
#' **Get ESPN NBA Athlete Splits**
#' @rdname espn_nba_athlete_splits
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A single long-format tibble. When data are present, columns include
#'   at minimum `category` and `split_name`, plus per-stat columns driven by
#'   ESPN labels.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows select any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_splits(athlete_id = "1966", season = 2024)
#' }
espn_nba_athlete_splits <- function(athlete_id,
                                     season = most_recent_nba_season(),
                                     ...) {
  .espn_basketball_athlete_splits(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_eventlog
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Eventlog**
#' @name espn_nba_athlete_eventlog
NULL
#' @title
#' **Get ESPN NBA Athlete Eventlog**
#' @rdname espn_nba_athlete_eventlog
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A single tibble. Per-event `statistics.$ref` URLs from the ESPN
#'   core-v2 API are returned as the character column `statistics_ref` and
#'   are NOT resolved. Similarly, `event_ref`, `competition_ref`, and
#'   `team_ref` are returned as character columns.
#'
#'    |col_name        |types     |description                              |
#'    |:---------------|:---------|:----------------------------------------|
#'    |event_ref       |character |Reference link to the originating event. |
#'    |competition_ref |character |                                         |
#'    |team_ref        |character |                                         |
#'    |statistics_ref  |character |                                         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_eventlog(athlete_id = "1966", season = 2024)
#' }
espn_nba_athlete_eventlog <- function(athlete_id,
                                       season = most_recent_nba_season(),
                                       ...) {
  .espn_basketball_athlete_eventlog(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_awards
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Awards**
#' @name espn_nba_athlete_awards
NULL
#' @title
#' **Get ESPN NBA Athlete Awards**
#' @rdname espn_nba_athlete_awards
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single tibble. This endpoint is sparse; many athletes have no
#'   award data, in which case an empty tibble with canonical columns is
#'   returned.
#'
#'    |col_name    |types     |description                                           |
#'    |:-----------|:---------|:-----------------------------------------------------|
#'    |season      |character |Season identifier (4-digit year or 'YYYY-YY' string). |
#'    |award_id    |character |                                                      |
#'    |name        |character |Display name.                                         |
#'    |description |character |Long-form description text.                           |
#'    |date        |character |Date in YYYY-MM-DD format.                            |
#'    |type        |character |Record type / category.                               |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_awards(athlete_id = "1966")
#' }
espn_nba_athlete_awards <- function(athlete_id, ...) {
  .espn_basketball_athlete_awards(
    league     = "nba",
    athlete_id = athlete_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_statisticslog
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Statisticslog**
#' @name espn_nba_athlete_statisticslog
NULL
#' @title
#' **Get ESPN NBA Athlete Statisticslog**
#' @rdname espn_nba_athlete_statisticslog
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A single tibble. When resolved, each row corresponds to one
#'   statistical entry in the core-v2 statistics log, with `event_ref` and
#'   `statistics_ref` character columns pointing to resolvable ESPN endpoints.
#'
#'    |col_name       |types     |description                              |
#'    |:--------------|:---------|:----------------------------------------|
#'    |event_ref      |character |Reference link to the originating event. |
#'    |statistics_ref |character |                                         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_statisticslog(athlete_id = "1966", season = 2024)
#' }
espn_nba_athlete_statisticslog <- function(athlete_id,
                                            season = most_recent_nba_season(),
                                            ...) {
  .espn_basketball_athlete_statisticslog(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}
