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
#'    |col_name           |types     |description                                |
#'    |:------------------|:---------|:------------------------------------------|
#'    |id                 |character |Id.                                        |
#'    |uid                |character |ESPN UID string (universal identifier).    |
#'    |slug               |character |URL-safe identifier.                       |
#'    |abbreviation       |character |Short abbreviation.                        |
#'    |display_name       |character |Display name.                              |
#'    |short_display_name |character |Short display name.                        |
#'    |name               |character |Display name.                              |
#'    |nickname           |character |Team or athlete nickname.                  |
#'    |location           |character |Location.                                  |
#'    |color              |character |Primary color (hex without leading '#').   |
#'    |alternate_color    |character |Alternate color (hex without leading '#'). |
#'    |logo               |character |Team or league logo URL.                   |
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
#'   espn_mbb_team(team_id = "2509", season = 2025)
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

#' **Get ESPN Women's College Basketball Team Roster**
#' @name espn_mbb_team_roster
NULL
#' @title
#' **Get ESPN Women's College Basketball Team Roster**
#' @rdname espn_mbb_team_roster
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A single tibble with one row per athlete.
#'
#'    |col_name        |types     |description                                            |
#'    |:---------------|:---------|:------------------------------------------------------|
#'    |athlete_id      |character |Unique athlete identifier (ESPN).                      |
#'    |full_name       |character |Player's full name.                                    |
#'    |jersey          |character |Jersey number worn by the player.                      |
#'    |position_abbrev |character |                                                       |
#'    |position_name   |character |Listed roster position ('Guard', 'Forward', 'Center'). |
#'    |height          |character |Player height (string e.g. '6-2' or inches).           |
#'    |weight          |character |Player weight in pounds.                               |
#'    |age             |character |Player age (in years).                                 |
#'    |birth_date      |character |Date of birth (YYYY-MM-DD).                            |
#'    |birth_place     |character |Place of birth.                                        |
#'    |headshot        |character |Headshot image URL.                                    |
#'    |link_web        |character |Web link / URL.                                        |
#'    |status          |character |Status label.                                          |
#'    |team_id         |character |Unique team identifier.                                |
#'    |season          |integer   |Season identifier (4-digit year or 'YYYY-YY' string).  |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_roster(team_id = "2509", season = 2025)
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
#'    |col_name               |types     |description                                                                                                        |
#'    |:----------------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |event_id               |character |Unique event / game identifier (ESPN).                                                                             |
#'    |season                 |integer   |Season identifier (4-digit year or 'YYYY-YY' string).                                                              |
#'    |season_type            |integer   |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |week                   |integer   |Week number within the season.                                                                                     |
#'    |date                   |character |Date in YYYY-MM-DD format.                                                                                         |
#'    |name                   |character |Display name.                                                                                                      |
#'    |short_name             |character |Short display name.                                                                                                |
#'    |opponent_id            |character |Unique identifier for opponent.                                                                                    |
#'    |opponent_abbrev        |character |Abbreviation for opponent.                                                                                         |
#'    |home_away              |character |Game venue label ('home' or 'away').                                                                               |
#'    |neutral_site           |logical   |Neutral site.                                                                                                      |
#'    |conference_competition |logical   |Conference competition.                                                                                            |
#'    |venue_id               |character |Unique venue identifier.                                                                                           |
#'    |venue_name             |character |Venue name.                                                                                                        |
#'    |venue_city             |character |Venue city.                                                                                                        |
#'    |venue_state            |character |Venue state / region.                                                                                              |
#'    |broadcast              |character |Broadcast information string.                                                                                      |
#'    |result                 |character |Result.                                                                                                            |
#'    |team_score             |character |Team's score / final score.                                                                                        |
#'    |opponent_score         |character |Opponent score.                                                                                                    |
#'    |winner                 |logical   |Winner.                                                                                                            |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_schedule(team_id = "2509", season = 2025)
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

#' **Get ESPN Women's College Basketball Team Leaders**
#' @name espn_mbb_team_leaders
NULL
#' @title
#' **Get ESPN Women's College Basketball Team Leaders**
#' @rdname espn_mbb_team_leaders
#' @author Saiem Gilani
#' @param team_id ESPN team identifier (character or numeric).
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A single long-format tibble (one row per category-rank-athlete).
#'
#'    |col_name     |types     |description                                           |
#'    |:------------|:---------|:-----------------------------------------------------|
#'    |team_id      |character |Unique team identifier.                               |
#'    |season       |integer   |Season identifier (4-digit year or 'YYYY-YY' string). |
#'    |category     |character |Category label.                                       |
#'    |display_name |character |Display name.                                         |
#'    |athlete_id   |character |Unique athlete identifier (ESPN).                     |
#'    |athlete_name |character |Athlete display name (ESPN).                          |
#'    |value        |numeric   |Numeric or string value field.                        |
#'    |rank         |integer   |Rank.                                                 |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble bind_rows any_of
#' @importFrom janitor clean_names
#' @export
#' @family ESPN MBB Functions
#' @examples
#' \donttest{
#'   espn_mbb_team_leaders(team_id = "2509", season = 2025)
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

#' **Get ESPN MBB Team-in-Season Profile**
#' @name espn_mbb_team_season_profile
NULL
#' @title
#' **Get ESPN MBB Team-in-Season Profile**
#' @rdname espn_mbb_team_season_profile
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
#' @param season Season year (numeric). Defaults to the most recent MBB season.
#' @param ... Additional arguments; currently unused.
#' @return A single-row tibble with team identity scalars and `_ref` URL
#'   columns. Selected columns:
#'
#'    |col_name              |types     |description                                       |
#'    |:---------------------|:---------|:-------------------------------------------------|
#'    |id                    |character |ESPN team identifier.                             |
#'    |guid                  |character |Stable cross-league team GUID.                    |
#'    |uid                   |character |ESPN UID string.                                  |
#'    |slug                  |character |URL-safe identifier.                              |
#'    |location              |character |School/program location (e.g. "Duke").            |
#'    |name                  |character |Team name (e.g. "Blue Devils").                   |
#'    |nickname              |character |Common nickname (often same as location).         |
#'    |abbreviation          |character |Short abbreviation (e.g. "DUKE").                 |
#'    |display_name          |character |Full display name.                                |
#'    |short_display_name    |character |Short display name.                               |
#'    |color                 |character |Primary color (hex, no leading '#').              |
#'    |alternate_color       |character |Alternate color (hex, no leading '#').            |
#'    |is_active             |logical   |Whether the team was active in this season.       |
#'    |season                |integer   |Season year.                                      |
#'    |logo                  |character |Primary logo URL.                                 |
#'    |logo_dark             |character |Dark-mode logo URL.                               |
#'    |record_ref            |character |`$ref` to team record resource.                   |
#'    |statistics_ref        |character |`$ref` to team statistics resource.               |
#'    |athletes_ref          |character |`$ref` to team roster resource (college-only).    |
#'    |college_ref           |character |`$ref` to college (institution) resource.         |
#'    |coaches_ref           |character |`$ref` to team coaches resource.                  |
#'    |franchise_ref         |character |`$ref` to franchise resource.                     |
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
#'   espn_mbb_team_season_statistics(team_id = 13, season = 2024)
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
