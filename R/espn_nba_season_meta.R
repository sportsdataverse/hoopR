# espn_nba_season_meta.R
# Public NBA shims for ESPN season-metadata endpoints: types, leaders, rankings.

# ---------------------------------------------------------------------------
# espn_nba_season_types
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Types Index**
#' @name espn_nba_season_types
NULL
#' @title
#' **Get ESPN NBA Season Types Index**
#' @rdname espn_nba_season_types
#' @author Saiem Gilani
#' @description
#' Returns the index of season-type IDs that exist for one NBA season
#' (typically 1 = preseason, 2 = regular, 3 = postseason, 4 = off-season).
#' Pass an ID to [espn_nba_season_type()] for the start/end dates and
#' whether that type carries groups, standings, or legs.
#'
#' @param season Season year (numeric). Defaults to the most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per season type.
#'
#'    |col_name    |types     |description                       |
#'    |:-----------|:---------|:---------------------------------|
#'    |league      |character |League slug (`"nba"`).            |
#'    |season      |integer   |Season year.                      |
#'    |season_type |integer   |Season-type id (1/2/3/4).         |
#'    |ref         |character |`$ref` URL for the type detail.   |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_season_types(season = 2025)
#' }
espn_nba_season_types <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_season_types(league = "nba", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_season_type
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season-Type Detail**
#' @name espn_nba_season_type
#' @title
#' **Get ESPN NBA Season-Type Detail**
#' @rdname espn_nba_season_type
#' @author Saiem Gilani
#' @description
#' Returns metadata for one season-type within an NBA season: name,
#' abbreviation, start / end dates, and whether it carries groups,
#' standings, or playoff legs.
#'
#' @param season_type Season-type id (1 = preseason, 2 = regular (default),
#'   3 = postseason, 4 = off-season).
#' @param season Season year. Defaults to most recent NBA season.
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_season_type(season_type = 2, season = 2025)
#' }
espn_nba_season_type <- function(season_type = 2L,
                                  season = most_recent_nba_season(),
                                  ...) {
  .espn_basketball_season_type(league = "nba", season = season,
                                 season_type = season_type, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_season_leaders
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Leaders (Long Format)**
#' @name espn_nba_season_leaders
#' @title
#' **Get ESPN NBA Season Leaders (Long Format)**
#' @rdname espn_nba_season_leaders
#' @author Saiem Gilani
#' @description
#' Returns the per-category leaderboard for one (NBA season x season-type),
#' in long format. Each row is one (category x rank) entry, e.g.
#' "Points Per Game x rank 1 x LeBron James".
#'
#' @param season Season year. Defaults to most recent NBA season.
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_season_leaders(season = 2025)
#' }
espn_nba_season_leaders <- function(season = most_recent_nba_season(),
                                     season_type = c(2L, 3L), ...) {
  .espn_basketball_season_leaders(league = "nba", season = season,
                                    season_type = season_type, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_season_rankings
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Rankings Index**
#' @name espn_nba_season_rankings
#' @title
#' **Get ESPN NBA Season Rankings Index**
#' @rdname espn_nba_season_rankings
#' @author Saiem Gilani
#' @description
#' Returns the index of season-level rankings recorded for one NBA season.
#' NBA + WNBA typically return zero rankings (ranking polls are a
#' college concept); the wrapper is provided for symmetry across leagues.
#' For MBB / WBB use the matching `espn_mbb_season_rankings()` /
#' `espn_wbb_season_rankings()`.
#'
#' @param season Season year. Defaults to most recent NBA season.
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_season_rankings(season = 2025)
#' }
espn_nba_season_rankings <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_season_rankings(league = "nba", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_season_ranking
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Season Ranking Detail**
#' @name espn_nba_season_ranking
#' @title
#' **Get ESPN NBA Season Ranking Detail**
#' @rdname espn_nba_season_ranking
#' @author Saiem Gilani
#' @description
#' Returns the per-week snapshot index for one ranking source (e.g. AP
#' Top 25). Each row is one weekly snapshot; the `ref` URL resolves to
#' the actual ranked teams for that (season-type x week) and will be
#' wrapped by a forthcoming `espn_nba_week_ranking()`.
#'
#' @param ranking_id ESPN ranking identifier (character or numeric).
#' @param season Season year. Defaults to most recent NBA season.
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_season_ranking(ranking_id = 1, season = 2025)
#' }
espn_nba_season_ranking <- function(ranking_id,
                                     season = most_recent_nba_season(),
                                     ...) {
  .espn_basketball_season_ranking(league = "nba", season = season,
                                    ranking_id = ranking_id, ...)
}
