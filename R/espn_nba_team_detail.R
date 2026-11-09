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
#' @eval .returns_rd("espn_nba_team")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble select any_of bind_rows
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
#' @eval .returns_rd("espn_nba_team_roster", unit = "athlete")
#' @return ESPN's roster endpoint ignores the season, so a season before the current
#'   one is built from that season's published player box scores (name, jersey,
#'   position and headshot from the athlete's last game; bio columns `NA`), and
#'   errors when none are published.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
#' @eval .returns_rd("espn_nba_team_schedule", unit = "event")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
#' @eval .returns_rd("espn_nba_team_leaders", unit = "category-rank-athlete")
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
#' @eval .returns_rd("espn_nba_team_season_profile", unit = "team-season")
#' @return The table lists selected columns: team identity scalars and `_ref` URL columns.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom janitor clean_names
#' @export
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
