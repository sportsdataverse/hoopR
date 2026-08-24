# espn_mbb_athlete_career.R
# Public MBB shims for athlete career-level core-v2 endpoints.

# ---------------------------------------------------------------------------
# espn_mbb_player_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Athlete Career Seasons**
#' @name espn_mbb_player_seasons
NULL
#' @title
#' **Get ESPN MBB Athlete Career Seasons**
#' @rdname espn_mbb_player_seasons
#' @author Saiem Gilani
#' @description
#' Returns the list of seasons an MBB athlete appeared in. Useful for
#' bounding follow-up calls to per-season endpoints.
#'
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per career season.
#'
#'    Columns as documented in the shared [espn_mbb_player_seasons_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   # LeBron James (1966): 23 career seasons
#'   espn_mbb_player_seasons(athlete_id = 4593919)
#' }
espn_mbb_player_seasons <- function(athlete_id, ...) {
  .espn_basketball_athlete_seasons(league = "mens-college-basketball",
                                     athlete_id = athlete_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_player_career_stats
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Athlete Career Stats (Long Format)**
#' @name espn_mbb_player_career_stats
#' @title
#' **Get ESPN MBB Athlete Career Stats (Long Format)**
#' @rdname espn_mbb_player_career_stats
#' @author Saiem Gilani
#' @description
#' Returns career stats for an MBB athlete in long format. Default
#' `stat_type = 0L` fetches the standard "All Splits" / regular-season
#' view. Pass a vector like `c(0L, 1L, 2L)` to attempt multiple types
#' and bind them via a `stat_type_id` column; variants that 404 for that
#' athlete are silently skipped. Stat types: 0 = regular season (default
#' endpoint), 1 = postseason, 2 = career aggregate. Coverage of types 1
#' and 2 is sparse — many athletes only have type 0 populated.
#'
#' @param athlete_id ESPN athlete identifier.
#' @param stat_type Integer or integer vector of stat-type codes.
#'   Default `0L` fetches the standard "All Splits" / regular-season view.
#'   Pass a vector like `c(0L, 1L, 2L)` to bind multiple types via a
#'   `stat_type_id` column; non-existent variants are silently skipped.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble (one row per stat_type × split × category × stat).
#'
#'    Columns as documented in the shared [espn_mbb_player_career_stats_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   # LeBron James — regular + postseason combined
#'   espn_mbb_player_career_stats(athlete_id = 4593919)
#'   # Just career aggregate
#'   espn_mbb_player_career_stats(athlete_id = 4593919, stat_type = 2L)
#' }
espn_mbb_player_career_stats <- function(athlete_id,
                                           stat_type = 0L,
                                           ...) {
  .espn_basketball_athlete_career_stats(league = "mens-college-basketball",
                                          athlete_id = athlete_id,
                                          stat_type = stat_type, ...)
}


# ---------------------------------------------------------------------------
# espn_mbb_player_eventlog_v2 (core-v2 per-season event log)
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Athlete Per-Season Event Log (core-v2)**
#' @name espn_mbb_player_eventlog_v2
NULL
#' @title
#' **Get ESPN MBB Athlete Per-Season Event Log (core-v2)**
#' @rdname espn_mbb_player_eventlog_v2
#' @author Saiem Gilani
#' @description
#' Returns one row per (event x team) for an MBB athlete's appearances
#' in a given season. Distinct from [espn_mbb_player_eventlog()] which
#' wraps the web-common-v3 endpoint; this core-v2 variant is era-correct.
#'
#' @param athlete_id ESPN athlete identifier.
#' @param season Season year. Defaults to most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per event appearance.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_player_eventlog_v2(athlete_id = 4683735, season = 2025)
#' }
espn_mbb_player_eventlog_v2 <- function(athlete_id,
                                          season = most_recent_mbb_season(),
                                          ...) {
  .espn_basketball_athlete_eventlog_v2(league = "mens-college-basketball",
                                      athlete_id = athlete_id,
                                      season = season, ...)
}
