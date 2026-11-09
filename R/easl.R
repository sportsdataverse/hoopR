# easl.R -- EASL (East Asia Super League) wrappers over an UNOFFICIAL third-party sync server
# (easl.joshricha.com/api/v1, an individual's mirror of Sportradar DataCore), at parity with sportsdataverse-py
# sportsdataverse/basketball/easl (origin/main e3d232ebc9). Transport, season mapping and refusals:
# R/easl_runtime.R; frames: R/easl_parsers.R; columns: R/easl_schema.R.

# The @details of every easl topic that shares the easl_health() notes (roxygen @eval .intl_details()).
.easl_health_details <- c(
  "* WARNING: UNOFFICIAL THIRD-PARTY INTERMEDIARY. These wrappers read easl.joshricha.com/api/v1, an Express server",
  "  run by an individual. It is not EASL's and not Sportradar's: it mirrors Sportradar DataCore (organisation b1e0z)",
  "  into SQLite and serves it keyless, and it can change or vanish without notice. Its routes, field names (steak,",
  "  facebook_username) and sync freshness are the proxy author's. A first-party DataCore feed needs credentials this",
  "  package does not have. The host serves no robots.txt (404) and states no terms; the runtime waits at least 1 s",
  "  before every request, retries included, and honours Retry-After. Payloads are not redistributed as release",
  "  assets.",
  "* Seasons are END years (2026 = EASL 25-26). The server's season key is the START year; the runtime reads the",
  "  season list, maps the END year to the DataCore seasonId and defaults to the ACTIVE season. Four editions exist",
  "  (2023-24 to 2026-27). The server defaults to the active season on /matches, /standings and /leaders; the runtime",
  "  always sends the resolved seasonId. A season is two calendar years: group by season_id, not by the year of the",
  "  tip-off.",
  "* Finished games only: the game routes first read the fixture and refuse (`hoopR_asset_fetch`) one that is not",
  "  CONFIRMED with two scores, a box score whose player points do not add up to the score (the server serves",
  "  one-team, four-row boxes for some games), a play-by-play that does not end on the final score in its highest",
  "  period (4 or more, and the last period of the period table), and team totals that disagree with the score. For",
  "  the ACTIVE season's fixture lists the runtime reads /health: a server clock more than a day from yours, or a",
  "  game still SCHEDULED more than a day after its tip-off, means the mirror has stalled (`hoopR_asset_fetch`). That",
  "  proves the mirror kept up with the games played, not that a game is final upstream.",
  "* Ids: every DataCore id is a UUID v1 string. team_id = entityId, player_id = personId; fixture_number (YYSSNNN)",
  "  is null on every 2023-24 fixture; `*_row_id` columns are the sync server's own integers, not DataCore ids. The",
  "  fixture's competitors come in arbitrary order: read `home_*` / `away_*`, which the parsers take from isHome.",
  "* No shot x/y, no game clock and no lineups exist on this server. The play-by-play text always says 'missed' for",
  "  field goals and 'Free throw K of M made' for free throws, made or not: use points_scored (the change of the",
  "  event team's running score), which lags on a minority of events. 301 of 2,444 sampled box rows are players who",
  "  did not play (null minutes and counting stats; points are 0); player_box.played tells them apart.",
  "  easl_player_stats ignores a season filter: it is the career line over every season. Names: nameFullLocal is the",
  "  English display name and nameFullLatin the native-script name, so the columns are name and name_native.",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, an empty list or leaders",
  "  object, a team or player without games), `hoopR_bad_request` (a malformed id, or a season that is not one of the",
  "  server's END years, raised before the request that would use it) and `hoopR_asset_fetch` (any other failure: any",
  "  non-2xx, including the server's HTTP 400 / 422 and the HTTP 500 it answers for an unknown fixture, which is not",
  "  retried; an error envelope; a game that is not finished or whose box score or play-by-play is incomplete; a",
  "  stalled sync on the active season; a body for another game, season, team or player than the one asked for).",
  "  Wrappers raise; they never warn and return an empty frame."
)

#' @title
#' **Get EASL Health**
#' @description
#' Liveness probe of the unofficial sync server: status, message and the server's own timestamp.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/health`
#' @eval .returns_rd("easl_health", inline = FALSE, unit = "health check")
#' @eval .intl_details(.easl_health_details, full = TRUE, "easl_health()")
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_health <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- "/health"
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("health", raw), "EASL Health from easl.joshricha.com")
}

#' @title
#' **Get EASL Seasons**
#' @description
#' Every configured EASL season (the four editions 2023-24 to 2026-27) with its DataCore season id and END year.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/metadata/seasons`
#' @eval .returns_rd("easl_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_seasons())
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- "/metadata/seasons"
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("seasons", raw), "EASL Seasons from easl.joshricha.com")
}

#' @title
#' **Get EASL Schedule**
#' @description
#' Every fixture of one season: status, tip-off, stage, pool, venue and both teams with their scores.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/matches`
#' @param season Season END year (2026 = EASL 25-26; the four editions are 2024 to 2027). The runtime reads
#'   easl_seasons and maps it to the DataCore seasonId. Default `NULL`: the ACTIVE season.
#' @eval .returns_rd("easl_schedule", inline = FALSE, unit = "game")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_schedule(season = 2026))
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_schedule <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- "/matches"
  raw <- .easl_get(path, list(season = season), call = rlang::current_env())
  .easl_out(.easl_parse("schedule", raw), "EASL Schedule from easl.joshricha.com")
}

#' @title
#' **Get EASL Game**
#' @description
#' Header of one finished fixture: teams, final score, status, stage, pool, venue and attendance.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/matches/{fixture_id}`
#' @param fixture_id (required) DataCore fixture (game) UUID v1, e.g. '10af8fd4-106e-11f1-960b-5798087c7aa3' (the
#'   2025-26 EASL Championship): the 'id' of easl_schedule rows. Only finished (CONFIRMED) games are served; a
#'   malformed id is `hoopR_bad_request`.
#' @eval .returns_rd("easl_game", inline = FALSE, unit = "game")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_game(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_game <- function(fixture_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/matches/", .easl_id_arg(fixture_id, "fixture_id"))
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("game", raw), "EASL Game from easl.joshricha.com")
}

#' @title
#' **Get EASL Player Box Score**
#' @description
#' Player box score of a finished game, one row per rostered player (non-players have null counting stats).
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/boxscore`
#' @param fixture_id (required) DataCore fixture (game) UUID v1, e.g. '10af8fd4-106e-11f1-960b-5798087c7aa3' (the
#'   2025-26 EASL Championship): the 'id' of easl_schedule rows. Only finished (CONFIRMED) games are served; a
#'   malformed id is `hoopR_bad_request`.
#' @eval .returns_rd("easl_player_box", inline = FALSE, unit = "rostered player")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_player_box(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_player_box <- function(fixture_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/matches/", .easl_id_arg(fixture_id, "fixture_id"), "/boxscore")
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("player_box", raw), "EASL Player Box Score from easl.joshricha.com")
}

#' @title
#' **Get EASL Play-by-Play**
#' @description
#' Play-by-play of a finished game in delivered order, with the running score and the points each event scored.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/playbyplay`
#' @param fixture_id (required) DataCore fixture (game) UUID v1, e.g. '10af8fd4-106e-11f1-960b-5798087c7aa3' (the
#'   2025-26 EASL Championship): the 'id' of easl_schedule rows. Only finished (CONFIRMED) games are served; a
#'   malformed id is `hoopR_bad_request`.
#' @eval .returns_rd("easl_pbp", inline = FALSE, unit = "play-by-play event")
#' @section Event descriptions:
#' * Shot types: Jump shot, Layup, Driving layup, Pull-up jump shot, Floating jump shot, Tip-in, Fadeaway,
#'   Step-back jump shot, Turnaround jump shot, Hook shot, Dunk, Reverse layup, Alley-oop, Alley-oop dunk,
#'   Euro step (none on 23 rows: '3pt missed').
#' * Shot modifiers: in the paint, second chance, from turnover, fast break, blocked.
#' * Other events (complete list; N FT = free throws awarded): Assist; Block; Steal; Substitution in;
#'   Substitution out; Defensive rebound; Defensive rebound (team); Offensive rebound; Offensive rebound (team);
#'   Foul; Foul (N FT); Foul drawn; Foul drawn (N FT); Personal foul; Personal foul (N FT); Personal foul
#'   (shooting); Personal foul (shooting) (N FT); Offensive foul; Offensive foul (charge); Technical foul;
#'   Technical foul (N FT); Bench technical foul; Bench technical foul (N FT); Coach technical foul; Coach
#'   technical foul (N FT); Unsportsmanlike foul; Unsportsmanlike foul (N FT); Disqualifying foul (N FT); Jump
#'   ball won; Jump ball won (held ball); Jump ball lost; Full timeout; Short timeout; Media timeout; Commercial
#'   timeout; Officials timeout; Officials timeout (mandatory); Coach's challenge (pending); Coach's challenge
#'   (complete) - upheld; Coach's challenge (complete) - overturned; Instant replay review (complete) - upheld;
#'   Instant replay review (complete) - overturned; Turnover - Bad pass; Ball handling; Traveling; Out of bounds;
#'   Offensive; Backcourt violation; Double dribble; Carrying; Offensive goaltending; 3 second violation; 5
#'   second violation; 5 second violation (team); 8 second violation (team); Shot clock violation (team); Other;
#'   Other (team).
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_pbp(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_pbp <- function(fixture_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/matches/", .easl_id_arg(fixture_id, "fixture_id"), "/playbyplay")
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("pbp", raw), "EASL Play-by-Play from easl.joshricha.com")
}

#' @title
#' **Get EASL Team Box Score**
#' @description
#' Team totals of a finished game, one row per team, with the opponent's totals as `*_against` columns.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/teamstats`
#' @param fixture_id (required) DataCore fixture (game) UUID v1, e.g. '10af8fd4-106e-11f1-960b-5798087c7aa3' (the
#'   2025-26 EASL Championship): the 'id' of easl_schedule rows. Only finished (CONFIRMED) games are served; a
#'   malformed id is `hoopR_bad_request`.
#' @eval .returns_rd("easl_team_box", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_team_box(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_team_box <- function(fixture_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/matches/", .easl_id_arg(fixture_id, "fixture_id"), "/teamstats")
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("team_box", raw), "EASL Team Box Score from easl.joshricha.com")
}

#' @title
#' **Get EASL Team Box Score By Period**
#' @description
#' Team totals of a finished game by period, one row per team and period (overtimes after the fourth).
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/matches/{fixture_id}/teamstats/by/period`
#' @param fixture_id (required) DataCore fixture (game) UUID v1, e.g. '10af8fd4-106e-11f1-960b-5798087c7aa3' (the
#'   2025-26 EASL Championship): the 'id' of easl_schedule rows. Only finished (CONFIRMED) games are served; a
#'   malformed id is `hoopR_bad_request`.
#' @eval .returns_rd("easl_team_box_by_period", inline = FALSE, unit = "team and period")
#' @eval .intl_details(.easl_health_details, 'easl_team_box_by_period(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3")')
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_team_box_by_period <- function(fixture_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/matches/", .easl_id_arg(fixture_id, "fixture_id"), "/teamstats/by/period")
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("team_box_by_period", raw), "EASL Team Box Score By Period from easl.joshricha.com")
}

#' @title
#' **Get EASL Standings**
#' @description
#' Group-stage standings of one season: rank within the pool, record, splits, points and the last five results.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/standings`
#' @param season Season END year (2026 = EASL 25-26; the four editions are 2024 to 2027). The runtime reads
#'   easl_seasons and maps it to the DataCore seasonId. Default `NULL`: the ACTIVE season.
#' @eval .returns_rd("easl_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_standings(season = 2026))
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_standings <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- "/standings"
  raw <- .easl_get(path, list(season = season), call = rlang::current_env())
  .easl_out(.easl_parse("standings", raw), "EASL Standings from easl.joshricha.com")
}

#' @title
#' **Get EASL Leaders**
#' @description
#' Tournament top-5 player leaders in nine categories (points, rebounds, assists, steals, blocks, shooting).
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/leaders`
#' @param season Season END year (2026 = EASL 25-26; the four editions are 2024 to 2027). The runtime reads
#'   easl_seasons and maps it to the DataCore seasonId. Default `NULL`: the ACTIVE season.
#' @eval .returns_rd("easl_leaders", inline = FALSE, unit = "leaderboard entry")
#' @eval .intl_details(.easl_health_details, "easl_leaders(season = 2026)")
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_leaders <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- "/leaders"
  raw <- .easl_get(path, list(season = season), call = rlang::current_env())
  .easl_out(.easl_parse("leaders", raw), "EASL Leaders from easl.joshricha.com")
}

#' @title
#' **Get EASL Teams**
#' @description
#' The 12 ACTIVE EASL teams (historical teams resolve only through easl_team).
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/teams`
#' @eval .returns_rd("easl_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_teams())
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_teams <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- "/teams"
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("teams", raw), "EASL Teams from easl.joshricha.com")
}

#' @title
#' **Get EASL Team**
#' @description
#' One team's directory entry; resolves the historical teams easl_teams does not list.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/teams/{team_id}`
#' @param team_id (required) DataCore team (entity) UUID v1, e.g. '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya
#'   Brex): the team_id of easl_teams, easl_standings and the box scores. easl_team resolves the 12 historical teams
#'   easl_teams does not list.
#' @eval .returns_rd("easl_team", inline = FALSE, unit = "team")
#' @eval .intl_details(.easl_health_details, 'easl_team(team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_team <- function(team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/teams/", .easl_id_arg(team_id, "team_id"))
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("team", raw), "EASL Team from easl.joshricha.com")
}

#' @title
#' **Get EASL Team Schedule**
#' @description
#' A team's fixtures in one season, shaped like easl_schedule.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/teams/{team_id}/matches`
#' @param team_id (required) DataCore team (entity) UUID v1, e.g. '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya
#'   Brex): the team_id of easl_teams, easl_standings and the box scores. easl_team resolves the 12 historical teams
#'   easl_teams does not list.
#' @param season Season END year (2026 = EASL 25-26; the four editions are 2024 to 2027). The runtime reads
#'   easl_seasons and maps it to the DataCore seasonId. Default `NULL`: the ACTIVE season.
#' @eval .returns_rd("easl_team_schedule", inline = FALSE, unit = "game")
#' @eval .intl_details(.easl_health_details, 'easl_team_schedule(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_team_schedule <- function(team_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/teams/", .easl_id_arg(team_id, "team_id"), "/matches")
  raw <- .easl_get(path, list(season = season), call = rlang::current_env())
  .easl_out(.easl_parse("team_schedule", raw), "EASL Team Schedule from easl.joshricha.com")
}

#' @title
#' **Get EASL Team Stats**
#' @description
#' A team's cumulative season statistics: totals, per-game rates and the opponent's totals (`*_against`).
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/teams/{team_id}/stats`
#' @param team_id (required) DataCore team (entity) UUID v1, e.g. '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya
#'   Brex): the team_id of easl_teams, easl_standings and the box scores. easl_team resolves the 12 historical teams
#'   easl_teams does not list.
#' @param season Season END year (2026 = EASL 25-26; the four editions are 2024 to 2027). The runtime reads
#'   easl_seasons and maps it to the DataCore seasonId. Default `NULL`: the ACTIVE season.
#' @eval .returns_rd("easl_team_stats", inline = FALSE, unit = "team-season")
#' @eval .intl_details(.easl_health_details, 'easl_team_stats(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_team_stats <- function(team_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/teams/", .easl_id_arg(team_id, "team_id"), "/stats")
  raw <- .easl_get(path, list(season = season), call = rlang::current_env())
  .easl_out(.easl_parse("team_stats", raw), "EASL Team Stats from easl.joshricha.com")
}

#' @title
#' **Get EASL Team Leaders**
#' @description
#' A team's top-5 player leaders per category in one season, shaped like easl_leaders.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/teams/{team_id}/leaders`
#' @param team_id (required) DataCore team (entity) UUID v1, e.g. '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya
#'   Brex): the team_id of easl_teams, easl_standings and the box scores. easl_team resolves the 12 historical teams
#'   easl_teams does not list.
#' @param season Season END year (2026 = EASL 25-26; the four editions are 2024 to 2027). The runtime reads
#'   easl_seasons and maps it to the DataCore seasonId. Default `NULL`: the ACTIVE season.
#' @eval .returns_rd("easl_team_leaders", inline = FALSE, unit = "leaderboard entry")
#' @eval .intl_details(.easl_health_details, 'easl_team_leaders(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_team_leaders <- function(team_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/teams/", .easl_id_arg(team_id, "team_id"), "/leaders")
  raw <- .easl_get(path, list(season = season), call = rlang::current_env())
  .easl_out(.easl_parse("team_leaders", raw), "EASL Team Leaders from easl.joshricha.com")
}

#' @title
#' **Get EASL Players**
#' @description
#' Every EASL player of all seasons; with season and team_id a roster that adds jersey number and position.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/players`
#' @param season Season END year (2026 = EASL 25-26; the four editions are 2024 to 2027). The runtime reads
#'   easl_seasons and maps it to the DataCore seasonId. Default `NULL`: no season filter.
#' @param team_id DataCore team (entity) UUID v1, e.g. '865489e8-b0f5-11ed-8b3f-c199a9dea184' (Utsunomiya Brex): the
#'   team_id of easl_teams, easl_standings and the box scores. easl_team resolves the 12 historical teams easl_teams
#'   does not list. Needs season for a roster (jersey number and position). Default `NULL`: no team filter.
#' @eval .returns_rd("easl_players", inline = FALSE, unit = "player")
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_players(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#' }
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_players <- function(season = NULL, team_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- "/players"
  raw <- .easl_get(path, list(season = season, teamId = team_id), call = rlang::current_env())
  .easl_out(.easl_parse("players", raw), "EASL Players from easl.joshricha.com")
}

#' @title
#' **Get EASL Player**
#' @description
#' One player's biography: names, nationality, birth date, height, weight.
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/players/{player_id}`
#' @param player_id (required) DataCore person UUID v1, e.g. '85c99dab-9f67-11f0-8780-a731edb5aad5': the player_id of
#'   easl_players, the box scores, leaders and play-by-play. A malformed id is `hoopR_bad_request`.
#' @eval .returns_rd("easl_player", inline = FALSE, unit = "player")
#' @eval .intl_details(.easl_health_details, 'easl_player(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5")')
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_player <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/players/", .easl_id_arg(player_id, "player_id"))
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("player", raw), "EASL Player from easl.joshricha.com")
}

#' @title
#' **Get EASL Player Stats**
#' @description
#' A player's cumulative statistics over ALL seasons (the server ignores a season filter).
#'
#' Endpoint: `GET https://easl.joshricha.com/api/v1/players/{player_id}/stats`
#' @param player_id (required) DataCore person UUID v1, e.g. '85c99dab-9f67-11f0-8780-a731edb5aad5': the player_id of
#'   easl_players, the box scores, leaders and play-by-play. A malformed id is `hoopR_bad_request`.
#' @eval .returns_rd("easl_player_stats", inline = FALSE, unit = "player")
#' @eval .intl_details(.easl_health_details, 'easl_player_stats(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5")')
#' @export
#' @concept EASL Functions
#' @seealso [family_easl] lists every function in this family.
easl_player_stats <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/players/", .easl_id_arg(player_id, "player_id"), "/stats")
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("player_stats", raw), "EASL Player Stats from easl.joshricha.com")
}
