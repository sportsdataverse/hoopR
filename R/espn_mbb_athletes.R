# espn_mbb_athletes.R
# Public MBB shims for ESPN athlete endpoints.
# These are thin wrappers over the internal helpers in
# espn_basketball_athlete_helpers.R.

# ---------------------------------------------------------------------------
# espn_mbb_player_info
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Athlete Info**
#' @name espn_mbb_player_info
NULL
#' @title
#' **Get ESPN Women's College Basketball Athlete Info**
#' @rdname espn_mbb_player_info
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @eval .returns_rd("espn_mbb_player_info")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_info(athlete_id = "4593919")
#' }
espn_mbb_player_info <- function(athlete_id, ...) {
  .espn_basketball_athlete_info(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_player_overview
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Athlete Overview**
#' @name espn_mbb_player_overview
NULL
#' @title
#' **Get ESPN Women's College Basketball Athlete Overview**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_mbb_player_overview")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_overview(athlete_id = "4593919", season = 2025)
#' }
espn_mbb_player_overview <- function(athlete_id,
                                      season = most_recent_mbb_season(),
                                      ...) {
  .espn_basketball_athlete_overview(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_player_stats_v3
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Athlete Stats**
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
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_stats_v3(athlete_id = "4593919", season = 2025)
#' }
espn_mbb_player_stats_v3 <- function(athlete_id,
                                   season = most_recent_mbb_season(),
                                   ...) {
  .espn_basketball_athlete_stats(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_player_gamelog
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Athlete Gamelog**
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
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_gamelog(athlete_id = "4593919", season = 2025)
#' }
espn_mbb_player_gamelog <- function(athlete_id,
                                     season = most_recent_mbb_season(),
                                     ...) {
  .espn_basketball_athlete_gamelog(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_player_splits
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Athlete Splits**
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
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_splits(athlete_id = "4593919", season = 2025)
#' }
espn_mbb_player_splits <- function(athlete_id,
                                    season = most_recent_mbb_season(),
                                    ...) {
  .espn_basketball_athlete_splits(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_player_eventlog
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Athlete Eventlog**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_mbb_player_eventlog", unit = "event appearance")
#' @return Per-event `statistics.$ref` URLs from the ESPN core-v2 API are returned as
#'   the character column `statistics_ref` and are NOT resolved. Similarly,
#'   `event_ref`, `competition_ref`, and `team_ref` are returned as character columns.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_eventlog(athlete_id = "4593919", season = 2025)
#' }
espn_mbb_player_eventlog <- function(athlete_id,
                                      season = most_recent_mbb_season(),
                                      ...) {
  .espn_basketball_athlete_eventlog(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_player_awards
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Athlete Awards**
#' @name espn_mbb_player_awards
NULL
#' @title
#' **Get ESPN Women's College Basketball Athlete Awards**
#' @rdname espn_mbb_player_awards
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_mbb_player_awards", unit = "award")
#' @return This endpoint is sparse; many athletes have no award data, in which case an
#'   empty tibble with canonical columns is returned.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_awards(athlete_id = "4593919")
#' }
espn_mbb_player_awards <- function(athlete_id, ...) {
  .espn_basketball_athlete_awards(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_player_statisticslog
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Athlete Statisticslog**
#' @rdname espn_mbb_player_overview
#' @author Saiem Gilani
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_mbb_player_statisticslog", unit = "statistics entry")
#' @return When resolved, each row corresponds to one statistical entry in the core-v2
#'   statistics log, with `event_ref` and `statistics_ref` character columns pointing
#'   to resolvable ESPN endpoints.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_player_statisticslog(athlete_id = "4593919", season = 2025)
#' }
espn_mbb_player_statisticslog <- function(athlete_id,
                                           season = most_recent_mbb_season(),
                                           ...) {
  .espn_basketball_athlete_statisticslog(
    league     = "mens-college-basketball",
    athlete_id = athlete_id,
    season     = season,
    ...
  )
}
