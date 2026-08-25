# espn_nba_athletes.R
# Public NBA shims for ESPN athlete endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_athlete_helpers.R.

# ---------------------------------------------------------------------------
# espn_nba_player_info
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Info**
#' @rdname espn_mbb_player_info
#' @name espn_nba_player_info
NULL
#' @title
#' **Get ESPN NBA Athlete Info**
#' @rdname espn_mbb_player_info
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
#'    Columns as documented in the shared [espn_mbb_player_info_bio_schema] table.
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
#'   espn_nba_player_info(athlete_id = "1966")
#' }
espn_nba_player_info <- function(athlete_id, ...) {
  .espn_basketball_athlete_info(
    league     = "nba",
    athlete_id = athlete_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_player_overview
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Overview**
#' @rdname espn_mbb_player_overview
#' @name espn_nba_player_overview
NULL
#' @title
#' **Get ESPN NBA Athlete Overview**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab character \tab Id. \cr
#'       date \tab character \tab Date in YYYY-MM-DD format. \cr
#'       name \tab character \tab Display name. \cr
#'       short_name \tab character \tab Short display name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **Last5Games**
#'
#'    |col_name |types     |description |
#'    |:--------|:---------|:-----------|
#'    |(varies) |character |            |
#'
#'    **Headlines**
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       headline \tab character \tab News headline. \cr
#'       description \tab character \tab Long-form description text. \cr
#'       published \tab character \tab Publication timestamp (ISO 8601). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#'   espn_nba_player_overview(athlete_id = "1966", season = 2024)
#' }
espn_nba_player_overview <- function(athlete_id,
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
# espn_nba_player_stats_v3
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Athlete Stats**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
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
#'   espn_nba_player_stats_v3(athlete_id = "1966", season = 2024)
#' }
espn_nba_player_stats_v3 <- function(athlete_id,
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
# espn_nba_player_gamelog
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Athlete Gamelog**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
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
#'   espn_nba_player_gamelog(athlete_id = "1966", season = 2024)
#' }
espn_nba_player_gamelog <- function(athlete_id,
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
# espn_nba_player_splits
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Athlete Splits**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
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
#'   espn_nba_player_splits(athlete_id = "1966", season = 2024)
#' }
espn_nba_player_splits <- function(athlete_id,
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
# espn_nba_player_eventlog
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Athlete Eventlog**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single tibble. Per-event `statistics.$ref` URLs from the ESPN
#'   core-v2 API are returned as the character column `statistics_ref` and
#'   are NOT resolved. Similarly, `event_ref`, `competition_ref`, and
#'   `team_ref` are returned as character columns.
#'
#'    Columns as documented in the shared [espn_mbb_player_eventlog_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_player_eventlog(athlete_id = "1966", season = 2024)
#' }
espn_nba_player_eventlog <- function(athlete_id,
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
# espn_nba_player_awards
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Awards**
#' @rdname espn_mbb_player_awards
#' @name espn_nba_player_awards
NULL
#' @title
#' **Get ESPN NBA Athlete Awards**
#' @rdname espn_mbb_player_awards
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single tibble. This endpoint is sparse; many athletes have no
#'   award data, in which case an empty tibble with canonical columns is
#'   returned.
#'
#'    Columns as documented in the shared [espn_mbb_player_awards_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_player_awards(athlete_id = "1966")
#' }
espn_nba_player_awards <- function(athlete_id, ...) {
  .espn_basketball_athlete_awards(
    league     = "nba",
    athlete_id = athlete_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_player_statisticslog
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Athlete Statisticslog**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single tibble. When resolved, each row corresponds to one
#'   statistical entry in the core-v2 statistics log, with `event_ref` and
#'   `statistics_ref` character columns pointing to resolvable ESPN endpoints.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       event_ref \tab character \tab Reference link to the originating event. \cr
#'       statistics_ref \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_player_statisticslog(athlete_id = "1966", season = 2024)
#' }
espn_nba_player_statisticslog <- function(athlete_id,
                                            season = most_recent_nba_season(),
                                            ...) {
  .espn_basketball_athlete_statisticslog(
    league     = "nba",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}
