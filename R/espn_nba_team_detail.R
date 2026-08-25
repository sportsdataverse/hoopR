# espn_nba_team_detail.R
# Public NBA shims for ESPN team-detail endpoints.
# These are thin wrappers over the internal helpers in espn_basketball_team_helpers.R.

# ---------------------------------------------------------------------------
# espn_nba_team
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Team Detail**
#' @rdname espn_mbb_team
#' @name espn_nba_team
NULL
#' @title
#' **Get ESPN NBA Team Detail**
#' @rdname espn_mbb_team
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team(team_id = "13", season = 2025)
#' }
espn_nba_team <- function(team_id,
                            season = most_recent_nba_season(),
                            ...) {
  .espn_basketball_team(
    league   = "nba",
    team_id  = team_id,
    season   = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_team_roster
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Team Roster**
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team_roster(team_id = "13", season = 2025)
#' }
espn_nba_team_roster <- function(team_id,
                                   season = most_recent_nba_season(),
                                   ...) {
  .espn_basketball_team_roster(
    league   = "nba",
    team_id  = team_id,
    season   = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_team_schedule
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Team Schedule**
#' @rdname espn_mbb_team_schedule
#' @name espn_nba_team_schedule
NULL
#' @title
#' **Get ESPN NBA Team Schedule**
#' @rdname espn_mbb_team_schedule
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team_schedule(team_id = "13", season = 2025)
#' }
espn_nba_team_schedule <- function(team_id,
                                     season      = most_recent_nba_season(),
                                     season_type = 2,
                                     ...) {
  .espn_basketball_team_schedule(
    league      = "nba",
    team_id     = team_id,
    season      = season,
    season_type = season_type,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_team_leaders
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Team Leaders**
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
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team_leaders(team_id = "13", season = 2025)
#' }
espn_nba_team_leaders <- function(team_id,
                                    season = most_recent_nba_season(),
                                    ...) {
  .espn_basketball_team_leaders(
    league   = "nba",
    team_id  = team_id,
    season   = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_team_season_profile
# ---------------------------------------------------------------------------

#' @title
#' **Get ESPN NBA Team-in-Season Profile**
#' @rdname espn_mbb_team
#' @author Saiem Gilani
#' @description
#' Era-correct team identity for an NBA franchise in a specific season,
#' plus the available `$ref` URLs for deeper resources (record, statistics,
#' leaders, coaches, etc.). Backed by the core-v2 endpoint
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/nba/seasons/{season}/teams/{team_id}`.
#'
#' Historical depth goes back to **1947** (NBA founding). Older seasons
#' return fewer `$ref` keys; missing refs become `NA`.
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
#'       location \tab character \tab Team city/region (e.g. "Los Angeles"). \cr
#'       name \tab character \tab Team name (e.g. "Lakers"). \cr
#'       abbreviation \tab character \tab Short abbreviation (e.g. "LAL"). \cr
#'       display_name \tab character \tab Full display name. \cr
#'       short_display_name \tab character \tab Short display name. \cr
#'       color \tab character \tab Primary color (hex, no leading '#'). \cr
#'       alternate_color \tab character \tab Alternate color (hex, no leading '#'). \cr
#'       is_active \tab logical \tab Whether the team was active in this season. \cr
#'       season \tab integer \tab Season year. \cr
#'       logo \tab character \tab Primary logo URL. \cr
#'       logo_dark \tab character \tab Dark-mode logo URL. \cr
#'       record_ref \tab character \tab \verb{$ref} to team record resource (if present). \cr
#'       statistics_ref \tab character \tab \verb{$ref} to team statistics resource (if present). \cr
#'       leaders_ref \tab character \tab \verb{$ref} to team leaders resource (if present). \cr
#'       coaches_ref \tab character \tab \verb{$ref} to team coaches resource (if present). \cr
#'       depth_charts_ref \tab character \tab \verb{$ref} to depth chart resource (NBA-only). \cr
#'       events_ref \tab character \tab \verb{$ref} to team events resource (if present). \cr
#'       transactions_ref \tab character \tab \verb{$ref} to team transactions resource (if present). \cr
#'       franchise_ref \tab character \tab \verb{$ref} to franchise resource. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom janitor clean_names
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team_season_profile(team_id = "13", season = 2025)
#' }
espn_nba_team_season_profile <- function(team_id,
                                          season = most_recent_nba_season(),
                                          ...) {
  .espn_basketball_team_season_profile(
    league  = "nba",
    team_id = team_id,
    season  = season,
    ...
  )
}

# ---------------------------------------------------------------------------
# espn_nba_team_season_statistics
# ---------------------------------------------------------------------------

#' **Get ESPN NBA Team Season Statistics (Long Format with Rank)**
#' @rdname espn_mbb_team_season_statistics
#' @name espn_nba_team_season_statistics
NULL
#' @title
#' **Get ESPN NBA Team Season Statistics (Long Format with Rank)**
#' @rdname espn_mbb_team_season_statistics
#' @author Saiem Gilani
#' @description
#' Returns the full team-season-type statistics sheet for one NBA team in
#' long format: one row per (category x stat). Each row carries the team's
#' league rank for that stat where ESPN provides it (`rank` +
#' `rank_display_value`). Complements [espn_nba_team_record()] (W-L only)
#' with the full stat package.
#'
#' @param team_id ESPN team identifier.
#' @param season_type Integer season type: 1 = preseason, 2 = regular
#'   (default), 3 = postseason.
#' @param ... Additional arguments; currently unused.
#' @return A long tibble with one row per (category x stat).
#' @export
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#'   espn_nba_team_season_statistics(team_id = 13, season = 2024)
#' }
espn_nba_team_season_statistics <- function(team_id,
                                              season      = most_recent_nba_season(),
                                              season_type = 2L,
                                              ...) {
  .espn_basketball_team_season_statistics(league = "nba",
                                            team_id = team_id,
                                            season = season,
                                            season_type = season_type, ...)
}
