# fiba_gamepage.R -- the fiba_gamepage_* wrappers (R mirror of sportsdataverse-py sportsdataverse/basketball/fiba_hub/fiba_gamepage.py).
# Same names, arguments, defaults and snake_case columns as sportsdataverse-py; the transport, refusals and
# parsers live in R/fiba_gdap_runtime.R, R/fiba_gdap_parsers.R and R/fiba_gamepage_runtime.R.

# The @details of every fiba topic that shares the fiba_gamepage_box_players() notes (roxygen @eval .intl_details()).
.fiba_gamepage_box_players_details <- c(
  "FIBA's terms restrict this source. The GDAP developer-portal terms limit API use to 'Authorized Users'",
  "(federations, organisers, FIBA partners) and say any broader use 'is not authorised'; the fiba.basketball",
  "terms say no portion of the site may be duplicated, redistributed or manipulated. Users who are not",
  "themselves authorised by FIBA should check the terms before using the wrappers.",
  "",
  "The GDAP subscription key is public (fiba.basketball ships it in every page); the runtime reads it from the",
  "live page at run time and never logs it. Officials' contact details and coaches' and officials' dates of",
  "birth are dropped from every body.",
  "",
  "Id key spaces: competition_id is one per edition (2023 World Cup = 208182) and game_id is global across",
  "competitions (the `<gameId>` of a game-page URL). team_id is per team per competition (Germany is 279569 at",
  "the 2023 World Cup and 281545 at Paris 2024), while organisation_id is the stable federation or club (64 =",
  "Germany, every year); the game page's T_`<id>` and the play-by-play oId are organisation ids, not team ids.",
  "",
  "The wrapper takes the game id and its competition (comp) and builds the real page URL from GDAP (the",
  "competition's marketing name gives the history slug, its schedule gives the two team codes; a competition",
  "with an event page is tried at its event URL when the archive URL answers the not-found shell, and the",
  "Champions League host last).",
  "",
  "Box scores start about 2006; play-by-play with shot x/y about 2012 (OVR events) and 2017-18 (FLS club",
  "competitions). A game with no box score raises `hoopR_no_data`; a game still live raises `hoopR_asset_fetch`.",
  "The page request sends a browser User-Agent (sportsdataverse-py answers fiba.basketball's HTTP 403 to plain clients with",
  "Chrome TLS; libcurl with a browser User-Agent was served on 2026-10-18).",
  "Shot x/y are image pixels with an unverified scale.",
  "",
  "Errors are classed conditions (all inherit `hoopR_error`): `hoopR_no_data` when FIBA has nothing (HTTP 404,",
  "or GDAP answers `{}` / `[]` for an unknown id, a game page with no box score, a listed game whose teams are",
  "not drawn yet); `hoopR_bad_request` for HTTP 400 / 422 or a malformed id, season or date; `hoopR_asset_fetch`",
  "for any other failed fetch or an answer that is not about the request (an error envelope, HTTP 401 after a",
  "key refresh, HTTP 500, a body for another game, competition, team, player, federation, family or season, a",
  "game of another competition than `comp`, the HTTP 200 not-found shell of a wrong game page, a live game).",
  "Seasons are FIBA's own key, which equals the sdv key: the END year for club competitions, the event year for",
  "national-team events, the target tournament year for qualifiers."
)

#' @title **FIBA GAMEPAGE: box players**
#' @description
#' Player box score of one FIBA game.
#'
#' Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`
#' @param game_id (integer, required) FIBA game id (global): gameId of a gdap schedule row, e.g. 100720 = the
#'   World Cup 2023 final.
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). The game must belong to it. Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list (the
#'   game-page objects `game`, `playByPlay`, `gameDetails`, `playersTeamA`, `playersTeamB`).
#' @eval .intl_details(.fiba_gamepage_box_players_details, full = TRUE)
#' @eval .returns_rd("fiba_gamepage_box_players", inline = FALSE, unit = "player in the game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gamepage_box_players(game_id = 100720, comp = 208182))
#' }
fiba_gamepage_box_players <- function(game_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .fiba_gamepage_route("box_players", game_id, comp, return_parsed, call = rlang::current_env())
}

#' @title **FIBA GAMEPAGE: box teams**
#' @description
#' Team box score of one FIBA game, with the game-level figures.
#'
#' Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`
#' @param game_id (integer, required) FIBA game id (global): gameId of a gdap schedule row, e.g. 100720 = the
#'   World Cup 2023 final.
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). The game must belong to it. Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list (the
#'   game-page objects `game`, `playByPlay`, `gameDetails`, `playersTeamA`, `playersTeamB`).
#' @eval .intl_details(.fiba_gamepage_box_players_details)
#'
#' @eval .returns_rd("fiba_gamepage_box_teams", inline = FALSE, unit = "team in the game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gamepage_box_teams(game_id = 100720, comp = 208182))
#' }
fiba_gamepage_box_teams <- function(game_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .fiba_gamepage_route("box_teams", game_id, comp, return_parsed, call = rlang::current_env())
}

#' @title **FIBA GAMEPAGE: lineup**
#' @description
#' Lineup card (the players who were registered for the game) of both teams of one FIBA game.
#'
#' Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`
#' @param game_id (integer, required) FIBA game id (global): gameId of a gdap schedule row, e.g. 100720 = the
#'   World Cup 2023 final.
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). The game must belong to it. Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list (the
#'   game-page objects `game`, `playByPlay`, `gameDetails`, `playersTeamA`, `playersTeamB`).
#' @eval .intl_details(.fiba_gamepage_box_players_details, "fiba_gamepage_lineup(game_id = 100720, comp = 208182)")
#' @eval .returns_rd("fiba_gamepage_lineup", inline = FALSE, unit = "player in the lineup")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gamepage_lineup <- function(game_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .fiba_gamepage_route("lineup", game_id, comp, return_parsed, call = rlang::current_env())
}

#' @title **FIBA GAMEPAGE: pbp**
#' @description
#' Play-by-play of one FIBA game: every action with period, clock, running score, actor and shot x/y.
#'
#' Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`
#' @param game_id (integer, required) FIBA game id (global): gameId of a gdap schedule row, e.g. 100720 = the
#'   World Cup 2023 final.
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). The game must belong to it. Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list (the
#'   game-page objects `game`, `playByPlay`, `gameDetails`, `playersTeamA`, `playersTeamB`).
#' @eval .intl_details(.fiba_gamepage_box_players_details)
#'
#' @eval .returns_rd("fiba_gamepage_pbp", inline = FALSE, unit = "play-by-play event")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gamepage_pbp(game_id = 100720, comp = 208182))
#' }
fiba_gamepage_pbp <- function(game_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .fiba_gamepage_route("pbp", game_id, comp, return_parsed, call = rlang::current_env())
}

#' @title **FIBA GAMEPAGE: period scores**
#' @description
#' Points by period of both teams of one FIBA game.
#'
#' Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`
#' @param game_id (integer, required) FIBA game id (global): gameId of a gdap schedule row, e.g. 100720 = the
#'   World Cup 2023 final.
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). The game must belong to it. Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list (the
#'   game-page objects `game`, `playByPlay`, `gameDetails`, `playersTeamA`, `playersTeamB`).
#' @eval .intl_details(.fiba_gamepage_box_players_details)
#'
#' @eval .returns_rd("fiba_gamepage_period_scores", inline = FALSE, unit = "team and period")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gamepage_period_scores(game_id = 100720, comp = 208182))
#' }
fiba_gamepage_period_scores <- function(game_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .fiba_gamepage_route("period_scores", game_id, comp, return_parsed, call = rlang::current_env())
}

#' @title **FIBA GAMEPAGE: shots**
#' @description
#' Shot attempts of one FIBA game (two- and three-pointers and free throws) with their x/y.
#'
#' Endpoint: `GET https://www.fiba.basketball/en/games/{game_id}`
#' @param game_id (integer, required) FIBA game id (global): gameId of a gdap schedule row, e.g. 100720 = the
#'   World Cup 2023 final.
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). The game must belong to it. Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list (the
#'   game-page objects `game`, `playByPlay`, `gameDetails`, `playersTeamA`, `playersTeamB`).
#' @eval .intl_details(.fiba_gamepage_box_players_details)
#'
#' @eval .returns_rd("fiba_gamepage_shots", inline = FALSE, unit = "shot")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gamepage_shots(game_id = 100720, comp = 208182))
#' }
fiba_gamepage_shots <- function(game_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .fiba_gamepage_route("shots", game_id, comp, return_parsed, call = rlang::current_env())
}

