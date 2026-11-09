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
#' ESPN - including the NCAA Tournament, NIT, conference tournaments,
#' and other in-season events. Pass an ID to [espn_mbb_tournament()]
#' for the human-readable name and seasons-list ref.
#'
#' @param ... Additional arguments; currently unused.
#' @eval .returns_rd("espn_mbb_tournaments", unit = "tournament")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
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
#' @eval .returns_rd("espn_mbb_tournament", unit = "tournament")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_tournament(tournament_id = 3)
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
#' @eval .returns_rd("espn_mbb_tournament_seasons", unit = "season")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_tournament_seasons(tournament_id = 3)
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
#' @concept ESPN MBB Functions
#' @seealso [family_espn_mbb] lists every function in this family.
#' @examples
#' \donttest{
#'   espn_mbb_tournament_season(tournament_id = 3, season = 2024)
#' }
espn_mbb_tournament_season <- function(tournament_id, season, ...) {
  .espn_basketball_tournament_season(league = "mens-college-basketball",
                                       tournament_id = tournament_id,
                                       season = season, ...)
}
