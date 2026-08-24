# espn_mbb_team_deep.R
# Public MBB shims for deeper per-team / per-coach core-v2 endpoints.

# ---------------------------------------------------------------------------
# espn_mbb_team_odds_records
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Team Odds-Records (Long Format)**
#' @name espn_mbb_team_odds_records
NULL
#' @title
#' **Get ESPN MBB Team Odds-Records (Long Format)**
#' @rdname espn_mbb_team_odds_records
#' @author Saiem Gilani
#' @description
#' Returns the long-format odds-records breakdown for a team in one
#' season. Each row is one (category × stat) — typical categories include
#' Money Line Overall, Money Line Home, Money Line Road, Against The
#' Spread Overall, Over/Under, etc. ESPN's coverage of this endpoint is
#' sparse; many (team × season-type) combinations return 404, in which
#' case the wrapper returns an empty tibble.
#'
#' @param team_id ESPN team identifier.
#' @param season Season year. Defaults to most recent MBB season.
#' @param season_type Season-type id. ESPN populates odds-records mostly
#'   under `season_type = 0` (all-types aggregate), so that is the default.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category × stat).
#'
#'    Columns as documented in the shared [espn_mbb_team_odds_records_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_odds_records(team_id = 150, season = 2026)
#' }
espn_mbb_team_odds_records <- function(team_id,
                                        season = most_recent_mbb_season(),
                                        season_type = 0L, ...) {
  .espn_basketball_team_odds_records(league = "mens-college-basketball", team_id = team_id,
                                       season = season,
                                       season_type = season_type, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_team_season_roster
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Team Roster (Per-Season, core-v2)**
#' @name espn_mbb_team_season_roster
#' @title
#' **Get ESPN MBB Team Roster (Per-Season, core-v2)**
#' @rdname espn_mbb_team_season_roster
#' @author Saiem Gilani
#' @description
#' Returns the per-season team roster as a tibble of athlete IDs from
#' `seasons/{y}/teams/{id}/athletes`. Distinct from [espn_mbb_team_roster()]
#' which targets a site-v2 endpoint optimized for the current season; this
#' core-v2 variant is era-correct and available back to ESPN's earliest
#' season for each league.
#'
#' @param team_id ESPN team identifier.
#' @param season Season year. Defaults to most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A tibble with one row per athlete on the season roster.
#'
#'    Columns as documented in the shared [espn_mbb_team_season_roster_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_season_roster(team_id = 150, season = 2025)
#' }
espn_mbb_team_season_roster <- function(team_id,
                                         season = most_recent_mbb_season(),
                                         ...) {
  .espn_basketball_team_season_roster(league = "mens-college-basketball", team_id = team_id,
                                        season = season, ...)
}

# ---------------------------------------------------------------------------
# espn_mbb_coach_season
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Coach-in-Season Detail**
#' @name espn_mbb_coach_season
#' @title
#' **Get ESPN MBB Coach-in-Season Detail**
#' @rdname espn_mbb_coach_season
#' @author Saiem Gilani
#' @description
#' Per-season coach detail (name, birth info, `$ref`s to team/college/
#' person). ESPN's coverage of this endpoint is sparse; many
#' (coach × season) combinations return 404.
#'
#' @param coach_id ESPN coach identifier.
#' @param season Season year. Defaults to most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble.
#'
#'    Columns as documented in the shared [espn_mbb_coach_season_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_coach_season(coach_id = 32116, season = 2025)
#' }
espn_mbb_coach_season <- function(coach_id,
                                   season = most_recent_mbb_season(),
                                   ...) {
  .espn_basketball_coach_season(league = "mens-college-basketball", coach_id = coach_id,
                                  season = season, ...)
}
# ---------------------------------------------------------------------------
# espn_mbb_team_record_detail
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Team Record Detail (Long Format)**
#' @name espn_mbb_team_record_detail
NULL
#' @title
#' **Get ESPN MBB Team Record Detail (Long Format)**
#' @rdname espn_mbb_team_record_detail
#' @author Saiem Gilani
#' @description
#' Returns one team's record detail in long format: one row per stat in
#' the record's `stats[]` array. Use [espn_mbb_team_record()] to enumerate
#' available `record_id` values per team-season (overall / home / away /
#' conference + per-opponent breakdowns).
#'
#' @param team_id ESPN team identifier.
#' @param season Season year (numeric).
#' @param record_id Record identifier (from [espn_mbb_team_record()] index).
#' @param season_type Integer season type: 1 = preseason, 2 = regular (default),
#'   3 = postseason.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble.
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_record_detail(team_id = 150, season = 2024, record_id = 0)
#' }
espn_mbb_team_record_detail <- function(team_id, season, record_id,
                                          season_type = 2L, ...) {
  .espn_basketball_team_record_detail(league = "mens-college-basketball",
                                        team_id = team_id,
                                        season = season,
                                        record_id = record_id,
                                        season_type = season_type, ...)
}
