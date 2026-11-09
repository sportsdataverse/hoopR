# sportpress.R -- BNXT League (Belgium + the Netherlands) wrappers over the Sportpress CMS API
# (bnxt.sportpress.info/api/v1), at parity with sportsdataverse-py sportsdataverse/basketball/bnxt (origin/main e3d232e).
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
#' @eval .returns_rd("sportpress_ui_strings", inline = FALSE, unit = "language and key")
#' @eval .intl_details(.sportpress_ui_strings_details, full = TRUE, "sportpress_ui_strings()")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_club_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_club_seasons())
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_referees", inline = FALSE, unit = "official")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_referees()")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_phases", inline = FALSE, unit = "phase")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_phases(season = 2026))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_competition_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_competition_teams(competition_id = 24))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_competition_staff", inline = FALSE, unit = "staff member")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_competition_staff(competition_id = 24)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_standings(competition_id = 24, phase_id = 169))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_schedule", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_schedule(season = 2026))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_slider", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_game_slider(competition_id = 25)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_team_rankings", inline = FALSE, unit = "team and category")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_team_rankings(competition_id = 24))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_player_rankings", inline = FALSE, unit = "player and category")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_player_rankings(competition_id = 24, limit = 5))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_season_roster", inline = FALSE, unit = "player")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_season_roster(season = 2026))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_nationality_codes", inline = FALSE, unit = "nationality code")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_nationality_codes(season = 2026)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_team_roster", inline = FALSE, unit = "player")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_roster(competition_team_id = 541)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_team_find", inline = FALSE, unit = "team")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_find(competition_team_id = 541)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_team_player_averages", inline = FALSE, unit = "player")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_player_averages(competition_team_id = 541)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_team_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_team_games(competition_team_id = 541)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_roster_find", inline = FALSE, unit = "roster entry")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_roster_find(roster_id = 11193)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_player_career", inline = FALSE, unit = "season and competition")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_player_career(roster_id = 11193)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_player_games", inline = FALSE, unit = "game the player played")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_player_games(roster_id = 11193)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_find", inline = FALSE, unit = "game")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_find(game_id = 11295))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_periods", inline = FALSE, unit = "side and period")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_periods(game_id = 11295))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_overview", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_overview(game_id = 11295))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_top_performers", inline = FALSE, unit = "side")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_game_top_performers(game_id = 11295)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_leaders", inline = FALSE, unit = "side and statistic")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_leaders(game_id = 11295))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_box", inline = FALSE, unit = "player line")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_box(competition_id = 25, game_id = 11295))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_team_box", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.sportpress_ui_strings_details)
#' @examples
#' \donttest{
#'   try(sportpress_game_team_box(competition_id = 25, game_id = 11295))
#' }
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
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
#' @eval .returns_rd("sportpress_game_film", inline = FALSE, unit = "play-by-play event")
#' @eval .intl_details(.sportpress_ui_strings_details, "sportpress_game_film(competition_id = 25, game_id = 11295)")
#' @export
#' @concept BNXT League Functions
#' @seealso [family_bnxt_league] lists every function in this family.
sportpress_game_film <- function(competition_id, game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .sportpress_get(
    "film",
    ids = list(competition_id = competition_id, game_id = game_id),
    call = rlang::current_env()
  )
  .sportpress_parse("game_film", raw, "BNXT League Game Play-by-Play (Film) from Sportpress")
}
