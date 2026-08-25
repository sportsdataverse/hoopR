# espn_nba_athlete_career.R
# Public NBA shims for athlete career-level core-v2 endpoints.

# ---------------------------------------------------------------------------
# espn_nba_player_seasons
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Career Seasons**
#' @rdname espn_mbb_player_seasons
#' @name espn_nba_player_seasons
NULL
#' @title
#' **Get ESPN NBA Athlete Career Seasons**
#' @rdname espn_mbb_player_seasons
#' @author Saiem Gilani
#' @description
#' Returns the list of seasons an NBA athlete appeared in. Useful for
#' bounding follow-up calls to per-season endpoints.
#'
#' @param athlete_id ESPN athlete identifier (character or numeric).
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per career season.
#'
#'    Columns as documented in the shared [espn_mbb_player_seasons_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   # LeBron James (1966): 23 career seasons
#'   espn_nba_player_seasons(athlete_id = 1966)
#' }
espn_nba_player_seasons <- function(athlete_id, ...) {
  .espn_basketball_athlete_seasons(league = "nba",
                                     athlete_id = athlete_id, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_player_career_stats
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Career Stats (Long Format)**
#' @name espn_nba_player_career_stats
#' @title
#' **Get ESPN NBA Athlete Career Stats (Long Format)**
#' @rdname espn_mbb_player_career_stats
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
#'    Columns as documented in the shared [espn_mbb_player_career_stats_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   # LeBron James — regular + postseason combined
#'   espn_nba_player_career_stats(athlete_id = 1966)
#'   # Just career aggregate
#'   espn_nba_player_career_stats(athlete_id = 1966, stat_type = 2L)
#' }
espn_nba_player_career_stats <- function(athlete_id,
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
#' @rdname espn_nba_draft
#' @author Saiem Gilani
#' @description
#' Returns a single NBA draft pick. Defaults to the most recent NBA
#' season's #1 overall pick. For a full draft, use [espn_nba_draft()].
#'
#' @param round Draft round (default 1).
#' @param pick Pick number within the round (default 1).
#' @return A single-row tibble.
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       league \tab character \tab League slug. \cr
#'       season \tab integer \tab Season year of the draft. \cr
#'       round \tab integer \tab Round number. \cr
#'       pick \tab integer \tab Pick within the round. \cr
#'       overall \tab integer \tab Overall pick number. \cr
#'       traded \tab logical \tab Whether the pick was traded. \cr
#'       trade_note \tab character \tab Trade note (if any). \cr
#'       status \tab character \tab Pick status name. \cr
#'       athlete_id \tab character \tab Drafted athlete's ESPN id. \cr
#'       team_id \tab character \tab Drafting team's ESPN id. \cr
#'       athlete_ref \tab character \tab \verb{$ref} to athlete. \cr
#'       team_ref \tab character \tab \verb{$ref} to team. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
# espn_nba_player_eventlog_v2 (core-v2 per-season event log)
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Athlete Per-Season Event Log (core-v2)**
#' @rdname espn_mbb_player_eventlog_v2
#' @name espn_nba_player_eventlog_v2
NULL
#' @title
#' **Get ESPN NBA Athlete Per-Season Event Log (core-v2)**
#' @rdname espn_mbb_player_eventlog_v2
#' @author Saiem Gilani
#' @description
#' Returns one row per (event x team) for an NBA athlete's appearances
#' in a given season. Distinct from [espn_nba_player_eventlog()] which
#' wraps the web-common-v3 gamelog endpoint returning stats per game;
#' this core-v2 variant returns refs + `played` flag and is era-correct.
#'
#' @param athlete_id ESPN athlete identifier.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per event appearance. See package source
#'   for column schema.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_player_eventlog_v2(athlete_id = 1966, season = 2025)
#' }
espn_nba_player_eventlog_v2 <- function(athlete_id,
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
#' @rdname espn_nba_draft
#' @author Saiem Gilani
#' @description
#' Returns one row per round of the NBA draft (typically 2 rounds:
#' 1st with 30 picks, 2nd with ~28 picks).
#'
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
#' @rdname espn_nba_draft
#' @author Saiem Gilani
#' @description
#' Returns one row per drafted athlete in a given NBA draft year.
#'
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
#' @rdname espn_nba_draft
#' @author Saiem Gilani
#' @description
#' Returns the current status of one NBA draft year (round, state,
#' description). Live during the draft; static afterward.
#'
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

# ---------------------------------------------------------------------------
# espn_nba_season_draft
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Season Draft (Top-Level Metadata)**
#' @rdname espn_nba_draft
#' @author Saiem Gilani
#' @description
#' Returns a single-row tibble with top-level draft-year metadata: year,
#' number of rounds, display name, plus `$ref`s for the deeper sub-resources
#' (status, athletes, rounds) already wrapped by [espn_nba_draft_status()],
#' [espn_nba_draft_athletes()], and [espn_nba_draft_rounds()].
#'
#' @return A single-row tibble.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_season_draft(season = 2024)
#' }
espn_nba_season_draft <- function(season = most_recent_nba_season(), ...) {
  .espn_basketball_season_draft(league = "nba", season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_nba_draft_athlete_detail
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Draft Athlete Detail (Single Drafted Player)**
#' @rdname espn_nba_draft
#' @name espn_nba_draft_athlete_detail
NULL
#' @title
#' **Get ESPN NBA Draft Athlete Detail (Single Drafted Player)**
#' @rdname espn_nba_draft
#' @author Saiem Gilani
#' @description
#' Returns rich single-row detail for one drafted athlete in one NBA
#' draft year: name, height, weight, position, pick (overall/round/team),
#' and a `$ref` to the athlete's core-v2 profile. Use
#' [espn_nba_draft_athletes()] to enumerate draftees for a year.
#'
#' @param athlete_id ESPN draftee identifier.
#' @return A single-row tibble.
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_draft_athlete_detail(season = 2024, athlete_id = 1966)
#' }
espn_nba_draft_athlete_detail <- function(season = most_recent_nba_season(),
                                            athlete_id, ...) {
  .espn_basketball_draft_athlete_detail(league = "nba",
                                          season = season,
                                          athlete_id = athlete_id, ...)
}
