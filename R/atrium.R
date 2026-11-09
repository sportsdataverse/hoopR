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
#' @eval .returns_rd("atrium_fixtures", inline = FALSE, unit = "fixture")
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
#' @eval .returns_rd("atrium_seasons", inline = FALSE, unit = "season")
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
#' @eval .returns_rd("atrium_fixtures_ribbon", inline = FALSE, unit = "fixture")
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
#' @eval .returns_rd("atrium_fixture", inline = FALSE, unit = "game")
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
#' @eval .returns_rd("atrium_fixture_periods", inline = FALSE, unit = "(`fixture_id`, `period_id`)")
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
#' @eval .returns_rd("atrium_box_score", inline = FALSE, unit = "(`fixture_id`, `person_id`)")
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
#' @eval .returns_rd("atrium_team_box_score", inline = FALSE, unit = "(`fixture_id`, `entity_id`)")
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
#' @eval .returns_rd("atrium_pbp", inline = FALSE, unit = "event")
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
#' @eval .returns_rd("atrium_shots", inline = FALSE, unit = "shot")
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
#' @eval .returns_rd("atrium_standings", inline = FALSE, unit = "(`season_id`, `group`, `entity_id`)")
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
#' @eval .returns_rd("atrium_standings_summary", inline = FALSE, unit = "(`season_id`, `group`, `entity_id`)")
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
#' @eval .returns_rd("atrium_teams", inline = FALSE, unit = "(`season_id`, `entity_id`)")
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
#' @eval .returns_rd("atrium_team", inline = FALSE, unit = "team")
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
#' @eval .returns_rd("atrium_players", inline = FALSE, unit = "(`season_id`, `person_id`)")
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
#' @eval .returns_rd("atrium_player", inline = FALSE, unit = "player")
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
#' @eval .returns_rd("atrium_player_seasons", inline = FALSE, unit = "(`person_id`, `season_name`, `team_id`)")
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
#' @eval .returns_rd("atrium_player_game_log", inline = FALSE, unit = "game")
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
#' @eval .returns_rd("atrium_leaders", inline = FALSE, unit = "(`season_id`, `stat_key`, `rank`)")
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
#' @eval .returns_rd("atrium_player_stats", inline = FALSE, unit = "(`table_key`, `person_id`, `stat_key`)")
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
#' @eval .returns_rd("atrium_team_stats", inline = FALSE, unit = "(`table_key`, `entity_name`, `stat_key`)")
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
#' @eval .returns_rd("atrium_competition_player_stats", inline = FALSE, unit = "(`table_key`, `person_name`, `stat_key`)")
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
#' @eval .returns_rd("atrium_competition_team_stats", inline = FALSE, unit = "(`table_key`, `entity_name`, `stat_key`)")
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
