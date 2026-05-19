# espn_nba_tournaments.R
# Public NBA shims for ESPN tournaments endpoints (e.g. the in-season
# tournament and other NBA-branded tournaments).

# ---------------------------------------------------------------------------
# espn_nba_tournaments
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Tournaments Index**
#' @name espn_nba_tournaments
NULL
#' @title
#' **Get ESPN NBA Tournaments Index**
#' @rdname espn_nba_tournaments
#' @author Saiem Gilani
#' @description
#' Returns the index of NBA-branded tournaments tracked by ESPN
#' (e.g. the in-season tournament). Each row is one tournament with its
#' ID and the `$ref` URL.
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per tournament.
#'
#'    |col_name      |types     |description                         |
#'    |:-------------|:---------|:-----------------------------------|
#'    |tournament_id |character |ESPN tournament identifier.         |
#'    |ref           |character |Full `$ref` URL for the detail.     |
#'    |league        |character |League slug (`"nba"`).              |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_tournaments()
#' }
espn_nba_tournaments <- function(...) {
  .espn_basketball_tournaments(league = "nba", ...)
}

# ---------------------------------------------------------------------------
# espn_nba_tournament
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Tournament Detail**
#' @name espn_nba_tournament
NULL
#' @title
#' **Get ESPN NBA Tournament Detail**
#' @rdname espn_nba_tournament
#' @author Saiem Gilani
#' @description
#' Returns metadata for a single tournament plus the `$ref` URL for the
#' tournament's seasons list. Use [espn_nba_tournament_seasons()] to
#' resolve the seasons.
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
#'    |league        |character |League slug (`"nba"`).                         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_tournament(tournament_id = 1)
#' }
espn_nba_tournament <- function(tournament_id, ...) {
  .espn_basketball_tournament(league = "nba",
                               tournament_id = tournament_id, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_tournament_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Tournament Seasons List**
#' @name espn_nba_tournament_seasons
NULL
#' @title
#' **Get ESPN NBA Tournament Seasons List**
#' @rdname espn_nba_tournament_seasons
#' @author Saiem Gilani
#' @description
#' Returns the seasons in which a given NBA tournament was held.
#'
#' @param tournament_id ESPN tournament identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per season.
#'
#'    |col_name      |types     |description                              |
#'    |:-------------|:---------|:----------------------------------------|
#'    |league        |character |League slug (`"nba"`).                   |
#'    |tournament_id |character |ESPN tournament identifier.              |
#'    |season        |integer   |Season year.                             |
#'    |ref           |character |Full `$ref` URL for that season.         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_tournament_seasons(tournament_id = 1)
#' }
espn_nba_tournament_seasons <- function(tournament_id, ...) {
  .espn_basketball_tournament_seasons(league = "nba",
                                       tournament_id = tournament_id, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_tournament_season
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Tournament Season Detail**
#' @name espn_nba_tournament_season
NULL
#' @title
#' **Get ESPN NBA Tournament Season Detail**
#' @rdname espn_nba_tournament_season
#' @author Saiem Gilani
#' @description
#' Returns single-row detail for one (tournament, season) pair: id,
#' display name, number of rounds, and `$ref`s to the season + bracketology
#' resources. Use [espn_nba_tournament_seasons()] to enumerate valid
#' (tournament_id, season) pairs.
#'
#' @param tournament_id ESPN tournament identifier.
#' @param season Season year (numeric).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_tournament_season(tournament_id = 1, season = 2024)
#' }
espn_nba_tournament_season <- function(tournament_id, season, ...) {
  .espn_basketball_tournament_season(league = "nba",
                                       tournament_id = tournament_id,
                                       season = season, ...)
}
