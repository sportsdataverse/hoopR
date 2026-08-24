# espn_mbb_weeks.R
# Public MBB shims for ESPN week + week-ranking endpoints.

# ---------------------------------------------------------------------------
# espn_mbb_season_weeks
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Weeks Index**
#' @name espn_mbb_season_weeks
NULL
#' @title
#' **Get ESPN MBB Season Weeks Index**
#' @rdname espn_mbb_season_weeks
#' @author Saiem Gilani
#' @description
#' Returns the list of week IDs for one (MBB season x season-type). MBB
#' uses a week structure inherited from ESPN's schema, but week-level
#' rankings are populated only for college (MBB / WBB).
#'
#' @param season Season year. Defaults to most recent MBB season.
#' @param season_type Season-type id (2 = regular (default), 3 = postseason).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per week.
#'
#'    Columns as documented in the shared [espn_mbb_season_weeks_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_weeks(season = 2025)
#' }
espn_mbb_season_weeks <- function(season = most_recent_mbb_season(),
                                   season_type = c(2L, 3L), ...) {
  .espn_basketball_season_weeks(league = "mens-college-basketball", season = season,
                                  season_type = season_type, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_season_week
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season-Week Detail**
#' @name espn_mbb_season_week
#' @title
#' **Get ESPN MBB Season-Week Detail**
#' @rdname espn_mbb_season_week
#' @author Saiem Gilani
#' @description
#' Returns metadata for one week (number, start / end dates, text label,
#' and `$ref` to the per-week rankings endpoint).
#'
#' @param week Week number.
#' @param season Season year. Defaults to most recent MBB season.
#' @param season_type Season-type id (2 = regular (default)).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#'
#'    Columns as documented in the shared [espn_mbb_season_week_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_week(week = 5, season = 2025)
#' }
espn_mbb_season_week <- function(week,
                                  season = most_recent_mbb_season(),
                                  season_type = 2L, ...) {
  .espn_basketball_season_week(league = "mens-college-basketball", season = season,
                                 season_type = season_type,
                                 week = week, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_week_rankings
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Per-Week Rankings Index**
#' @name espn_mbb_week_rankings
#' @title
#' **Get ESPN MBB Per-Week Rankings Index**
#' @rdname espn_mbb_week_rankings
#' @author Saiem Gilani
#' @description
#' Returns the index of ranking sources available for one (MBB season x
#' season-type x week). Typical sources: AP Top 25 (id 1), Coaches Poll
#' (id 2). Pass an id to [espn_mbb_week_ranking()] for the ranked teams.
#'
#' @param week Week number.
#' @param season Season year. Defaults to most recent MBB season.
#' @param season_type Season-type id (2 = regular (default)).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per ranking source.
#'
#'    Columns as documented in the shared [espn_mbb_week_rankings_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_week_rankings(week = 5, season = 2025)
#' }
espn_mbb_week_rankings <- function(week,
                                    season = most_recent_mbb_season(),
                                    season_type = 2L, ...) {
  .espn_basketball_week_rankings(league = "mens-college-basketball", season = season,
                                   season_type = season_type,
                                   week = week, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_week_ranking
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Per-Week Ranking Detail**
#' @name espn_mbb_week_ranking
#' @title
#' **Get ESPN MBB Per-Week Ranking Detail**
#' @rdname espn_mbb_week_ranking
#' @author Saiem Gilani
#' @description
#' Returns the long-format ranked teams for one (season x season-type x
#' week x ranking-source). Typically 25 rows for MBB (AP Top 25).
#'
#' @param ranking_id Ranking source id (1 = AP, 2 = Coaches, etc.).
#' @param week Week number.
#' @param season Season year. Defaults to most recent MBB season.
#' @param season_type Season-type id (2 = regular (default)).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per ranked team (typically 25).
#'
#'    Columns as documented in the shared [espn_mbb_week_ranking_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_week_ranking(ranking_id = 1, week = 5, season = 2025)
#' }
espn_mbb_week_ranking <- function(ranking_id, week,
                                   season = most_recent_mbb_season(),
                                   season_type = 2L, ...) {
  .espn_basketball_week_ranking(league = "mens-college-basketball", season = season,
                                  season_type = season_type,
                                  week = week,
                                  ranking_id = ranking_id, ...)
}
