# espn_mbb_athlete_career.R
# Public MBB shims for athlete career-level core-v2 endpoints.

# ---------------------------------------------------------------------------
# espn_mbb_athlete_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Athlete Career Seasons**
#' @name espn_mbb_athlete_seasons
NULL
#' @title
#' **Get ESPN MBB Athlete Career Seasons**
#' @rdname espn_mbb_athlete_seasons
#' @author Saiem Gilani
#' @description
#' Returns the list of seasons an MBB athlete appeared in. Useful for
#' bounding follow-up calls to per-season endpoints.
#'
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per career season.
#'
#'    |col_name   |types     |description                              |
#'    |:----------|:---------|:----------------------------------------|
#'    |league     |character |League slug.                             |
#'    |athlete_id |character |ESPN athlete id.                         |
#'    |season     |integer   |Season year.                             |
#'    |ref        |character |`$ref` URL to the season detail.         |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   # LeBron James (1966): 23 career seasons
#'   espn_mbb_athlete_seasons(athlete_id = 1966)
#' }
espn_mbb_athlete_seasons <- function(athlete_id, ...) {
  .espn_basketball_athlete_seasons(league = "mens-college-basketball",
                                     athlete_id = athlete_id, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_athlete_career_stats
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Athlete Career Stats (Long Format)**
#' @name espn_mbb_athlete_career_stats
#' @title
#' **Get ESPN MBB Athlete Career Stats (Long Format)**
#' @rdname espn_mbb_athlete_career_stats
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
#'    |col_name         |types     |description                                |
#'    |:----------------|:---------|:------------------------------------------|
#'    |league           |character |League slug.                               |
#'    |athlete_id       |character |ESPN athlete id.                           |
#'    |stat_type_id     |character |Stat-type code (0 = reg, 1 = post, 2 = career). |
#'    |split_id         |character |Split id.                                  |
#'    |split_name       |character |Split name (typically "All Splits").       |
#'    |split_type       |character |Split type code.                           |
#'    |category_name    |character |Category key (e.g. "defensive").           |
#'    |category_display |character |Category display name.                     |
#'    |category_short   |character |Category short display.                    |
#'    |category_abbrev  |character |Category abbreviation.                     |
#'    |stat_name        |character |Stat key.                                  |
#'    |stat_abbrev      |character |Stat abbreviation.                         |
#'    |stat_display     |character |Stat display name.                         |
#'    |stat_short       |character |Stat short display.                        |
#'    |description      |character |Stat description.                          |
#'    |value            |numeric   |Stat value.                                |
#'    |display_value    |character |Display-formatted value.                   |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   # LeBron James — regular + postseason combined
#'   espn_mbb_athlete_career_stats(athlete_id = 1966)
#'   # Just career aggregate
#'   espn_mbb_athlete_career_stats(athlete_id = 1966, stat_type = 2L)
#' }
espn_mbb_athlete_career_stats <- function(athlete_id,
                                           stat_type = 0L,
                                           ...) {
  .espn_basketball_athlete_career_stats(league = "mens-college-basketball",
                                          athlete_id = athlete_id,
                                          stat_type = stat_type, ...)
}

