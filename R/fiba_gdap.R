# fiba_gdap.R -- the fiba_gdap_* wrappers (R mirror of sportsdataverse-py sportsdataverse/basketball/fiba_hub/fiba_gdap.py).
# Same names, arguments, defaults and snake_case columns as sportsdataverse-py; the transport, refusals and
# parsers live in R/fiba_gdap_runtime.R, R/fiba_gdap_parsers.R and R/fiba_gamepage_runtime.R.

# The @details of every fiba topic that shares the fiba_gdap_awards() notes (roxygen @eval .intl_details()).
.fiba_gdap_awards_details <- c(
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
  "Errors are classed conditions (all inherit `hoopR_error`): `hoopR_no_data` when FIBA has nothing (HTTP 404,",
  "or GDAP answers `{}` / `[]` for an unknown id); `hoopR_bad_request` for HTTP 400 / 422 or a malformed id,",
  "season or date; `hoopR_asset_fetch` for any other failed fetch or an answer that is not about the request (an",
  "error envelope, HTTP 401 after a key refresh, HTTP 500, a body for another game, competition, team, player,",
  "federation, family or season). Seasons are FIBA's own key, which equals the sdv key: the END year for club",
  "competitions, the event year for national-team events, the target tournament year for qualifiers."
)

#' @title **FIBA GDAP: awards**
#' @description
#' Awards of a competition (MVP, All-Star Five...).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionawardsbyid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param discipline_format (character, optional) Optional; the site passes its discipline format. 5x5 answers
#'   the same as omitting it (verified on awards and rosters)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, full = TRUE, "fiba_gdap_awards(comp = 208182)")
#' @eval .returns_rd("fiba_gdap_awards", inline = FALSE, unit = "award")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_awards <- function(comp, discipline_format = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("awards", "getgdapcompetitionawardsbyid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call),
    disciplineFormat = discipline_format
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: competition**
#' @description
#' One competition (edition): season, dates, hosts, zone, category and competition family.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getGdapCompetitionById`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_competition", inline = FALSE, unit = "competition")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_competition(comp = 208182))
#' }
fiba_gdap_competition <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("competition", "getGdapCompetitionById", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: editions**
#' @description
#' Every edition of a competition family between two seasons.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionsbyseasonsandcompetitionmarketingname`
#' @param family_id (integer, required) Required. Competition family id
#'   (competitionMarketingName.competitionMarketingNameId): 201 = World Cup, 320 = men's Olympics, 306 = Women's
#'   World Cup, 112 = BCL tier 1, 211 = EuroLeague Women.
#' @param season (integer, optional) Season key: the END year for club competitions (BCL 2024-25 = 2025), the
#'   event year for national-team events (World Cup 2023 = 2023); qualifiers carry the TARGET tournament year
#'   (World Cup 2027 qualifiers played in 2025 = 2027). Sent unchanged. First season, inclusive; omitted = no
#'   lower bound.
#' @param to_season (integer, optional) Last season, inclusive (same key as season). Omitted with season given =
#'   the same season.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_editions", inline = FALSE, unit = "edition")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_editions(family_id = 201, season = 2023))
#' }
fiba_gdap_editions <- function(family_id, season = NULL, to_season = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("editions", "getgdapcompetitionsbyseasonsandcompetitionmarketingname", list(
    competitionMarketingNameId = .fiba_int_id(family_id, "family_id", call = call),
    fromSeason = .fiba_season(season, "season", call = call),
    toSeason = .fiba_season(to_season, "to_season", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: federation games**
#' @description
#' A federation's recent and upcoming national-team games.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapfederationgamesbyfederationid`
#' @param federation_id (integer, required) Required. Federation organisationId, stable across competitions (64
#'   = Germany; teamA.organisationId)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_federation_games(federation_id = 64)")
#' @eval .returns_rd("fiba_gdap_federation_games", inline = FALSE, unit = "game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_federation_games <- function(federation_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("federation_games", "getgdapfederationgamesbyfederationid", list(
    gdapFederationId = .fiba_int_id(federation_id, "federation_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: federation ranking**
#' @description
#' FIBA world ranking of national teams.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapfederationsranking`
#' @param category (character, default `"men"`) Ranking category: men or women (the site also knows boys/girls)
#' @param zone_id (integer, default `1L`) Ranking zone id from getgdaprankingzones (1 = World, 2 = Africa, 3 =
#'   Americas, 4 = Asia, 5 = Europe)
#' @param as_of_date (character, optional) Ranking as of this date, ISO 8601: the latest ranking published on or
#'   before it (2026-03-10 answers the 2026-03-03 ranking). Omitted = the latest ranking
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_federation_ranking(category = "men", zone_id = 1, as_of_date = "2025-09-15")')
#' @eval .returns_rd("fiba_gdap_federation_ranking", inline = FALSE, unit = "ranked federation")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_federation_ranking <- function(category = "men", zone_id = 1L, as_of_date = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("federation_ranking", "getgdapfederationsranking", list(
    gdapCategory = category,
    zoneRankingId = .fiba_int_id(zone_id, "zone_id", call = call),
    asOfDate = as_of_date
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: final standings**
#' @description
#' Final ranking of a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionfinalstandingbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_final_standings", inline = FALSE, unit = "team in the standings")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_final_standings(comp = 208182))
#' }
fiba_gdap_final_standings <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("final_standings", "getgdapcompetitionfinalstandingbycompetitionid", list(
    profile = "true",
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: game**
#' @description
#' One game's header: teams, score, venue, attendance and status codes (no box score or play-by-play: see
#' fiba_gamepage).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`
#' @param game_id (integer, required) Required. FIBA game id (global GDAP key space): gameId of a schedule row;
#'   the `<gameId>` of a game page URL
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_game", inline = FALSE, unit = "game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_game(game_id = 100720))
#' }
fiba_gdap_game <- function(game_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("game", "getgdapgamebyid", list(
    gdapGameId = .fiba_int_id(game_id, "game_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: game officials**
#' @description
#' Officials nominated to one game (referees, table officials, commissioner).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`
#' @param game_id (integer, required) Required. FIBA game id (global GDAP key space): gameId of a schedule row;
#'   the `<gameId>` of a game page URL
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_game_officials(game_id = 100720)")
#' @eval .returns_rd("fiba_gdap_game_officials", inline = FALSE, unit = "official")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_game_officials <- function(game_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("game_officials", "getgdapgamebyid", list(
    gdapGameId = .fiba_int_id(game_id, "game_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: game periods**
#' @description
#' Period scores of one game.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`
#' @param game_id (integer, required) Required. FIBA game id (global GDAP key space): gameId of a schedule row;
#'   the `<gameId>` of a game page URL
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_game_periods", inline = FALSE, unit = "period")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_game_periods(game_id = 100720))
#' }
fiba_gdap_game_periods <- function(game_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("game_periods", "getgdapgamebyid", list(
    gdapGameId = .fiba_int_id(game_id, "game_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: games between**
#' @description
#' Games of EVERY FIBA competition in a local-time window (how competitions and games are discovered).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamesbetweentwodates`
#' @param date_from (character, required) Required. Window start as YYYY-MM-DD, compared with the venue-local
#'   gameDateTime (not UTC).
#' @param date_to (character, required) Required. Window end as YYYY-MM-DD, EXCLUSIVE (date_from = date_to
#'   returns nothing).
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_games_between(date_from = "2023-09-08", date_to = "2023-09-11")')
#' @eval .returns_rd("fiba_gdap_games_between", inline = FALSE, unit = "game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_games_between <- function(date_from, date_to, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("games_between", "getgdapgamesbetweentwodates", list(
    dateFrom = .fiba_window_date(date_from, "date_from", call = call),
    dateTo = .fiba_window_date(date_to, "date_to", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: gateway competition ids**
#' @description
#' Ids of the competitions that run in a date window.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getcustomgateway`
#' @param start_date (character, required) Required. Window start as YYYY-MM-DD.
#' @param end_date (character, required) Required. Window end as YYYY-MM-DD.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_gateway_competition_ids(start_date = "2025-01-14", end_date = "2025-01-16")')
#' @eval .returns_rd("fiba_gdap_gateway_competition_ids", inline = FALSE, unit = "competition")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_gateway_competition_ids <- function(start_date, end_date, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("gateway_competition_ids", "getcustomgateway", list(
    fibaFunction = "competitionIdsBetweenTwoDates",
    startDate = .fiba_window_date(start_date, "start_date", call = call),
    endDate = .fiba_window_date(end_date, "end_date", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: gateway federation ranking**
#' @description
#' FIBA world ranking from the server-side gateway (same items as fiba_gdap_federation_ranking).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getcustomgateway`
#' @param gender (character, default `"men"`) federationRanking: men or women (= gdapCategory)
#' @param zone_id (integer, default `1L`) federationRanking: ranking zone id (= zoneRankingId)
#' @param as_of_date (character, optional) Ranking as of this date, ISO 8601: the latest ranking published on or
#'   before it (2026-03-10 answers the 2026-03-03 ranking). Omitted = the latest ranking
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, 'fiba_gdap_gateway_federation_ranking(gender = "men", zone_id = 1, as_of_date = "2025-09-15")')
#' @eval .returns_rd("fiba_gdap_gateway_federation_ranking", inline = FALSE, unit = "ranked federation")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_gateway_federation_ranking <- function(gender = "men", zone_id = 1L, as_of_date = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("gateway_federation_ranking", "getcustomgateway", list(
    fibaFunction = "federationRanking",
    gender = gender,
    zoneId = .fiba_int_id(zone_id, "zone_id", call = call),
    asOfDate = as_of_date
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: medal count**
#' @description
#' All-time medal table of a competition family.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapmedalcount`
#' @param family_id (integer, required) Required. Competition family id
#'   (competitionMarketingName.competitionMarketingNameId): 201 = World Cup, 320 = men's Olympics, 306 = Women's
#'   World Cup, 112 = BCL tier 1, 211 = EuroLeague Women.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_medal_count(family_id = 201)")
#' @eval .returns_rd("fiba_gdap_medal_count", inline = FALSE, unit = "team")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_medal_count <- function(family_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("medal_count", "getgdapmedalcount", list(
    competitionMarketingNameId = .fiba_int_id(family_id, "family_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: national teams**
#' @description
#' Every national federation FIBA lists.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapnationalteams`
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_national_teams()")
#' @eval .returns_rd("fiba_gdap_national_teams", inline = FALSE, unit = "team")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_national_teams <- function(return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("national_teams", "getgdapnationalteams", list(), return_parsed, call = rlang::current_env())
}

#' @title **FIBA GDAP: nominations**
#' @description
#' Officials nominated for a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionnominationsbyid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param level (character, default `"competition"`) competition = officials nominated for the whole competition
#'   (the only value the site sends)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_nominations(comp = 208182)")
#' @eval .returns_rd("fiba_gdap_nominations", inline = FALSE, unit = "nomination")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_nominations <- function(comp, level = "competition", return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("nominations", "getgdapcompetitionnominationsbyid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call),
    level = level
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: player game stats**
#' @description
#' A player's game log (full box lines) at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapplayergamestatisticsbyplayerid`
#' @param player_id (integer, required) Required. FIBA person id (global): personId of a roster row, pId in
#'   play-by-play, P_`<id>` in the game-page box
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_player_game_stats", inline = FALSE, unit = "player in the game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_player_game_stats(player_id = 211501, comp = 208182))
#' }
fiba_gdap_player_game_stats <- function(player_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("player_game_stats", "getgdapplayergamestatisticsbyplayerid", list(
    gdapPlayerId = .fiba_int_id(player_id, "player_id", call = call),
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: player info**
#' @description
#' A player's bio and per-game averages with ranks at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapplayerinfobycompetitionid`
#' @param player_id (integer, required) Required. FIBA person id (global): personId of a roster row, pId in
#'   play-by-play, P_`<id>` in the game-page box
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_player_info(player_id = 211501, comp = 208182)")
#' @eval .returns_rd("fiba_gdap_player_info", inline = FALSE, unit = "player")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_player_info <- function(player_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("player_info", "getgdapplayerinfobycompetitionid", list(
    gdapPlayerId = .fiba_int_id(player_id, "player_id", call = call),
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: player stats**
#' @description
#' A player's per-game averages, totals and highs at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapplayercompetitionstatisticsbyplayerid`
#' @param player_id (integer, required) Required. FIBA person id (global): personId of a roster row, pId in
#'   play-by-play, P_`<id>` in the game-page box
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_player_stats", inline = FALSE, unit = "player")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_player_stats(player_id = 211501, comp = 208182))
#' }
fiba_gdap_player_stats <- function(player_id, comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("player_stats", "getgdapplayercompetitionstatisticsbyplayerid", list(
    gdapPlayerId = .fiba_int_id(player_id, "player_id", call = call),
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: ranking zones**
#' @description
#' FIBA world-ranking zones.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdaprankingzones`
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_ranking_zones()")
#' @eval .returns_rd("fiba_gdap_ranking_zones", inline = FALSE, unit = "ranking zone")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_ranking_zones <- function(return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("ranking_zones", "getgdaprankingzones", list(), return_parsed, call = rlang::current_env())
}

#' @title **FIBA GDAP: roster**
#' @description
#' A team's roster at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamrosterbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param discipline_format (character, optional) Optional; the site passes its discipline format. 5x5 answers
#'   the same as omitting it (verified on awards and rosters)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_roster", inline = FALSE, unit = "player")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_roster(team_id = 279569))
#' }
fiba_gdap_roster <- function(team_id, discipline_format = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("roster", "getgdapcompetitionteamrosterbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call),
    disciplineFormat = discipline_format
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: roster coaches**
#' @description
#' A team's coaches on its roster at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamrosterbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param discipline_format (character, optional) Optional; the site passes its discipline format. 5x5 answers
#'   the same as omitting it (verified on awards and rosters)
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_roster_coaches(team_id = 279569)")
#' @eval .returns_rd("fiba_gdap_roster_coaches", inline = FALSE, unit = "staff member")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_roster_coaches <- function(team_id, discipline_format = NULL, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("roster_coaches", "getgdapcompetitionteamrosterbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call),
    disciplineFormat = discipline_format
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: roster latest**
#' @description
#' A team's latest roster (same shape as the roster).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamlatestrosterbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_roster_latest(team_id = 282183)")
#' @eval .returns_rd("fiba_gdap_roster_latest", inline = FALSE, unit = "player")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_roster_latest <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("roster_latest", "getgdapcompetitionteamlatestrosterbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: round gamedays**
#' @description
#' Rounds of a competition with their game days.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionroundgamedaysbyid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_round_gamedays(comp = 208182)")
#' @eval .returns_rd("fiba_gdap_round_gamedays", inline = FALSE, unit = "round game day")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_round_gamedays <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("round_gamedays", "getgdapcompetitionroundgamedaysbyid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: round standings**
#' @description
#' Group standings of every round of a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_round_standings", inline = FALSE, unit = "team in the standings")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_round_standings(comp = 208182))
#' }
fiba_gdap_round_standings <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("round_standings", "getgdaproundsbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: rounds**
#' @description
#' Rounds of a competition (group stage, knockout rounds).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdaproundsbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_rounds", inline = FALSE, unit = "round")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_rounds(comp = 208182))
#' }
fiba_gdap_rounds <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("rounds", "getgdaproundsbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: schedule**
#' @description
#' Schedule and results of one competition (edition): one row per game.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamesbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_schedule", inline = FALSE, unit = "game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_schedule(comp = 208182))
#' }
fiba_gdap_schedule <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("schedule", "getgdapgamesbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team games**
#' @description
#' A team's games with each team's leaders.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgameswithleaderdetailsbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_team_games", inline = FALSE, unit = "game")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_team_games(team_id = 279569))
#' }
fiba_gdap_team_games <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_games", "getgdapgameswithleaderdetailsbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team player stats**
#' @description
#' Per-game averages of every player of a team at a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamstatisticsbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_team_player_stats(team_id = 279569)")
#' @eval .returns_rd("fiba_gdap_team_player_stats", inline = FALSE, unit = "player of the team")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_team_player_stats <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_player_stats", "getgdapcompetitionteamstatisticsbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team staff**
#' @description
#' Coaches of every team of a competition.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapteamstaffbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details, "fiba_gdap_team_staff(comp = 208182)")
#' @eval .returns_rd("fiba_gdap_team_staff", inline = FALSE, unit = "staff member")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
fiba_gdap_team_staff <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_staff", "getgdapteamstaffbycompetitionid", list(
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: team stats**
#' @description
#' A team's per-game averages and totals at a competition, with the bench totals.
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamstatisticsbyteamid`
#' @param team_id (integer, required) Required. Competition team id: one per team per competition (teamA.teamId
#'   of a game row; Germany is 279569 at the 2023 World Cup and 281545 at Paris 2024). Not the federation
#'   organisationId
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_team_stats", inline = FALSE, unit = "team")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_team_stats(team_id = 279569))
#' }
fiba_gdap_team_stats <- function(team_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("team_stats", "getgdapcompetitionteamstatisticsbyteamid", list(
    gdapTeamId = .fiba_int_id(team_id, "team_id", call = call)
  ), return_parsed, call = call)
}

#' @title **FIBA GDAP: teams**
#' @description
#' Teams of a competition with their profile (final ranking, per-game averages).
#'
#' Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapcompetitionteamsbycompetitionid`
#' @param comp (integer, required) Required. FIBA competition id (GDAP key space), one per edition:
#'   competition.competitionId of any game row (208182 = World Cup 2023, 208722 = Paris 2024 men, 208850 = BCL
#'   2024-25). Find it with fiba_gdap_editions or fiba_gdap_games_between.
#' @param return_parsed Parse the payload into a tibble (default `TRUE`); `FALSE` returns the raw JSON list.
#' @eval .intl_details(.fiba_gdap_awards_details)
#' @eval .returns_rd("fiba_gdap_teams", inline = FALSE, unit = "team")
#' @concept FIBA Functions
#' @seealso [family_fiba] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(fiba_gdap_teams(comp = 208182))
#' }
fiba_gdap_teams <- function(comp, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  .fiba_gdap_route("teams", "getgdapcompetitionteamsbycompetitionid", list(
    profile = "true",
    gdapCompetitionId = .fiba_int_id(comp, "comp", call = call)
  ), return_parsed, call = call)
}

