# sportpress.R -- BNXT League (Belgium + the Netherlands) wrappers over the Sportpress CMS API
# (bnxt.sportpress.info/api/v1), at parity with sdv-py sportsdataverse/basketball/bnxt (origin/main e3d232e).
# Transport and refusals: R/sportpress_runtime.R; frames: R/sportpress_parsers.R.

# The @details of every sportpress topic that shares the sportpress_ui_strings() notes (roxygen @eval .intl_details()).
.sportpress_ui_strings_details <- c(
  "* Unofficial and unsupported: the Sportpress API is the JSON backend of bnxtleague.com, not a documented public",
  "  API. Every route needs a header key; it is public (hard-coded in the site bundle), `bnxt_runtime` reads it from",
  "  the bundle at run time, falls back to a documented value when the bundle cannot be read, and never prints or logs",
  "  it. A 401 raises AssetFetchError (`key rotated?`). robots.txt allows everything; requests are spaced at least 1 s",
  "  apart.",
  "* Season key: the END year (`season=2026` is 2025-26), the API's own key on the season routes. Every other route is",
  "  keyed by the competition id (one per season: 1 = 2021-22, 2 = 2020-21, 3 = 2022-23, 12 = 2023-24, 22 = 2024-25,",
  "  24 = 2025-26, 25 = 2026-27), the competition-team id (new every season; `uu_team_id` is the stable club), the",
  "  roster id (player x team x season) or the game id (unique across seasons). `sportpress_phases(season)` maps a",
  "  season to its competition id.",
  "* Coverage: schedule and rosters from 2021-22 (2020-21 is empty); box scores for 2021-22, 2024-25, 2025-26 and",
  "  2026-27 (2022-23 and 2023-24 answer empty); standings and averages for 2021-22 and 2024-25 on; play-by-play",
  "  ('film', with court x/y) for 2021-22 and 2026-27 only: for 2022-23 to 2025-26 use Genius play-by-play through",
  "  `genius_id` ([sportpress_game_slider()], organisation BNXT). The game routes (box score, film, overview) refuse a",
  "  game that is not finished (AssetFetchError).",
  "* Data notes: a team's box total can differ from the schedule final score on about 18 of 1,246 sampled team boxes",
  "  (mostly 2024-25, by 2-21 points); the frames report what the API serves. `nationality_code` is dirty (lower case,",
  "  `USA/BEL` pairs, empty, `HOL`). Names differ by language and sponsor: join on ids. Contact and social fields are",
  "  dropped; only a player's public birth date is kept. The sibling tenants sopron.sportpress.info and",
  "  beac.sportpress.info are not wrapped.",
  "* Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty `data` list: an unknown id or a season without",
  "  data, an empty ranking), `hoopR_bad_request` (an id or season that is not an integer, HTTP 400 / 422) and",
  "  `hoopR_asset_fetch` (a rejected key after one renewal, any other non-200, a non-JSON or empty body, an error or",
  "  changed envelope, a game that is not finished, a body for another season, competition, team or game), all",
  "  inheriting `hoopR_error`. Wrappers raise; they never return an empty frame for a failed request. Whole doubles",
  "  (`24`) are accepted for integer arguments."
)

#' @title
#' **Get BNXT League UI Strings**
#' @description
#' UI string tables of the site in English, French and Dutch (one row per language and key).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/server-config`
#' @return
#' A `hoopR_data` tibble: UI string tables of the site in English, French and Dutch (one row per language and key). An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_ui_strings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | language | character | ISO 639-1 code of the UI language: en, fr (French) or nl (Dutch). |
#' | key | character | Dotted UI string key such as 'statistics.individual.points'; 302 keys per language. |
#' | text | character | The UI text in that language; 11 keys label statistics columns, the rest are menus and buttons. |
#' @eval .intl_details(.sportpress_ui_strings_details, full = TRUE, "sportpress_ui_strings()")
#' @export
#' @family BNXT League Functions
sportpress_ui_strings <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "server_config",
    call = rlang::current_env()
  )
  .sportpress_parse("ui_strings", raw, "BNXT League UI Strings from Sportpress")
}

#' @title
#' **Get BNXT League Club Seasons**
#' @description
#' Seasons (END years) in which Belgian and Dutch clubs have teams.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/club/seasons`
#' @return
#' A `hoopR_data` tibble: Seasons (END years) in which Belgian and Dutch clubs have teams. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_club_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year in which the clubs (countries) have teams; includes 2021 = 2020-21. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_club_seasons())
#' }
#' @export
#' @family BNXT League Functions
sportpress_club_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "club_seasons",
    query = list(`clubs[0]` = 1L, `clubs[1]` = 2L),
    call = rlang::current_env()
  )
  .sportpress_parse("club_seasons", raw, "BNXT League Club Seasons from Sportpress")
}

#' @title
#' **Get BNXT League Referees**
#' @description
#' Referees of the league (staff title 2).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/staff/list`
#' @return
#' A `hoopR_data` tibble: Referees of the league (staff title 2). An empty valid answer raises `hoopR_no_data`; the
#'   columns are always these, in this order (sdv-py `sportpress_referees`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | staff_id | integer | Staff member id (key space: sportpress staff); the referees are title 2. |
#' | name | character | Referee name 'First Last' (free text). |
#' | title_id | integer | Staff title id: 1 = Head coach, 2 = Referee; Assistant coach has its own id. |
#' | title_name | character | Staff title in English: Head coach, Assistant coach or Referee. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_referees()")
#' @export
#' @family BNXT League Functions
sportpress_referees <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "staff_list",
    query = list(title_id = 2L),
    call = rlang::current_env()
  )
  .sportpress_parse("referees", raw, "BNXT League Referees from Sportpress")
}

#' @title
#' **Get BNXT League Phases**
#' @description
#' The competition of a season with its phases (regular season, playoffs, supercup).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/phase/season/{season}`
#' @param season (required) Season END year (2026 = 2025-26), the API's own key; no mapping is applied.
#' @return
#' A `hoopR_data` tibble: The competition of a season with its phases (regular season, playoffs, supercup). An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_phases`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | competition_name | character | Competition name, 'BNXT League 2025-2026'. |
#' | phase_id | integer | Phase id (key space: sportpress phases); the `{phaseId}` of the standings route. New every season. |
#' | phase_name | character | Phase name as entered in the CMS; names differ every season. |
#' | standings_visible | logical | Whether the phase shows standings; false for playoff phases, which answer the standings route empty. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_phases(season = 2026))
#' }
#' @export
#' @family BNXT League Functions
sportpress_phases <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "phase_season",
    ids = list(season = season),
    call = rlang::current_env()
  )
  .sportpress_parse("phases", raw, "BNXT League Phases from Sportpress")
}

#' @title
#' **Get BNXT League Competition Teams**
#' @description
#' Every competition team of one competition: ids, names and country.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/all`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @return
#' A `hoopR_data` tibble: Every competition team of one competition: ids, names and country. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_competition_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id the team plays in (key space: sportpress competitions); the competition_id the route was asked for. |
#' | season | integer | Season END year of the team's competition. |
#' | uu_team_id | integer | Stable club key across seasons (key space: sportpress clubs-as-teams); competition_team_id changes every season, this does not. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
#' | club_name | character | Country name in English, Belgium or Netherlands. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_competition_teams(competition_id = 24))
#' }
#' @export
#' @family BNXT League Functions
sportpress_competition_teams <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "competition_teams",
    query = list(competition_id = competition_id),
    call = rlang::current_env()
  )
  .sportpress_parse("competition_teams", raw, "BNXT League Competition Teams from Sportpress")
}

#' @title
#' **Get BNXT League Competition Staff**
#' @description
#' Coaching staff (head coach, assistants) of every competition team of one competition.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/all`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @return
#' A `hoopR_data` tibble: Coaching staff (head coach, assistants) of every competition team of one competition. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_competition_staff`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id of the team the staff member works for. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | staff_id | integer | Staff member id (key space: sportpress staff). |
#' | name | character | Staff member name 'First Last' (free text). |
#' | title_id | integer | Staff title id: 1 = Head coach; Assistant coach has its own id. |
#' | title_name | character | Staff title in English: Head coach or Assistant coach. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_competition_staff(competition_id = 24)")
#' @export
#' @family BNXT League Functions
sportpress_competition_staff <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "competition_teams",
    query = list(competition_id = competition_id),
    call = rlang::current_env()
  )
  .sportpress_parse("competition_staff", raw, "BNXT League Competition Staff from Sportpress")
}

#' @title
#' **Get BNXT League Standings**
#' @description
#' Standings of one phase of a competition: record, points, home/away split, last five and streak.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/standings/competition/{competition_id}/phase/{phase_id}`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @param phase_id (required) Phase id (integer) of the competition, from [sportpress_phases()] (`phase_id`).
#' @return
#' A `hoopR_data` tibble: Standings of one phase of a competition: record, points, home/away split, last five and
#'   streak. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
#' | club_name | character | Country name in English, Belgium or Netherlands. |
#' | position | integer | Rank in the table, 1 = first. |
#' | played | integer | Games played in the phase (win + loss + even). |
#' | win | integer | Games won in the phase. |
#' | loss | integer | Games lost in the phase. |
#' | even | integer | Games drawn; 0 in every sample (basketball has no draws). |
#' | score | integer | Points scored in the phase. |
#' | against | integer | Points conceded in the phase. |
#' | score_difference | integer | score - against. |
#' | percent | double | Win percentage 0-100, rounded to 1 decimal. |
#' | point | integer | League points: 2 per win plus 1 per loss. |
#' | point_percent | double | Share of the possible league points won, 0-1 rounded to 2 decimals. |
#' | home_win | integer | Wins in home games. |
#' | home_loss | integer | Losses in home games. |
#' | away_win | integer | Wins in away games. |
#' | away_loss | integer | Losses in away games. |
#' | last5_win | integer | Wins among the last five games. |
#' | last5_loss | integer | Losses among the last five games. |
#' | streak_is_win | logical | True for a winning streak, false for a losing one. |
#' | streak_count | integer | Length of the current streak in games. |
#' | group | character | Group label for split phases; null in every sample. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_standings(competition_id = 24, phase_id = 169))
#' }
#' @export
#' @family BNXT League Functions
sportpress_standings <- function(competition_id, phase_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "standings",
    ids = list(competition_id = competition_id, phase_id = phase_id),
    call = rlang::current_env()
  )
  .sportpress_parse("standings", raw, "BNXT League Standings from Sportpress")
}

#' @title
#' **Get BNXT League Schedule**
#' @description
#' Every game of a season for Belgian and Dutch clubs, with teams, scores, phase and venue.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/schedule/club/{season}`
#' @param season (required) Season END year (2026 = 2025-26), the API's own key; no mapping is applied.
#' @param month (default `-1`) Calendar month filter; -1 (default) = the whole season in one body.
#' @param phase_id (default `NULL`) Restrict to one phase (integer), from [sportpress_phases()]. Omitted = every
#'   phase.
#' @return
#' A `hoopR_data` tibble: Every game of a season for Belgian and Dutch clubs, with teams, scores, phase and venue. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_schedule`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
#' | game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
#' | status | character | Game status: finished, or ready for an upcoming game. |
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | season | integer | Season END year of the game's competition. |
#' | phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
#' | phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
#' | round_name | character | Round label as entered in the CMS; often empty. |
#' | round_priority | integer | Sort order of the round within the phase (provider's priority); meaning of the values is unverified. |
#' | period_name | character | Name of the period the game is in or ended in; 'Extra2' means the second overtime. |
#' | arena | character | Name of the arena where the game is played. |
#' | home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | home_score | integer | Home side. Final points of the side, including overtime. |
#' | away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | away_score | integer | Away side. Final points of the side, including overtime. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_schedule(season = 2026))
#' }
#' @export
#' @family BNXT League Functions
sportpress_schedule <- function(season, month = -1, phase_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "schedule_club",
    ids = list(season = season),
    query = list(`clubs[0]` = 1L, `clubs[1]` = 2L, month = month, phase_id = phase_id),
    call = rlang::current_env()
  )
  .sportpress_parse("schedule", raw, "BNXT League Schedule from Sportpress")
}

#' @title
#' **Get BNXT League Game Slider**
#' @description
#' The latest 14 finished games of a competition plus every upcoming game, with the Genius match id.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/schedule/game-slider/{competition_id}`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @return
#' A `hoopR_data` tibble: The latest 14 finished games of a competition plus every upcoming game, with the Genius
#'   match id. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_game_slider`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
#' | genius_id | integer | Genius Sports LiveStats match id (organisation BNXT): the join to the genius family. Upcoming games already carry one; null for the 2020-21 competition. |
#' | game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
#' | status | character | Game status: finished, or ready for an upcoming game. |
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
#' | phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
#' | phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
#' | home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | home_score | integer | Home side. Final points of the side, including overtime. |
#' | away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | away_score | integer | Away side. Final points of the side, including overtime. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_game_slider(competition_id = 25)")
#' @export
#' @family BNXT League Functions
sportpress_game_slider <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "game_slider",
    ids = list(competition_id = competition_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_slider", raw, "BNXT League Game Slider from Sportpress")
}

#' @title
#' **Get BNXT League Team Rankings**
#' @description
#' Team per-game leaders in nine categories (one row per team and category).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/average-rankings/{competition_id}`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @param phase_id (default `NULL`) Restrict to one phase (integer), from [sportpress_phases()]. Omitted = every
#'   phase.
#' @param limit (default `NULL`) Cap each ranking list at this many rows. Omitted = the complete lists.
#' @return
#' A `hoopR_data` tibble: Team per-game leaders in nine categories (one row per team and category). An empty valid
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_team_rankings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | category | character | Ranking category: efficiency, points, total_rebound, block, assist, steal, two_point_percent, three_point_percent or free_throw_percent. |
#' | rank | integer | Place in the category list, 1 = the leader (the list is sorted best first). |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | value | double | The team's per-game mean (or percentage 0-100) in the row's category. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_team_rankings(competition_id = 24))
#' }
#' @export
#' @family BNXT League Functions
sportpress_team_rankings <- function(competition_id, phase_id = NULL, limit = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "team_rankings",
    ids = list(competition_id = competition_id),
    query = list(phase_id = phase_id, limit = limit),
    call = rlang::current_env()
  )
  .sportpress_parse("team_rankings", raw, "BNXT League Team Rankings from Sportpress")
}

#' @title
#' **Get BNXT League Player Rankings**
#' @description
#' Qualified-player per-game leaders in nine categories (one row per player and category).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/player/average-rankings/{competition_id}`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @param phase_id (default `NULL`) Restrict to one phase (integer), from [sportpress_phases()]. Omitted = every
#'   phase.
#' @param limit (default `NULL`) Cap each ranking list at this many rows. Omitted = the complete lists.
#' @param type (default `NULL`) Return one ranking category only (e.g. `points`); `all` or omitted = the nine
#'   categories.
#' @return
#' A `hoopR_data` tibble: Qualified-player per-game leaders in nine categories (one row per player and category). An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_player_rankings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | category | character | Ranking category: efficiency, points, total_rebound, block, assist, steal, two_point_percent, three_point_percent or free_throw_percent. |
#' | rank | integer | Place in the category list, 1 = the leader (the list is sorted best first). |
#' | roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | value | double | The player's per-game mean (or percentage 0-100) in the row's category. |
#' | throw_made | double | Field goals made per game; filled in the three percentage categories only. |
#' | throw_attempted | double | Field goals attempted per game; filled in the three percentage categories only. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_player_rankings(competition_id = 24))
#' }
#' @export
#' @family BNXT League Functions
sportpress_player_rankings <- function(competition_id, phase_id = NULL, limit = NULL, type = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "player_rankings",
    ids = list(competition_id = competition_id),
    query = list(phase_id = phase_id, limit = limit, type = type),
    call = rlang::current_env()
  )
  .sportpress_parse("player_rankings", raw, "BNXT League Player Rankings from Sportpress")
}

#' @title
#' **Get BNXT League Season Roster**
#' @description
#' Every roster entry of a season: player, team, jersey, height, weight and position.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/roster/season-players/{season}`
#' @param season (required) Season END year (2026 = 2025-26), the API's own key; no mapping is applied.
#' @return
#' A `hoopR_data` tibble: Every roster entry of a season: player, team, jersey, height, weight and position. An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_season_roster`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year the roster was asked for. |
#' | roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
#' | weight | integer | Weight in kg; null when unknown. |
#' | height | integer | Height in cm; null when unknown. |
#' | active | logical | True for a current roster entry; the lists hold current entries only. |
#' | position_id | integer | Position id (key space: sportpress positions; 3 = small_forward). |
#' | position | character | Position code: point_guard, shooting_guard, small_forward, power_forward, center, and the hybrids point_guard-shooting_guard, shooting_guard-small_forward, small_forward-power_forward, power_forward-center. |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_season_roster(season = 2026))
#' }
#' @export
#' @family BNXT League Functions
sportpress_season_roster <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "season_players",
    ids = list(season = season),
    call = rlang::current_env()
  )
  .sportpress_parse("season_roster", raw, "BNXT League Season Roster from Sportpress")
}

#' @title
#' **Get BNXT League Nationality Codes**
#' @description
#' Distinct player nationality codes of a season (dirty: lower case, pairs, empty).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/roster/season-nationality-codes/{season}`
#' @param season (required) Season END year (2026 = 2025-26), the API's own key; no mapping is applied.
#' @return
#' A `hoopR_data` tibble: Distinct player nationality codes of a season (dirty: lower case, pairs, empty). An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_nationality_codes`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year the codes were asked for. |
#' | nationality_code | character | A distinct nationality code of the season's players, as served (dirty). |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_nationality_codes(season = 2026)")
#' @export
#' @family BNXT League Functions
sportpress_nationality_codes <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "nationality_codes",
    ids = list(season = season),
    call = rlang::current_env()
  )
  .sportpress_parse("nationality_codes", raw, "BNXT League Nationality Codes from Sportpress")
}

#' @title
#' **Get BNXT League Team Roster**
#' @description
#' Roster of one competition team (current entries only).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/roster/team-players/{competition_team_id}`
#' @param competition_team_id (required) Competition-team id (integer): a team in ONE competition, so new every season
#'   (e.g. 541 = Antwerp in 2026-27); from [sportpress_competition_teams()].
#' @return
#' A `hoopR_data` tibble: Roster of one competition team (current entries only). An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_team_roster`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
#' | weight | integer | Weight in kg; null when unknown. |
#' | height | integer | Height in cm; null when unknown. |
#' | active | logical | True for a current roster entry; the lists hold current entries only. |
#' | position_id | integer | Position id (key space: sportpress positions; 3 = small_forward). |
#' | position | character | Position code: point_guard, shooting_guard, small_forward, power_forward, center, and the hybrids point_guard-shooting_guard, shooting_guard-small_forward, small_forward-power_forward, power_forward-center. |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_roster(competition_team_id = 541)")
#' @export
#' @family BNXT League Functions
sportpress_team_roster <- function(competition_team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "team_players",
    ids = list(competition_team_id = competition_team_id),
    call = rlang::current_env()
  )
  .sportpress_parse("team_roster", raw, "BNXT League Team Roster from Sportpress")
}

#' @title
#' **Get BNXT League Team**
#' @description
#' One competition team with its season scoring averages.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/find/{competition_team_id}`
#' @param competition_team_id (required) Competition-team id (integer): a team in ONE competition, so new every season
#'   (e.g. 541 = Antwerp in 2026-27); from [sportpress_competition_teams()].
#' @return
#' A `hoopR_data` tibble: One competition team with its season scoring averages. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_team_find`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | season | integer | Season END year of the team's competition. |
#' | competition_name | character | Competition name, 'BNXT League 2026-2027'. |
#' | uu_team_id | integer | Stable club key across seasons (key space: sportpress clubs-as-teams); competition_team_id changes every season, this does not. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
#' | club_name | character | Country name in English, Belgium or Netherlands. |
#' | average_score_for | double | Points scored per game by the team over the season; null for a team with no statistics. |
#' | average_score_against | double | Points conceded per game; null for a team with no statistics. |
#' | field_goal_percent | double | Team field-goal percentage 0-100; null for a team with no statistics. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_find(competition_team_id = 541)")
#' @export
#' @family BNXT League Functions
sportpress_team_find <- function(competition_team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "team_find",
    ids = list(competition_team_id = competition_team_id),
    call = rlang::current_env()
  )
  .sportpress_parse("team_find", raw, "BNXT League Team from Sportpress")
}

#' @title
#' **Get BNXT League Team Player Averages**
#' @description
#' Per-game averages of each player of a competition team.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/player-averages/{competition_team_id}`
#' @param competition_team_id (required) Competition-team id (integer): a team in ONE competition, so new every season
#'   (e.g. 541 = Antwerp in 2026-27); from [sportpress_competition_teams()].
#' @return
#' A `hoopR_data` tibble: Per-game averages of each player of a competition team. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_team_player_averages`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' | played_games | integer | Games the player played in the season. |
#' | games_started | integer | Games started (a count, not a mean). |
#' | minute | double | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). Per-game mean over the games played (fractional). |
#' | foul | double | Personal fouls committed. Per-game mean over the games played (fractional). |
#' | defensive_foul | double | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. Per-game mean over the games played (fractional). |
#' | dunk_made | double | Dunks made (a subset of the two-point field goals). Per-game mean over the games played (fractional). |
#' | dunk_all | double | Dunks attempted. Per-game mean over the games played (fractional). |
#' | dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. Per-game mean over the games played (fractional). |
#' | two_point_made | double | Two-point field goals made. Per-game mean over the games played (fractional). |
#' | two_point_all | double | Two-point field goals attempted. Per-game mean over the games played (fractional). |
#' | two_point_percent | double | Two-point percentage 0-100. Per-game mean over the games played (fractional). |
#' | three_point_made | double | Three-point field goals made. Per-game mean over the games played (fractional). |
#' | three_point_all | double | Three-point field goals attempted. Per-game mean over the games played (fractional). |
#' | three_point_percent | double | Three-point percentage 0-100. Per-game mean over the games played (fractional). |
#' | throw_made | double | All field goals made, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
#' | throw_all | double | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
#' | throw_percent | double | Field-goal percentage 0-100. Per-game mean over the games played (fractional). |
#' | free_throw_made | double | Free throws made. Per-game mean over the games played (fractional). |
#' | free_throw_all | double | Free throws attempted. Per-game mean over the games played (fractional). |
#' | free_throw_percent | double | Free-throw percentage 0-100. Per-game mean over the games played (fractional). |
#' | offensive_rebound | double | Offensive rebounds. Per-game mean over the games played (fractional). |
#' | defensive_rebound | double | Defensive rebounds. Per-game mean over the games played (fractional). |
#' | total_rebound | double | Total rebounds (offensive plus defensive). Per-game mean over the games played (fractional). |
#' | block | double | Shots blocked by the player. Per-game mean over the games played (fractional). |
#' | block_against | double | Own shots blocked by an opponent. Per-game mean over the games played (fractional). |
#' | turnover | double | Turnovers committed. Per-game mean over the games played (fractional). |
#' | steal | double | Steals (balls taken from an opponent). Per-game mean over the games played (fractional). |
#' | assist | double | Assists (passes leading directly to a made basket). Per-game mean over the games played (fractional). |
#' | points | double | Points scored (2 x two-pointers + 3 x three-pointers + free throws). Per-game mean over the games played (fractional). |
#' | value | double | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. Per-game mean over the games played (fractional). |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_player_averages(competition_team_id = 541)")
#' @export
#' @family BNXT League Functions
sportpress_team_player_averages <- function(competition_team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "player_averages",
    ids = list(competition_team_id = competition_team_id),
    call = rlang::current_env()
  )
  .sportpress_parse("team_player_averages", raw, "BNXT League Team Player Averages from Sportpress")
}

#' @title
#' **Get BNXT League Team Games**
#' @description
#' Every finished game of a competition team with that team's totals.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/statistics-by-game/total/{competition_team_id}`
#' @param competition_team_id (required) Competition-team id (integer): a team in ONE competition, so new every season
#'   (e.g. 541 = Antwerp in 2026-27); from [sportpress_competition_teams()].
#' @return
#' A `hoopR_data` tibble: Every finished game of a competition team with that team's totals. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_team_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_team_id | integer | Competition-team id the games were asked for (the team the totals belong to). |
#' | game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
#' | game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
#' | status | character | Game status: finished, or ready for an upcoming game. |
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | season | integer | Season END year of the game's competition. |
#' | phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
#' | phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
#' | round_name | character | Round label as entered in the CMS; often empty. |
#' | round_priority | integer | Sort order of the round within the phase (provider's priority); meaning of the values is unverified. |
#' | period_name | character | Name of the period the game is in or ended in; 'Extra2' means the second overtime. |
#' | arena | character | Name of the arena where the game is played. |
#' | home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | home_score | integer | Home side. Final points of the side, including overtime. |
#' | away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | away_score | integer | Away side. Final points of the side, including overtime. |
#' | minute | integer | The team's own minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
#' | foul | integer | The team's own personal fouls committed. |
#' | defensive_foul | integer | The team's own fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
#' | dunk_made | integer | The team's own dunks made (a subset of the two-point field goals). |
#' | dunk_all | integer | The team's own dunks attempted. |
#' | dunk_percent | double | The team's own dunk percentage 0-100; 0 when none were attempted. |
#' | two_point_made | integer | The team's own two-point field goals made. |
#' | two_point_all | integer | The team's own two-point field goals attempted. |
#' | two_point_percent | double | The team's own two-point percentage 0-100. |
#' | three_point_made | integer | The team's own three-point field goals made. |
#' | three_point_all | integer | The team's own three-point field goals attempted. |
#' | three_point_percent | double | The team's own three-point percentage 0-100. |
#' | throw_made | integer | The team's own all field goals made, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_all | integer | The team's own all field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_percent | double | The team's own field-goal percentage 0-100. |
#' | free_throw_made | integer | The team's own free throws made. |
#' | free_throw_all | integer | The team's own free throws attempted. |
#' | free_throw_percent | double | The team's own free-throw percentage 0-100. |
#' | offensive_rebound | integer | The team's own offensive rebounds. |
#' | defensive_rebound | integer | The team's own defensive rebounds. |
#' | total_rebound | integer | The team's own total rebounds (offensive plus defensive). |
#' | block | integer | The team's own shots blocked by the player. |
#' | block_against | integer | The team's own own shots blocked by an opponent. |
#' | turnover | integer | The team's own turnovers committed. |
#' | steal | integer | The team's own steals (balls taken from an opponent). |
#' | assist | integer | The team's own assists (passes leading directly to a made basket). |
#' | points | integer | The team's own points scored (2 x two-pointers + 3 x three-pointers + free throws). |
#' | value | integer | The team's own efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
#' | plusminus | integer | The team's own plus/minus: the score margin while the player (or team) was on court; for a team total it is the game margin. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_games(competition_team_id = 541)")
#' @export
#' @family BNXT League Functions
sportpress_team_games <- function(competition_team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "team_games",
    ids = list(competition_team_id = competition_team_id),
    call = rlang::current_env()
  )
  .sportpress_parse("team_games", raw, "BNXT League Team Games from Sportpress")
}

#' @title
#' **Get BNXT League Roster Entry**
#' @description
#' One roster entry with its player, team and season.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/roster/find/{roster_id}`
#' @param roster_id (required) Roster id (integer): one player on one team in one season; from the roster frames.
#' @return
#' A `hoopR_data` tibble: One roster entry with its player, team and season. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_roster_find`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
#' | weight | integer | Weight in kg; null when unknown. |
#' | height | integer | Height in cm; null when unknown. |
#' | active | logical | True for a current roster entry; former entries are false. |
#' | position_id | integer | Position id (key space: sportpress positions; 3 = small_forward). |
#' | position | character | Position code: point_guard, shooting_guard, small_forward, power_forward, center, and the hybrids point_guard-shooting_guard, shooting_guard-small_forward, small_forward-power_forward, power_forward-center. |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' | uu_team_id | integer | Stable club key across seasons of the team. |
#' | team | character | Team display name including the sponsor. |
#' | team_short_name | character | Three-letter club code of the team. |
#' | competition_id | integer | Competition id the roster entry's team plays in. |
#' | season | integer | Season END year of the roster entry's competition. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_roster_find(roster_id = 11193)")
#' @export
#' @family BNXT League Functions
sportpress_roster_find <- function(roster_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "roster_find",
    ids = list(roster_id = roster_id),
    call = rlang::current_env()
  )
  .sportpress_parse("roster_find", raw, "BNXT League Roster Entry from Sportpress")
}

#' @title
#' **Get BNXT League Player Career**
#' @description
#' Season-by-season per-game averages of the player of a roster entry.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/player/career-averages/{roster_id}`
#' @param roster_id (required) Roster id (integer): one player on one team in one season; from the roster frames.
#' @return
#' A `hoopR_data` tibble: Season-by-season per-game averages of the player of a roster entry. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_player_career`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | roster_id | integer | Roster id the career was asked for; the rows are the person's seasons, each with its own roster. |
#' | competition_id | integer | Competition id of the season row. |
#' | season | integer | Season END year of the row. |
#' | competition_name | character | Competition name of the season row. |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
#' | club_name | character | Country name in English, Belgium or Netherlands. |
#' | position | character | Playing position; null in every sample. |
#' | jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
#' | played_games | integer | Games played in the season. |
#' | games_started | integer | Games started (a count, not a mean). |
#' | minute | double | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). Per-game mean over the games played (fractional). |
#' | foul | double | Personal fouls committed. Per-game mean over the games played (fractional). |
#' | defensive_foul | double | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. Per-game mean over the games played (fractional). |
#' | dunk_made | double | Dunks made (a subset of the two-point field goals). Per-game mean over the games played (fractional). |
#' | dunk_all | double | Dunks attempted. Per-game mean over the games played (fractional). |
#' | dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. Per-game mean over the games played (fractional). |
#' | two_point_made | double | Two-point field goals made. Per-game mean over the games played (fractional). |
#' | two_point_all | double | Two-point field goals attempted. Per-game mean over the games played (fractional). |
#' | two_point_percent | double | Two-point percentage 0-100. Per-game mean over the games played (fractional). |
#' | three_point_made | double | Three-point field goals made. Per-game mean over the games played (fractional). |
#' | three_point_all | double | Three-point field goals attempted. Per-game mean over the games played (fractional). |
#' | three_point_percent | double | Three-point percentage 0-100. Per-game mean over the games played (fractional). |
#' | throw_made | double | All field goals made, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
#' | throw_all | double | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
#' | throw_percent | double | Field-goal percentage 0-100. Per-game mean over the games played (fractional). |
#' | free_throw_made | double | Free throws made. Per-game mean over the games played (fractional). |
#' | free_throw_all | double | Free throws attempted. Per-game mean over the games played (fractional). |
#' | free_throw_percent | double | Free-throw percentage 0-100. Per-game mean over the games played (fractional). |
#' | offensive_rebound | double | Offensive rebounds. Per-game mean over the games played (fractional). |
#' | defensive_rebound | double | Defensive rebounds. Per-game mean over the games played (fractional). |
#' | total_rebound | double | Total rebounds (offensive plus defensive). Per-game mean over the games played (fractional). |
#' | block | double | Shots blocked by the player. Per-game mean over the games played (fractional). |
#' | block_against | double | Own shots blocked by an opponent. Per-game mean over the games played (fractional). |
#' | turnover | double | Turnovers committed. Per-game mean over the games played (fractional). |
#' | steal | double | Steals (balls taken from an opponent). Per-game mean over the games played (fractional). |
#' | assist | double | Assists (passes leading directly to a made basket). Per-game mean over the games played (fractional). |
#' | points | double | Points scored (2 x two-pointers + 3 x three-pointers + free throws). Per-game mean over the games played (fractional). |
#' | value | double | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. Per-game mean over the games played (fractional). |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_player_career(roster_id = 11193)")
#' @export
#' @family BNXT League Functions
sportpress_player_career <- function(roster_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "player_career",
    ids = list(roster_id = roster_id),
    call = rlang::current_env()
  )
  .sportpress_parse("player_career", raw, "BNXT League Player Career from Sportpress")
}

#' @title
#' **Get BNXT League Player Games**
#' @description
#' Game-by-game box lines of a roster entry (including games with 0 minutes).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/boxscore/player/season-games/{roster_id}`
#' @param roster_id (required) Roster id (integer): one player on one team in one season; from the roster frames.
#' @return
#' A `hoopR_data` tibble: Game-by-game box lines of a roster entry (including games with 0 minutes). An empty valid
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_player_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | roster_id | integer | Roster id the lines were asked for. |
#' | game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
#' | game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
#' | status | character | Game status: finished, or ready for an upcoming game. |
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | season | integer | Season END year of the game's competition. |
#' | phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
#' | phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
#' | round_name | character | Round label as entered in the CMS; often empty. |
#' | round_priority | integer | Sort order of the round within the phase (provider's priority); meaning of the values is unverified. |
#' | period_name | character | Name of the period the game is in or ended in; 'Extra2' means the second overtime. |
#' | arena | character | Name of the arena where the game is played. |
#' | home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | home_score | integer | Home side. Final points of the side, including overtime. |
#' | away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | away_score | integer | Away side. Final points of the side, including overtime. |
#' | competition_team_id | integer | Competition-team id the player played for in the game. |
#' | starter | logical | True when the player started the game. |
#' | jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
#' | minute | integer | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
#' | foul | integer | Personal fouls committed. |
#' | defensive_foul | integer | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
#' | dunk_made | integer | Dunks made (a subset of the two-point field goals). |
#' | dunk_all | integer | Dunks attempted. |
#' | dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. |
#' | two_point_made | integer | Two-point field goals made. |
#' | two_point_all | integer | Two-point field goals attempted. |
#' | two_point_percent | double | Two-point percentage 0-100. |
#' | three_point_made | integer | Three-point field goals made. |
#' | three_point_all | integer | Three-point field goals attempted. |
#' | three_point_percent | double | Three-point percentage 0-100. |
#' | throw_made | integer | All field goals made, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_all | integer | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_percent | double | Field-goal percentage 0-100. |
#' | free_throw_made | integer | Free throws made. |
#' | free_throw_all | integer | Free throws attempted. |
#' | free_throw_percent | double | Free-throw percentage 0-100. |
#' | offensive_rebound | integer | Offensive rebounds. |
#' | defensive_rebound | integer | Defensive rebounds. |
#' | total_rebound | integer | Total rebounds (offensive plus defensive). |
#' | block | integer | Shots blocked by the player. |
#' | block_against | integer | Own shots blocked by an opponent. |
#' | turnover | integer | Turnovers committed. |
#' | steal | integer | Steals (balls taken from an opponent). |
#' | assist | integer | Assists (passes leading directly to a made basket). |
#' | points | integer | Points scored (2 x two-pointers + 3 x three-pointers + free throws). |
#' | value | integer | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_player_games(roster_id = 11193)")
#' @export
#' @family BNXT League Functions
sportpress_player_games <- function(roster_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "player_games",
    ids = list(roster_id = roster_id),
    call = rlang::current_env()
  )
  .sportpress_parse("player_games", raw, "BNXT League Player Games from Sportpress")
}

#' @title
#' **Get BNXT League Game**
#' @description
#' One game: teams, scores, phase, venue and the neighbouring game ids.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/schedule/find/{game_id}`
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: One game: teams, scores, phase, venue and the neighbouring game ids. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_game_find`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
#' | game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
#' | status | character | Game status: finished, or ready for an upcoming game. |
#' | competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
#' | season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
#' | phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
#' | phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
#' | round_name | character | Round label as entered in the CMS; often empty. |
#' | round_priority | integer | Sort order of the round within the phase (provider's priority); meaning of the values is unverified. |
#' | period_name | character | Name of the period the game is in or ended in; 'Extra2' means the second overtime. |
#' | arena | character | Name of the arena where the game is played. |
#' | home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | home_score | integer | Home side. Final points of the side, including overtime. |
#' | away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
#' | away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
#' | away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
#' | away_score | integer | Away side. Final points of the side, including overtime. |
#' | last_game_id | integer | Latest finished meeting of the same two teams in the competition, which can be LATER than this game; null when none. |
#' | next_game_id | integer | Next meeting of the same two teams; null in every sample. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_find(game_id = 11295))
#' }
#' @export
#' @family BNXT League Functions
sportpress_game_find <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "game_find",
    ids = list(game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_find", raw, "BNXT League Game from Sportpress")
}

#' @title
#' **Get BNXT League Game Periods**
#' @description
#' Points each side scored in each period of a game (periods 5 and up are overtimes).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/schedule/find/{game_id}`
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: Points each side scored in each period of a game (periods 5 and up are overtimes). An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_game_periods`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
#' | team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
#' | competition_team_id | integer | Competition-team id of the side. |
#' | period | integer | Period number: 1-4 are the quarters, 5 and up are overtimes (5 = first overtime). |
#' | score | integer | Points the side scored IN that period (not cumulative). |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_periods(game_id = 11295))
#' }
#' @export
#' @family BNXT League Functions
sportpress_game_periods <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "game_find",
    ids = list(game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_periods", raw, "BNXT League Game Periods from Sportpress")
}

#' @title
#' **Get BNXT League Game Overview**
#' @description
#' Team totals of both sides of a finished game.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: Team totals of both sides of a finished game. An empty valid answer raises `hoopR_no_data`;
#'   the columns are always these, in this order (sdv-py `sportpress_game_overview`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id the overview was asked for (the body does not echo it). |
#' | team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | score | integer | Final score of the side. |
#' | minute | integer | The team's total: minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
#' | foul | integer | The team's total: personal fouls committed. |
#' | defensive_foul | integer | The team's total: fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
#' | dunk_made | integer | The team's total: dunks made (a subset of the two-point field goals). |
#' | dunk_all | integer | The team's total: dunks attempted. |
#' | dunk_percent | double | The team's total: dunk percentage 0-100; 0 when none were attempted. |
#' | two_point_made | integer | The team's total: two-point field goals made. |
#' | two_point_all | integer | The team's total: two-point field goals attempted. |
#' | two_point_percent | double | The team's total: two-point percentage 0-100. |
#' | three_point_made | integer | The team's total: three-point field goals made. |
#' | three_point_all | integer | The team's total: three-point field goals attempted. |
#' | three_point_percent | double | The team's total: three-point percentage 0-100. |
#' | throw_made | integer | The team's total: all field goals made, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_all | integer | The team's total: all field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_percent | double | The team's total: field-goal percentage 0-100. |
#' | free_throw_made | integer | The team's total: free throws made. |
#' | free_throw_all | integer | The team's total: free throws attempted. |
#' | free_throw_percent | double | The team's total: free-throw percentage 0-100. |
#' | offensive_rebound | integer | The team's total: offensive rebounds. |
#' | defensive_rebound | integer | The team's total: defensive rebounds. |
#' | total_rebound | integer | The team's total: total rebounds (offensive plus defensive). |
#' | block | integer | The team's total: shots blocked by the player. |
#' | block_against | integer | The team's total: own shots blocked by an opponent. |
#' | turnover | integer | The team's total: turnovers committed. |
#' | steal | integer | The team's total: steals (balls taken from an opponent). |
#' | assist | integer | The team's total: assists (passes leading directly to a made basket). |
#' | points | integer | The team's total: points scored (2 x two-pointers + 3 x three-pointers + free throws). |
#' | value | integer | The team's total: efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
#' | plusminus | integer | The team's total: plus/minus: the score margin while the player (or team) was on court; for a team total it is the game margin. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_overview(game_id = 11295))
#' }
#' @export
#' @family BNXT League Functions
sportpress_game_overview <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "overview",
    ids = list(game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_overview", raw, "BNXT League Game Overview from Sportpress")
}

#' @title
#' **Get BNXT League Game Top Performers**
#' @description
#' The top performer of each side of a finished game, with his full line.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: The top performer of each side of a finished game, with his full line. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_game_top_performers`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id the overview was asked for (the body does not echo it). |
#' | team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' | jersey | character | Shirt number as text. |
#' | starter | logical | True when the player started the game. |
#' | minute | integer | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
#' | foul | integer | Personal fouls committed. |
#' | defensive_foul | integer | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
#' | dunk_made | integer | Dunks made (a subset of the two-point field goals). |
#' | dunk_all | integer | Dunks attempted. |
#' | dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. |
#' | two_point_made | integer | Two-point field goals made. |
#' | two_point_all | integer | Two-point field goals attempted. |
#' | two_point_percent | double | Two-point percentage 0-100. |
#' | three_point_made | integer | Three-point field goals made. |
#' | three_point_all | integer | Three-point field goals attempted. |
#' | three_point_percent | double | Three-point percentage 0-100. |
#' | throw_made | integer | All field goals made, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_all | integer | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_percent | double | Field-goal percentage 0-100. |
#' | free_throw_made | integer | Free throws made. |
#' | free_throw_all | integer | Free throws attempted. |
#' | free_throw_percent | double | Free-throw percentage 0-100. |
#' | offensive_rebound | integer | Offensive rebounds. |
#' | defensive_rebound | integer | Defensive rebounds. |
#' | total_rebound | integer | Total rebounds (offensive plus defensive). |
#' | block | integer | Shots blocked by the player. |
#' | block_against | integer | Own shots blocked by an opponent. |
#' | turnover | integer | Turnovers committed. |
#' | steal | integer | Steals (balls taken from an opponent). |
#' | assist | integer | Assists (passes leading directly to a made basket). |
#' | points | integer | Points scored (2 x two-pointers + 3 x three-pointers + free throws). |
#' | value | integer | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_game_top_performers(game_id = 11295)")
#' @export
#' @family BNXT League Functions
sportpress_game_top_performers <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "overview",
    ids = list(game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_top_performers", raw, "BNXT League Game Top Performers from Sportpress")
}

#' @title
#' **Get BNXT League Game Leaders**
#' @description
#' The game leader of each side in every statistic (one row per side and statistic).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: The game leader of each side in every statistic (one row per side and statistic). An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `sportpress_game_leaders`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id the overview was asked for (the body does not echo it). |
#' | team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | stat | character | Statistic the leader leads, in the provider's column name (points, total_rebound, value, ...). |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' | value | double | The leader's count (or percentage) in that statistic in this game. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_leaders(game_id = 11295))
#' }
#' @export
#' @family BNXT League Functions
sportpress_game_leaders <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "overview",
    ids = list(game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_leaders", raw, "BNXT League Game Leaders from Sportpress")
}

#' @title
#' **Get BNXT League Game Box Score**
#' @description
#' Per-player box score of a finished game (one row per player line).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/boxscore/game/{competition_id}/{game_id}`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: Per-player box score of a finished game (one row per player line). An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_game_box`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id the box score was asked for (the body does not echo it). |
#' | competition_id | integer | Competition id the box score was asked for; checked against the game. |
#' | team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | roster_id | integer | Roster id of the line; null when the line has no player (15 of 14,142 sampled lines). |
#' | player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' | position_id | integer | Playing position id (key space: sportpress positions); null on 21 of 14,142 sampled lines. |
#' | position | character | Playing position: point_guard, shooting_guard, small_forward, power_forward or center. |
#' | starter | logical | True when the player was in the starting five. |
#' | jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
#' | minute | integer | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
#' | foul | integer | Personal fouls committed. |
#' | defensive_foul | integer | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
#' | dunk_made | integer | Dunks made (a subset of the two-point field goals). |
#' | dunk_all | integer | Dunks attempted. |
#' | dunk_percent | double | Dunk percentage 0-100; 0 when none were attempted. |
#' | two_point_made | integer | Two-point field goals made. |
#' | two_point_all | integer | Two-point field goals attempted. |
#' | two_point_percent | double | Two-point percentage 0-100. |
#' | three_point_made | integer | Three-point field goals made. |
#' | three_point_all | integer | Three-point field goals attempted. |
#' | three_point_percent | double | Three-point percentage 0-100. |
#' | throw_made | integer | All field goals made, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_all | integer | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_percent | double | Field-goal percentage 0-100. |
#' | free_throw_made | integer | Free throws made. |
#' | free_throw_all | integer | Free throws attempted. |
#' | free_throw_percent | double | Free-throw percentage 0-100. |
#' | offensive_rebound | integer | Offensive rebounds. |
#' | defensive_rebound | integer | Defensive rebounds. |
#' | total_rebound | integer | Total rebounds (offensive plus defensive). |
#' | block | integer | Shots blocked by the player. |
#' | block_against | integer | Own shots blocked by an opponent. |
#' | turnover | integer | Turnovers committed. |
#' | steal | integer | Steals (balls taken from an opponent). |
#' | assist | integer | Assists (passes leading directly to a made basket). |
#' | points | integer | Points scored (2 x two-pointers + 3 x three-pointers + free throws). |
#' | value | integer | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
#' | plusminus | integer | Plus/minus: the score margin while the player (or team) was on court; for a team total it is the game margin. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_box(competition_id = 25, game_id = 11295))
#' }
#' @export
#' @family BNXT League Functions
sportpress_game_box <- function(competition_id, game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "box",
    ids = list(competition_id = competition_id, game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_box", raw, "BNXT League Game Box Score from Sportpress")
}

#' @title
#' **Get BNXT League Game Team Box Score**
#' @description
#' Team totals of both sides from the box score of a finished game.
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/boxscore/game/{competition_id}/{game_id}`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: Team totals of both sides from the box score of a finished game. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_game_team_box`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id the box score was asked for (the body does not echo it). |
#' | competition_id | integer | Competition id the box score was asked for; checked against the game. |
#' | team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | minute | integer | The team's total: minutes played; for a team total, the sum over its players (200 + 25 per overtime). |
#' | foul | integer | The team's total: personal fouls committed. |
#' | defensive_foul | integer | The team's total: fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. |
#' | dunk_made | integer | The team's total: dunks made (a subset of the two-point field goals). |
#' | dunk_all | integer | The team's total: dunks attempted. |
#' | dunk_percent | double | The team's total: dunk percentage 0-100; 0 when none were attempted. |
#' | two_point_made | integer | The team's total: two-point field goals made. |
#' | two_point_all | integer | The team's total: two-point field goals attempted. |
#' | two_point_percent | double | The team's total: two-point percentage 0-100. |
#' | three_point_made | integer | The team's total: three-point field goals made. |
#' | three_point_all | integer | The team's total: three-point field goals attempted. |
#' | three_point_percent | double | The team's total: three-point percentage 0-100. |
#' | throw_made | integer | The team's total: all field goals made, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_all | integer | The team's total: all field goals attempted, two- plus three-pointers (the provider calls them 'throw'). |
#' | throw_percent | double | The team's total: field-goal percentage 0-100. |
#' | free_throw_made | integer | The team's total: free throws made. |
#' | free_throw_all | integer | The team's total: free throws attempted. |
#' | free_throw_percent | double | The team's total: free-throw percentage 0-100. |
#' | offensive_rebound | integer | The team's total: offensive rebounds. |
#' | defensive_rebound | integer | The team's total: defensive rebounds. |
#' | total_rebound | integer | The team's total: total rebounds (offensive plus defensive). |
#' | block | integer | The team's total: shots blocked by the player. |
#' | block_against | integer | The team's total: own shots blocked by an opponent. |
#' | turnover | integer | The team's total: turnovers committed. |
#' | steal | integer | The team's total: steals (balls taken from an opponent). |
#' | assist | integer | The team's total: assists (passes leading directly to a made basket). |
#' | points | integer | Team points in the box score; can differ from the schedule final score (about 18 of 1,246 sampled team boxes, by 2-21 points). |
#' | value | integer | The team's total: efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. |
#' | plusminus | integer | The team's total: plus/minus: the score margin while the player (or team) was on court; for a team total it is the game margin. |
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_team_box(competition_id = 25, game_id = 11295))
#' }
#' @export
#' @family BNXT League Functions
sportpress_game_team_box <- function(competition_id, game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "box",
    ids = list(competition_id = competition_id, game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_team_box", raw, "BNXT League Game Team Box Score from Sportpress")
}

#' @title
#' **Get BNXT League Game Play-by-Play (Film)**
#' @description
#' Play-by-play ('film') of a finished game with court x/y (2021-22 and 2026-27 only).
#'
#' Endpoint: `GET https://bnxt.sportpress.info/api/v1/film/game/{competition_id}/{game_id}`
#' @param competition_id (required) Competition id (integer), ONE per season of the league: 24 = 2025-26, 25 = 2026-27
#'   ([sportpress_phases()] maps a season to it).
#' @param game_id (required) Game id (integer), unique across seasons; from [sportpress_schedule()] (`game_id`).
#' @return
#' A `hoopR_data` tibble: Play-by-play ('film') of a finished game with court x/y (2021-22 and 2026-27 only). An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `sportpress_game_film`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | Game id the film was asked for (the body does not echo it). |
#' | competition_id | integer | Competition id the film was asked for; checked against the game. |
#' | order | integer | Event sequence number in the game, strictly increasing from 0. |
#' | period | integer | Period of the event: 1-4 quarters, 5 and up overtimes. |
#' | minute | integer | Whole minutes ELAPSED in the period (not clock remaining). |
#' | second | integer | Seconds elapsed within that minute. |
#' | team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
#' | competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
#' | team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
#' | team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
#' | event_code | integer | Provider event code: 1000 made shot, 1001 missed shot, 1002 defensive rebound, 1003 offensive rebound, 1004 steal, 1005 turnover, 1006 foul drawn, 1007 foul committed, 1008 assist, 1009 block, 1011 substitution, 1101 period marker; 2xxx team events (meaning unverified). |
#' | event_subcode | integer | Provider sub-type of the event: for shots 1, 2 and 5 = two-pointer, 3 = three-pointer, 4 = free throw; turnover and foul sub-types are unnamed by the provider. |
#' | x | integer | Court x position of the event in the provider's integer court coordinates (0 on events with none); the coordinate system and orientation are unverified. |
#' | y | integer | Court y position of the event in the provider's integer court coordinates (0 on events with none); the coordinate system and orientation are unverified. |
#' | home_score | integer | Running home score AFTER the event; the maximum is the final score. |
#' | away_score | integer | Running away score AFTER the event; the maximum is the final score. |
#' | player_id | integer | Player id of the actor; null on team events and period markers. |
#' | first_name | character | Given name of the player as entered in the CMS. |
#' | last_name | character | Family name of the player as entered in the CMS. |
#' | nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
#' | birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
#' | player2_id | integer | Player id of the second player; filled on substitutions only. |
#' | player2_first_name | character | Given name of the second player; substitutions only. |
#' | player2_last_name | character | Family name of the second player; substitutions only. |
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_game_film(competition_id = 25, game_id = 11295)")
#' @export
#' @family BNXT League Functions
sportpress_game_film <- function(competition_id, game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "film",
    ids = list(competition_id = competition_id, game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_film", raw, "BNXT League Game Play-by-Play (Film) from Sportpress")
}
