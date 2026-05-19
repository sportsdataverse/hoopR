# espn_nba_athlete_career.R
# Public NBA shims for athlete career-level core-v2 endpoints.

# ---------------------------------------------------------------------------
# espn_nba_athlete_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Career Seasons**
#' @name espn_nba_athlete_seasons
NULL
#' @title
#' **Get ESPN NBA Athlete Career Seasons**
#' @rdname espn_nba_athlete_seasons
#' @author Saiem Gilani
#' @description
#' Returns the list of seasons an NBA athlete appeared in. Useful for
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   # LeBron James (1966): 23 career seasons
#'   espn_nba_athlete_seasons(athlete_id = 1966)
#' }
espn_nba_athlete_seasons <- function(athlete_id, ...) {
  .espn_basketball_athlete_seasons(league = "nba",
                                     athlete_id = athlete_id, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_career_stats
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Career Stats (Long Format)**
#' @name espn_nba_athlete_career_stats
#' @title
#' **Get ESPN NBA Athlete Career Stats (Long Format)**
#' @rdname espn_nba_athlete_career_stats
#' @author Saiem Gilani
#' @description
#' Returns career stats for an NBA athlete in long format. Default
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   # LeBron James — regular + postseason combined
#'   espn_nba_athlete_career_stats(athlete_id = 1966)
#'   # Just career aggregate
#'   espn_nba_athlete_career_stats(athlete_id = 1966, stat_type = 2L)
#' }
espn_nba_athlete_career_stats <- function(athlete_id,
                                           stat_type = 0L,
                                           ...) {
  .espn_basketball_athlete_career_stats(league = "nba",
                                          athlete_id = athlete_id,
                                          stat_type = stat_type, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_draft_pick
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Draft Pick Detail**
#' @name espn_nba_draft_pick
#' @title
#' **Get ESPN NBA Draft Pick Detail**
#' @rdname espn_nba_draft_pick
#' @author Saiem Gilani
#' @description
#' Returns a single NBA draft pick. Defaults to the most recent NBA
#' season's #1 overall pick. For a full draft, use [espn_nba_draft()].
#'
#' @param season Season year. Defaults to most recent NBA season.
#' @param round Draft round (default 1).
#' @param pick Pick number within the round (default 1).
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#'
#'    |col_name    |types     |description                                |
#'    |:-----------|:---------|:------------------------------------------|
#'    |league      |character |League slug.                               |
#'    |season      |integer   |Season year of the draft.                  |
#'    |round       |integer   |Round number.                              |
#'    |pick        |integer   |Pick within the round.                     |
#'    |overall     |integer   |Overall pick number.                       |
#'    |traded      |logical   |Whether the pick was traded.               |
#'    |trade_note  |character |Trade note (if any).                       |
#'    |status      |character |Pick status name.                          |
#'    |athlete_id  |character |Drafted athlete's ESPN id.                 |
#'    |team_id     |character |Drafting team's ESPN id.                   |
#'    |athlete_ref |character |`$ref` to athlete.                         |
#'    |team_ref    |character |`$ref` to team.                            |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_draft_pick(season = 2024, round = 1, pick = 1)
#' }
espn_nba_draft_pick <- function(season = most_recent_nba_season(),
                                 round = 1L, pick = 1L, ...) {
  .espn_basketball_draft_pick(league = "nba", season = season,
                                round = round, pick = pick, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_athlete_eventlog_v2 (core-v2 per-season event log)
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Per-Season Event Log (core-v2)**
#' @name espn_nba_athlete_eventlog_v2
NULL
#' @title
#' **Get ESPN NBA Athlete Per-Season Event Log (core-v2)**
#' @rdname espn_nba_athlete_eventlog_v2
#' @author Saiem Gilani
#' @description
#' Returns one row per (event x team) for an NBA athlete's appearances
#' in a given season. Distinct from [espn_nba_athlete_eventlog()] which
#' wraps the web-common-v3 gamelog endpoint returning stats per game;
#' this core-v2 variant returns refs + `played` flag and is era-correct.
#'
#' @param athlete_id ESPN athlete identifier.
#' @param season Season year. Defaults to most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per event appearance. See package source
#'   for column schema.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_athlete_eventlog_v2(athlete_id = 1966, season = 2025)
#' }
espn_nba_athlete_eventlog_v2 <- function(athlete_id,
                                          season = most_recent_nba_season(),
                                          ...) {
  .espn_basketball_athlete_eventlog_v2(league = "nba",
                                      athlete_id = athlete_id,
                                      season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_draft_rounds
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Draft Rounds Summary**
#' @name espn_nba_draft_rounds
#' @title
#' **Get ESPN NBA Draft Rounds Summary**
#' @rdname espn_nba_draft_rounds
#' @author Saiem Gilani
#' @description
#' Returns one row per round of the NBA draft (typically 2 rounds:
#' 1st with 30 picks, 2nd with ~28 picks).
#'
#' @param season Season year. Defaults to most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per round.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_draft_rounds(season = 2024)
#' }
espn_nba_draft_rounds <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_draft_rounds(league = "nba", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_draft_athletes
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Draft Athletes Index**
#' @name espn_nba_draft_athletes
#' @title
#' **Get ESPN NBA Draft Athletes Index**
#' @rdname espn_nba_draft_athletes
#' @author Saiem Gilani
#' @description
#' Returns one row per drafted athlete in a given NBA draft year.
#'
#' @param season Season year. Defaults to most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble of athlete IDs + `$ref` URLs.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_draft_athletes(season = 2024)
#' }
espn_nba_draft_athletes <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_draft_athletes(league = "nba", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_draft_status
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Draft Status**
#' @name espn_nba_draft_status
#' @title
#' **Get ESPN NBA Draft Status**
#' @rdname espn_nba_draft_status
#' @author Saiem Gilani
#' @description
#' Returns the current status of one NBA draft year (round, state,
#' description). Live during the draft; static afterward.
#'
#' @param season Season year. Defaults to most recent NBA season.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_draft_status(season = 2024)
#' }
espn_nba_draft_status <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_draft_status(league = "nba", season = season, ...)
}
