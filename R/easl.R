# easl.R -- EASL (East Asia Super League) wrappers over an UNOFFICIAL third-party sync server
# (easl.joshricha.com/api/v1, an individual's mirror of Sportradar DataCore), at parity with sdv-py
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
#' @return
#' A `hoopR_data` tibble: Liveness probe of the unofficial sync server: status, message and the server's own
#'   timestamp. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_health`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | status | character | Server status: 'OK'. |
#' | message | character | Human-readable status text ('EASL Basketball API is running'). |
#' | timestamp | character | Server time, ISO 8601 with milliseconds and Z (UTC). |
#' @eval .intl_details(.easl_health_details, full = TRUE, "easl_health()")
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Every configured EASL season (the four editions 2023-24 to 2026-27) with its DataCore
#'   season id and END year. An empty answer raises `hoopR_no_data`; the columns are always these, in this order
#'   (sdv-py `easl_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = EASL 25-26), derived as year + 1. |
#' | season_id | character | seasonId: DataCore season UUID v1 (key space: EASL seasons; one per edition: 57cefc32... is 2024-25). Joins the `seasonId` query parameter of /matches, /standings, /leaders, /players and the `/teams/{teamId}` routes, the `seasonId` of every fixture and leader row, and the season half of a team-fixture `stage.id`. |
#' | season_row_id | integer | The sync server's own integer row id (1 = 2024-25, 2 = 2025-26, 3 = 2023-24, 4 = 2026-27: insertion order, not chronological). Not a DataCore id. |
#' | year | integer | START year of the season (2024 = EASL 24-25, which runs 2024-10 to 2025-03). sdv season (END year) = year + 1. |
#' | name | character | Season label ('EASL 24-25' = 2024-25). |
#' | name_latin | character | Season label in Latin script; null on some seasons. |
#' | status | character | COMPLETE for a finished season, ACTIVE for the current one (the default of every season route). |
#' | start_date | Date | First day of the season, local date YYYY-MM-DD. |
#' | end_date | Date | Last scheduled day of the season, local date YYYY-MM-DD. |
#' | competition_id | character | DataCore competition UUID v1 (key space: competitions); the same 77a790d8-ad01-11ed-8355-01b87a3904c0 on all four seasons: EASL is one competition with one season per edition. |
#' | profile_id | character | DataCore profile UUID v1 of the competition (joins nothing in this API). |
#' | organization_id | character | DataCore organisation id of the league: b1e0z (EASL) on every row. |
#' | age_group | character | Age group of the competition: SENIOR. |
#' | event_type | character | DataCore event type: FIXTURE (a game schedule). |
#' | gender | character | MALE (EASL is a men's competition). |
#' | representation | character | CLUB (club teams, not national teams). |
#' | season_type | character | DataCore season type: SEASON. |
#' | standard | character | Competition standard: ELITE. |
#' | created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
#' | updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_seasons())
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Every fixture of one season: status, tip-off, stage, pool, venue and both teams with their
#'   scores. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_schedule`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request, null when parsed bare. |
#' | season_id | character | DataCore season UUID v1 of the fixture (the row's own seasonId). |
#' | fixture_id | character | fixtureId: DataCore fixture (game) UUID v1 (key space: EASL games; the `{fixtureId}` of every /matches route). |
#' | fixture_number | integer | Fixture number YYSSNNN: two-digit start year, two-digit end year, three-digit sequence (2627001 = first game of 2026-27, 2526003 = third of 2025-26). Null on every 2023-24 fixture. |
#' | fixture_type | character | REGULAR (group stage), PLAYOFF (quarter- and semifinals) or FINAL (championship and third-place games). Missing from the DRAFT placeholders. Absent on some rows. |
#' | status | character | CONFIRMED for a finished game, SCHEDULED for a future one, DRAFT for an unscheduled placeholder. |
#' | fixture_name | character | Fixture name for special games ('EASL Championship', 'Semifinals 2', 'EASL Tip-Off 2026 Cebu'); null for ordinary group games. |
#' | start_time_utc | character | Scheduled tip-off in UTC, 'YYYY-MM-DDTHH:MM:SS' with no zone marker. The /matches list holds null here on DRAFT fixtures; the single-fixture sample is a finished game. |
#' | start_time_local | character | Scheduled tip-off in the venue's local time, 'YYYY-MM-DDTHH:MM:SS' with no zone (19:10 local = 10:10 UTC in Tokyo). DRAFT fixtures carry a date at 00:00:00. |
#' | attendance | integer | Announced attendance of the game; null when not recorded. |
#' | live_data_available | logical | Whether live stats were collected for the game (present on a minority of fixtures; meaning unverified). Absent on some rows. |
#' | live_video_available | logical | Whether live video was available (false on all 146 fixtures of the four seasons). |
#' | pool_code | character | Pool (group) id: a 30-character hex string, equal to pool.id; null on playoff and DRAFT fixtures. |
#' | pool_id | character | Pool id: a 30-character hex string; null for playoff games ('Unknown Pool'). |
#' | pool_name | character | Pool name: 'Group A', 'Group B', 'Group C' or the placeholder 'Unknown Pool'. |
#' | pool_abb | character | Pool abbreviation (A, B, C). Playoff and DRAFT fixtures of the /matches list carry the placeholder pool, whose abb is empty or 'N/A'. Null on some rows. |
#' | stage_id | character | Stage reference `<season UUID>:<stage code>` on team-fixture rows only (its first half scopes the fixture to a season); null on the other fixture routes, which send the stage_code, stage_name and stage_order trio. |
#' | stage_code | character | Stage id: a 30-character hex string. Absent on some rows. |
#' | stage_name | character | Stage name: 'Group Stage', 'Final Four' or 'EASL Playoffs'. Absent on some rows. |
#' | stage_order | integer | Ordinal of the stage within the season (1 = Group Stage, 2 = EASL Playoffs). Absent on some rows. |
#' | venue_name | character | Arena name. Absent on some rows. |
#' | venue_name_latin | character | Venue name in Latin script; null on most rows. Absent on some rows. |
#' | venue_abbreviation_latin | character | Venue abbreviation in the Latin field; null except the native-script name of Okinawa Arena on 12 fixtures. Absent on some rows. |
#' | venue_abbreviation_local | character | Venue abbreviation in the local field; null except 'F-PICO' on 2 fixtures. Absent on some rows. |
#' | venue_alternate_name_latin | character | Alternative venue name; null on most rows. Absent on some rows. |
#' | venue_country_code | character | ISO 3166-1 alpha-3 country code of the arena: JPN, TWN, PHL, KOR, MAC, HKG, MNG, CHN. The /matches list holds null here on DRAFT fixtures (empty venue). Absent on some rows. |
#' | venue_city | character | City of the arena. Absent on some rows. |
#' | venue_state | character | State or province of the arena (Philippine games, for example Cebu). Absent on some rows. |
#' | home_team_id | character | Home team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | home_name | character | Home team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | home_name_native | character | Home team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | home_code_latin | character | Home team: three-letter club code (for example BRE); null or empty for some clubs. |
#' | home_code_local | character | Home team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' | home_score | integer | Home team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
#' | home_result_place | integer | Home team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
#' | home_draw | logical | Home team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |
#' | away_team_id | character | Away team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | away_name | character | Away team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | away_name_native | character | Away team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | away_code_latin | character | Away team: three-letter club code (for example BRE); null or empty for some clubs. |
#' | away_code_local | character | Away team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' | away_score | integer | Away team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
#' | away_result_place | integer | Away team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
#' | away_draw | logical | Away team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_schedule(season = 2026))
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Header of one finished fixture: teams, final score, status, stage, pool, venue and
#'   attendance. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_game`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Always null here: the game route carries no season; join season_id to easl_seasons. |
#' | season_id | character | Always null here: the game route carries no season. |
#' | fixture_id | character | fixtureId: DataCore fixture (game) UUID v1 (key space: EASL games; the `{fixtureId}` of every /matches route). |
#' | fixture_number | integer | Fixture number YYSSNNN: two-digit start year, two-digit end year, three-digit sequence (2627001 = first game of 2026-27, 2526003 = third of 2025-26). Null on every 2023-24 fixture. |
#' | fixture_type | character | REGULAR (group stage), PLAYOFF (quarter- and semifinals) or FINAL (championship and third-place games). Missing from the DRAFT placeholders. |
#' | status | character | CONFIRMED = finished with a final box score; SCHEDULED = future; DRAFT = a placeholder with no teams or time. |
#' | fixture_name | character | Fixture name for special games ('EASL Championship', 'Semifinals 2', 'EASL Tip-Off 2026 Cebu'); null for ordinary group games. |
#' | start_time_utc | character | Scheduled tip-off in UTC, 'YYYY-MM-DDTHH:MM:SS' with no zone marker. The /matches list holds null here on DRAFT fixtures; the single-fixture sample is a finished game. |
#' | start_time_local | character | Scheduled tip-off in the venue's local time, 'YYYY-MM-DDTHH:MM:SS' with no zone (19:10 local = 10:10 UTC in Tokyo). DRAFT fixtures carry a date at 00:00:00. |
#' | attendance | integer | Announced attendance of the game; null when not recorded. |
#' | live_data_available | logical | Whether live stats were collected for the game (present on a minority of fixtures; meaning unverified). Absent on some rows. |
#' | live_video_available | logical | Whether live video was available (false on all 146 fixtures of the four seasons). |
#' | pool_code | character | Pool (group) id: a 30-character hex string, equal to pool.id; null on playoff and DRAFT fixtures. |
#' | pool_id | character | Pool id: a 30-character hex string; null for playoff games ('Unknown Pool'). |
#' | pool_name | character | Pool name: 'Group A', 'Group B', 'Group C' or the placeholder 'Unknown Pool'. |
#' | pool_abb | character | Pool abbreviation (A, B, C). Playoff and DRAFT fixtures of the /matches list carry the placeholder pool, whose abb is empty or 'N/A'. |
#' | stage_id | character | Stage reference `<season UUID>:<stage code>` on team-fixture rows only (its first half scopes the fixture to a season); null on the other fixture routes, which send the stage_code, stage_name and stage_order trio. |
#' | stage_code | character | Stage id: a 30-character hex string. Absent on some rows. |
#' | stage_name | character | Stage name: 'Group Stage', 'Final Four' or 'EASL Playoffs'. Absent on some rows. |
#' | stage_order | integer | Ordinal of the stage within the season (1 = Group Stage, 2 = EASL Playoffs). Absent on some rows. |
#' | venue_name | character | Arena name. Absent on some rows. |
#' | venue_name_latin | character | Venue name in Latin script; null on most rows. |
#' | venue_abbreviation_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | venue_abbreviation_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | venue_alternate_name_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | venue_country_code | character | ISO 3166-1 alpha-3 country code of the arena: JPN, TWN, PHL, KOR, MAC, HKG, MNG, CHN. The /matches list holds null here on DRAFT fixtures (empty venue). |
#' | venue_city | character | City of the arena. |
#' | venue_state | character | State or province of the arena (Philippine games, for example Cebu). |
#' | home_team_id | character | Home team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | home_name | character | Home team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | home_name_native | character | Home team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | home_code_latin | character | Home team: three-letter club code (for example BRE); null or empty for some clubs. |
#' | home_code_local | character | Home team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' | home_score | integer | Home team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
#' | home_result_place | integer | Home team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
#' | home_draw | logical | Home team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |
#' | away_team_id | character | Away team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | away_name | character | Away team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | away_name_native | character | Away team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | away_code_latin | character | Away team: three-letter club code (for example BRE); null or empty for some clubs. |
#' | away_code_local | character | Away team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' | away_score | integer | Away team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
#' | away_result_place | integer | Away team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
#' | away_draw | logical | Away team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_game(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Player box score of a finished game, one row per rostered player (non-players have null
#'   counting stats). An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_player_box`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | fixture_id | character | DataCore fixture (game) UUID v1 of the box row. |
#' | team_id | character | The player's team: DataCore team (entity) UUID v1 (the wire's entityId). |
#' | team_name | character | The player's team display name, joined from the body's teams array. |
#' | team_name_native | character | The player's team name in native script, joined from the body's teams array; blank for most clubs. |
#' | player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
#' | player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. Absent on some rows. |
#' | player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. Absent on some rows. |
#' | bib | character | Jersey number as a string ('00' and '0' are distinct). |
#' | position | character | Playing position: G, F, C, PG, SG, SF, PF or GF; null on some rows. |
#' | starter | logical | True for a starter (five per team). |
#' | is_player | logical | True on every row (team officials are never listed). |
#' | is_team_official | logical | False on every row. |
#' | played | logical | True when the player has playing time (minutes present); False for the rostered players who did not play (their counting stats are null). |
#' | minutes_played | double | Playing time in minutes (decimal), parsed from the ISO 8601 minutes statistic (PT35M11S = 35.1833). |
#' | assists | integer | Assists: passes that directly lead to a made field goal. Null on some rows. |
#' | assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Null on some rows. |
#' | assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Null on some rows. |
#' | blocks | integer | Shots blocked (made by this player or team). Null on some rows. |
#' | blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Null on some rows. |
#' | double_double | integer | Double-double flag: 1 when exactly two of points, rebounds, assists, steals, blocks reached 10 in the game, else 0 (a triple-double is counted in tripleDouble instead). In a season line it is a count of such games. |
#' | dunks | integer | Dunks made. Null on some rows. |
#' | efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). |
#' | efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Null on some rows. |
#' | field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Null on some rows. |
#' | field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Null on some rows. |
#' | field_goals_made | integer | Field goals made (2- and 3-point shots). Null on some rows. |
#' | field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Null on some rows. |
#' | fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Null on some rows. |
#' | fouls_coach_technical | integer | Technical fouls on the coach. Null on some rows. |
#' | fouls_disqualifying | integer | Disqualifying fouls. Null on some rows. |
#' | fouls_disruptive | integer | Disruptive fouls (DataCore column; filled from 2026-27). Null on some rows. |
#' | fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Null on some rows. |
#' | fouls_flagrant | integer | Flagrant fouls (DataCore column; filled from 2026-27). Null on some rows. |
#' | fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Null on some rows. |
#' | fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Null on some rows. |
#' | fouls_technical | integer | Technical fouls committed by the player or team. Null on some rows. |
#' | fouls_technical_cat1 | integer | Technical fouls of category 1 (DataCore column; filled from 2026-27). Null on some rows. |
#' | fouls_technical_cat2 | integer | Technical fouls of category 2 (DataCore column; filled from 2026-27). Null on some rows. |
#' | fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). |
#' | fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Null on some rows. |
#' | free_throws_attempted | integer | Free throws attempted. Null on some rows. |
#' | free_throws_made | integer | Free throws made: a game count on the box-score and team-total routes, a season total on the season statistics routes. |
#' | free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Null on some rows. |
#' | index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. |
#' | max_assists | integer | Highest assists in a single game: in a game row it equals assists; in a season line it is the best game. Null on some rows. |
#' | max_free_throws_made | integer | Highest free throws made in a single game (equals freeThrowsMade in a game row). |
#' | max_points | integer | Highest points in a single game (equals points in a game row). |
#' | max_points_four_made | integer | Highest 4-point shots made in a game (DataCore column; EASL has no 4-point line; filled from 2026-27). Null on some rows. |
#' | max_points_three_made | integer | Highest 3-pointers made in a single game. Null on some rows. |
#' | max_points_two_made | integer | Highest 2-pointers made in a single game. Null on some rows. |
#' | max_rebounds | integer | Highest rebounds in a single game. Null on some rows. |
#' | max_rebounds_defensive | integer | Highest defensive rebounds in a single game. Null on some rows. |
#' | max_rebounds_offensive | integer | Highest offensive rebounds in a single game. Null on some rows. |
#' | max_steals | integer | Highest steals in a single game. Null on some rows. |
#' | minus | integer | Points the opponents scored while the player was on the court. Null on some rows. |
#' | minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Null on some rows. |
#' | pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). |
#' | plus | integer | Points the player's team scored while he was on the court. Null on some rows. |
#' | plus_minus | integer | plus - minus: the team's point margin while the player was on the court. Null on some rows. |
#' | points | integer | Points scored: a game count on the box-score and team-total routes, a season total on the season statistics routes. |
#' | points_fast_break | integer | Points scored on fast breaks. Null on some rows. |
#' | points_fast_break_attempted | integer | Fast-break field goals attempted. Null on some rows. |
#' | points_fast_break_made | integer | Fast-break field goals made. Null on some rows. |
#' | points_four_attempted | integer | 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Null on some rows. |
#' | points_four_made | integer | 4-point shots made (see pointsFourAttempted). Null on some rows. |
#' | points_four_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_from_turnover | integer | Points scored off opponent turnovers. Null on some rows. |
#' | points_in_the_paint | integer | Points scored in the paint. Null on some rows. |
#' | points_in_the_paint_attempted | integer | Field goals attempted in the paint. Null on some rows. |
#' | points_in_the_paint_made | integer | Field goals made in the paint. Null on some rows. |
#' | points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Null on some rows. |
#' | points_second_chance_attempted | integer | Second-chance field goals attempted. Null on some rows. |
#' | points_second_chance_made | integer | Second-chance field goals made. Null on some rows. |
#' | points_three_attempted | integer | 3-point field goals attempted. Null on some rows. |
#' | points_three_made | integer | 3-point field goals made. Null on some rows. |
#' | points_three_percentage | double | 3-point percentage on a 0-100 scale. Null on some rows. |
#' | points_two_attempted | integer | 2-point field goals attempted. Null on some rows. |
#' | points_two_made | integer | 2-point field goals made. Null on some rows. |
#' | points_two_percentage | double | 2-point percentage on a 0-100 scale. Null on some rows. |
#' | power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Null on some rows. |
#' | power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Null on some rows. |
#' | rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Null on some rows. |
#' | rebounds_defensive | integer | Defensive rebounds. Null on some rows. |
#' | rebounds_defensive_percentage | double | Share of available defensive rebounds taken while on the court, on a 0-100 scale; values above 100 (up to 108.9) occur, so the definition is unverified. Null on some rows. |
#' | rebounds_offensive | integer | Offensive rebounds. Null on some rows. |
#' | rebounds_offensive_percentage | double | Share of available offensive rebounds taken while on the court, 0-100 scale (up to 91.4 observed); definition unverified. Null on some rows. |
#' | rebounds_percentage | double | Share of all available rebounds taken while on the court, 0-100 scale; definition unverified. Null on some rows. |
#' | steals | integer | Steals. Null on some rows. |
#' | triple_double | integer | Triple-double flag: 1 when three or more of points, rebounds, assists, steals, blocks reached 10, else 0. |
#' | true_shooting_attempts | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | true_shooting_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | turnovers | integer | Turnovers committed by players. Null on some rows. |
#' | turnovers_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | usage_rate | double | Usage rate on a 0-100 scale: share of the team's possessions used while on the court (up to 136 observed); definition unverified. Null on some rows. |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_player_box(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Play-by-play of a finished game in delivered order, with the running score and the points
#'   each event scored. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_pbp`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | fixture_id | character | DataCore fixture (game) UUID v1 from the request. |
#' | event_number | integer | 1-based position of the event in the delivered array, which is the only usable order (sequence is not monotonic). |
#' | sequence | integer | Event sequence number from the scorer's system: NOT in game order (the delivered array order is), and not always unique within a game (35 of 106 games repeat values). |
#' | period_id | integer | Period: 1-4 regulation, 11 = first overtime (12 = second overtime appears in team totals). |
#' | period_label | character | Q1-Q4 for periods 1-4; OT1, OT2 ... for overtimes (the server numbers the first overtime 11 in team totals; periods 5-10 are read as `OT{n-4}`, unverified). |
#' | event_time | character | When the event was logged, wall-clock 'YYYY-MM-DDTHH:MM:SS.mmm' in UTC with no zone marker. There is NO game clock (time remaining) in this feed. |
#' | received_time | double | When the event was received upstream, Unix epoch MILLISECONDS (UTC): a median 1.6 s after eventTime (5th to 95th percentile -0.6 s to +55 s over 30,874 events); meaning unverified. |
#' | description | character | Event text. Shots read `<2pt/3pt> <shot type> missed[ (modifier)]` for EVERY field-goal attempt, made or not: the word 'missed' is always there and the result is the change of `scores` (see the divergence notes). Shot types: Jump shot, Layup, Driving layup, Pull-up jump shot, Floating jump shot, Tip-in, Fadeaway, Step-back jump shot, Turnaround jump shot, Hook shot, Dunk, Reverse layup, Alley-oop, Alley-oop dunk, Euro step (none on 23 rows: '3pt missed'). Modifiers: in the paint, second chance, from turnover, fast break, blocked. Free throws read 'Free throw K of M made' (M = 1, 2 or 3) for every attempt, also always 'made'. Other events (complete list): Assist; Block; Steal; Substitution in; Substitution out; Defensive rebound; Defensive rebound (team); Offensive rebound; Offensive rebound (team); Foul; Foul (N FT); Foul drawn; Foul drawn (N FT); Personal foul; Personal foul (N FT); Personal foul (shooting); Personal foul (shooting) (N FT); Offensive foul; Offensive foul (charge); Technical foul; Technical foul (N FT); Bench technical foul; Bench technical foul (N FT); Coach technical foul; Coach technical foul (N FT); Unsportsmanlike foul; Unsportsmanlike foul (N FT); Disqualifying foul (N FT); Jump ball won; Jump ball won (held ball); Jump ball lost; Full timeout; Short timeout; Media timeout; Commercial timeout; Officials timeout; Officials timeout (mandatory); Coach's challenge (pending); Coach's challenge (complete) - upheld; Coach's challenge (complete) - overturned; Instant replay review (complete) - upheld; Instant replay review (complete) - overturned; Turnover - Bad pass; Ball handling; Traveling; Out of bounds; Offensive; Backcourt violation; Double dribble; Carrying; Offensive goaltending; 3 second violation; 5 second violation; 5 second violation (team); 8 second violation (team); Shot clock violation (team); Other; Other (team). N FT = free throws awarded. |
#' | team_id | character | DataCore team UUID v1 of the acting team; null on events with no team. |
#' | player_id | character | DataCore person UUID v1 of the acting player; null for team events (team rebounds, timeouts). |
#' | player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. Absent on some rows. |
#' | player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. Absent on some rows. |
#' | jersey_number | character | Jersey number as a string; null on one event. Absent on some rows. |
#' | team_score | integer | The event team's running score as of this event (the running score lags the true score on a minority of events); null on events with no team. |
#' | opponent_score | integer | The other team's running score as of this event; null on events with no team. |
#' | points_scored | integer | Points the event team gained since the previous event (change of its running score): the made shot's value. The description always says 'missed', so count points here, not strings; the running score lags on some games, which shifts points to a later event. |
#' | team1_id | character | First team of the body's teams array (the fixture's competitors order, arbitrary home/away); team1_score belongs to it. |
#' | team1_score | integer | Running score of team1_id as of this event. |
#' | team2_id | character | Second team of the body's teams array; team2_score belongs to it. |
#' | team2_score | integer | Running score of team2_id as of this event. |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_pbp(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Team totals of a finished game, one row per team, with the opponent's totals as `*_against`
#'   columns. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_team_box`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | fixture_id | character | fixtureId: DataCore fixture (game) UUID v1 (key space: EASL games; the `{fixtureId}` of every /matches route). |
#' | team_id | character | DataCore team (entity) UUID v1 (the wire's entityId). |
#' | team_name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | team_name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | assists | integer | Assists: passes that directly lead to a made field goal. Team total for the game. |
#' | assists_against | integer | Opponent's figure in the same games: assists: passes that directly lead to a made field goal. Team total for the game. Absent on some rows. |
#' | assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Team total for the game. |
#' | assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Team total for the game. |
#' | biggest_lead | integer | Largest lead the team held during the game, in points. A season total sums the per-game maxima. Team total for the game. |
#' | biggest_scoring_run | integer | Longest unanswered scoring run of the team, in points. A season total sums the per-game maxima. Team total for the game. |
#' | blocks | integer | Shots blocked (made by this player or team). Team total for the game. |
#' | blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Team total for the game. |
#' | dunks | integer | Dunks made. Team total for the game. |
#' | efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). Team total for the game. |
#' | efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Team total for the game. |
#' | field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Team total for the game. |
#' | field_goals_attempted_against | integer | Opponent's figure in the same games: field goals attempted (2- and 3-point shots; free throws excluded). Team total for the game. Absent on some rows. |
#' | field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Team total for the game. |
#' | field_goals_made | integer | Field goals made (2- and 3-point shots). Team total for the game. |
#' | field_goals_made_against | integer | Opponent's figure in the same games: field goals made (2- and 3-point shots). Team total for the game. Absent on some rows. |
#' | field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Team total for the game. |
#' | field_goals_percentage_against | double | Opponent's figure in the same games: field-goal percentage on a 0-100 scale (made / attempted x 100). Team total for the game. Absent on some rows. |
#' | fouls_bench_technical | integer | Technical fouls called on the bench (not a player). Team total for the game. |
#' | fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Team total for the game. |
#' | fouls_coach_technical | integer | Technical fouls on the coach. Team total for the game. |
#' | fouls_disqualifying | integer | Disqualifying fouls. Team total for the game. |
#' | fouls_disruptive | integer | Disruptive fouls (DataCore column; filled from 2026-27). Team total for the game. Absent on some rows. |
#' | fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Team total for the game. |
#' | fouls_flagrant | integer | Flagrant fouls (DataCore column; filled from 2026-27). Team total for the game. Absent on some rows. |
#' | fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Team total for the game. |
#' | fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Team total for the game. |
#' | fouls_personal_against | integer | Opponent's figure in the same games: personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Team total for the game. Absent on some rows. |
#' | fouls_technical | integer | Technical fouls committed by the player or team. Team total for the game. |
#' | fouls_technical_against | integer | Opponent's figure in the same games: technical fouls committed by the player or team. Team total for the game. Absent on some rows. |
#' | fouls_technical_cat1 | integer | Technical fouls of category 1 (DataCore column; filled from 2026-27). Team total for the game. Absent on some rows. |
#' | fouls_technical_cat2 | integer | Technical fouls of category 2 (DataCore column; filled from 2026-27). Team total for the game. Absent on some rows. |
#' | fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). Team total for the game. |
#' | fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Team total for the game. |
#' | free_throws_attempted | integer | Free throws attempted. Team total for the game. |
#' | free_throws_attempted_against | integer | Opponent's figure in the same games: free throws attempted. Team total for the game. Absent on some rows. |
#' | free_throws_made | integer | Free throws made. Team total for the game. |
#' | free_throws_made_against | integer | Opponent's figure in the same games: free throws made. Team total for the game. Absent on some rows. |
#' | free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Team total for the game. |
#' | free_throws_percentage_against | double | Opponent's figure in the same games: free-throw percentage on a 0-100 scale. Team total for the game. Absent on some rows. |
#' | index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. Team total for the game. |
#' | lead_changes | integer | Times the lead changed hands during the game (a season total sums the games). Team total for the game. |
#' | minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Team total for the game. |
#' | pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). Team total for the game. |
#' | points | integer | Points scored. Team total for the game. |
#' | points_against | integer | Opponent's figure in the same games: points scored. Team total for the game. |
#' | points_fast_break | integer | Points scored on fast breaks. Team total for the game. |
#' | points_fast_break_against | integer | Opponent's figure in the same games: points scored on fast breaks. Team total for the game. Absent on some rows. |
#' | points_fast_break_attempted | integer | Fast-break field goals attempted. Team total for the game. |
#' | points_fast_break_made | integer | Fast-break field goals made. Team total for the game. |
#' | points_four_attempted | integer | 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Team total for the game. Absent on some rows. |
#' | points_four_attempted_against | integer | Opponent's figure in the same games: 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Team total for the game. Absent on some rows. |
#' | points_four_made | integer | 4-point shots made (see pointsFourAttempted). Team total for the game. Absent on some rows. |
#' | points_four_made_against | integer | Opponent's figure in the same games: 4-point shots made (see pointsFourAttempted). Team total for the game. Absent on some rows. |
#' | points_from_bench | integer | Points scored by players who did not start (a team figure). Team total for the game. |
#' | points_from_bench_against | integer | Opponent's figure in the same games: points scored by players who did not start (a team figure). Team total for the game. Absent on some rows. |
#' | points_from_turnover | integer | Points scored off opponent turnovers. Team total for the game. |
#' | points_from_turnover_against | integer | Opponent's figure in the same games: points scored off opponent turnovers. Team total for the game. Absent on some rows. |
#' | points_in_the_paint | integer | Points scored in the paint. Team total for the game. |
#' | points_in_the_paint_against | integer | Opponent's figure in the same games: points scored in the paint. Team total for the game. Absent on some rows. |
#' | points_in_the_paint_attempted | integer | Field goals attempted in the paint. Team total for the game. |
#' | points_in_the_paint_made | integer | Field goals made in the paint. Team total for the game. |
#' | points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Team total for the game. |
#' | points_second_chance_against | integer | Opponent's figure in the same games: points scored on second-chance possessions (after an offensive rebound). Team total for the game. Absent on some rows. |
#' | points_second_chance_attempted | integer | Second-chance field goals attempted. Team total for the game. |
#' | points_second_chance_made | integer | Second-chance field goals made. Team total for the game. |
#' | points_three_attempted | integer | 3-point field goals attempted. Team total for the game. |
#' | points_three_attempted_against | integer | Opponent's figure in the same games: 3-point field goals attempted. Team total for the game. Absent on some rows. |
#' | points_three_made | integer | 3-point field goals made. Team total for the game. |
#' | points_three_made_against | integer | Opponent's figure in the same games: 3-point field goals made. Team total for the game. Absent on some rows. |
#' | points_three_percentage | double | 3-point percentage on a 0-100 scale. Team total for the game. |
#' | points_three_percentage_against | double | Opponent's figure in the same games: 3-point percentage on a 0-100 scale. Team total for the game. Absent on some rows. |
#' | points_two_attempted | integer | 2-point field goals attempted. Team total for the game. |
#' | points_two_attempted_against | integer | Opponent's figure in the same games: 2-point field goals attempted. Team total for the game. Absent on some rows. |
#' | points_two_made | integer | 2-point field goals made. Team total for the game. |
#' | points_two_made_against | integer | Opponent's figure in the same games: 2-point field goals made. Team total for the game. Absent on some rows. |
#' | points_two_percentage | double | 2-point percentage on a 0-100 scale. Team total for the game. |
#' | points_two_percentage_against | double | Opponent's figure in the same games: 2-point percentage on a 0-100 scale. Team total for the game. Absent on some rows. |
#' | power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Team total for the game. |
#' | power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Team total for the game. |
#' | rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Team total for the game. |
#' | rebounds_against | integer | Opponent's figure in the same games: total rebounds: offensive + defensive. Team's totals include team rebounds. Team total for the game. Absent on some rows. |
#' | rebounds_defensive | integer | Defensive rebounds. Team total for the game. |
#' | rebounds_defensive_against | integer | Opponent's figure in the same games: defensive rebounds. Team total for the game. Absent on some rows. |
#' | rebounds_offensive | integer | Offensive rebounds. Team total for the game. |
#' | rebounds_offensive_against | integer | Opponent's figure in the same games: offensive rebounds. Team total for the game. Absent on some rows. |
#' | rebounds_team_defensive | integer | Defensive rebounds credited to the team as a whole (not to a player). Team total for the game. |
#' | rebounds_team_defensive_against | integer | Opponent's figure in the same games: defensive rebounds credited to the team as a whole (not to a player). Team total for the game. Absent on some rows. |
#' | rebounds_team_offensive | integer | Offensive rebounds credited to the team as a whole. Team total for the game. |
#' | rebounds_team_offensive_against | integer | Opponent's figure in the same games: offensive rebounds credited to the team as a whole. Team total for the game. Absent on some rows. |
#' | rebounds_team_total | integer | Team rebounds credited to the team as a whole (offensive + defensive). Team total for the game. |
#' | rebounds_team_total_against | integer | Opponent's figure in the same games: team rebounds credited to the team as a whole (offensive + defensive). Team total for the game. Absent on some rows. |
#' | steals | integer | Steals. Team total for the game. |
#' | steals_against | integer | Opponent's figure in the same games: steals. Team total for the game. Absent on some rows. |
#' | time_in_lead | character | Time the team led, as an ISO 8601 duration `PT{m}M{s}S` (unwrapped minutes). Team total for the game. |
#' | timeouts_used | integer | Timeouts taken by the team (present from 2025-26). Team total for the game. Absent on some rows. |
#' | times_score_level | integer | Times the score was tied during the game. Team total for the game. |
#' | turnovers | integer | Turnovers committed by players. Team total for the game. |
#' | turnovers_against | integer | Opponent's figure in the same games: turnovers committed by players. Team total for the game. Absent on some rows. |
#' | turnovers_team | integer | Team turnovers not charged to a player (shot-clock and similar violations). Team total for the game. |
#' | turnovers_team_against | integer | Opponent's figure in the same games: team turnovers not charged to a player (shot-clock and similar violations). Team total for the game. Absent on some rows. |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_team_box(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3"))
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Team totals of a finished game by period, one row per team and period (overtimes after the
#'   fourth). An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_team_box_by_period`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | fixture_id | character | DataCore fixture (game) UUID v1 from the request. |
#' | team_id | character | DataCore team UUID v1 (the wire's team.teamId). |
#' | team_name | character | Team display name (English / Latin script, the wire's nameFullLocal). |
#' | team_name_native | character | Team name in native script (the wire's nameFullLatin; blank for most clubs). |
#' | period | integer | Period number: 1-4 for regulation, overtimes after (the wire's `period_{n}` key). |
#' | period_label | character | Q1-Q4 for periods 1-4; OT1, OT2 ... for overtimes (the server numbers the first overtime 11 in team totals; periods 5-10 are read as `OT{n-4}`, unverified). |
#' | assists | integer | Assists: passes that directly lead to a made field goal. Team total for the period. |
#' | assists_against | integer | Opponent's figure in the same games: assists: passes that directly lead to a made field goal. Team total for the period. Absent on some rows. |
#' | assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Team total for the period. |
#' | assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Team total for the period. Absent on some rows. |
#' | biggest_lead | integer | Largest lead the team held during the game, in points. A season total sums the per-game maxima. Team total for the period. |
#' | biggest_scoring_run | integer | Longest unanswered scoring run of the team, in points. A season total sums the per-game maxima. Team total for the period. |
#' | blocks | integer | Shots blocked (made by this player or team). Team total for the period. |
#' | blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Team total for the period. |
#' | dunks | integer | Dunks made. Team total for the period. |
#' | efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). Team total for the period. |
#' | efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Team total for the period. |
#' | field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Team total for the period. |
#' | field_goals_attempted_against | integer | Opponent's figure in the same games: field goals attempted (2- and 3-point shots; free throws excluded). Team total for the period. Absent on some rows. |
#' | field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Team total for the period. |
#' | field_goals_made | integer | Field goals made (2- and 3-point shots). Team total for the period. |
#' | field_goals_made_against | integer | Opponent's figure in the same games: field goals made (2- and 3-point shots). Team total for the period. Absent on some rows. |
#' | field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Team total for the period. |
#' | field_goals_percentage_against | double | Opponent's figure in the same games: field-goal percentage on a 0-100 scale (made / attempted x 100). Team total for the period. Absent on some rows. |
#' | fouls_bench_technical | integer | Technical fouls called on the bench (not a player). Team total for the period. |
#' | fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Team total for the period. |
#' | fouls_coach_technical | integer | Technical fouls on the coach. Team total for the period. |
#' | fouls_disqualifying | integer | Disqualifying fouls. Team total for the period. |
#' | fouls_disruptive | integer | Disruptive fouls (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
#' | fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Team total for the period. |
#' | fouls_flagrant | integer | Flagrant fouls (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
#' | fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Team total for the period. |
#' | fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Team total for the period. |
#' | fouls_personal_against | integer | Opponent's figure in the same games: personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Team total for the period. Absent on some rows. |
#' | fouls_technical | integer | Technical fouls committed by the player or team. Team total for the period. |
#' | fouls_technical_against | integer | Opponent's figure in the same games: technical fouls committed by the player or team. Team total for the period. Absent on some rows. |
#' | fouls_technical_cat1 | integer | Technical fouls of category 1 (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
#' | fouls_technical_cat2 | integer | Technical fouls of category 2 (DataCore column; filled from 2026-27). Team total for the period. Absent on some rows. |
#' | fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). Team total for the period. |
#' | fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Team total for the period. |
#' | free_throws_attempted | integer | Free throws attempted. Team total for the period. |
#' | free_throws_attempted_against | integer | Opponent's figure in the same games: free throws attempted. Team total for the period. Absent on some rows. |
#' | free_throws_made | integer | Free throws made. Team total for the period. |
#' | free_throws_made_against | integer | Opponent's figure in the same games: free throws made. Team total for the period. Absent on some rows. |
#' | free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
#' | free_throws_percentage_against | double | Opponent's figure in the same games: free-throw percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
#' | index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. Team total for the period. |
#' | lead_changes | integer | Times the lead changed hands during the game (a season total sums the games). Team total for the period. |
#' | minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Team total for the period. |
#' | pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). Team total for the period. |
#' | points | integer | Points scored. Team total for the period. |
#' | points_against | integer | Opponent's figure in the same games: points scored. Team total for the period. |
#' | points_fast_break | integer | Points scored on fast breaks. Team total for the period. |
#' | points_fast_break_against | integer | Opponent's figure in the same games: points scored on fast breaks. Team total for the period. Absent on some rows. |
#' | points_fast_break_attempted | integer | Fast-break field goals attempted. Team total for the period. |
#' | points_fast_break_made | integer | Fast-break field goals made. Team total for the period. |
#' | points_four_attempted | integer | 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Team total for the period. Absent on some rows. |
#' | points_four_attempted_against | integer | Opponent's figure in the same games: 4-point shots attempted (DataCore column; EASL has no 4-point line; filled from 2026-27). Team total for the period. Absent on some rows. |
#' | points_four_made | integer | 4-point shots made (see pointsFourAttempted). Team total for the period. Absent on some rows. |
#' | points_four_made_against | integer | Opponent's figure in the same games: 4-point shots made (see pointsFourAttempted). Team total for the period. Absent on some rows. |
#' | points_from_bench | integer | Points scored by players who did not start (a team figure). Team total for the period. |
#' | points_from_bench_against | integer | Opponent's figure in the same games: points scored by players who did not start (a team figure). Team total for the period. Absent on some rows. |
#' | points_from_turnover | integer | Points scored off opponent turnovers. Team total for the period. |
#' | points_from_turnover_against | integer | Opponent's figure in the same games: points scored off opponent turnovers. Team total for the period. Absent on some rows. |
#' | points_in_the_paint | integer | Points scored in the paint. Team total for the period. |
#' | points_in_the_paint_against | integer | Opponent's figure in the same games: points scored in the paint. Team total for the period. Absent on some rows. |
#' | points_in_the_paint_attempted | integer | Field goals attempted in the paint. Team total for the period. |
#' | points_in_the_paint_made | integer | Field goals made in the paint. Team total for the period. |
#' | points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Team total for the period. |
#' | points_second_chance_against | integer | Opponent's figure in the same games: points scored on second-chance possessions (after an offensive rebound). Team total for the period. Absent on some rows. |
#' | points_second_chance_attempted | integer | Second-chance field goals attempted. Team total for the period. |
#' | points_second_chance_made | integer | Second-chance field goals made. Team total for the period. |
#' | points_three_attempted | integer | 3-point field goals attempted. Team total for the period. |
#' | points_three_attempted_against | integer | Opponent's figure in the same games: 3-point field goals attempted. Team total for the period. Absent on some rows. |
#' | points_three_made | integer | 3-point field goals made. Team total for the period. |
#' | points_three_made_against | integer | Opponent's figure in the same games: 3-point field goals made. Team total for the period. Absent on some rows. |
#' | points_three_percentage | double | 3-point percentage on a 0-100 scale. Team total for the period. |
#' | points_three_percentage_against | double | Opponent's figure in the same games: 3-point percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
#' | points_two_attempted | integer | 2-point field goals attempted. Team total for the period. |
#' | points_two_attempted_against | integer | Opponent's figure in the same games: 2-point field goals attempted. Team total for the period. Absent on some rows. |
#' | points_two_made | integer | 2-point field goals made. Team total for the period. |
#' | points_two_made_against | integer | Opponent's figure in the same games: 2-point field goals made. Team total for the period. Absent on some rows. |
#' | points_two_percentage | double | 2-point percentage on a 0-100 scale. Team total for the period. |
#' | points_two_percentage_against | double | Opponent's figure in the same games: 2-point percentage on a 0-100 scale. Team total for the period. Absent on some rows. |
#' | power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Team total for the period. |
#' | power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Team total for the period. |
#' | rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Team total for the period. |
#' | rebounds_against | integer | Opponent's figure in the same games: total rebounds: offensive + defensive. Team's totals include team rebounds. Team total for the period. Absent on some rows. |
#' | rebounds_defensive | integer | Defensive rebounds. Team total for the period. |
#' | rebounds_defensive_against | integer | Opponent's figure in the same games: defensive rebounds. Team total for the period. Absent on some rows. |
#' | rebounds_offensive | integer | Offensive rebounds. Team total for the period. |
#' | rebounds_offensive_against | integer | Opponent's figure in the same games: offensive rebounds. Team total for the period. Absent on some rows. |
#' | rebounds_team_defensive | integer | Defensive rebounds credited to the team as a whole (not to a player). Team total for the period. |
#' | rebounds_team_defensive_against | integer | Opponent's figure in the same games: defensive rebounds credited to the team as a whole (not to a player). Team total for the period. Absent on some rows. |
#' | rebounds_team_offensive | integer | Offensive rebounds credited to the team as a whole. Team total for the period. |
#' | rebounds_team_offensive_against | integer | Opponent's figure in the same games: offensive rebounds credited to the team as a whole. Team total for the period. Absent on some rows. |
#' | rebounds_team_total | integer | Team rebounds credited to the team as a whole (offensive + defensive). Team total for the period. |
#' | rebounds_team_total_against | integer | Opponent's figure in the same games: team rebounds credited to the team as a whole (offensive + defensive). Team total for the period. Absent on some rows. |
#' | steals | integer | Steals. Team total for the period. |
#' | steals_against | integer | Opponent's figure in the same games: steals. Team total for the period. Absent on some rows. |
#' | time_in_lead | character | Time the team led, as an ISO 8601 duration `PT{m}M{s}S` (unwrapped minutes). Team total for the period. |
#' | timeouts_used | integer | Timeouts taken by the team (present from 2025-26). Team total for the period. Absent on some rows. |
#' | times_score_level | integer | Times the score was tied during the game. Team total for the period. |
#' | turnovers | integer | Turnovers committed by players. Team total for the period. |
#' | turnovers_against | integer | Opponent's figure in the same games: turnovers committed by players. Team total for the period. Absent on some rows. |
#' | turnovers_team | integer | Team turnovers not charged to a player (shot-clock and similar violations). Team total for the period. |
#' | turnovers_team_against | integer | Opponent's figure in the same games: team turnovers not charged to a player (shot-clock and similar violations). Team total for the period. Absent on some rows. |
#' @eval .intl_details(.easl_health_details, 'easl_team_box_by_period(fixture_id = "10af8fd4-106e-11f1-960b-5798087c7aa3")')
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Group-stage standings of one season: rank within the pool, record, splits, points and the
#'   last five results. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = EASL 25-26), from the request. |
#' | season_id | character | DataCore season UUID v1, from the request (the standings rows carry none). |
#' | standing_id | character | Standings row id: a DataCore UUID v1 for the (season, pool, team) row (joins nothing else). |
#' | position | integer | Rank within the pool, 1-4. |
#' | team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | team_name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | team_code | character | Three-letter club code; null for some clubs. |
#' | pool_id | character | Pool id: a 30-character hex string (equals a fixture's poolCode). |
#' | pool_name | character | Pool name: 'Group A', 'Group B' or 'Group C'. |
#' | pool_abb | character | Pool abbreviation: A, B or C. Null on some rows. |
#' | live | logical | True while the standing is recomputed live during games (false on all six snapshots checked). |
#' | latest | logical | True on the newest standings snapshot (false on all six snapshots checked, including the active season's). |
#' | game_played | integer | Games played (group stage only: playoff games are not counted, although lastFiveMatches includes them). |
#' | game_played_home | integer | Games played at home. |
#' | game_played_away | integer | Games played away. |
#' | wins | integer | Wins: all group-stage games on the standings route, all games on the season statistics routes. |
#' | wins_home | integer | Wins in the team's home games. |
#' | wins_away | integer | Wins in the team's away games. |
#' | losses | integer | Losses: all group-stage games on the standings route, all games on the season statistics routes. |
#' | losses_home | integer | Losses in the team's home games. |
#' | losses_away | integer | Losses in the team's away games. |
#' | draws | integer | Draws (0: basketball has none). |
#' | draws_home | integer | Home draws (0). |
#' | draws_away | integer | Away draws (0). |
#' | win_percentage | double | Winning share as a 0-1 ratio rounded to 2 decimals (0.83 = 5-1), NOT a percentage. |
#' | win_percentage_home | double | Home winning share, 0-1 ratio. |
#' | win_percentage_away | double | Away winning share, 0-1 ratio. |
#' | points_for | integer | Points the team scored over its group-stage games (points_against is the points it conceded). |
#' | points_against | integer | Points allowed. |
#' | point_difference | integer | Points for minus points against. |
#' | point_difference_home | integer | Point difference in home games. |
#' | point_difference_away | integer | Point difference in away games. |
#' | steak | integer | Current winning streak in games (the key is misspelled 'steak'); 0 after a loss. Never negative: losing streaks are not tracked. |
#' | streak_home | integer | Current winning streak in home games; 0 after a loss. |
#' | streak_away | integer | Current winning streak in away games; 0 after a loss. |
#' | last_five | character | Results of the team's last five games as a comma-separated string, most recent first (W win, L loss). |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_standings(season = 2026))
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Tournament top-5 player leaders in nine categories (points, rebounds, assists, steals,
#'   blocks, shooting). An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_leaders`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request, null when the body is parsed bare. |
#' | season_id | character | DataCore season UUID v1 of the leader row. |
#' | category | character | Leader category, the wire key of the group: pointsPerGame, reboundsPerGame, assistsPerGame, stealsPerGame, blocksPerGame, pointsThreeMade, pointsThreePercentage, fieldGoalsPercentage or freeThrowsPercentage. |
#' | rank | integer | Rank inside the category, 1 = best, in the delivered order (the server lists the top 5). |
#' | value | double | The leader's value in the category: a per-game average, a count (pointsThreeMade) or a percentage (0-100). Float64. |
#' | player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
#' | player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
#' | player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
#' | jersey_number | character | Jersey number as a string ('00', '0' and '75' are distinct). |
#' | position | character | Playing position: G, F, C, PG, SG, SF, PF or GF (guard-forward). |
#' | player_status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
#' | team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | team_name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | team_name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | team_code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
#' | team_code_local | character | Alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' @eval .intl_details(.easl_health_details, "easl_leaders(season = 2026)")
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: The 12 ACTIVE EASL teams (historical teams resolve only through easl_team). An empty answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `easl_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_row_id | integer | The sync server's own integer row id of the team (not a DataCore id; inactive teams interleave, so ids of /teams rows have gaps). |
#' | team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
#' | code_local | character | Alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' | standard | character | Competition standard: ELITE. |
#' | age_group | character | Age group: SENIOR; null on some inactive teams. |
#' | gender | character | Competition gender of the team: MALE (the EASL is a men's competition). |
#' | status | character | ACTIVE for teams in the current season (the only ones /teams lists), INACTIVE for historical teams (only via `/teams/{teamId}`). |
#' | primary_color | character | Club colour as a 6-digit hex string without '#'; '000000' is a placeholder on several clubs. |
#' | secondary_color | character | Club colour as a 6-digit hex string without '#'; '000000' is a placeholder on several clubs. |
#' | tertiary_color | character | Club colour as a 6-digit hex string without '#'; '000000' is a placeholder on several clubs. |
#' | logo | character | Club logo URL on the Sportradar DataCore asset CDN (images.dc.connect.sportradar.com/b1e0z/...). |
#' | website | character | Club website URL; most clubs have none. Null on some rows. |
#' | facebook_username | character | Club Facebook handle; most clubs have none. Null on some rows. |
#' | twitter_username | character | Club X / Twitter handle; most clubs have none. Null on some rows. |
#' | instagram_username | character | Club Instagram handle; some clubs have none. Null on some rows. |
#' | wikipedia_url | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | organization_id | character | DataCore organisation id: b1e0z (EASL). |
#' | created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
#' | updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_teams())
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: One team's directory entry; resolves the historical teams easl_teams does not list. An
#'   empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `easl_team`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_row_id | integer | The sync server's own integer row id of the team (not a DataCore id; inactive teams interleave, so ids of /teams rows have gaps). |
#' | team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. |
#' | code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
#' | code_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | standard | character | Competition standard: ELITE. |
#' | age_group | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | gender | character | Competition gender of the team: MALE (the EASL is a men's competition). |
#' | status | character | ACTIVE for teams in the current season (the only ones /teams lists), INACTIVE for historical teams (only via `/teams/{teamId}`). |
#' | primary_color | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | secondary_color | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | tertiary_color | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | logo | character | Club logo URL on the Sportradar DataCore asset CDN (images.dc.connect.sportradar.com/b1e0z/...). |
#' | website | character | Club website URL; most clubs have none. |
#' | facebook_username | character | Club Facebook handle; most clubs have none. |
#' | twitter_username | character | Club X / Twitter handle; most clubs have none. |
#' | instagram_username | character | Club Instagram handle; some clubs have none. |
#' | wikipedia_url | character | Club Wikipedia URL (DataCore column); empty for every ACTIVE team. |
#' | organization_id | character | DataCore organisation id: b1e0z (EASL). |
#' | created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
#' | updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |
#' @eval .intl_details(.easl_health_details, 'easl_team(team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: A team's fixtures in one season, shaped like easl_schedule. An empty answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `easl_team_schedule`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request. |
#' | season_id | character | Season UUID: the rows carry no seasonId (the season sits in the first half of stage_id), so this is the request's. |
#' | fixture_id | character | fixtureId: DataCore fixture (game) UUID v1 (key space: EASL games; the `{fixtureId}` of every /matches route). |
#' | fixture_number | integer | Fixture number YYSSNNN: two-digit start year, two-digit end year, three-digit sequence (2627001 = first game of 2026-27, 2526003 = third of 2025-26). Null on every 2023-24 fixture. |
#' | fixture_type | character | REGULAR (group stage), PLAYOFF (quarter- and semifinals) or FINAL (championship and third-place games). Missing from the DRAFT placeholders. |
#' | status | character | CONFIRMED = finished with a final box score; SCHEDULED = future; DRAFT = a placeholder with no teams or time. |
#' | fixture_name | character | Fixture name for special games ('EASL Championship', 'Semifinals 2', 'EASL Tip-Off 2026 Cebu'); null for ordinary group games. |
#' | start_time_utc | character | Scheduled tip-off in UTC, 'YYYY-MM-DDTHH:MM:SS' with no zone marker. The /matches list holds null here on DRAFT fixtures; the single-fixture sample is a finished game. |
#' | start_time_local | character | Scheduled tip-off in the venue's local time, 'YYYY-MM-DDTHH:MM:SS' with no zone (19:10 local = 10:10 UTC in Tokyo). DRAFT fixtures carry a date at 00:00:00. |
#' | attendance | integer | Announced attendance of the game; null when not recorded. |
#' | live_data_available | logical | Whether live stats were collected for the game (present on a minority of fixtures; meaning unverified). Absent on some rows. |
#' | live_video_available | logical | Whether live video was available (false on all 146 fixtures of the four seasons). |
#' | pool_code | character | Pool (group) id: a 30-character hex string, equal to pool.id; null on playoff and DRAFT fixtures. |
#' | pool_id | character | Pool id: a 30-character hex string; null for playoff games ('Unknown Pool'). |
#' | pool_name | character | Pool name: 'Group A', 'Group B', 'Group C' or the placeholder 'Unknown Pool'. |
#' | pool_abb | character | Pool abbreviation (A, B, C). Playoff and DRAFT fixtures of the /matches list carry the placeholder pool, whose abb is empty or 'N/A'. |
#' | stage_id | character | Stage reference on `/teams/{teamId}/matches` rows only: `<seasonId UUID>:<stage code>` (the season and stage the game belongs to; replaces the nameLocal / stageCode / stageOrder trio of /matches rows). |
#' | stage_code | character | Stage id: a 30-character hex string. Absent on some rows. |
#' | stage_name | character | Stage name: 'Group Stage', 'Final Four' or 'EASL Playoffs'. Absent on some rows. |
#' | stage_order | integer | Ordinal of the stage within the season (1 = Group Stage, 2 = EASL Playoffs). Absent on some rows. |
#' | venue_name | character | Arena name. Absent on some rows. |
#' | venue_name_latin | character | Venue name in Latin script; null on most rows. |
#' | venue_abbreviation_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | venue_abbreviation_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | venue_alternate_name_latin | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | venue_country_code | character | ISO 3166-1 alpha-3 country code of the arena: JPN, TWN, PHL, KOR, MAC, HKG, MNG, CHN. The /matches list holds null here on DRAFT fixtures (empty venue). |
#' | venue_city | character | City of the arena. Absent on some rows. |
#' | venue_state | character | State or province of the arena (Philippine games, for example Cebu). Absent on some rows. |
#' | home_team_id | character | Home team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | home_name | character | Home team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | home_name_native | character | Home team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | home_code_latin | character | Home team: three-letter club code (for example BRE); null or empty for some clubs. |
#' | home_code_local | character | Home team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' | home_score | integer | Home team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
#' | home_result_place | integer | Home team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
#' | home_draw | logical | Home team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |
#' | away_team_id | character | Away team: teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | away_name | character | Away team: display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | away_name_native | character | Away team: alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. Null on some rows. |
#' | away_code_latin | character | Away team: three-letter club code (for example BRE); null or empty for some clubs. |
#' | away_code_local | character | Away team: alternative three-letter club code (for example TPP); null for most clubs. A club may have only one of codeLatin / codeLocal. |
#' | away_score | integer | Away team final points (the wire sends a numeric string; cast to Int64); null before the game is played. |
#' | away_result_place | integer | Away team: result place: 1 = winner, 2 = loser. The /matches list holds null here for fixtures not yet played; `/matches/{fixtureId}` is sampled for finished games only. |
#' | away_draw | logical | Away team: true when the game has no winner YET or ever: true on every unplayed competitor, false on every finished one (a tie has never happened). |
#' @eval .intl_details(.easl_health_details, 'easl_team_schedule(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: A team's cumulative season statistics: totals, per-game rates and the opponent's totals
#'   (`*_against`). An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_team_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | character | DataCore team UUID v1, from the request (the body carries none). |
#' | season | integer | Season END year (2026 = EASL 25-26), from the request. |
#' | season_id | character | DataCore season UUID v1, from the request. |
#' | assists | integer | Assists: passes that directly lead to a made field goal. Season total of the team's finished games. |
#' | assists_against | integer | Opponent's figure in the same games: assists: passes that directly lead to a made field goal. Season total of the team's finished games. |
#' | assists_against_per_game | double | Opponent's figure in the same games: assists: passes that directly lead to a made field goal. Per-game average: the total divided by `games`. |
#' | assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Season total of the team's finished games. |
#' | assists_per_game | double | Assists: passes that directly lead to a made field goal. Per-game average: the total divided by `games`. |
#' | assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Season total of the team's finished games. |
#' | biggest_lead | integer | Largest lead the team held during the game, in points. A season total sums the per-game maxima. Season total of the team's finished games. |
#' | biggest_scoring_run | integer | Longest unanswered scoring run of the team, in points. A season total sums the per-game maxima. Season total of the team's finished games. |
#' | blocks | integer | Shots blocked (made by this player or team). Season total of the team's finished games. |
#' | blocks_per_game | double | Shots blocked (made by this player or team). Per-game average: the total divided by `games`. |
#' | blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Season total of the team's finished games. |
#' | blocks_received_per_game | double | The team's or player's own shots that were blocked by an opponent. Per-game average: the total divided by `games`. |
#' | draws | integer | Drawn games (basketball has none). Season total of the team's finished games. |
#' | dunks | integer | Dunks made. Season total of the team's finished games. |
#' | dunks_per_game | double | Dunks made. Per-game average: the total divided by `games`. |
#' | efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). Season total of the team's finished games. |
#' | efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Season total of the team's finished games. |
#' | field_goals_against_percentage | double | Field-goal percentage allowed to opponents over the season (0-100 scale). Season total of the team's finished games. |
#' | field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Season total of the team's finished games. |
#' | field_goals_attempted_against | integer | Opponent's figure in the same games: field goals attempted (2- and 3-point shots; free throws excluded). Season total of the team's finished games. |
#' | field_goals_attempted_against_per_game | double | Opponent's figure in the same games: field goals attempted (2- and 3-point shots; free throws excluded). Per-game average: the total divided by `games`. |
#' | field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Season total of the team's finished games. |
#' | field_goals_made | integer | Field goals made (2- and 3-point shots). Season total of the team's finished games. |
#' | field_goals_made_against | integer | Opponent's figure in the same games: field goals made (2- and 3-point shots). Season total of the team's finished games. |
#' | field_goals_made_against_per_game | double | Opponent's figure in the same games: field goals made (2- and 3-point shots). Per-game average: the total divided by `games`. |
#' | field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Season total of the team's finished games. |
#' | fouls_bench_technical | integer | Technical fouls called on the bench (not a player). Season total of the team's finished games. |
#' | fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Season total of the team's finished games. |
#' | fouls_coach_technical | integer | Technical fouls on the coach. Season total of the team's finished games. |
#' | fouls_disqualifying | integer | Disqualifying fouls. Season total of the team's finished games. |
#' | fouls_disruptive | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Season total of the team's finished games. |
#' | fouls_drawn_per_game | double | Fouls drawn (committed against this player or team by an opponent). Per-game average: the total divided by `games`. |
#' | fouls_flagrant | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Season total of the team's finished games. |
#' | fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Season total of the team's finished games. |
#' | fouls_personal_against | integer | Opponent's figure in the same games: personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Season total of the team's finished games. |
#' | fouls_personal_against_per_game | double | Opponent's figure in the same games: personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Per-game average: the total divided by `games`. |
#' | fouls_personal_per_game | double | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Per-game average: the total divided by `games`. |
#' | fouls_technical | integer | Technical fouls committed by the player or team. Season total of the team's finished games. |
#' | fouls_technical_against | integer | Opponent's figure in the same games: technical fouls committed by the player or team. Season total of the team's finished games. |
#' | fouls_technical_against_per_game | double | Opponent's figure in the same games: technical fouls committed by the player or team. Per-game average: the total divided by `games`. |
#' | fouls_technical_cat1 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_technical_cat2 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). Season total of the team's finished games. |
#' | fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Season total of the team's finished games. |
#' | free_throws_against_percentage | double | Free-throw percentage allowed to opponents over the season (0-100 scale). Season total of the team's finished games. |
#' | free_throws_attempted | integer | Free throws attempted. Season total of the team's finished games. |
#' | free_throws_attempted_against | integer | Opponent's figure in the same games: free throws attempted. Season total of the team's finished games. |
#' | free_throws_attempted_against_per_game | double | Opponent's figure in the same games: free throws attempted. Per-game average: the total divided by `games`. |
#' | free_throws_attempted_per_game | double | Free throws attempted. Per-game average: the total divided by `games`. |
#' | free_throws_made | integer | Free throws made. Season total of the team's finished games. |
#' | free_throws_made_against | integer | Opponent's figure in the same games: free throws made. Season total of the team's finished games. |
#' | free_throws_made_against_per_game | double | Opponent's figure in the same games: free throws made. Per-game average: the total divided by `games`. |
#' | free_throws_made_per_game | double | Free throws made. Per-game average: the total divided by `games`. |
#' | free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Season total of the team's finished games. |
#' | games | integer | Finished games counted in this line. Season total of the team's finished games. |
#' | index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. Season total of the team's finished games. |
#' | losses | integer | Games lost (for a player: by his team while he is in the line). Season total of the team's finished games. |
#' | minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Season total of the team's finished games. |
#' | offensive_rating | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). Season total of the team's finished games. |
#' | points | integer | Points scored. Season total of the team's finished games. |
#' | points_against | integer | Opponent's figure in the same games: points scored. Season total of the team's finished games. |
#' | points_against_per_game | double | Opponent's figure in the same games: points scored. Per-game average: the total divided by `games`. |
#' | points_fast_break | integer | Points scored on fast breaks. Season total of the team's finished games. |
#' | points_fast_break_against | integer | Opponent's figure in the same games: points scored on fast breaks. Season total of the team's finished games. |
#' | points_fast_break_against_per_game | double | Opponent's figure in the same games: points scored on fast breaks. Per-game average: the total divided by `games`. |
#' | points_fast_break_attempted | integer | Fast-break field goals attempted. Season total of the team's finished games. |
#' | points_fast_break_made | integer | Fast-break field goals made. Season total of the team's finished games. |
#' | points_fast_break_per_game | double | Points scored on fast breaks. Per-game average: the total divided by `games`. |
#' | points_four_attempted | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | points_four_attempted_against | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | points_four_attempted_against_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_four_attempted_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_four_made | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | points_four_made_against | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | points_four_made_against_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_four_made_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_four_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_four_percentage_against | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | points_from_bench | integer | Points scored by players who did not start (a team figure). Season total of the team's finished games. |
#' | points_from_bench_against | integer | Opponent's figure in the same games: points scored by players who did not start (a team figure). Season total of the team's finished games. |
#' | points_from_bench_against_per_game | double | Opponent's figure in the same games: points scored by players who did not start (a team figure). Per-game average: the total divided by `games`. |
#' | points_from_bench_per_game | double | Points scored by players who did not start (a team figure). Per-game average: the total divided by `games`. |
#' | points_from_turnover | integer | Points scored off opponent turnovers. Season total of the team's finished games. |
#' | points_from_turnover_against | integer | Opponent's figure in the same games: points scored off opponent turnovers. Season total of the team's finished games. |
#' | points_from_turnover_against_per_game | double | Opponent's figure in the same games: points scored off opponent turnovers. Per-game average: the total divided by `games`. |
#' | points_in_the_paint | integer | Points scored in the paint. Season total of the team's finished games. |
#' | points_in_the_paint_against | integer | Opponent's figure in the same games: points scored in the paint. Season total of the team's finished games. |
#' | points_in_the_paint_against_per_game | double | Opponent's figure in the same games: points scored in the paint. Per-game average: the total divided by `games`. |
#' | points_in_the_paint_attempted | integer | Field goals attempted in the paint. Season total of the team's finished games. |
#' | points_in_the_paint_made | integer | Field goals made in the paint. Season total of the team's finished games. |
#' | points_in_the_paint_per_game | double | Points scored in the paint. Per-game average: the total divided by `games`. |
#' | points_per_game | double | Points scored. Per-game average: the total divided by `games`. |
#' | points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Season total of the team's finished games. |
#' | points_second_chance_against | integer | Opponent's figure in the same games: points scored on second-chance possessions (after an offensive rebound). Season total of the team's finished games. |
#' | points_second_chance_against_per_game | double | Opponent's figure in the same games: points scored on second-chance possessions (after an offensive rebound). Per-game average: the total divided by `games`. |
#' | points_second_chance_attempted | integer | Second-chance field goals attempted. Season total of the team's finished games. |
#' | points_second_chance_made | integer | Second-chance field goals made. Season total of the team's finished games. |
#' | points_second_chance_per_game | double | Points scored on second-chance possessions (after an offensive rebound). Per-game average: the total divided by `games`. |
#' | points_three_attempted | integer | 3-point field goals attempted. Season total of the team's finished games. |
#' | points_three_attempted_against | integer | Opponent's figure in the same games: 3-point field goals attempted. Season total of the team's finished games. |
#' | points_three_attempted_against_per_game | double | Opponent's figure in the same games: 3-point field goals attempted. Per-game average: the total divided by `games`. |
#' | points_three_attempted_per_game | double | 3-point field goals attempted. Per-game average: the total divided by `games`. |
#' | points_three_made | integer | 3-point field goals made. Season total of the team's finished games. |
#' | points_three_made_against | integer | Opponent's figure in the same games: 3-point field goals made. Season total of the team's finished games. |
#' | points_three_made_against_per_game | double | Opponent's figure in the same games: 3-point field goals made. Per-game average: the total divided by `games`. |
#' | points_three_made_per_game | double | 3-point field goals made. Per-game average: the total divided by `games`. |
#' | points_three_percentage | double | 3-point percentage on a 0-100 scale. Season total of the team's finished games. |
#' | points_three_percentage_against | double | Opponent's figure in the same games: 3-point percentage on a 0-100 scale. Season total of the team's finished games. |
#' | points_two_attempted | integer | 2-point field goals attempted. Season total of the team's finished games. |
#' | points_two_attempted_against | integer | Opponent's figure in the same games: 2-point field goals attempted. Season total of the team's finished games. |
#' | points_two_attempted_against_per_game | double | Opponent's figure in the same games: 2-point field goals attempted. Per-game average: the total divided by `games`. |
#' | points_two_attempted_per_game | double | 2-point field goals attempted. Per-game average: the total divided by `games`. |
#' | points_two_made | integer | 2-point field goals made. Season total of the team's finished games. |
#' | points_two_made_against | integer | Opponent's figure in the same games: 2-point field goals made. Season total of the team's finished games. |
#' | points_two_made_against_per_game | double | Opponent's figure in the same games: 2-point field goals made. Per-game average: the total divided by `games`. |
#' | points_two_made_per_game | double | 2-point field goals made. Per-game average: the total divided by `games`. |
#' | points_two_percentage | double | 2-point percentage on a 0-100 scale. Season total of the team's finished games. |
#' | points_two_percentage_against | double | Opponent's figure in the same games: 2-point percentage on a 0-100 scale. Season total of the team's finished games. |
#' | power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Season total of the team's finished games. |
#' | power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Season total of the team's finished games. |
#' | rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Season total of the team's finished games. |
#' | rebounds_against | integer | Opponent's figure in the same games: total rebounds: offensive + defensive. Team's totals include team rebounds. Season total of the team's finished games. |
#' | rebounds_against_per_game | double | Opponent's figure in the same games: total rebounds: offensive + defensive. Team's totals include team rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_defensive | integer | Defensive rebounds. Season total of the team's finished games. |
#' | rebounds_defensive_against | integer | Opponent's figure in the same games: defensive rebounds. Season total of the team's finished games. |
#' | rebounds_defensive_against_per_game | double | Opponent's figure in the same games: defensive rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_defensive_per_game | double | Defensive rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_offensive | integer | Offensive rebounds. Season total of the team's finished games. |
#' | rebounds_offensive_against | integer | Opponent's figure in the same games: offensive rebounds. Season total of the team's finished games. |
#' | rebounds_offensive_against_per_game | double | Opponent's figure in the same games: offensive rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_offensive_per_game | double | Offensive rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_per_game | double | Total rebounds: offensive + defensive. Team's totals include team rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_team_defensive | integer | Defensive rebounds credited to the team as a whole (not to a player). Season total of the team's finished games. |
#' | rebounds_team_defensive_against | integer | Opponent's figure in the same games: defensive rebounds credited to the team as a whole (not to a player). Season total of the team's finished games. |
#' | rebounds_team_defensive_against_per_game | double | Opponent's figure in the same games: defensive rebounds credited to the team as a whole (not to a player). Per-game average: the total divided by `games`. |
#' | rebounds_team_offensive | integer | Offensive rebounds credited to the team as a whole. Season total of the team's finished games. |
#' | rebounds_team_offensive_against | integer | Opponent's figure in the same games: offensive rebounds credited to the team as a whole. Season total of the team's finished games. |
#' | rebounds_team_offensive_against_per_game | double | Opponent's figure in the same games: offensive rebounds credited to the team as a whole. Per-game average: the total divided by `games`. |
#' | rebounds_team_total | integer | Team rebounds credited to the team as a whole (offensive + defensive). Season total of the team's finished games. |
#' | rebounds_team_total_against | integer | Opponent's figure in the same games: team rebounds credited to the team as a whole (offensive + defensive). Season total of the team's finished games. |
#' | rebounds_team_total_against_per_game | double | Opponent's figure in the same games: team rebounds credited to the team as a whole (offensive + defensive). Per-game average: the total divided by `games`. |
#' | steals | integer | Steals. Season total of the team's finished games. |
#' | steals_against | integer | Opponent's figure in the same games: steals. Season total of the team's finished games. |
#' | steals_against_per_game | double | Opponent's figure in the same games: steals. Per-game average: the total divided by `games`. |
#' | steals_per_game | double | Steals. Per-game average: the total divided by `games`. |
#' | true_shooting_attempts | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | true_shooting_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | turnovers | integer | Turnovers committed by players. Season total of the team's finished games. |
#' | turnovers_against | integer | Opponent's figure in the same games: turnovers committed by players. Season total of the team's finished games. |
#' | turnovers_against_per_game | double | Opponent's figure in the same games: turnovers committed by players. Per-game average: the total divided by `games`. |
#' | turnovers_per_game | double | Turnovers committed by players. Per-game average: the total divided by `games`. |
#' | turnovers_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | turnovers_team | integer | Team turnovers not charged to a player (shot-clock and similar violations). Season total of the team's finished games. |
#' | turnovers_team_against | integer | Opponent's figure in the same games: team turnovers not charged to a player (shot-clock and similar violations). Season total of the team's finished games. |
#' | turnovers_team_against_per_game | double | Opponent's figure in the same games: team turnovers not charged to a player (shot-clock and similar violations). Per-game average: the total divided by `games`. |
#' | wins | integer | Games won (for a player: by his team while he is in the line). Season total of the team's finished games. |
#' @eval .intl_details(.easl_health_details, 'easl_team_stats(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: A team's top-5 player leaders per category in one season, shaped like easl_leaders. An
#'   empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `easl_team_leaders`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = EASL 25-26): stamped by easl_runtime from the request, null when the body is parsed bare. |
#' | season_id | character | DataCore season UUID v1 of the leader row. |
#' | category | character | Leader category, the wire key of the group: pointsPerGame, reboundsPerGame, assistsPerGame, stealsPerGame, blocksPerGame, pointsThreeMade, pointsThreePercentage, fieldGoalsPercentage or freeThrowsPercentage. |
#' | rank | integer | Rank inside the category, 1 = best, in the delivered order (the server lists the top 5). |
#' | value | double | The leader's value in the category: a per-game average, a count (pointsThreeMade) or a percentage (0-100). Float64. |
#' | player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
#' | player_name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
#' | player_name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
#' | jersey_number | character | Jersey number as a string ('00', '0' and '75' are distinct). |
#' | position | character | Playing position: G, F, C, PG, SG, SF, PF or GF (guard-forward). |
#' | player_status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
#' | team_id | character | teamId: DataCore team (entity) UUID v1 (key space: EASL teams, the same id as `entityId`; joins /teams, /standings team.id, fixture competitors, box and play-by-play teams). Not a player id. |
#' | team_name | character | Display name. Despite the field name this is the English / Latin-script name used on the league site. |
#' | team_name_native | character | Alternative name: the native-script name of some Japanese clubs (for example the Japanese-script name of Utsunomiya Brex), blank for most clubs; for players it usually equals nameFullLocal. Despite the field name it is not always Latin script. |
#' | team_code_latin | character | Three-letter club code (for example BRE); null or empty for some clubs. |
#' | team_code_local | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' @eval .intl_details(.easl_health_details, 'easl_team_leaders(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184")')
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: Every EASL player of all seasons; with season and team_id a roster that adds jersey number
#'   and position. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `easl_players`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year of the filter, from the request; null when no season was passed. |
#' | season_id | character | DataCore season UUID v1 of the filter; null when no season was passed. |
#' | player_row_id | integer | The sync server's own integer row id of the player (not a DataCore id). |
#' | player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
#' | name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
#' | name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
#' | name_abbreviated | character | Abbreviated name; null for 551 of 552 players (one empty string). |
#' | nationality | character | ISO 3166-1 alpha-3 code of the player's nationality; 36 codes occur, KOR 119, USA 102, JPN 81, PHL 80, TWN 61, CHN 22, MNG 16, HKG 15, MAC 13 ('PHI' also appears once, a non-ISO spelling of PHL). |
#' | gender | character | MALE on all 552 rows. |
#' | dob | Date | Date of birth, 'YYYY-MM-DD' (a public biography field; 1980-10-05 to 2023-10-16 in the data, so the latest values are implausible); 5 players have none. Null on some rows. |
#' | height_cm | integer | Height in centimetres; 43 of 552 players have none. Null on some rows. |
#' | height_feet | character | Height in feet and inches as a string (6'9); null for most players. |
#' | weight_kg | integer | Weight in kilograms; many players have none. Null on some rows. |
#' | weight_lbs | integer | Weight in pounds; null for many players. |
#' | status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
#' | jersey_number | character | Jersey number as a string. Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
#' | position | character | Playing position (G, F, C, PG, SG, SF, PF, GF). Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
#' | organization_id | character | DataCore organisation id: b1e0z (EASL). |
#' | created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
#' | updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |
#' @eval .intl_details(.easl_health_details)
#' @examples
#' \donttest{
#'   try(easl_players(season = 2026, team_id = "865489e8-b0f5-11ed-8b3f-c199a9dea184"))
#' }
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: One player's biography: names, nationality, birth date, height, weight. An empty answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `easl_player`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_row_id | integer | The sync server's own integer row id of the player (not a DataCore id). |
#' | player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
#' | name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
#' | name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
#' | name_abbreviated | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | nationality | character | ISO 3166-1 alpha-3 code of the player's nationality; 36 codes occur, KOR 119, USA 102, JPN 81, PHL 80, TWN 61, CHN 22, MNG 16, HKG 15, MAC 13 ('PHI' also appears once, a non-ISO spelling of PHL). |
#' | gender | character | MALE on all 552 rows. |
#' | dob | Date | Date of birth, 'YYYY-MM-DD' (a public biography field; 1980-10-05 to 2023-10-16 in the data, so the latest values are implausible); 5 players have none. |
#' | height_cm | integer | Height in centimetres; 43 of 552 players have none. |
#' | height_feet | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
#' | weight_kg | integer | Weight in kilograms; many players have none. |
#' | weight_lbs | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
#' | jersey_number | character | Jersey number as a string. Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
#' | position | character | Playing position (G, F, C, PG, SG, SF, PF, GF). Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
#' | organization_id | character | DataCore organisation id: b1e0z (EASL). |
#' | created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
#' | updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |
#' @eval .intl_details(.easl_health_details, 'easl_player(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5")')
#' @export
#' @family EASL Functions
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
#' @return
#' A `hoopR_data` tibble: A player's cumulative statistics over ALL seasons (the server ignores a season filter). An
#'   empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `easl_player_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | character | DataCore person UUID v1, from the request (the body carries none). |
#' | assists | integer | Assists: passes that directly lead to a made field goal. Total over the player's games. |
#' | assists_defensive | integer | Defensive assists (DataCore column; meaning unverified). Total over the player's games. |
#' | assists_per_game | double | Assists: passes that directly lead to a made field goal. Per-game average: the total divided by `games`. |
#' | assists_turnover_ratio | double | Assists divided by turnovers (a ratio, not a percentage). Total over the player's games. |
#' | blocks | integer | Shots blocked (made by this player or team). Total over the player's games. |
#' | blocks_per_game | double | Shots blocked (made by this player or team). Per-game average: the total divided by `games`. |
#' | blocks_received | integer | The team's or player's own shots that were blocked by an opponent. Total over the player's games. |
#' | blocks_received_per_game | double | The team's or player's own shots that were blocked by an opponent. Per-game average: the total divided by `games`. |
#' | double_double | integer | Double-double flag: 1 when exactly two of points, rebounds, assists, steals, blocks reached 10 in the game, else 0 (a triple-double is counted in tripleDouble instead). In a season line it is a count of such games. Total over the player's games. |
#' | draws | integer | Drawn games (basketball has none). Total over the player's games. |
#' | dunks | integer | Dunks made. Total over the player's games. |
#' | dunks_per_game | double | Dunks made. Per-game average: the total divided by `games`. |
#' | efficiency | integer | NBA-style efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on all 2,143 played player-games). Total over the player's games. |
#' | efficiency_custom | integer | Custom efficiency slot (DataCore column; meaning unverified). Total over the player's games. |
#' | field_goals_attempted | integer | Field goals attempted (2- and 3-point shots; free throws excluded). Total over the player's games. |
#' | field_goals_effective_percentage | double | Effective field-goal percentage on a 0-100 scale: (FGM + 0.5 x 3PM) / FGA x 100; can exceed 100 on small samples. Total over the player's games. |
#' | field_goals_made | integer | Field goals made (2- and 3-point shots). Total over the player's games. |
#' | field_goals_percentage | double | Field-goal percentage on a 0-100 scale (made / attempted x 100). Total over the player's games. |
#' | fouls_coach_disqualifying | integer | Disqualifying fouls on the coach. Total over the player's games. |
#' | fouls_coach_technical | integer | Technical fouls on the coach. Total over the player's games. |
#' | fouls_disqualifying | integer | Disqualifying fouls. Total over the player's games. |
#' | fouls_disruptive | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_drawn | integer | Fouls drawn (committed against this player or team by an opponent). Total over the player's games. |
#' | fouls_drawn_per_game | double | Fouls drawn (committed against this player or team by an opponent). Per-game average: the total divided by `games`. |
#' | fouls_flagrant | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_offensive | integer | Offensive fouls committed. Counted separately from foulsPersonal. Total over the player's games. |
#' | fouls_personal | integer | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Total over the player's games. |
#' | fouls_personal_per_game | double | Personal fouls committed (offensive, technical and unsportsmanlike fouls are separate columns). Per-game average: the total divided by `games`. |
#' | fouls_technical | integer | Technical fouls committed by the player or team. Total over the player's games. |
#' | fouls_technical_cat1 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_technical_cat2 | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | fouls_total | integer | Fouls charged in total: personal + technical + unsportsmanlike + offensive (matches 2,142 of 2,143 played player-games; the exception is unexplained). Total over the player's games. |
#' | fouls_unsportsmanlike | integer | Unsportsmanlike fouls committed. Total over the player's games. |
#' | free_throws_attempted | integer | Free throws attempted. Total over the player's games. |
#' | free_throws_attempted_per_game | double | Free throws attempted. Per-game average: the total divided by `games`. |
#' | free_throws_made | integer | Free throws made. Total over the player's games. |
#' | free_throws_made_per_game | double | Free throws made. Per-game average: the total divided by `games`. |
#' | free_throws_percentage | double | Free-throw percentage on a 0-100 scale. Total over the player's games. |
#' | games | integer | Finished games counted in this line. Total over the player's games. |
#' | games_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | games_started | integer | Games the player started. Total over the player's games. |
#' | index_of_success | integer | Index of success: efficiency + fouls drawn - personal fouls - technical fouls - blocks received (verified on all 2,143 played player-games). It differs from pir only in which fouls it subtracts. Total over the player's games. |
#' | losses | integer | Games lost (for a player: by his team while he is in the line). Total over the player's games. |
#' | max_assists | integer | Highest assists in a single game: in a game row it equals assists; in a season line it is the best game. Total over the player's games. |
#' | max_free_throws_made | integer | Highest free throws made in a single game (equals freeThrowsMade in a game row). Total over the player's games. |
#' | max_points | integer | Highest points in a single game (equals points in a game row). Total over the player's games. |
#' | max_points_four_made | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | max_points_three_made | integer | Highest 3-pointers made in a single game. Total over the player's games. |
#' | max_points_two_made | integer | Highest 2-pointers made in a single game. Total over the player's games. |
#' | max_rebounds | integer | Highest rebounds in a single game. Total over the player's games. |
#' | max_rebounds_defensive | integer | Highest defensive rebounds in a single game. Total over the player's games. |
#' | max_rebounds_offensive | integer | Highest offensive rebounds in a single game. Total over the player's games. |
#' | max_steals | integer | Highest steals in a single game. Total over the player's games. |
#' | minus | integer | Points the opponents scored while the player was on the court. Total over the player's games. |
#' | minutes | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Total over the player's games. |
#' | minutes_per_game | character | Playing time as an ISO 8601 duration `PT{m}M{s}S` with the minutes NOT wrapped at 60 (PT27M53S; a team's is the sum of its players', PT200M for a 40-minute game, PT250M with one overtime). Per-game average: the total divided by `games`. |
#' | pir | integer | Performance index rating: efficiency + fouls drawn - total fouls - blocks received (verified on all 2,143 played player-games). Total over the player's games. |
#' | plus | integer | Points the player's team scored while he was on the court. Total over the player's games. |
#' | plus_minus | integer | plus - minus: the team's point margin while the player was on the court. Total over the player's games. |
#' | points | integer | Points scored. Total over the player's games. |
#' | points_fast_break | integer | Points scored on fast breaks. Total over the player's games. |
#' | points_fast_break_attempted | integer | Fast-break field goals attempted. Total over the player's games. |
#' | points_fast_break_made | integer | Fast-break field goals made. Total over the player's games. |
#' | points_four_attempted | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | points_four_attempted_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_four_made | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
#' | points_four_made_per_game | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_four_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | points_from_turnover | integer | Points scored off opponent turnovers. Total over the player's games. |
#' | points_in_the_paint | integer | Points scored in the paint. Total over the player's games. |
#' | points_in_the_paint_attempted | integer | Field goals attempted in the paint. Total over the player's games. |
#' | points_in_the_paint_made | integer | Field goals made in the paint. Total over the player's games. |
#' | points_per_game | double | Points scored. Per-game average: the total divided by `games`. |
#' | points_second_chance | integer | Points scored on second-chance possessions (after an offensive rebound). Total over the player's games. |
#' | points_second_chance_attempted | integer | Second-chance field goals attempted. Total over the player's games. |
#' | points_second_chance_made | integer | Second-chance field goals made. Total over the player's games. |
#' | points_three_attempted | integer | 3-point field goals attempted. Total over the player's games. |
#' | points_three_attempted_per_game | double | 3-point field goals attempted. Per-game average: the total divided by `games`. |
#' | points_three_made | integer | 3-point field goals made. Total over the player's games. |
#' | points_three_made_per_game | double | 3-point field goals made. Per-game average: the total divided by `games`. |
#' | points_three_percentage | double | 3-point percentage on a 0-100 scale. Total over the player's games. |
#' | points_two_attempted | integer | 2-point field goals attempted. Total over the player's games. |
#' | points_two_attempted_per_game | double | 2-point field goals attempted. Per-game average: the total divided by `games`. |
#' | points_two_made | integer | 2-point field goals made. Total over the player's games. |
#' | points_two_made_per_game | double | 2-point field goals made. Per-game average: the total divided by `games`. |
#' | points_two_percentage | double | 2-point percentage on a 0-100 scale. Total over the player's games. |
#' | power_play_points | integer | Power-play points (an ice-hockey column; meaning in basketball unverified). Total over the player's games. |
#' | power_play_points_awarded | integer | Power-play points awarded (an ice-hockey column; meaning in basketball unverified). Total over the player's games. |
#' | rebounds | integer | Total rebounds: offensive + defensive. Team's totals include team rebounds. Total over the player's games. |
#' | rebounds_defensive | integer | Defensive rebounds. Total over the player's games. |
#' | rebounds_defensive_per_game | double | Defensive rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_offensive | integer | Offensive rebounds. Total over the player's games. |
#' | rebounds_offensive_per_game | double | Offensive rebounds. Per-game average: the total divided by `games`. |
#' | rebounds_per_game | double | Total rebounds: offensive + defensive. Team's totals include team rebounds. Per-game average: the total divided by `games`. |
#' | steals | integer | Steals. Total over the player's games. |
#' | steals_per_game | double | Steals. Per-game average: the total divided by `games`. |
#' | triple_double | integer | Triple-double flag: 1 when three or more of points, rebounds, assists, steals, blocks reached 10, else 0. Total over the player's games. |
#' | true_shooting_attempts | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | true_shooting_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | turnovers | integer | Turnovers committed by players. Total over the player's games. |
#' | turnovers_per_game | double | Turnovers committed by players. Per-game average: the total divided by `games`. |
#' | turnovers_percentage | double | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Float64). |
#' | wins | integer | Games won (for a player: by his team while he is in the line). Total over the player's games. |
#' @eval .intl_details(.easl_health_details, 'easl_player_stats(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5")')
#' @export
#' @family EASL Functions
easl_player_stats <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  path <- paste0("/players/", .easl_id_arg(player_id, "player_id"), "/stats")
  raw <- .easl_get(path, list(), call = rlang::current_env())
  .easl_out(.easl_parse("player_stats", raw), "EASL Player Stats from easl.joshricha.com")
}
