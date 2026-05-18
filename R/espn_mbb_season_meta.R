# espn_mbb_season_meta.R
# Public MBB shims for ESPN season-metadata endpoints: types, leaders, rankings.

# ---------------------------------------------------------------------------
# espn_mbb_season_types
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Types Index**
#' @name espn_mbb_season_types
NULL
#' @title
#' **Get ESPN MBB Season Types Index**
#' @rdname espn_mbb_season_types
#' @author Saiem Gilani
#' @description
#' Returns the index of season-type IDs that exist for one MBB season
#' (typically 1 = preseason, 2 = regular, 3 = postseason, 4 = off-season).
#' Pass an ID to [espn_mbb_season_type()] for the start/end dates and
#' whether that type carries groups, standings, or legs.
#'
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per season type.
#'
#'    |col_name    |types     |description                       |
#'    |:-----------|:---------|:---------------------------------|
#'    |league      |character |League slug (`"mens-college-basketball"`).            |
#'    |season      |integer   |Season year.                      |
#'    |season_type |integer   |Season-type id (1/2/3/4).         |
#'    |ref         |character |`$ref` URL for the type detail.   |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_types(season = 2025)
#' }
espn_mbb_season_types <- function(season = most_recent_mbb_season(), ...) {
  .espn_basketball_season_types(league = "mens-college-basketball", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_season_type
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season-Type Detail**
#' @name espn_mbb_season_type
#' @title
#' **Get ESPN MBB Season-Type Detail**
#' @rdname espn_mbb_season_type
#' @author Saiem Gilani
#' @description
#' Returns metadata for one season-type within an MBB season: name,
#' abbreviation, start / end dates, and whether it carries groups,
#' standings, or playoff legs.
#'
#' @param season_type Season-type id (1 = preseason, 2 = regular (default),
#'   3 = postseason, 4 = off-season).
#' @param season Season year. Defaults to most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#'
#'    |col_name      |types     |description                                |
#'    |:-------------|:---------|:------------------------------------------|
#'    |league        |character |League slug.                               |
#'    |season        |integer   |Season year.                               |
#'    |season_type   |integer   |Season-type id.                            |
#'    |type          |integer   |Numeric type code.                         |
#'    |name          |character |Display name (e.g. "Regular Season").      |
#'    |abbreviation  |character |Short code (e.g. "reg").                   |
#'    |year          |integer   |Year stamp.                                |
#'    |start_date    |character |ISO 8601 start date.                       |
#'    |end_date      |character |ISO 8601 end date.                         |
#'    |has_groups    |logical   |Whether groups exist for this type.        |
#'    |has_standings |logical   |Whether standings exist.                   |
#'    |has_legs      |logical   |Whether playoff legs exist.                |
#'    |slug          |character |URL slug.                                  |
#'    |groups_ref    |character |`$ref` to the groups endpoint.             |
#'    |weeks_ref     |character |`$ref` to the weeks endpoint.              |
#'    |leaders_ref   |character |`$ref` to the leaders endpoint.            |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_type(season_type = 2, season = 2025)
#' }
espn_mbb_season_type <- function(season_type = 2L,
                                  season = most_recent_mbb_season(),
                                  ...) {
  .espn_basketball_season_type(league = "mens-college-basketball", season = season,
                                 season_type = season_type, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_season_leaders
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Leaders (Long Format)**
#' @name espn_mbb_season_leaders
#' @title
#' **Get ESPN MBB Season Leaders (Long Format)**
#' @rdname espn_mbb_season_leaders
#' @author Saiem Gilani
#' @description
#' Returns the per-category leaderboard for one (MBB season x season-type),
#' in long format. Each row is one (category x rank) entry, e.g.
#' "Points Per Game x rank 1 x LeBron James".
#'
#' @param season Season year. Defaults to most recent MBB season.
#' @param season_type Season-type id (2 = regular (default), 3 = postseason).
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x leader).
#'
#'    |col_name         |types     |description                              |
#'    |:----------------|:---------|:----------------------------------------|
#'    |league           |character |League slug.                             |
#'    |season           |integer   |Season year.                             |
#'    |season_type      |integer   |Season-type id.                          |
#'    |category_name    |character |Internal category key (e.g. "pointsPerGame"). |
#'    |category_display |character |Human-readable category name.            |
#'    |category_short   |character |Short display name.                      |
#'    |category_abbrev  |character |Stat abbreviation (e.g. "PTS").          |
#'    |rank             |integer   |Rank within the category (1 = best).     |
#'    |athlete_id       |character |ESPN athlete id.                         |
#'    |team_id          |character |ESPN team id.                            |
#'    |display_value    |character |Display-formatted value.                 |
#'    |value            |numeric   |Numeric leader value.                    |
#'    |rel              |character |Comma-joined `rel` tags from ESPN.       |
#'    |athlete_ref      |character |`$ref` URL to the leader's athlete.      |
#'    |team_ref         |character |`$ref` URL to the leader's team.         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_leaders(season = 2025)
#' }
espn_mbb_season_leaders <- function(season = most_recent_mbb_season(),
                                     season_type = 2L, ...) {
  .espn_basketball_season_leaders(league = "mens-college-basketball", season = season,
                                    season_type = season_type, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_season_rankings
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Rankings Index**
#' @name espn_mbb_season_rankings
#' @title
#' **Get ESPN MBB Season Rankings Index**
#' @rdname espn_mbb_season_rankings
#' @author Saiem Gilani
#' @description
#' Returns the index of season-level rankings recorded for one MBB season.
#' Typical sources: AP Top 25 (id 1), Coaches Poll (id 2). Pass an
#' `ranking_id` to [espn_mbb_season_ranking()] for the ranked teams.
#'
#' @param season Season year. Defaults to most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per ranking source.
#'
#'    |col_name   |types     |description                          |
#'    |:----------|:---------|:------------------------------------|
#'    |league     |character |League slug.                         |
#'    |season     |integer   |Season year.                         |
#'    |ranking_id |character |ESPN ranking id.                     |
#'    |ref        |character |`$ref` URL for the ranking detail.   |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_rankings(season = 2025)
#' }
espn_mbb_season_rankings <- function(season = most_recent_mbb_season(), ...) {
  .espn_basketball_season_rankings(league = "mens-college-basketball", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_season_ranking
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Season Ranking Detail**
#' @name espn_mbb_season_ranking
#' @title
#' **Get ESPN MBB Season Ranking Detail**
#' @rdname espn_mbb_season_ranking
#' @author Saiem Gilani
#' @description
#' Returns the per-week snapshot index for one ranking source (e.g. AP
#' Top 25). Each row is one weekly snapshot; the `ref` URL resolves to
#' the actual ranked teams for that (season-type x week) and will be
#' wrapped by a forthcoming `espn_LOWERMBB_week_ranking()`.
#'
#' @param ranking_id ESPN ranking identifier (character or numeric).
#' @param season Season year. Defaults to most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per weekly snapshot.
#'
#'    |col_name    |types     |description                                |
#'    |:-----------|:---------|:------------------------------------------|
#'    |league      |character |League slug.                               |
#'    |season      |integer   |Season year.                               |
#'    |ranking_id  |character |ESPN ranking id.                           |
#'    |name        |character |Ranking name (e.g. "AP Top 25").           |
#'    |short_name  |character |Short name (e.g. "AP Poll").               |
#'    |type        |character |Ranking type code (e.g. "ap").             |
#'    |season_type |integer   |Season-type id of this snapshot.           |
#'    |week        |integer   |Week number of this snapshot.              |
#'    |ref         |character |`$ref` URL for the per-week ranking detail.|
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_season_ranking(ranking_id = 1, season = 2025)
#' }
espn_mbb_season_ranking <- function(ranking_id,
                                     season = most_recent_mbb_season(),
                                     ...) {
  .espn_basketball_season_ranking(league = "mens-college-basketball", season = season,
                                    ranking_id = ranking_id, ...)
}
