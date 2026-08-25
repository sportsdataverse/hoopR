# espn_mbb_team_detail.R
# Public MBB shims for ESPN team-detail endpoints.
# These are thin wrappers over the internal helpers in espn_basketball_team_helpers.R.

# ---------------------------------------------------------------------------
# espn_mbb_team
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Team Detail**
#' @name espn_mbb_team
NULL
#' @title
#' **Get ESPN Women's College Basketball Team Detail**
#' @rdname espn_mbb_team
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
#' @param season Season year (numeric, e.g. 2025). Defaults to the most
#'   recent MBB season.
#' @param ... Additional arguments; currently unused but retained for
#'   forward compatibility. Proxy configuration should use
#'   `options(hoopR.proxy = ...)` -- see `?hoopR` for details.
#' @return A named list of data frames: `Info`, `Record`, `NextEvent`,
#'   `StandingSummary`, `Coaches`.
#'
#'    **Info**
#'
#'    Columns as documented in the shared [espn_mbb_team_info_schema] table.
#'
#'    **Record**
#'
#'    |col_name |types     |description             |
#'    |:--------|:---------|:-----------------------|
#'    |type     |character |Record type / category. |
#'    |summary  |character |                        |
#'    |stats    |list      |                        |
#'
#'    **NextEvent**
#'
#'    |col_name   |types     |description                |
#'    |:----------|:---------|:--------------------------|
#'    |id         |character |Id.                        |
#'    |date       |character |Date in YYYY-MM-DD format. |
#'    |name       |character |Display name.              |
#'    |short_name |character |Short display name.        |
#'
#'    **StandingSummary**
#'
#'    |col_name         |types     |description |
#'    |:----------------|:---------|:-----------|
#'    |standing_summary |character |            |
#'
#'    **Coaches**
#'
#'    |col_name   |types     |description                       |
#'    |:----------|:---------|:---------------------------------|
#'    |id         |character |Id.                               |
#'    |first_name |character |Player's first name.              |
#'    |last_name  |character |Player's last name.               |
#'    |experience |integer   |Years of professional experience. |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team(team_id = "150", season = 2025)
#' }
espn_mbb_team <- function(team_id,
                           season = most_recent_mbb_season(),
                           ...) {
  .espn_basketball_team(
    league   = "mens-college-basketball",
    team_id  = team_id,
    season   = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_team_roster
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Team Roster**
#' @rdname espn_mbb_team
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
#' @return A single tibble with one row per athlete.
#'
#'    Columns as documented in the shared [espn_mbb_team_roster_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_roster(team_id = "150", season = 2025)
#' }
espn_mbb_team_roster <- function(team_id,
                                  season = most_recent_mbb_season(),
                                  ...) {
  .espn_basketball_team_roster(
    league   = "mens-college-basketball",
    team_id  = team_id,
    season   = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_team_schedule
# ---------------------------------------------------------------------------

#' **Get ESPN Women's College Basketball Team Schedule**
#' @name espn_mbb_team_schedule
NULL
#' @title
#' **Get ESPN Women's College Basketball Team Schedule**
#' @rdname espn_mbb_team_schedule
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param season_type Integer season type: 1 = preseason, 2 = regular (default),
#'   3 = postseason.
#' @param ... Additional arguments; currently unused.
#' @return A single tibble with one row per event.
#'
#'    Columns as documented in the shared [espn_mbb_team_schedule_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_schedule(team_id = "150", season = 2025)
#' }
espn_mbb_team_schedule <- function(team_id,
                                    season      = most_recent_mbb_season(),
                                    season_type = 2,
                                    ...) {
  .espn_basketball_team_schedule(
    league      = "mens-college-basketball",
    team_id     = team_id,
    season      = season,
    season_type = season_type,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_team_leaders
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN Women's College Basketball Team Leaders**
#' @rdname espn_mbb_team
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
#' @return A single long-format tibble (one row per category-rank-athlete).
#'
#'    Columns as documented in the shared [espn_mbb_team_leaders_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_leaders(team_id = "150", season = 2025)
#' }
espn_mbb_team_leaders <- function(team_id,
                                   season = most_recent_mbb_season(),
                                   ...) {
  .espn_basketball_team_leaders(
    league   = "mens-college-basketball",
    team_id  = team_id,
    season   = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_team_season_profile
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN MBB Team-in-Season Profile**
#' @rdname espn_mbb_team
#' @author Saiem Gilani
#' @description
#' Era-correct team identity for a men's college basketball program in a
#' specific season, plus the available `$ref` URLs for deeper resources
#' (record, statistics, leaders, athletes/roster, coaches, college, etc.).
#' Backed by the core-v2 endpoint
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/seasons/{season}/teams/{team_id}`.
#'
#' Historical depth goes back to **1939** at ESPN. Older seasons return
#' fewer `$ref` keys; missing refs become `NA`.
#'
#' @param team_id ESPN team identifier (character or numeric).
#' @return A single-row tibble with team identity scalars and `_ref` URL
#'   columns. Selected columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab character \tab ESPN team identifier. \cr
#'       guid \tab character \tab Stable cross-league team GUID. \cr
#'       uid \tab character \tab ESPN UID string. \cr
#'       slug \tab character \tab URL-safe identifier. \cr
#'       location \tab character \tab School/program location (e.g. "Duke"). \cr
#'       name \tab character \tab Team name (e.g. "Blue Devils"). \cr
#'       nickname \tab character \tab Common nickname (often same as location). \cr
#'       abbreviation \tab character \tab Short abbreviation (e.g. "DUKE"). \cr
#'       display_name \tab character \tab Full display name. \cr
#'       short_display_name \tab character \tab Short display name. \cr
#'       color \tab character \tab Primary color (hex, no leading '#'). \cr
#'       alternate_color \tab character \tab Alternate color (hex, no leading '#'). \cr
#'       is_active \tab logical \tab Whether the team was active in this season. \cr
#'       season \tab integer \tab Season year. \cr
#'       logo \tab character \tab Primary logo URL. \cr
#'       logo_dark \tab character \tab Dark-mode logo URL. \cr
#'       record_ref \tab character \tab \verb{$ref} to team record resource. \cr
#'       statistics_ref \tab character \tab \verb{$ref} to team statistics resource. \cr
#'       athletes_ref \tab character \tab \verb{$ref} to team roster resource (college-only). \cr
#'       college_ref \tab character \tab \verb{$ref} to college (institution) resource. \cr
#'       coaches_ref \tab character \tab \verb{$ref} to team coaches resource. \cr
#'       franchise_ref \tab character \tab \verb{$ref} to franchise resource. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_season_profile(team_id = "150", season = 2025)
#' }
espn_mbb_team_season_profile <- function(team_id,
                                          season = most_recent_mbb_season(),
                                          ...) {
  .espn_basketball_team_season_profile(
    league  = "mens-college-basketball",
    team_id = team_id,
    season  = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_mbb_team_season_statistics
# ---------------------------------------------------------------------------

#' **Get ESPN MBB Team Season Statistics (Long Format with Rank)**
#' @name espn_mbb_team_season_statistics
NULL
#' @title
#' **Get ESPN MBB Team Season Statistics (Long Format with Rank)**
#' @rdname espn_mbb_team_season_statistics
#' @author Saiem Gilani
#' @description
#' Returns the full team-season-type statistics sheet for one MBB team in
#' long format: one row per (category x stat). Each row carries the team's
#' league rank for that stat where ESPN provides it (`rank` +
#' `rank_display_value`). Complements [espn_mbb_team_record()] (W-L only)
#' with the full stat package.
#'
#' @param team_id ESPN team identifier.
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param season_type Integer season type: 1 = preseason, 2 = regular
#'   (default), 3 = postseason.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x stat).
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_season_statistics(team_id = 150, season = 2024)
#' }
espn_mbb_team_season_statistics <- function(team_id,
                                              season      = most_recent_mbb_season(),
                                              season_type = 2L,
                                              ...) {
  .espn_basketball_team_season_statistics(league = "mens-college-basketball",
                                            team_id = team_id,
                                            season = season,
                                            season_type = season_type, ...)
}
