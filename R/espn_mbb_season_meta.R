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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League slug (\code{"mens-college-basketball"}). \cr
#'       season \tab integer \tab Season year. \cr
#'       season_type \tab integer \tab Season-type id (1/2/3/4). \cr
#'       ref \tab character \tab \verb{$ref} URL for the type detail. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#'    Columns as documented in the shared [espn_mbb_season_type_schema] table.
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
#'    Columns as documented in the shared [espn_mbb_season_leaders_schema] table.
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
                                     season_type = c(2L, 3L), ...) {
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League slug. \cr
#'       season \tab integer \tab Season year. \cr
#'       ranking_id \tab character \tab ESPN ranking id. \cr
#'       ref \tab character \tab \verb{$ref} URL for the ranking detail. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#'    Columns as documented in the shared [espn_mbb_season_ranking_schema] table.
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
