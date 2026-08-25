# espn_nba_tournaments.R
# Public NBA shims for ESPN tournaments endpoints (e.g. the in-season
# tournament and other NBA-branded tournaments).

# ---------------------------------------------------------------------------
# espn_nba_tournaments
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Tournaments Index**
#' @rdname espn_mbb_tournaments
#' @name espn_nba_tournaments
NULL
#' @title
#' **Get ESPN NBA Tournaments Index**
#' @rdname espn_mbb_tournaments
#' @author Saiem Gilani
#' @description
#' Returns the index of NBA-branded tournaments tracked by ESPN
#' (e.g. the in-season tournament). Each row is one tournament with its
#' ID and the `$ref` URL.
#'
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per tournament.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       tournament_id \tab character \tab ESPN tournament identifier. \cr
#'       ref \tab character \tab Full \verb{$ref} URL for the detail. \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname espn_mbb_tournament
#' @name espn_nba_tournament
NULL
#' @title
#' **Get ESPN NBA Tournament Detail**
#' @rdname espn_mbb_tournament
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       tournament_id \tab character \tab ESPN tournament identifier. \cr
#'       display_name \tab character \tab Human-readable tournament name. \cr
#'       seasons_ref \tab character \tab \verb{$ref} to the seasons-list endpoint. \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname espn_mbb_tournament_seasons
#' @name espn_nba_tournament_seasons
NULL
#' @title
#' **Get ESPN NBA Tournament Seasons List**
#' @rdname espn_mbb_tournament_seasons
#' @author Saiem Gilani
#' @description
#' Returns the seasons in which a given NBA tournament was held.
#'
#' @param tournament_id ESPN tournament identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per season.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League slug (\code{"nba"}). \cr
#'       tournament_id \tab character \tab ESPN tournament identifier. \cr
#'       season \tab integer \tab Season year. \cr
#'       ref \tab character \tab Full \verb{$ref} URL for that season. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
#' @rdname espn_mbb_tournament_season
#' @name espn_nba_tournament_season
NULL
#' @title
#' **Get ESPN NBA Tournament Season Detail**
#' @rdname espn_mbb_tournament_season
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
