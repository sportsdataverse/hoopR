# atrium.R -- the exported `atrium_*()` wrappers (Sportradar Atrium embed API).
# Internals (transport checks, season mapping, parsers) live in atrium_utils.R;
# the per-site aliases (lnb_*, lnbp_*, ...) in atrium_competitions.R.

# The @details of every atrium topic that shares the atrium_fixtures() notes (roxygen @eval .intl_details()).
.atrium_fixtures_details <- c(
  "**Unofficial.** This is the public endpoint the Sportradar Atrium / Synergy",
  "\"Connect\" widget calls from every visitor's browser (keyless; the host has no",
  "robots.txt). The data is Sportradar's and the leagues'. The wrappers read it on the",
  "caller's behalf, one request at least 1 s after the last to the host.",
  "Keep crawls small and incremental.",
  "",
  "**Sites and seasons.** `website_id` picks the league site; one site carries many",
  "competitions. Seasons are END years (`season = 2026`): the site's own year is the",
  "START year on LNB and the calendar year elsewhere, and a year can hold several",
  "competitions, so pair `season` with `competition_id` (see [atrium_seasons()]) or",
  "pass `season_id`. [atrium_end_year()] maps a site's own year to that END year, and",
  "[atrium_season_id()] finds the season UUID.",
  "",
  "**Columns** are configured per site: a statistic one site omits is `NA`. A key the",
  "documented columns do not list is appended with an inferred type. Player and team",
  "ids (UUIDs, character) are shared across sites; the player stat tables carry names",
  "only, so `person_id` there is decoded from the widget link beside each name.",
  "",
  "**Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when",
  "the site has nothing for the request (HTTP 404, no such season, an empty fixture",
  "list, a game with no play-by-play yet, or a fixture id the site does not serve: an",
  "unknown id or a game of another site, which the API answers alike with an empty",
  "fixture); `hoopR_bad_request` for HTTP 400 / 422 or an argument that cannot be",
  "mapped (an ambiguous END year, `season` with `season_id`); `hoopR_asset_fetch` for",
  "any other failed fetch, an error / stub body, or a body that belongs to another",
  "site, type, season, game, player or team than the one asked for."
)

#' @title
#' **Atrium Fixtures (schedule and results)**
#' @description
#' **Fixtures (schedule and results) of a season, home and away side by side.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixtures`
#'
#' Scores are integers (the API sends strings); `start_time_utc` is a UTC `POSIXct`;
#' `start_time_local` is the venue's wall-clock time as the API sends it (character: its
#' zone, `timezone`, varies per row, so no single `POSIXct` zone fits). sportsdataverse-py keeps both naive.
#' @param website_id (*integer* required): Site config id: which league site's widget
#'   this is (12 LNB France, 14 LNBP Mexico, 3 NBL1 Australia, 13 El Salvador, 22
#'   Panama, 236 Austria, 326 Montenegro). Not a league id: one site serves several
#'   competitions.
#' @param season (*integer* optional): Season END year (2026 = 2025-26 on LNB, site
#'   12, whose own year is the START year; the calendar year on the other sites).
#'   Needs `competition_id` when several competitions share that year (see
#'   [atrium_seasons()]). Omit `season` and `season_id` for the site's default season.
#' @param season_id (*character* optional): Season UUID (`season_id` in
#'   [atrium_seasons()]); sent as is, skipping the END-year lookup of `season`.
#' @param competition_id (*character* optional): Competition UUID (`competition_id` in
#'   [atrium_seasons()]). Picks the season together with `season`, and is then not
#'   sent; with neither `season` nor `season_id` the API filters by it.
#' @param entity_id (*character* optional): Team UUID (`entity_id` in [atrium_teams()]
#'   or any fixture row).
#' @param round_number (*integer* optional): Round (journee) number to show; the pages
#'   that take it list their rounds.
#' @param sub (*character* optional): Tab: `"FIXTURES"` (upcoming) or `"RESULTS"`
#'   (played). Omitted = the site's default tab.
#' @param locale (*character* optional): Locale of the labels, e.g. `"en-EN"` or
#'   `"fr-FR"`. Omitted = the site's own language. Ids and codes never change.
#' @return A `hoopR_data` tibble, one row per `fixture_id`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID the page is about (the site's default season when none was asked). |
#' | competition_id | character | Competition UUID of the season. |
#' | competition_name | character | Competition name in the site's language, e.g. Betclic ELITE or LIGA CALIENTE.MX LNBP. |
#' | season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | fixture_type | character | Kind of game as sent: REGULAR, PLAYOFF, ... (the set is open). |
#' | name | character | Fixture name as the site prints it (e.g. Paris - Lyon-Villeurbanne); null on LNBP. |
#' | round | character | Round of the game as the site words it, e.g. Journee: 30. |
#' | round_code | character | Round code; null in every body seen. |
#' | pool | character | Pool the game belongs to; null when the competition has none. |
#' | series | character | Playoff series the game belongs to as sent (JSON text when an object); null outside a series. |
#' | stage_code | character | Opaque 30-hex stage code of the game; null in every body seen. |
#' | status | character | Status code of the game, e.g. CONFIRMED (final), as sent. |
#' | status_label | character | Status of the game as the site words it in its own language (e.g. Termine, Final). |
#' | start_time_utc | POSIXct | Scheduled start, naive datetime in UTC (the API sends no offset). |
#' | start_time_local | character | Scheduled start in the venue's local time, as the API sends it (`YYYY-MM-DDTHH:MM:SS`, no offset; timezone gives the zone, which varies per row). |
#' | timezone | character | IANA time zone of the venue (e.g. Europe/Paris, Mexico/General) that start_time_local is in. |
#' | times_unconfirmed | logical | True while the start time is not final. |
#' | venue | character | Name of the arena where the game is played. |
#' | venue_id | character | Venue UUID; joins no other route. |
#' | attendance | integer | Spectators at the game; null when not reported. |
#' | home_entity_id | character | Team UUID of the home team. |
#' | home_code | character | Short code of the home team (e.g. PAB). |
#' | home_name | character | Name of the home team. |
#' | home_score | integer | Points scored by the home team (the API sends a string; Int64 here). |
#' | home_result_place | integer | Result place of the home team: 1 for the winner, 2 for the loser. |
#' | home_result_status | character | Result status of the home team's score, e.g. CONFIRMED. |
#' | home_draw | logical | True when the game ended level for the home team. |
#' | home_shootout_attempts | character | Shootout attempts of the home team as sent (an empty string becomes null). |
#' | home_secondary_score | character | Secondary score of the home team (unused in the samples; shown as text). |
#' | away_entity_id | character | Team UUID of the away team. |
#' | away_code | character | Short code of the away team (e.g. PAB). |
#' | away_name | character | Name of the away team. |
#' | away_score | integer | Points scored by the away team (the API sends a string; Int64 here). |
#' | away_result_place | integer | Result place of the away team: 1 for the winner, 2 for the loser. |
#' | away_result_status | character | Result status of the away team's score, e.g. CONFIRMED. |
#' | away_draw | logical | True when the game ended level for the away team. |
#' | away_shootout_attempts | character | Shootout attempts of the away team as sent (an empty string becomes null). |
#' | away_secondary_score | character | Secondary score of the away team (unused in the samples; shown as text). |
#' @eval .intl_details(.atrium_fixtures_details, full = TRUE)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_fixtures(website_id = 14))
#' }
atrium_fixtures <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL,
                            entity_id = NULL, round_number = NULL, sub = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixtures", list(
    season = season, seasonId = season_id, competitionId = competition_id, entityId = entity_id,
    roundNumber = round_number, sub = sub, locale = locale
  ))
  .atrium_data(.atrium_parse_fixtures(raw), "fixtures")
}

#' @title
#' **Atrium Seasons**
#' @description
#' **Every season (competition and year) a site lists, with the sdv END year of each.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixtures`
#'
#' A season is one competition in one year. `year` is the site's own key (START year
#' on site 12, calendar year elsewhere); `season_end_year` is the sdv END year. Site
#' 236 lists no seasons, so its frame is empty.
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `season_id`; `is_default_season` marks
#'   the season the site serves by default:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID; pass it as season_id to any season-scoped wrapper. |
#' | competition_id | character | Competition UUID; pass it as competition_id to pick one of several seasons of an END year. |
#' | competition_name | character | Competition name in the site's language; the same name can appear for several years. |
#' | season_name | character | Season name in the site's language, e.g. Betclic ELITE 2025. |
#' | abbreviation_local | character | Local abbreviation of the season; null in every body seen. |
#' | year | integer | The site's own year of the season: the START year on LNB (site 12), the calendar year elsewhere. |
#' | season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
#' | is_default_season | logical | True for the season the body is about (the site's default when none was asked). |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_seasons(website_id = 12))
#' }
atrium_seasons <- function(website_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixtures", list(locale = locale))
  .atrium_data(.atrium_parse_seasons(raw), "seasons")
}

#' @title
#' **Atrium Fixtures Ribbon**
#' @description
#' **The fixtures ribbon: recent and upcoming games across the site's competitions
#' (empty on LNB off-season).**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixtures_ribbon`
#'
#' Its scores are integers; `start_time_local` is the ribbon's `fixture.date` (a local
#' time, no offset; unverified).
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `fixture_id`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the game. |
#' | season_name | character | Name of the season / competition the game belongs to. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | series | character | Playoff series the game belongs to as sent (JSON text when an object); null outside a series. |
#' | stage_name | character | Name of the stage; null in every body seen. |
#' | status | character | Status code of the game, e.g. CONFIRMED. |
#' | status_label | character | Status of the game as the site words it in its own language (e.g. Termine, Final). |
#' | is_final | logical | True when the game is over. |
#' | is_live | logical | True while the game is being played. |
#' | times_unconfirmed | logical | True while the start time is not final. |
#' | start_time_utc | POSIXct | Scheduled start, naive datetime in UTC (the API sends no offset). |
#' | start_time_local | character | The ribbon's fixture date as the API sends it: a local wall-clock time (no offset; the zone is not given). |
#' | home_entity_id | character | Team UUID of the home team. |
#' | home_name | character | Name of the home team. |
#' | home_score | integer | Points scored by the home team (the API sends a string; Int64 here). |
#' | home_result_status | character | Result status of the home team's score, e.g. CONFIRMED. |
#' | home_is_leading | logical | True while the home team leads (ribbon rows). |
#' | away_entity_id | character | Team UUID of the away team. |
#' | away_name | character | Name of the away team. |
#' | away_score | integer | Points scored by the away team (the API sends a string; Int64 here). |
#' | away_result_status | character | Result status of the away team's score, e.g. CONFIRMED. |
#' | away_is_leading | logical | True while the away team leads (ribbon rows). |
#' @eval .intl_details(.atrium_fixtures_details, "atrium_fixtures_ribbon(website_id = 14)")
#' @family Atrium Functions
#' @export
atrium_fixtures_ribbon <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL,
                                   entity_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixtures_ribbon", list(
    season = season, seasonId = season_id, competitionId = competition_id, entityId = entity_id, locale = locale
  ))
  .atrium_data(.atrium_parse_fixtures_ribbon(raw), "fixtures ribbon")
}

#' @title
#' **Atrium Fixture (game header)**
#' @description
#' **One game's header: teams, score, venue, status, rules (periods, overtime, shot
#' clock) and captains.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`
#'
#' The rules (`number_of_periods`, `period_length` in minutes, `overtime_length`,
#' `shot_clock` in seconds, ...) come from the game's profile. `*_captain_person_id`
#' is the person id of each team's captain.
#' @inheritParams atrium_fixtures
#' @param fixture_id (*character* required): Game UUID (`fixture_id` in
#'   [atrium_fixtures()]), e.g. `"0dc631bd-c34c-11f1-8d16-4d5a21afb79d"`.
#' @return A `hoopR_data` tibble, one row for the game:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | season_id | character | Season UUID of the game. |
#' | competition_name | character | Name of the competition, in the site's language. |
#' | name | character | Fixture name; null on LNBP. |
#' | fixture_type | character | Kind of game as sent: REGULAR, PLAYOFF, ... (the set is open). |
#' | age_group | character | Age group of the competition, e.g. SENIOR. |
#' | status | character | Status code of the game, e.g. CONFIRMED (final), as sent. |
#' | status_label | character | Status of the game as the site words it in its own language (e.g. Termine, Final). |
#' | start_time_utc | POSIXct | Scheduled start, naive datetime in UTC (the API sends no offset). |
#' | start_time_local | character | Scheduled start in the venue's local time, as the API sends it (`YYYY-MM-DDTHH:MM:SS`, no offset; timezone gives the zone, which varies per row). |
#' | timezone | character | IANA time zone of the venue (e.g. Europe/Paris, Mexico/General) that start_time_local is in. |
#' | venue | character | Name of the arena where the game is played. |
#' | venue_id | character | Venue UUID; joins no other route. |
#' | attendance | integer | Spectators at the game; null when not reported. |
#' | external_id | character | The league's own match number (LNB: the lnb.fr number); null elsewhere. |
#' | updated | POSIXct | When the record was last updated, naive datetime (no offset; zone unverified). |
#' | live_data_available | logical | True when live data feeds are enabled for the game. |
#' | live_video_available | logical | True when a live video stream is attached. |
#' | discipline | character | Discipline label of the game; null in every body seen. |
#' | series | character | Playoff series the game belongs to as sent (JSON text when an object); null outside a series. |
#' | number_of_periods | integer | Regulation periods in the game (4). |
#' | period_length | integer | Length of a regulation period, in minutes. |
#' | overtime_allowed | logical | True when the game may go to overtime. |
#' | overtime_length | integer | Length of an overtime period, in minutes. |
#' | shot_clock | integer | Shot clock length, in seconds. |
#' | max_fouls_personal | integer | Personal fouls that disqualify a player. |
#' | fouls_before_bonus | integer | Team fouls in a period before the bonus applies. |
#' | maximum_players_on_court | integer | Players a team has on court at once. |
#' | maximum_roster_size | integer | Largest roster a team may enter for the game. |
#' | home_entity_id | character | Team UUID of the home team. |
#' | home_code | character | Short code of the home team (e.g. PAB). |
#' | home_name | character | Name of the home team. |
#' | home_score | integer | Points scored by the home team (the API sends a string; Int64 here). |
#' | home_result_status | character | Result status of the home team's score, e.g. CONFIRMED. |
#' | away_entity_id | character | Team UUID of the away team. |
#' | away_code | character | Short code of the away team (e.g. PAB). |
#' | away_name | character | Name of the away team. |
#' | away_score | integer | Points scored by the away team (the API sends a string; Int64 here). |
#' | away_result_status | character | Result status of the away team's score, e.g. CONFIRMED. |
#' | home_captain_person_id | character | Person UUID of the home team's captain; null when the body names none. |
#' | away_captain_person_id | character | Person UUID of the away team's captain; null when the body names none. |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_fixture(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#' }
atrium_fixture <- function(website_id, fixture_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixture_detail", list(sub = "statistics", fixtureId = fixture_id, locale = locale))
  .atrium_data(.atrium_parse_fixture(raw), "fixture")
}

#' @title
#' **Atrium Fixture Periods**
#' @description
#' **One game's periods with the points each team scored in each, overtime periods
#' included (ids 11+).**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`
#'
#' `home_points` / `away_points` are the points scored IN that period, not the running
#' score. Overtime periods are `period_id` 11, 12, ... (not 5).
#' @inheritParams atrium_fixture
#' @return A `hoopR_data` tibble, one row per `(fixture_id, period_id)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | season_id | character | Season UUID of the game. |
#' | period_id | integer | Period number: 1-4 regulation, 11, 12, ... overtimes (not 5). |
#' | label | character | Short period label in the site's language (Q1, P1), as sent. |
#' | is_overtime | logical | True for an overtime period. |
#' | is_shootout | logical | True for a shootout period. |
#' | started | logical | True once the period has started. |
#' | ended | logical | True once the period has ended. |
#' | duration_minutes | integer | Length of the period in minutes. |
#' | elapsed_minutes_before_period | integer | Minutes of game time played before the period starts (40 for the first overtime). |
#' | home_entity_id | character | Team UUID of the home team, from the fixture's isHome flag. |
#' | away_entity_id | character | Team UUID of the away team, from the fixture's isHome flag. |
#' | home_points | integer | Points the home team scored in this period (not the running score). |
#' | away_points | integer | Points the away team scored in this period (not the running score). |
#' @eval .intl_details(.atrium_fixtures_details, 'atrium_fixture_periods(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d")')
#' @family Atrium Functions
#' @export
atrium_fixture_periods <- function(website_id, fixture_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixture_detail", list(sub = "statistics", fixtureId = fixture_id, locale = locale))
  .atrium_data(.atrium_parse_fixture_periods(raw), "fixture periods")
}

#' @title
#' **Atrium Player Box Score**
#' @description
#' **One game's box score: one row per rostered player with the statistics the site
#' configures.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`
#'
#' A player who did not play has `participated` `FALSE` and `NA` statistics. LNB has
#' `blocks_received` and `plus_minus` but no field-goal totals; LNBP the reverse.
#' `minutes` is the ISO duration as sent and `seconds_played` its value. Percentages
#' are 0-100. `side` is `home` or `away`.
#' @inheritParams atrium_fixture
#' @return A `hoopR_data` tibble, one row per `(fixture_id, person_id)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | season_id | character | Season UUID of the game. |
#' | entity_id | character | Team UUID the player is rostered with for this game. |
#' | side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
#' | person_id | character | Player UUID (person), shared across seasons and sites. |
#' | person_name | character | Player name as the site prints it (upper case on LNBP and NBL1). |
#' | bib | character | Jersey number the player wears, as text. |
#' | position | character | Position code on the roster (LNB, e.g. PG); null on LNBP. |
#' | starter | logical | True when the player started the game. |
#' | active | logical | True when the player is on the court in a live game. |
#' | participated | logical | True when the player entered the game; false rows have null statistics. |
#' | did_not_play_reason | character | Reason the player did not play; null in every body seen. |
#' | minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (player, this game). |
#' | seconds_played | integer | Time played in whole seconds, parsed from minutes (player, this game). |
#' | points | integer | Points scored (player, this game). |
#' | rebounds | integer | Total rebounds (player, this game). |
#' | rebounds_offensive | integer | Offensive rebounds (player, this game). |
#' | rebounds_defensive | integer | Defensive rebounds (player, this game). |
#' | assists | integer | Assists (player, this game). |
#' | steals | integer | Steals (player, this game). |
#' | blocks | integer | Shots blocked (player, this game). |
#' | blocks_received | integer | Own shots blocked by an opponent (LNB only) (player, this game). |
#' | turnovers | integer | Turnovers (player, this game). |
#' | fouls_total | integer | Fouls committed (player, this game). |
#' | fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (player, this game). |
#' | plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (player, this game). |
#' | efficiency | integer | Efficiency rating, from the site's own formula (player, this game). |
#' | field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (player, this game). |
#' | field_goals_attempted | integer | Field goals attempted (LNBP only) (player, this game). |
#' | field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (player, this game). |
#' | points_two_made | integer | Two-point field goals made (player, this game). |
#' | points_two_attempted | integer | Two-point field goals attempted (player, this game). |
#' | points_two_percentage | double | Two-point percentage, 0-100 (player, this game). |
#' | points_three_made | integer | Three-point field goals made (player, this game). |
#' | points_three_attempted | integer | Three-point field goals attempted (player, this game). |
#' | points_three_percentage | double | Three-point percentage, 0-100 (player, this game). |
#' | free_throws_made | integer | Free throws made (player, this game). |
#' | free_throws_attempted | integer | Free throws attempted (player, this game). |
#' | free_throws_percentage | double | Free-throw percentage, 0-100 (player, this game). |
#' | points_fast_break | integer | Fast-break points (LNBP only) (player, this game). |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_box_score(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#' }
atrium_box_score <- function(website_id, fixture_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixture_detail", list(sub = "statistics", fixtureId = fixture_id, locale = locale))
  .atrium_data(.atrium_parse_box_score(raw), "box score")
}

#' @title
#' **Atrium Team Box Score**
#' @description
#' **One game's team lines: the team totals, the team-level counts and the game
#' aggregates (lead changes, biggest lead).**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=statistics`
#'
#' The team line is the API's `entity` block (minutes are the sum over players,
#' `PT200M`); `extra_*` are the team-level counts not credited to a player (team
#' rebounds and turnovers) and `total_*` the game-level aggregates.
#' @inheritParams atrium_fixture
#' @return A `hoopR_data` tibble, one row per `(fixture_id, entity_id)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | season_id | character | Season UUID of the game. |
#' | entity_id | character | Team UUID (from the fixture's isHome flag). |
#' | side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
#' | minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (team, this game). |
#' | seconds_played | integer | Time played in whole seconds, parsed from minutes (team, this game). |
#' | points | integer | Points scored (team, this game). |
#' | rebounds | integer | Total rebounds (team, this game). |
#' | rebounds_offensive | integer | Offensive rebounds (team, this game). |
#' | rebounds_defensive | integer | Defensive rebounds (team, this game). |
#' | assists | integer | Assists (team, this game). |
#' | steals | integer | Steals (team, this game). |
#' | blocks | integer | Shots blocked (team, this game). |
#' | blocks_received | integer | Own shots blocked by an opponent (LNB only) (team, this game). |
#' | turnovers | integer | Turnovers (team, this game). |
#' | fouls_total | integer | Fouls committed (team, this game). |
#' | fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (team, this game). |
#' | plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (team, this game). |
#' | efficiency | integer | Efficiency rating, from the site's own formula (team, this game). |
#' | field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (team, this game). |
#' | field_goals_attempted | integer | Field goals attempted (LNBP only) (team, this game). |
#' | field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (team, this game). |
#' | points_two_made | integer | Two-point field goals made (team, this game). |
#' | points_two_attempted | integer | Two-point field goals attempted (team, this game). |
#' | points_two_percentage | double | Two-point percentage, 0-100 (team, this game). |
#' | points_three_made | integer | Three-point field goals made (team, this game). |
#' | points_three_attempted | integer | Three-point field goals attempted (team, this game). |
#' | points_three_percentage | double | Three-point percentage, 0-100 (team, this game). |
#' | free_throws_made | integer | Free throws made (team, this game). |
#' | free_throws_attempted | integer | Free throws attempted (team, this game). |
#' | free_throws_percentage | double | Free-throw percentage, 0-100 (team, this game). |
#' | points_fast_break | integer | Fast-break points (LNBP only) (team, this game). |
#' | extra_fouls_total | integer | Fouls committed (team, credited to the team rather than a player). |
#' | extra_rebounds | integer | Total rebounds (team, credited to the team rather than a player). |
#' | extra_rebounds_defensive | integer | Defensive rebounds (team, credited to the team rather than a player). |
#' | extra_rebounds_offensive | integer | Offensive rebounds (team, credited to the team rather than a player). |
#' | extra_turnovers | integer | Turnovers (team, credited to the team rather than a player). |
#' | total_biggest_lead | integer | Biggest lead of the game, in points (team, game total). |
#' | total_biggest_scoring_run | integer | Longest unanswered scoring run of the game, in points (team, game total). |
#' | total_field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (team, game total). |
#' | total_free_throws_percentage | double | Free-throw percentage, 0-100 (team, game total). |
#' | total_lead_changes | integer | Number of lead changes in the game (team, game total). |
#' | total_points_fast_break | integer | Fast-break points (LNBP only) (team, game total). |
#' | total_points_from_bench | integer | Points scored by non-starters (LNBP only) (team, game total). |
#' | total_points_from_turnover | integer | Points scored off opponent turnovers (LNBP only) (team, game total). |
#' | total_time_in_lead | character | Time the team led, as an ISO 8601 duration (PT36M11S) (team, game total). |
#' | total_time_in_lead_seconds | integer | Time the team led, in whole seconds (team, game total). |
#' | total_turnovers | integer | Turnovers (team, game total). |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_team_box_score(website_id = 12, fixture_id = "5423072b-6715-11f0-bd8b-9ffadebc148f"))
#' }
atrium_team_box_score <- function(website_id, fixture_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixture_detail", list(sub = "statistics", fixtureId = fixture_id, locale = locale))
  .atrium_data(.atrium_parse_team_box_score(raw), "team box score")
}

#' @title
#' **Atrium Play-by-Play**
#' @description
#' **One game's play-by-play: every event with the period clock, the player and the
#' running score.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=pbp`
#'
#' `sequence` is the 1-based position in the body (periods in order, events
#' chronological within a period). `clock` is the time REMAINING in the period as sent
#' (`PT10M0S` at the start) and `clock_seconds` its value. `home_score` / `away_score`
#' are the running score after the event. `x` / `y` (shots only) are percent of the
#' court (0-100). Team events have no `person_id`. Overtime is `period_id` 11+.
#' @inheritParams atrium_fixture
#' @return A `hoopR_data` tibble, one row per `event_id`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | season_id | character | Season UUID of the game. |
#' | sequence | integer | 1-based position of the event in the game (periods in order, events chronological). |
#' | event_id | character | Event UUID, shared with the same event in atrium_shots. |
#' | period_id | integer | Period number: 1-4 regulation, 11, 12, ... overtimes (not 5). |
#' | clock | character | Time REMAINING in the period as an ISO 8601 duration (PT10M0S at the start). |
#' | clock_seconds | integer | Seconds remaining in the period, parsed from clock. |
#' | entity_id | character | Team UUID the event is credited to. |
#' | side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
#' | person_id | character | Player UUID; null for team events (time-outs, team rebounds). |
#' | person_name | character | Player the event is credited to; null for team events (time-outs, team rebounds). |
#' | bib | character | Jersey number of the player, as text; null for team events. |
#' | event_type | character | Event type: 2pt, 3pt, freeThrow, rebound, assist, steal, block, turnover, foul, substitution, timeOut, jumpBall, ... (language-independent). |
#' | event_sub_type | character | Event detail: jumpShot, layup, offensive, defensive, in, out, 1Of2, personal, ...; null when none. |
#' | description | character | The event's text in the site's language (e.g. Entre-deux remporte). |
#' | success | logical | True when a shot or free throw was made, false when missed; null for other events. |
#' | success_label | character | The made / missed label in the site's language; sent on shot events only. |
#' | x | double | Shot location along the 28 m court length as percent of the court (0-100, origin at a corner); the home team attacks the low-x basket all game; null for non-shots. |
#' | y | double | Shot location across the 15 m width as percent of the court (0-100); which sideline is 0 is unverified; null for non-shots. |
#' | home_score | integer | Home team's running score after the event. |
#' | away_score | integer | Away team's running score after the event. |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_pbp(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#' }
atrium_pbp <- function(website_id, fixture_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixture_detail", list(sub = "pbp", fixtureId = fixture_id, locale = locale))
  .atrium_data(.atrium_parse_pbp(raw), "play-by-play")
}

#' @title
#' **Atrium Shots**
#' @description
#' **One game's 2pt / 3pt attempts with their court location (percent of the court)
#' and result.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/fixture_detail?sub=shot_chart`
#'
#' The shot chart holds field-goal attempts only (no free throws); `event_id` joins
#' the same event in [atrium_pbp()]. `x` / `y` are percent of the court (0-100,
#' origin at a corner, x along the 28 m length). LNBP and NBL1 clamp rim attempts to
#' x = 5 / 95.
#' @inheritParams atrium_fixture
#' @return A `hoopR_data` tibble, one row per shot (`event_id`):
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | fixture_id | character | Game UUID (fixture); the key of every game frame and of the fixture_detail routes. |
#' | season_id | character | Season UUID of the game. |
#' | sequence | integer | 1-based position of the shot among the shots of the game (not the pbp sequence). |
#' | event_id | character | Event UUID of the shot; the same event in atrium_pbp. |
#' | period_id | integer | Period number: 1-4 regulation, 11, 12, ... overtimes (not 5). |
#' | clock | character | Time REMAINING in the period as an ISO 8601 duration (PT10M0S at the start). |
#' | clock_seconds | integer | Seconds remaining in the period, parsed from clock. |
#' | entity_id | character | Team UUID the event is credited to. |
#' | side | character | Side of the game the row belongs to: home or away (from the fixture's isHome flag). |
#' | person_id | character | Player UUID of the shooter. |
#' | person_name | character | Name of the shooter. |
#' | bib | character | Jersey number of the player, as text; null for team events. |
#' | event_type | character | Event type: 2pt, 3pt, freeThrow, rebound, assist, steal, block, turnover, foul, substitution, timeOut, jumpBall, ... (language-independent). |
#' | event_sub_type | character | Event detail: jumpShot, layup, offensive, defensive, in, out, 1Of2, personal, ...; null when none. |
#' | description | character | The event's text in the site's language (e.g. Entre-deux remporte). |
#' | success | logical | True when the shot was made, false when missed. |
#' | success_label | character | The made / missed label in the site's language; sent on shot events only. |
#' | x | double | Shot location along the 28 m court length as percent of the court (0-100, origin at a corner); the home team attacks the low-x basket all game; LNBP and NBL1 clamp rim attempts to 5 / 95. |
#' | y | double | Shot location across the 15 m width as percent of the court (0-100); which sideline is 0 is unverified. |
#' | home_score | integer | Home team's running score after the event. |
#' | away_score | integer | Away team's running score after the event. |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_shots(website_id = 14, fixture_id = "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"))
#' }
atrium_shots <- function(website_id, fixture_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "fixture_detail", list(sub = "shot_chart", fixtureId = fixture_id, locale = locale))
  .atrium_data(.atrium_parse_shots(raw), "shots")
}

#' @title
#' **Atrium Standings**
#' @description
#' **Standings of a season, with the columns the site configures (LNB home / away
#' splits, LNBP played and points).**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/standings`
#'
#' `win_percentage` is a 0-1 fraction. `group` is the table's label (empty for a
#' single table).
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `(season_id, group, entity_id)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the table. |
#' | season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
#' | group | character | Label of the table when the standings hold several groups; null for a single table. |
#' | position | integer | League table position (1 = first). |
#' | entity_id | character | Team UUID of the row. |
#' | team_name | character | Team name as the site prints it. |
#' | is_current_team | logical | True for the team the page was opened for (team context); false on a plain standings request. |
#' | logo_url | character | URL of the team logo image. |
#' | wins | integer | Games won; -1 for two teams in the 2025-26 LNB table (an administrative ranking, unverified), kept as sent (team, this table). |
#' | losses | integer | Games lost (team, this table). |
#' | played | integer | Games played (LNBP and the compact standings) (team, this table). |
#' | standing_points | integer | League table points (LNBP) (team, this table). |
#' | win_percentage | double | Share of games won as a 0-1 fraction (not 0-100) (team, this table). |
#' | scored_for | integer | Points scored over the season (team, this table). |
#' | scored_against | integer | Points conceded over the season (team, this table). |
#' | point_difference | integer | Point differential over the season (team, this table). |
#' | result_string_home | character | Home results as a string of result letters in the site's language, one per game (order and letters per locale; unverified) (team, this table). |
#' | scored_for_home | integer | Points scored in home games (team, this table). |
#' | scored_against_home | integer | Points conceded in home games (team, this table). |
#' | point_difference_home | integer | Point differential in home games (team, this table). |
#' | result_string_away | character | Away results as a string of result letters in the site's language, one per game (order and letters per locale; unverified) (team, this table). |
#' | scored_for_away | integer | Points scored in away games (team, this table). |
#' | scored_against_away | integer | Points conceded in away games (team, this table). |
#' | point_difference_away | integer | Point differential in away games (team, this table). |
#' | streak | integer | Length of the current run of results (the win / loss sign convention is unverified) (team, this table). |
#' | streak_home | integer | Length of the current run of home results (sign convention unverified) (team, this table). |
#' | streak_away | integer | Length of the current run of away results (sign convention unverified) (team, this table). |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_standings(
#'     website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
#'   ))
#' }
atrium_standings <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL,
                             round_number = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "standings", list(
    season = season, seasonId = season_id, competitionId = competition_id, roundNumber = round_number, locale = locale
  ))
  .atrium_data(.atrium_parse_standings(raw), "standings")
}

#' @title
#' **Atrium Standings Summary**
#' @description
#' **Compact standings of a season: position, wins, losses and games played.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/standings_fragment`
#'
#' The columns are those of [atrium_standings()]; the compact fragment fills only
#' `wins` / `losses` / `played`.
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `(season_id, group, entity_id)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the table. |
#' | season_end_year | integer | Season END year (the sdv key): the site's year + 1 on LNB (site 12), the calendar year on the other registered sites; null when the site is unregistered, lists no seasons or the body has no season list. |
#' | group | character | Label of the table when the standings hold several groups; null for a single table. |
#' | position | integer | League table position (1 = first). |
#' | entity_id | character | Team UUID of the row. |
#' | team_name | character | Team name as the site prints it. |
#' | is_current_team | logical | True for the team the page was opened for (team context); false on a plain standings request. |
#' | logo_url | character | URL of the team logo image. |
#' | wins | integer | Games won; -1 for two teams in the 2025-26 LNB table (an administrative ranking, unverified), kept as sent (team, this table). |
#' | losses | integer | Games lost (team, this table). |
#' | played | integer | Games played (LNBP and the compact standings) (team, this table). |
#' | standing_points | integer | League table points (LNBP) (team, this table). |
#' | win_percentage | double | Share of games won as a 0-1 fraction (not 0-100) (team, this table). |
#' | scored_for | integer | Points scored over the season (team, this table). |
#' | scored_against | integer | Points conceded over the season (team, this table). |
#' | point_difference | integer | Point differential over the season (team, this table). |
#' | result_string_home | character | Home results as a string of result letters in the site's language, one per game (order and letters per locale; unverified) (team, this table). |
#' | scored_for_home | integer | Points scored in home games (team, this table). |
#' | scored_against_home | integer | Points conceded in home games (team, this table). |
#' | point_difference_home | integer | Point differential in home games (team, this table). |
#' | result_string_away | character | Away results as a string of result letters in the site's language, one per game (order and letters per locale; unverified) (team, this table). |
#' | scored_for_away | integer | Points scored in away games (team, this table). |
#' | scored_against_away | integer | Points conceded in away games (team, this table). |
#' | point_difference_away | integer | Point differential in away games (team, this table). |
#' | streak | integer | Length of the current run of results (the win / loss sign convention is unverified) (team, this table). |
#' | streak_home | integer | Length of the current run of home results (sign convention unverified) (team, this table). |
#' | streak_away | integer | Length of the current run of away results (sign convention unverified) (team, this table). |
#' @eval .intl_details(.atrium_fixtures_details, c(
#'   'atrium_standings_summary(website_id = 12, season = 2026,',
#'   '                         competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404")'
#' ))
#' @family Atrium Functions
#' @export
atrium_standings_summary <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL,
                                     locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "standings_fragment", list(
    season = season, seasonId = season_id, competitionId = competition_id, locale = locale
  ))
  .atrium_data(.atrium_parse_standings(raw), "standings summary")
}

#' @title
#' **Atrium Teams**
#' @description
#' **The teams of a season.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/entities`
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `(season_id, entity_id)`; `entity_id` is
#'   stable across seasons:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the team list. |
#' | entity_id | character | Team UUID (entity): one id per club across seasons, shared by every site that shows the team. |
#' | name | character | Team name in the site's language. |
#' | image_url | character | URL of the Sportradar-hosted image (400 px). |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_teams(
#'     website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
#'   ))
#' }
atrium_teams <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "entities", list(
    season = season, seasonId = season_id, competitionId = competition_id, locale = locale
  ))
  .atrium_data(.atrium_parse_teams(raw), "teams")
}

#' @title
#' **Atrium Team Page**
#' @description
#' **A team page (summary tab): the team and its last and next game.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/entity_detail`
#'
#' `previous_*` is the last played game and `next_*` the next scheduled one (`NA` when
#' the page shows none). `entity_id` is decoded from the page's tab links; `color` is
#' a hex string with its `#`.
#' @inheritParams atrium_fixtures
#' @param entity_id (*character* required): Team UUID (`entity_id` in [atrium_teams()]
#'   or any fixture row), e.g. `"f43b1b0f-55bc-11f0-84d9-01499d2f0a07"`.
#' @return A `hoopR_data` tibble, one row for the team:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | entity_id | character | Team UUID, decoded from the page's tab links (the body does not echo it elsewhere). |
#' | name | character | Team name from the page banner. |
#' | color | character | Team colour from the banner, hex string with its #. |
#' | logo_url | character | URL of the banner's team logo. |
#' | previous_fixture_id | character | Game UUID of the last played game shown on the team page. |
#' | previous_round | character | Round of the last played game as the site words it (e.g. 30). |
#' | previous_status | character | Status code of the last played game, e.g. CONFIRMED. |
#' | previous_start_time_utc | POSIXct | Start of the last played game, naive UTC datetime. |
#' | previous_start_time_local | character | Start of the last played game in venue-local time, as the API sends it (no offset). |
#' | previous_venue | character | Arena of the last played game. |
#' | previous_attendance | integer | Spectators at the last played game; null when not reported. |
#' | previous_home_entity_id | character | Team UUID of the last played game's home team. |
#' | previous_home_name | character | Name of the last played game's home team. |
#' | previous_home_score | integer | Home team's points in the last played game. |
#' | previous_away_entity_id | character | Team UUID of the last played game's away team. |
#' | previous_away_name | character | Name of the last played game's away team. |
#' | previous_away_score | integer | Away team's points in the last played game. |
#' | next_fixture_id | character | Game UUID of the next scheduled game shown on the team page. |
#' | next_round | character | Round of the next scheduled game as the site words it (e.g. 30). |
#' | next_status | character | Status code of the next scheduled game, e.g. CONFIRMED. |
#' | next_start_time_utc | POSIXct | Start of the next scheduled game, naive UTC datetime. |
#' | next_start_time_local | character | Start of the next scheduled game in venue-local time, as the API sends it (no offset). |
#' | next_venue | character | Arena of the next scheduled game. |
#' | next_attendance | integer | Spectators at the next scheduled game; null when not reported. |
#' | next_home_entity_id | character | Team UUID of the next scheduled game's home team. |
#' | next_home_name | character | Name of the next scheduled game's home team. |
#' | next_home_score | integer | Home team's points in the next scheduled game. |
#' | next_away_entity_id | character | Team UUID of the next scheduled game's away team. |
#' | next_away_name | character | Name of the next scheduled game's away team. |
#' | next_away_score | integer | Away team's points in the next scheduled game. |
#' @eval .intl_details(.atrium_fixtures_details, 'atrium_team(website_id = 12, entity_id = "f43b1b0f-55bc-11f0-84d9-01499d2f0a07")')
#' @family Atrium Functions
#' @export
atrium_team <- function(website_id, entity_id, season = NULL, season_id = NULL, competition_id = NULL,
                        locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "entity_detail", list(
    entityId = entity_id, season = season, seasonId = season_id, competitionId = competition_id, locale = locale
  ))
  .atrium_data(.atrium_parse_team(raw), "team")
}

#' @title
#' **Atrium Players**
#' @description
#' **The players of a season, with position, nationality, birth date, age and height.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/persons`
#'
#' `height` is an integer where the site gives one (centimetres; unit unverified).
#' `position_code` / `position_name` follow the site locale (the name is translated,
#' the code is not). `person_id` is stable across seasons and sites.
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `(season_id, person_id)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the roster list. |
#' | person_id | character | Player UUID (person), shared across seasons and sites. |
#' | name | character | Player name as the site prints it. |
#' | bib | character | Jersey number, as text. |
#' | entity_id | character | Team UUID the player is rostered with that season. |
#' | team_name | character | Team name in the site's language. |
#' | position_code | character | Position code (C, PG, SF, ...), language-independent. |
#' | position_name | character | Position name in the site's language. |
#' | nationality | character | Player's nationality in the site's language (e.g. Belgique). |
#' | date_of_birth | Date | Player's date of birth. |
#' | age | integer | Player's age in years when the body was generated. |
#' | height | integer | Height as an integer, centimetres presumed (unit unverified); null when the site gives none. |
#' | status | character | Player status in the site's language (Actif, Blesse). |
#' | image_url | character | URL of the Sportradar-hosted image (400 px). |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_players(
#'     website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
#'   ))
#' }
atrium_players <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL,
                           entity_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "persons", list(
    season = season, seasonId = season_id, competitionId = competition_id, entityId = entity_id, locale = locale
  ))
  .atrium_data(.atrium_parse_players(raw), "players")
}

#' @title
#' **Atrium Player Page**
#' @description
#' **A player page: bio and the season averages the card shows.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/person_detail`
#'
#' Info items the documented columns do not list (height, position, ...) are appended
#' as columns named after their key.
#' @inheritParams atrium_fixtures
#' @param person_id (*character* required): Player UUID (`person_id` in
#'   [atrium_players()] or a box score), e.g. `"4458f165-f865-11f0-8ebf-539c931c1654"`.
#' @return A `hoopR_data` tibble, one row for the player:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | person_id | character | Player UUID (person), shared across seasons and sites. |
#' | name | character | Player name as the site prints it. |
#' | bib | character | Jersey number on the card; null when none. |
#' | team_id | character | Team UUID of the player's current team on the card. |
#' | team_name | character | Name of the player's current team on the card. |
#' | image_url | character | URL of the Sportradar-hosted image (400 px). |
#' | date_of_birth | Date | Player's date of birth, from the card's info items. |
#' | age | integer | Player's age in years, from the card's info items. |
#' | nationality | character | Player's nationality in the site's language, from the card's info items. |
#' | points_per_game | double | Points per game over the season shown on the card. |
#' | rebounds_offensive_per_game | double | Offensive rebounds per game over the season shown on the card. |
#' | rebounds_defensive_per_game | double | Defensive rebounds per game over the season shown on the card. |
#' @eval .intl_details(.atrium_fixtures_details, 'atrium_player(website_id = 12, person_id = "4458f165-f865-11f0-8ebf-539c931c1654")')
#' @family Atrium Functions
#' @export
atrium_player <- function(website_id, person_id, season = NULL, season_id = NULL, competition_id = NULL,
                          locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "person_detail", list(
    personId = person_id, season = season, seasonId = season_id, competitionId = competition_id, locale = locale
  ))
  .atrium_data(.atrium_parse_player(raw), "player")
}

#' @title
#' **Atrium Player Seasons**
#' @description
#' **A player's per-game averages, one row per competition-season.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/person_detail`
#'
#' `season_year` is the site's own year and `season_end_year` the sdv END year. The
#' statistics are the per-game averages the site configures (double rates, ISO
#' `minutes_per_game`).
#' @inheritParams atrium_player
#' @return A `hoopR_data` tibble, one row per `(person_id, season_name, team_id)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | person_id | character | Player UUID (person), shared across seasons and sites. |
#' | season_name | character | Competition-season the line is for, in the site's language (Betclic ELITE - Playoffs 2025). |
#' | season_year | integer | The site's own year of that season (START year on LNB). |
#' | season_end_year | integer | Season END year of that season (sdv key); null when the site is unmapped. |
#' | team_id | character | Team UUID the player played for in that season. |
#' | team_name | character | Name of the team the player played for in that season. |
#' | minutes_per_game | character | Minutes per game as an ISO 8601 duration (player, that competition-season). |
#' | points_per_game | double | Points per game (player, that competition-season). |
#' | rebounds_per_game | double | Rebounds per game (player, that competition-season). |
#' | rebounds_offensive_per_game | double | Offensive rebounds per game (player, that competition-season). |
#' | rebounds_defensive_per_game | double | Defensive rebounds per game (player, that competition-season). |
#' | assists_per_game | double | Assists per game (player, that competition-season). |
#' | steals_per_game | double | Steals per game (player, that competition-season). |
#' | blocks_per_game | double | Blocks per game (player, that competition-season). |
#' | turnovers_per_game | double | Turnovers per game (player, that competition-season). |
#' | fouls_personal_per_game | double | Personal fouls per game (player, that competition-season). |
#' | dunks_per_game | double | Dunks per game (player, that competition-season). |
#' | efficiency | integer | Efficiency rating, from the site's own formula (player, that competition-season). |
#' @eval .intl_details(.atrium_fixtures_details, 'atrium_player_seasons(website_id = 12, person_id = "4458f165-f865-11f0-8ebf-539c931c1654")')
#' @family Atrium Functions
#' @export
atrium_player_seasons <- function(website_id, person_id, season = NULL, season_id = NULL,
                                  competition_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "person_detail", list(
    personId = person_id, season = season, seasonId = season_id, competitionId = competition_id, locale = locale
  ))
  .atrium_data(.atrium_parse_player_seasons(raw), "player seasons")
}

#' @title
#' **Atrium Player Game Log**
#' @description
#' **A player's game log: one row per game with the opponent, result and the
#' statistics the site shows.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/person_detail?sub=log`
#'
#' `score` is the site's text (`"88 - 91"`); which side is listed first is unverified,
#' so it is not split. `date` is the local start time (no offset). The log carries no
#' fixture id: join on date and opponent.
#' @inheritParams atrium_player
#' @return A `hoopR_data` tibble, one row per game:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | person_id | character | Player UUID (person), shared across seasons and sites. |
#' | season_id | character | Season UUID the log is for (the season asked, else the site's default). |
#' | date | character | Local start of the game as the API sends it (`YYYY-MM-DDTHH:MM:SS`, no offset; the zone is not given): the field the ribbon's start_time_local reads. |
#' | opponent_entity_id | character | Team UUID of the opponent. |
#' | opponent_name | character | Name of the opponent. |
#' | result | character | Result for the player's team: W or L. |
#' | result_label | character | Result label in the site's language (V, D). |
#' | score | character | Final score as the site's text (e.g. 88 - 91); which side is listed first is unverified, so it is not split. |
#' | minutes | character | Time played as an ISO 8601 duration (PT7M23S); a team's is the sum over its players (PT200M) (player, that game). |
#' | seconds_played | integer | Time played in whole seconds, parsed from minutes (player, that game). |
#' | points | integer | Points scored (player, that game). |
#' | rebounds | integer | Total rebounds (player, that game). |
#' | rebounds_offensive | integer | Offensive rebounds (player, that game). |
#' | rebounds_defensive | integer | Defensive rebounds (player, that game). |
#' | assists | integer | Assists (player, that game). |
#' | steals | integer | Steals (player, that game). |
#' | blocks | integer | Shots blocked (player, that game). |
#' | blocks_received | integer | Own shots blocked by an opponent (LNB only) (player, that game). |
#' | turnovers | integer | Turnovers (player, that game). |
#' | fouls_total | integer | Fouls committed (player, that game). |
#' | fouls_drawn | integer | Fouls drawn (committed against the player or team; LNBP only) (player, that game). |
#' | plus_minus | integer | Plus/minus, the point differential while on court (LNB only; null in some team lines) (player, that game). |
#' | efficiency | integer | Efficiency rating, from the site's own formula (player, that game). |
#' | field_goals_made | integer | Field goals made, two- and three-pointers together (LNBP only) (player, that game). |
#' | field_goals_attempted | integer | Field goals attempted (LNBP only) (player, that game). |
#' | field_goals_percentage | double | Field-goal percentage, 0-100 (LNBP only) (player, that game). |
#' | points_two_made | integer | Two-point field goals made (player, that game). |
#' | points_two_attempted | integer | Two-point field goals attempted (player, that game). |
#' | points_two_percentage | double | Two-point percentage, 0-100 (player, that game). |
#' | points_three_made | integer | Three-point field goals made (player, that game). |
#' | points_three_attempted | integer | Three-point field goals attempted (player, that game). |
#' | points_three_percentage | double | Three-point percentage, 0-100 (player, that game). |
#' | free_throws_made | integer | Free throws made (player, that game). |
#' | free_throws_attempted | integer | Free throws attempted (player, that game). |
#' | free_throws_percentage | double | Free-throw percentage, 0-100 (player, that game). |
#' | points_fast_break | integer | Fast-break points (LNBP only) (player, that game). |
#' | dunks | integer | Dunks (player, that game). |
#' | fouls_personal | integer | Personal fouls (player, that game). |
#' @eval .intl_details(.atrium_fixtures_details, 'atrium_player_game_log(website_id = 12, person_id = "4458f165-f865-11f0-8ebf-539c931c1654")')
#' @family Atrium Functions
#' @export
atrium_player_game_log <- function(website_id, person_id, season = NULL, season_id = NULL,
                                   competition_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "person_detail", list(
    sub = "log", personId = person_id, season = season, seasonId = season_id, competitionId = competition_id,
    locale = locale
  ))
  .atrium_data(.atrium_parse_player_game_log(raw), "player game log")
}

#' @title
#' **Atrium Leaders**
#' @description
#' **Season leaders per statistic (top 5 each), with their player and team ids.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/statistics_leaders`
#'
#' `rank` is the 1-based position within the statistic. `value` is numeric; a
#' duration statistic (`minutesPerGame`) lands in `value_text` as an ISO string.
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `(season_id, stat_key, rank)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the leaders. |
#' | stat_key | character | Statistic the leader is ranked in (points, pointsPerGame, efficiency, doubleDouble, ...). |
#' | stat_name | character | Short column heading the site shows for the statistic (PTS, REB), in the site's language. |
#' | stat_label | character | Longer statistic label the site shows (code in the API), in the site's language. |
#' | rank | integer | Position of the leader within the statistic, 1-based (the API lists the top 5). |
#' | entity_id | character | Team UUID of the leader's team. |
#' | entity_name | character | Name of the leader's team. |
#' | person_id | character | Player UUID of the leader. |
#' | person_name | character | Name of the leader. |
#' | value | double | Numeric value of the statistic; null when the API sends a duration or text (see value_text). |
#' | value_text | character | Non-numeric statistic value, e.g. an ISO 8601 duration such as PT12M2S for minutes per game. |
#' @eval .intl_details(.atrium_fixtures_details, c(
#'   'atrium_leaders(',
#'   '  website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"',
#'   ')'
#' ))
#' @family Atrium Functions
#' @export
atrium_leaders <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL,
                           entity_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "statistics_leaders", list(
    season = season, seasonId = season_id, competitionId = competition_id, entityId = entity_id, locale = locale
  ))
  .atrium_data(.atrium_parse_leaders(raw), "leaders")
}

#' @title
#' **Atrium Player Stats (season, long form)**
#' @description
#' **Player season statistics in long form (one row per player, table and
#' statistic); ids decoded from the widget links.**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/statistics_persons`
#'
#' Each body holds several tables (`averages`, `shootingstatistics`, `totals`, ...)
#' whose statistic set the site configures. `stat_key` (`pointsPerGame`) carries its
#' numeric `value` or, for ISO durations, `value_text`; pivot on `stat_key` for a wide
#' table. Percentages are 0-100.
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `(table_key, person_id, stat_key)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the table; null for the competition-scoped routes (their bodies carry none). |
#' | table_key | character | Statistics table the row is from: averages, shootingstatistics, totals, ... (the set is per site). |
#' | table_label | character | The table's heading in the site's language (e.g. Moyennes). |
#' | person_id | character | Player UUID decoded from the widget link beside the name (the tables carry names only); null when the link is missing or undecodable, and always null in team and competition bodies. |
#' | person_name | character | Player name as the site prints it; null in team tables. |
#' | entity_id | character | Team UUID decoded from the widget link (team tables only; player tables name the team but carry no id). |
#' | entity_name | character | Team name as the site prints it; for player rows of a stat table it is the player's team. |
#' | stat_key | character | Statistic key as the API names it (pointsPerGame, fieldGoalsMade, ...), unchanged from header key. |
#' | stat_name | character | Short column heading the site shows for the statistic (PTS, REB), in the site's language. |
#' | stat_label | character | Longer statistic label the site shows (code in the API), in the site's language. |
#' | value | double | Numeric value of the statistic; null when the API sends a duration or text (see value_text). |
#' | value_text | character | Non-numeric statistic value, e.g. an ISO 8601 duration such as PT12M2S for minutes per game. |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_player_stats(
#'     website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
#'   ))
#' }
atrium_player_stats <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "statistics_persons", list(
    season = season, seasonId = season_id, competitionId = competition_id, locale = locale
  ))
  .atrium_data(.atrium_parse_stat_tables(raw), "player stats")
}

#' @title
#' **Atrium Team Stats (season, long form)**
#' @description
#' **Team season statistics in long form (one row per team, table and statistic).**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/statistics_entities`
#' @inheritParams atrium_fixtures
#' @return A `hoopR_data` tibble, one row per `(table_key, entity_name, stat_key)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the table; null for the competition-scoped routes (their bodies carry none). |
#' | table_key | character | Statistics table the row is from: averages, shootingstatistics, totals, ... (the set is per site). |
#' | table_label | character | The table's heading in the site's language (e.g. Moyennes). |
#' | person_id | character | Player UUID decoded from the widget link beside the name (the tables carry names only); null when the link is missing or undecodable, and always null in team and competition bodies. |
#' | person_name | character | Player name as the site prints it; null in team tables. |
#' | entity_id | character | Team UUID decoded from the widget link (team tables only; player tables name the team but carry no id). |
#' | entity_name | character | Team name as the site prints it; for player rows of a stat table it is the player's team. |
#' | stat_key | character | Statistic key as the API names it (pointsPerGame, fieldGoalsMade, ...), unchanged from header key. |
#' | stat_name | character | Short column heading the site shows for the statistic (PTS, REB), in the site's language. |
#' | stat_label | character | Longer statistic label the site shows (code in the API), in the site's language. |
#' | value | double | Numeric value of the statistic; null when the API sends a duration or text (see value_text). |
#' | value_text | character | Non-numeric statistic value, e.g. an ISO 8601 duration such as PT12M2S for minutes per game. |
#' @eval .intl_details(.atrium_fixtures_details)
#' @family Atrium Functions
#' @export
#' @examples
#' \donttest{
#'   try(atrium_team_stats(
#'     website_id = 12, season = 2026, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"
#'   ))
#' }
atrium_team_stats <- function(website_id, season = NULL, season_id = NULL, competition_id = NULL, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "statistics_entities", list(
    season = season, seasonId = season_id, competitionId = competition_id, locale = locale
  ))
  .atrium_data(.atrium_parse_stat_tables(raw), "team stats")
}

#' @title
#' **Atrium Competition Player Stats (long form)**
#' @description
#' **Player statistics of a competition in long form (names only: the bodies carry no
#' ids).**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/statistics_competition_persons`
#' @inheritParams atrium_fixtures
#' @param competition_id (*character* required): Competition UUID (`competition_id` in
#'   [atrium_seasons()]), e.g. `"3f4064bb-51ad-11f0-aaaf-2923c944b404"`.
#' @return A `hoopR_data` tibble, one row per `(table_key, person_name, stat_key)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the table; null for the competition-scoped routes (their bodies carry none). |
#' | table_key | character | Statistics table the row is from: averages, shootingstatistics, totals, ... (the set is per site). |
#' | table_label | character | The table's heading in the site's language (e.g. Moyennes). |
#' | person_id | character | Player UUID decoded from the widget link beside the name (the tables carry names only); null when the link is missing or undecodable, and always null in team and competition bodies. |
#' | person_name | character | Player name as the site prints it; null in team tables. |
#' | entity_id | character | Team UUID decoded from the widget link (team tables only; player tables name the team but carry no id). |
#' | entity_name | character | Team name as the site prints it; for player rows of a stat table it is the player's team. |
#' | stat_key | character | Statistic key as the API names it (pointsPerGame, fieldGoalsMade, ...), unchanged from header key. |
#' | stat_name | character | Short column heading the site shows for the statistic (PTS, REB), in the site's language. |
#' | stat_label | character | Longer statistic label the site shows (code in the API), in the site's language. |
#' | value | double | Numeric value of the statistic; null when the API sends a duration or text (see value_text). |
#' | value_text | character | Non-numeric statistic value, e.g. an ISO 8601 duration such as PT12M2S for minutes per game. |
#' @eval .intl_details(.atrium_fixtures_details, c(
#'   'atrium_competition_player_stats(',
#'   '  website_id = 12, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"',
#'   ')'
#' ))
#' @family Atrium Functions
#' @export
atrium_competition_player_stats <- function(website_id, competition_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "statistics_competition_persons", list(competitionId = competition_id, locale = locale))
  .atrium_data(.atrium_parse_stat_tables(raw), "competition player stats")
}

#' @title
#' **Atrium Competition Team Stats (long form)**
#' @description
#' **Team statistics of a competition in long form (names only: the bodies carry no
#' ids).**
#'
#' Endpoint: `GET https://embed-api.eui.connect.sportradar.com/v1/embed/{website_id}/statistics_competition_entities`
#' @inheritParams atrium_competition_player_stats
#' @return A `hoopR_data` tibble, one row per `(table_key, entity_name, stat_key)`:
#'
#' | col_name | type | description |
#' |---|---|---|
#' | website_id | integer | Site config id the body came from (12 LNB, 14 LNBP, 3 NBL1, 13 El Salvador, 22 Panama, 236 Austria, 326 Montenegro), read from the body's links.self. |
#' | season_id | character | Season UUID of the table; null for the competition-scoped routes (their bodies carry none). |
#' | table_key | character | Statistics table the row is from: averages, shootingstatistics, totals, ... (the set is per site). |
#' | table_label | character | The table's heading in the site's language (e.g. Moyennes). |
#' | person_id | character | Player UUID decoded from the widget link beside the name (the tables carry names only); null when the link is missing or undecodable, and always null in team and competition bodies. |
#' | person_name | character | Player name as the site prints it; null in team tables. |
#' | entity_id | character | Team UUID decoded from the widget link (team tables only; player tables name the team but carry no id). |
#' | entity_name | character | Team name as the site prints it; for player rows of a stat table it is the player's team. |
#' | stat_key | character | Statistic key as the API names it (pointsPerGame, fieldGoalsMade, ...), unchanged from header key. |
#' | stat_name | character | Short column heading the site shows for the statistic (PTS, REB), in the site's language. |
#' | stat_label | character | Longer statistic label the site shows (code in the API), in the site's language. |
#' | value | double | Numeric value of the statistic; null when the API sends a duration or text (see value_text). |
#' | value_text | character | Non-numeric statistic value, e.g. an ISO 8601 duration such as PT12M2S for minutes per game. |
#' @eval .intl_details(.atrium_fixtures_details, c(
#'   'atrium_competition_team_stats(',
#'   '  website_id = 12, competition_id = "3f4064bb-51ad-11f0-aaaf-2923c944b404"',
#'   ')'
#' ))
#' @family Atrium Functions
#' @export
atrium_competition_team_stats <- function(website_id, competition_id, locale = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .atrium_get(website_id, "statistics_competition_entities", list(competitionId = competition_id, locale = locale))
  .atrium_data(.atrium_parse_stat_tables(raw), "competition team stats")
}

#' @title
#' **Atrium Season Id**
#' @description
#' **The `seasonId` of a site's season, from its END year and optionally its
#' competition.**
#'
#' Maps through the site's own season list (`/{website_id}/fixtures`), fetched once and
#' cached for an hour per site.
#' @param website_id (*integer* required): The site (12 LNB, 14 LNBP, 3 NBL1, 13 El
#'   Salvador, 22 Panama, 326 Montenegro). Site 236 lists no seasons.
#' @param season (*integer* required): The sdv season END year (2026 = 2025-26 on LNB;
#'   the calendar year on the other sites). A whole number; a string, a logical or a
#'   fraction is refused.
#' @param competition_id (*character* optional): The competition when the site lists
#'   several for that year (see [atrium_seasons()]). Omit it when the year is unique.
#' @return The season's UUID (a character string), for the `season_id` argument of
#'   every season-scoped wrapper.
#' @details
#' Raises `hoopR_bad_request` when `season` is not a whole number, the site is not a
#' known Atrium site, it lists no seasons (236), or the year is shared by several
#' competitions and `competition_id` is missing; `hoopR_no_data` when the site lists no
#' such season; `hoopR_asset_fetch` when the season list could not be fetched or is
#' not the site's.
#'
#' ```r
#'  atrium_season_id(14, 2026, competition_id = "16be8396-24fb-11ef-9ab7-df6be196e88f")
#' ```
#' @family Atrium Functions
#' @export
atrium_season_id <- function(website_id, season, competition_id = NULL) {
  .atrium_season_id(website_id, season, competition_id)
}

#' @noRd
.atrium_season_id <- function(website_id, season, competition_id = NULL, call = rlang::caller_env()) {
  if (!.atrium_whole(season)) {
    shown <- if (is.null(season)) "NULL" else format(season)
    .abort_bad_request("{.arg season} must be the END year as a whole number; got {.val {shown}}.", call = call)
  }
  kind <- if (.atrium_whole(website_id)) .atrium_sites[[as.character(as.integer(website_id))]] else NULL
  if (is.null(kind)) {
    known <- paste(sort(as.integer(names(.atrium_sites))), collapse = ", ")
    .abort_bad_request(paste0("website_id {.val {format(website_id)}} is not a known Atrium site ({known}): its season ",
                              "year cannot be mapped to an END year, so pass {.arg season_id} instead."), call = call)
  }
  if (is.na(kind$year)) {
    .abort_bad_request("Atrium site {website_id} lists no seasons: pass {.arg season_id}, or no season for its current one.",
                       call = call)
  }
  rows <- .atrium_fetch_seasons(as.integer(website_id), call = call)
  keep <- !is.na(rows$season_end_year) & rows$season_end_year == season &
    (if (is.null(competition_id)) TRUE else rows$competition_id %in% competition_id)
  rows <- rows[keep, ]
  if (!nrow(rows)) {
    which <- if (is.null(competition_id)) "" else paste0(" for competition ", competition_id)
    .abort_no_data("Atrium site {website_id} lists no season with END year {season}{which}.", call = call)
  }
  if (nrow(rows) > 1L) {
    names <- paste0(utils::head(rows$competition_name, 8), " (", utils::head(rows$competition_id, 8), ")", collapse = "; ")
    more <- if (nrow(rows) > 8L) "; ..." else ""
    .abort_bad_request(paste0("END year {season} is ambiguous on Atrium site {website_id}: {nrow(rows)} seasons ",
                              "({names}{more}). Pass {.arg competition_id} (see {.fn atrium_seasons}) or {.arg season_id}."),
                       call = call)
  }
  rows$season_id[[1]]
}

#' @title
#' **Atrium END Year**
#' @description
#' **The sdv season key (END year) of a site's own `year`, or `NA` when it cannot be
#' mapped.**
#' @param website_id (*integer* required): The site (12 LNB, 14 LNBP, 3 NBL1, 13 El
#'   Salvador, 22 Panama, 236 Austria, 326 Montenegro).
#' @param year (*integer* required): The `year` of a site's season list (START year on
#'   site 12, the calendar year elsewhere); a vector is mapped element by element.
#' @return An integer vector: `year + 1` on site 12 (2025 -> 2026 = 2025-26), `year` on
#'   the calendar-year sites, `NA` for an unregistered site, site 236 (no season list)
#'   or a value that is not a whole number.
#' @family Atrium Functions
#' @export
#' @examples
#' atrium_end_year(12, 2025)
#' atrium_end_year(14, 2026)
atrium_end_year <- function(website_id, year) {
  vapply(as.list(year), function(y) .atrium_end_year1(website_id, y), integer(1))
}
