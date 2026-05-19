# espn_mbb_tournaments.R
# Public MBB shims for ESPN tournaments endpoints.

# ---------------------------------------------------------------------------
# espn_mbb_tournaments
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Tournaments Index**
#' @name espn_mbb_tournaments
NULL
#' @title
#' **Get ESPN MBB Tournaments Index**
#' @rdname espn_mbb_tournaments
#' @author Saiem Gilani
#' @description
#' Returns the index of men's college basketball tournaments tracked by
#' ESPN — including the NCAA Tournament, NIT, conference tournaments,
#' and other in-season events. Pass an ID to [espn_mbb_tournament()]
#' for the human-readable name and seasons-list ref.
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per tournament.
#'
#'    |col_name      |types     |description                                |
#'    |:-------------|:---------|:------------------------------------------|
#'    |tournament_id |character |ESPN tournament identifier.                |
#'    |ref           |character |Full `$ref` URL for the detail.            |
#'    |league        |character |League slug (`"mens-college-basketball"`). |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_tournaments()
#' }
espn_mbb_tournaments <- function(...) {
  .espn_basketball_tournaments(league = "mens-college-basketball", ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_tournament
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Tournament Detail**
#' @name espn_mbb_tournament
NULL
#' @title
#' **Get ESPN MBB Tournament Detail**
#' @rdname espn_mbb_tournament
#' @author Saiem Gilani
#' @description
#' Returns metadata for a single MBB tournament plus the `$ref` URL for
#' the tournament's seasons list. Tournament IDs of interest include
#' the NCAA Tournament and NIT (resolve via [espn_mbb_tournaments()]).
#'
#' @param tournament_id ESPN tournament identifier.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#'
#'    |col_name      |types     |description                                    |
#'    |:-------------|:---------|:----------------------------------------------|
#'    |tournament_id |character |ESPN tournament identifier.                    |
#'    |display_name  |character |Human-readable tournament name.                |
#'    |seasons_ref   |character |`$ref` to the seasons-list endpoint.           |
#'    |league        |character |League slug.                                   |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_tournament(tournament_id = 22)
#' }
espn_mbb_tournament <- function(tournament_id, ...) {
  .espn_basketball_tournament(league = "mens-college-basketball",
                               tournament_id = tournament_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_tournament_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Tournament Seasons List**
#' @name espn_mbb_tournament_seasons
NULL
#' @title
#' **Get ESPN MBB Tournament Seasons List**
#' @rdname espn_mbb_tournament_seasons
#' @author Saiem Gilani
#' @description
#' Returns the seasons in which a given MBB tournament was held.
#'
#' @param tournament_id ESPN tournament identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per season.
#'
#'    |col_name      |types     |description                              |
#'    |:-------------|:---------|:----------------------------------------|
#'    |league        |character |League slug.                             |
#'    |tournament_id |character |ESPN tournament identifier.              |
#'    |season        |integer   |Season year.                             |
#'    |ref           |character |Full `$ref` URL for that season.         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_tournament_seasons(tournament_id = 22)
#' }
espn_mbb_tournament_seasons <- function(tournament_id, ...) {
  .espn_basketball_tournament_seasons(league = "mens-college-basketball",
                                       tournament_id = tournament_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_tournament_season
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Tournament Season Detail**
#' @name espn_mbb_tournament_season
NULL
#' @title
#' **Get ESPN MBB Tournament Season Detail**
#' @rdname espn_mbb_tournament_season
#' @author Saiem Gilani
#' @description
#' Returns single-row detail for one (tournament, season) pair: id,
#' display name, number of rounds, and `$ref`s to the season + bracketology
#' resources. Use [espn_mbb_tournament_seasons()] to enumerate valid
#' (tournament_id, season) pairs.
#'
#' @param tournament_id ESPN tournament identifier.
#' @param season Season year (numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_tournament_season(tournament_id = 1, season = 2024)
#' }
espn_mbb_tournament_season <- function(tournament_id, season, ...) {
  .espn_basketball_tournament_season(league = "mens-college-basketball",
                                       tournament_id = tournament_id,
                                       season = season, ...)
}
