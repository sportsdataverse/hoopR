# cebl.R -- CEBL (Canada) wrappers over the league's own stats API (api.data.cebl.ca, the backend of
# the CEBL Stats Hub), at parity with sportsdataverse-py sportsdataverse/basketball/cebl (origin/main e3d232ebc9).
# Transport, key and refusals: R/cebl_runtime.R; frames: R/cebl_parsers.R; columns: R/cebl_schema.R.

# The @details of every cebl topic that shares the cebl_seasons() notes (roxygen @eval .intl_details()).
.cebl_seasons_details <- c(
  "* Unofficial use of the CEBL's own API: these wrappers read the league's own FastAPI service (api.data.cebl.ca,",
  "  the backend of the CEBL Stats Hub) with the X-Api-Key that the hub's own page bundle ships to every browser.",
  "  The key is not issued to third parties and no developer terms were found; cebl.ca's terms of use were not",
  "  reviewed. The runtime reads the key from the bundle at run time, falls back to a documented constant, never",
  "  prints it, and raises `hoopR_asset_fetch` with a 'key rotated?' hint on a persistent 401.",
  "  www.cebl.ca/robots.txt disallows nothing. Requests are spaced at least 1 s apart.",
  "* Season is the calendar year (May to August) = the sdv END year: no mapping. The first season is 2019. An",
  "  unknown season, team or player answers an empty list, which the runtime raises as `hoopR_no_data`. Ids are",
  "  CEBL's own; a relocated franchise has two team ids (cebl_teams lists all 15).",
  "* This API has no box-score, play-by-play or shot route. They live in Genius LiveStats (organisation CEBL, see",
  "  the genius family): cebl_games and cebl_player_gamelog carry the Genius match id as genius_match_id, parsed",
  "  from the stats URLs (derived, not fetched; the match of a cancelled game may have no data). home_team_id is",
  "  Genius team 1 and away_team_id team 2 (checked on match 2600563).",
  "* Some completed schedule rows have null scores (2026), and a cancelled game has status CANELLED (the API's",
  "  spelling) with null or zero scores. The schedule lists unplayed games too, so no wrapper refuses an unfinished",
  "  game. Aggregates are decimal strings upstream and double here. Players' names, nationality and birth date are",
  "  the public bio; no contact data is served.",
  "* Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty list, an all-null profile: an unknown",
  "  season, team or player), `hoopR_bad_request` (a bad argument, HTTP 400 / 422) and `hoopR_asset_fetch` (a key",
  "  the API still refuses after one re-read, any other non-200, a non-JSON body, an error envelope, a body for",
  "  another season, team or player), all inheriting `hoopR_error`. HTTP 500 is the API's answer to a bad id and is",
  "  not retried. Wrappers raise; they never return an empty frame.",
  "* Deliberate divergence: a string column that the API sends as an object, or a list of objects, carries compact",
  "  JSON here (`{\"name\":\"TSN\"}`), where sportsdataverse-py's String cast writes Python's `str(dict)` repr (`{'name': 'TSN'}`).",
  "  No string column of the committed fixtures carries an object."
)

#' @title
#' **Get CEBL Seasons**
#' @description
#' Every CEBL season (2019 on), with the active and live flags.
#'
#' Endpoint: `GET https://api.data.cebl.ca/seasons/`
#' @eval .returns_rd("cebl_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.cebl_seasons_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(cebl_seasons())
#' }
#' @export
#' @family CEBL Functions
cebl_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "seasons", call = rlang::current_env())
  .cebl_out(.cebl_parse("seasons", raw), "CEBL Seasons from the CEBL Stats API")
}

#' @title
#' **Get CEBL Teams**
#' @description
#' Every franchise identity, past and present (15 team ids; a relocated franchise has a second id).
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/`
#' @eval .returns_rd("cebl_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.cebl_seasons_details)
#' @examples
#' \donttest{
#'   try(cebl_teams())
#' }
#' @export
#' @family CEBL Functions
cebl_teams <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "teams", call = rlang::current_env())
  .cebl_out(.cebl_parse("teams", raw), "CEBL Teams from the CEBL Stats API")
}

#' @title
#' **Get CEBL Standings**
#' @description
#' Standings of one season, one row per team: record, home/away splits, games behind, streak.
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/{season}/`
#' @param season (required) Season: the calendar year it is played in (May to August) = the sdv END year (2025 = the
#'   2025 season). The CEBL's first season is 2019. A season with no data answers `hoopR_no_data`.
#' @eval .returns_rd("cebl_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.cebl_seasons_details)
#' @examples
#' \donttest{
#'   try(cebl_standings(season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_standings <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "standings", season = season, call = rlang::current_env())
  .cebl_out(.cebl_parse("standings", raw), "CEBL Standings from the CEBL Stats API")
}

#' @title
#' **Get CEBL Team Roster**
#' @description
#' One team's roster in one season: player, nationality, birth date, position and jersey.
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/{team_id}/roster/{season}/`
#' @param team_id (required) CEBL team id of that season (``team_id`` in cebl_standings), e.g. 20 (Ottawa
#'   BlackJacks).
#' @param season (required) Season: the calendar year it is played in (May to August) = the sdv END year (2025 = the
#'   2025 season). The CEBL's first season is 2019. A season with no data answers `hoopR_no_data`.
#' @eval .returns_rd("cebl_roster", inline = FALSE, unit = "player")
#' @eval .intl_details(.cebl_seasons_details)
#' @examples
#' \donttest{
#'   try(cebl_roster(team_id = 14, season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_roster <- function(team_id, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "roster", team_id = team_id, season = season, call = rlang::current_env())
  .cebl_out(.cebl_parse("roster", raw), "CEBL Team Roster from the CEBL Stats API")
}

#' @title
#' **Get CEBL Team Statistics**
#' @description
#' Team statistic table (totals or per game) with a league row; filter by season, competition, segment, opponent
#' team or opponent conference.
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/statistics/aggregated/`
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @param segment (default `NULL`) Game subset: HOME, AWAY, L7D (last 7 days), L5G (last 5 games), L10G (last 10
#'   games), MAY, JUNE, JULY or AUGUST. `NULL` = all games. Values from the CEBL Stats Hub bundle.
#' @param vs_team_id (default `NULL`) CEBL team id of the opponent: only games against that team count.
#' @param vs_conference (default `NULL`) EAST or WEST: only games against that conference's teams count.
#' @eval .returns_rd("cebl_team_stats", inline = FALSE, unit = "team, plus a league row")
#' @eval .intl_details(.cebl_seasons_details, 'cebl_team_stats(mode = "TOTALS", season = 2025, competition = "REGULAR")')
#' @export
#' @family CEBL Functions
cebl_team_stats <- function(
    mode = "PER_GAME",
    season = NULL,
    competition = NULL,
    segment = NULL,
    vs_team_id = NULL,
    vs_conference = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "team_stats", mode = mode, season = season, competition = competition, segment =
    segment, vs_team_id = vs_team_id, vs_conference = vs_conference, call = rlang::current_env())
  .cebl_out(.cebl_parse("team_stats", raw), "CEBL Team Statistics from the CEBL Stats API")
}

#' @title
#' **Get CEBL Games**
#' @description
#' Schedule and results of one season (regular season and finals), with the Genius match id that joins play-by-play
#' and shots; optionally one team's games.
#'
#' Endpoint: `GET https://api.data.cebl.ca/games/{season}/`
#' @param season (required) Season: the calendar year it is played in (May to August) = the sdv END year (2025 = the
#'   2025 season). The CEBL's first season is 2019. A season with no data answers `hoopR_no_data`.
#' @param team_id (default `NULL`) CEBL team id (``team_id`` in cebl_teams): limits the rows to that team; the rows
#'   echo it.
#' @eval .returns_rd("cebl_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.cebl_seasons_details)
#' @examples
#' \donttest{
#'   try(cebl_games(season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_games <- function(season, team_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "games", season = season, team_id = team_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("games", raw), "CEBL Games from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Statistics**
#' @description
#' Player statistic table (totals or per game) for a season or all-time; filter by competition, segment or team.
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/statistics/aggregated/`
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @param segment (default `NULL`) Game subset: HOME, AWAY, L7D (last 7 days), L5G (last 5 games), L10G (last 10
#'   games), MAY, JUNE, JULY or AUGUST. `NULL` = all games. Values from the CEBL Stats Hub bundle.
#' @param team_id (default `NULL`) CEBL team id (``team_id`` in cebl_teams): limits the rows to that team; the rows
#'   echo it.
#' @eval .returns_rd("cebl_player_stats", inline = FALSE, unit = "player")
#' @eval .intl_details(.cebl_seasons_details)
#' @examples
#' \donttest{
#'   try(cebl_player_stats(mode = "PER_GAME", season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_player_stats <- function(
    mode = "PER_GAME",
    season = NULL,
    competition = NULL,
    segment = NULL,
    team_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "player_stats", mode = mode, season = season, competition = competition, segment =
    segment, team_id = team_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("player_stats", raw), "CEBL Player Statistics from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Leaders**
#' @description
#' Top five players per requested statistic (long frame, one row per statistic and leader).
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/statistics/leaders/`
#' @param statistics (default `"POINTS,REBOUNDS,ASSISTS,TARGET_SCORES"`) Comma-separated statistic names; the frame
#'   has one block per name. Names the Stats Hub sends: POINTS, REBOUNDS, ASSISTS, BLOCKS, STEALS, TARGET_SCORES,
#'   FIELD_GOAL_PERCENTAGE, THREE_POINTS_MADE, THREE_POINT_PERCENTAGE, FREE_THROW_PERCENTAGE, FOULS, TURNOVERS,
#'   MINUTES.
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @param team_id (default `NULL`) CEBL team id (``team_id`` in cebl_teams): limits the rows to that team; the rows
#'   echo it.
#' @eval .returns_rd("cebl_player_leaders", inline = FALSE, unit = "statistic and leader")
#' @eval .intl_details(.cebl_seasons_details, 'cebl_player_leaders(mode = "PER_GAME", season = 2025)')
#' @export
#' @family CEBL Functions
cebl_player_leaders <- function(
    statistics = "POINTS,REBOUNDS,ASSISTS,TARGET_SCORES",
    mode = "PER_GAME",
    season = NULL,
    competition = NULL,
    team_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "leaders", statistics = statistics, mode = mode, season = season, competition =
    competition, team_id = team_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("player_leaders", raw), "CEBL Player Leaders from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Seasons**
#' @description
#' One player's per-season rows and career row (totals or per game).
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/statistics/`
#' @param player_id (required) CEBL player id (global across seasons and teams), e.g. 570965 (Javonte Smart);
#'   ``player_id`` in cebl_player_stats.
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param career_only (default `FALSE`) `TRUE` returns the career row alone; `FALSE` the per-season rows and the
#'   career row.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @eval .returns_rd("cebl_player_seasons", inline = FALSE, unit = "player-season")
#' @eval .intl_details(.cebl_seasons_details, 'cebl_player_seasons(player_id = 570965, mode = "PER_GAME")')
#' @export
#' @family CEBL Functions
cebl_player_seasons <- function(player_id, mode = "PER_GAME", career_only = FALSE, competition = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "player_seasons", player_id = player_id, mode = mode, career_only = career_only,
    competition = competition, call = rlang::current_env())
  .cebl_out(.cebl_parse("player_seasons", raw), "CEBL Player Seasons from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player**
#' @description
#' One player's profile and current team: name, nationality, birth date, position, jersey.
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/`
#' @param player_id (required) CEBL player id (global across seasons and teams), e.g. 570965 (Javonte Smart);
#'   ``player_id`` in cebl_player_stats.
#' @eval .returns_rd("cebl_player", inline = FALSE, unit = "player")
#' @eval .intl_details(.cebl_seasons_details, "cebl_player(player_id = 570965)")
#' @export
#' @family CEBL Functions
cebl_player <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "player", player_id = player_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("player", raw), "CEBL Player from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Game Log**
#' @description
#' One player's game log: one row per game played, with the Genius match id of the game.
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/gamelog/`
#' @param player_id (required) CEBL player id (global across seasons and teams), e.g. 570965 (Javonte Smart);
#'   ``player_id`` in cebl_player_stats.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @eval .returns_rd("cebl_player_gamelog", inline = FALSE, unit = "game played")
#' @eval .intl_details(.cebl_seasons_details, "cebl_player_gamelog(player_id = 570965, season = 2025)")
#' @export
#' @family CEBL Functions
cebl_player_gamelog <- function(player_id, season = NULL, competition = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "gamelog", player_id = player_id, season = season, competition = competition, call =
    rlang::current_env())
  .cebl_out(.cebl_parse("player_gamelog", raw), "CEBL Player Game Log from the CEBL Stats API")
}

#' @title
#' **Get CEBL News**
#' @description
#' News articles in one language. The API answered an empty list on every probe, so this raises `hoopR_no_data`.
#'
#' Endpoint: `GET https://api.data.cebl.ca/news/articles/{language}/`
#' @param language (required) Language code, e.g. ``en``; every language tried answered an empty list.
#' @param team_source_id (default `NULL`) CEBL team id: only that team's articles.
#' @eval .returns_rd("cebl_news", inline = FALSE, unit = "news article")
#' @eval .intl_details(.cebl_seasons_details, 'cebl_news(language = "en")')
#' @export
#' @family CEBL Functions
cebl_news <- function(language, team_source_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "news", language = language, team_source_id = team_source_id, call =
    rlang::current_env())
  .cebl_out(.cebl_parse("news", raw), "CEBL News from the CEBL Stats API")
}
