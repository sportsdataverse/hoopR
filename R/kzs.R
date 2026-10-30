# kzs.R -- KZS (Basketball Federation of Slovenia) wrappers over api.kzs.si/api/v1/public, the read API the
# kzs.si site calls, at parity with sportsdataverse-py sportsdataverse/basketball/kzs (origin/main e3d232ebc9).
# Transport, season mapping and refusals: R/kzs_runtime.R; frames: R/kzs_parsers.R; columns: R/kzs_schema.R.

# The @details of every kzs topic that shares the kzs_seasons() notes (roxygen @eval .intl_details()).
.kzs_seasons_details <- c(
  "* Unofficial and unsupported: these wrappers read the public read API (Java/Spring, built by OnixWeb) that the",
  "  kzs.si site itself calls. No terms of use were located (unverified), api.kzs.si/robots.txt answers 401 and",
  "  www.kzs.si/robots.txt 404, so no policy or Crawl-delay is published. The runtime waits at least 1 s before every",
  "  request, retries included.",
  "* Personal data: the API serves officials' and coaches' emails, phones and home towns, and clubs' bank accounts and",
  "  addresses, publicly. The parsers never output them (officials appear by name only; club addresses, personnel and",
  "  the commissioner report are dropped). Do not add them back.",
  "* Seasons are END years (2027 = 2026/2027); KZS' own season ids are opaque (27 = 2026/2027) and the runtime maps",
  "  them. Competition ids are per season. Three team keys are never interchangeable: the match-team id (per match and",
  "  side), team_id (one club team in one season) and club_id (across seasons). player_id is the registry id,",
  "  person_id the person behind it.",
  "* Errors are HTTP 400 for everything (an unknown id and a bad parameter alike), so the runtime raises",
  "  `hoopR_asset_fetch` for it, never `hoopR_bad_request` or an empty frame. List routes default to 150 rows with no",
  "  truncation signal: every list wrapper asks for a large limit and refuses a full page. The play-by-play and",
  "  box-score wrappers, the leaderboards, teams, rounds and playing days each make one extra, cached request (the",
  "  match header or the competition) to prove the answer is the one asked for and the game is final.",
  "* Coverage: scores from 2007/08; box scores and play-by-play from 2015/16. Some 2020/21 men's games have a box",
  "  score but no play-by-play (`hoopR_no_data`): the Genius data.json (genius_match_id in kzs_matches) is the",
  "  fallback. Shot x/y are Genius court percent; side (LEFT/RIGHT) names the basket end and teams switch ends at half",
  "  time, so normalise with side before stacking shots. Advanced box-score fields are 0 in every observed game.",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (an empty answer or list, a",
  "  competition without standings, a final game with no play-by-play or box score, HTTP 404), `hoopR_asset_fetch`",
  "  (HTTP 400, the API's only error status for an unknown id and a bad parameter alike; any other non-2xx; a non-JSON",
  "  or empty body; an envelope whose status is not OK; a full list page; a game that is not final; a body for another",
  "  competition, match, team, player or season than the one asked for) and `hoopR_bad_request` (a bad argument,",
  "  before any request). HTTP 500 is retried. Wrappers raise; they never return an empty frame for a failed fetch."
)

#' @title
#' **Get KZS Seasons**
#' @description
#' Every season (39: 1991/1992 to 2029/2030) with its opaque id and the sdv END year.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/seasons/`
#' @return
#' A `hoopR_data` tibble: Every season (39: 1991/1992 to 2029/2030) with its opaque id and the sdv END year. An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
#' | name | character | Season, 'START/END' (2025/2026); the sdv season is the END year. |
#' | is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
#' | active | logical | Same as `isActive`. |
#' | season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
#' @eval .intl_details(.kzs_seasons_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(kzs_seasons())
#' }
#' @export
#' @family KZS Functions
kzs_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  raw <- .kzs_get("/seasons/", ids = list(), query = list(limit = 1000L), call = call)
  .kzs_out(.kzs_parse("seasons", raw), "KZS Seasons from api.kzs.si")
}

#' @title
#' **Get KZS Competitions**
#' @description
#' Competitions of a season (leagues, cups, youth, 3x3, national teams), or of every season.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/`
#' @param season Season END year (2027 = 2026/2027); the wrapper maps it to KZS' opaque season id. Omitted = every
#'   season (627 competitions).
#' @return
#' A `hoopR_data` tibble: Competitions of a season (leagues, cups, youth, 3x3, national teams), or of every season. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py
#'   `kzs_competitions`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
#' | name | character | Competition name, Slovenian; the sponsor name changes over the years (glossary in kzs-returns.md). |
#' | gender | character | MALE or FEMALE. |
#' | category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
#' | rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
#' | season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
#' | season_name | character | Season, 'START/END' (2025/2026); sdv season = the END year. |
#' | season_is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
#' | season_active | logical | Same as `isActive`. |
#' | type | character | Competition type (code table); absent on 2 competitions. |
#' | season | integer | The competition's season. |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_competitions(season = 2026))
#' }
#' @export
#' @family KZS Functions
kzs_competitions <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  raw <- .kzs_get("/competitions/", ids = list(), query = list(limit = 10000L, season = season), call = call)
  .kzs_out(.kzs_parse("competitions", raw), "KZS Competitions from api.kzs.si")
}

#' @title
#' **Get KZS Competition**
#' @description
#' One competition: season, gender, category, rank and type (its phases are kzs_phases).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: One competition: season, gender, category, rank and type (its phases are kzs_phases). An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py
#'   `kzs_competition`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
#' | name | character | Competition name, Slovenian (glossary in kzs-returns.md). |
#' | season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
#' | season_name | character | Season, 'START/END' (2025/2026); sdv season = the END year. |
#' | season_is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
#' | season_active | logical | Same as `isActive`. |
#' | gender | character | MALE or FEMALE. |
#' | category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
#' | rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
#' | type | character | Competition type (code table). |
#' | season | integer | Season of the record: opaque id and 'START/END' name. |
#' | social_medias | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_competition(competition_id = 579))
#' }
#' @export
#' @family KZS Functions
kzs_competition <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/competitions/{competition_id}", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("competition", raw), "KZS Competition from api.kzs.si")
}

#' @title
#' **Get KZS Competition Phases**
#' @description
#' The phases of a competition (regular season, play-offs, finals) with dates and type.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: The phases of a competition (regular season, play-offs, finals) with dates and type. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_phases`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
#' | phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
#' | name | character | Phase name, Slovenian: 'Redni del' = regular season, 'Cetrtfinale' = quarterfinal, 'Polfinale' = semifinal, 'Finale' = final, '1. del' / '2. del' = first / second stage. |
#' | start_date | character | Phase start date (UTC midnight). |
#' | end_date | character | Phase end date (UTC midnight). |
#' | type | character | Phase format (code table). |
#' | groups | character | Groups of the phase (empty when the phase has one table). |
#' | wins_needed | integer | Wins needed to take a best-of series. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_phases(competition_id = 579)")
#' @export
#' @family KZS Functions
kzs_phases <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/competitions/{competition_id}", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("phases", raw), "KZS Competition Phases from api.kzs.si")
}

#' @title
#' **Get KZS Competition Rounds**
#' @description
#' Number of rounds of each phase of a competition.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/rounds`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: Number of rounds of each phase of a competition. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_rounds`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
#' | rounds | integer | Number of rounds in the phase. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_rounds(competition_id = 579)")
#' @export
#' @family KZS Functions
kzs_rounds <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/competitions/{competition_id}/rounds", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("rounds", raw), "KZS Competition Rounds from api.kzs.si")
}

#' @title
#' **Get KZS Player Leaderboard**
#' @description
#' Player leaderboard of a competition for one stat category (total, per-game average and single-game best).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/playerStats`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @param stats_category Stat category (the site's statsCategory): PTS points, M_2/A_2/PERC_2 two-pointers,
#'   M_3/A_3/PERC_3 three-pointers, M_FG/A_FG/PERC_FG field goals, M_FT/A_FT/PERC_FT free throws, R rebounds (R_D
#'   defensive, R_O offensive), ASS assists, ST steals, TOV turnovers, PF_CM/PF_RV fouls committed/received, ASS_TOV
#'   and ST_TOV ratios. Competitions without live stats offer only PTS, M_2, M_3, M_FT, A_FT, PERC_FT. One of "PTS",
#'   "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG", "PERC_FG", "M_FT", "A_FT", "PERC_FT", "R", "R_D",
#'   "R_O", "ASS", "ST", "TOV", "PF_CM", "PF_RV", "ASS_TOV", "ST_TOV".
#' @param order_type Figure the leaderboard is built on: AVERAGE (per game), SUM (season total) or BEST_PERFORMANCE.
#'   One of "AVERAGE", "SUM", "BEST_PERFORMANCE".
#' @param sort_by Row column the board is ordered by: avg (average), sum or max. The runtime checks the order. One of
#'   "avg", "sum", "max".
#' @param sort Sort direction. One of "ASC", "DESC".
#' @return
#' A `hoopR_data` tibble: Player leaderboard of a competition for one stat category (total, per-game average and
#'   single-game best). An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order
#'   (sportsdataverse-py `kzs_player_leaderboard`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | stats_category | character | Stat category of the board (PTS points, R rebounds, ASS assists ...): the request's, the rows do not echo it. |
#' | club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
#' | club_fullname | character | Club's full legal name. |
#' | club_logo_uuid | character | Club logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | club_code | character | Club 3-letter code. |
#' | team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
#' | team_name | character | Team name for the season, sponsor included. |
#' | games_played | integer | Games the player played in the competition. |
#' | sum | double | Season total of the requested statsCategory. |
#' | average | double | Per-game average of the statsCategory. |
#' | max | double | Single-game best of the statsCategory. |
#' | player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | player_firstname | character | The player's given name as registered with KZS (lower-case n in this route). |
#' | player_lastname | character | The player's family name as registered with KZS (lower-case n in this route). |
#' | photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_player_leaderboard(competition_id = 579)")
#' @export
#' @family KZS Functions
kzs_player_leaderboard <- function(competition_id, stats_category = "PTS", order_type = "AVERAGE", sort_by = "avg",
                                    sort = "DESC") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  stats_category <- .kzs_choice(stats_category, .KZS_STATS_CATEGORIES, "stats_category", call = call)
  order_type <- .kzs_choice(order_type, c("AVERAGE", "SUM", "BEST_PERFORMANCE"), "order_type", call = call)
  sort_by <- .kzs_choice(sort_by, c("avg", "sum", "max"), "sort_by", call = call)
  sort <- .kzs_choice(sort, c("ASC", "DESC"), "sort", call = call)
  raw <- .kzs_get("/competitions/{competition_id}/playerStats", ids = list(competition_id = competition_id),
                  query = list(limit = 1000L, statsCategory = stats_category, orderType = order_type, sortBy = sort_by,
                  sort = sort), call = call)
  .kzs_out(.kzs_parse("player_leaderboard", raw), "KZS Player Leaderboard from api.kzs.si")
}

#' @title
#' **Get KZS Team Leaderboard**
#' @description
#' Team leaderboard of a competition for one stat category (total, per-game average and single-game best).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/teamStats`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @param stats_category Stat category (the site's statsCategory): PTS points, M_2/A_2/PERC_2 two-pointers,
#'   M_3/A_3/PERC_3 three-pointers, M_FG/A_FG/PERC_FG field goals, M_FT/A_FT/PERC_FT free throws, R rebounds (R_D
#'   defensive, R_O offensive), ASS assists, ST steals, TOV turnovers, PF_CM/PF_RV fouls committed/received, ASS_TOV
#'   and ST_TOV ratios. Competitions without live stats offer only PTS, M_2, M_3, M_FT, A_FT, PERC_FT. One of "PTS",
#'   "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG", "PERC_FG", "M_FT", "A_FT", "PERC_FT", "R", "R_D",
#'   "R_O", "ASS", "ST", "TOV", "PF_CM", "PF_RV", "ASS_TOV", "ST_TOV".
#' @param order_type Figure the leaderboard is built on: AVERAGE (per game), SUM (season total) or BEST_PERFORMANCE.
#'   One of "AVERAGE", "SUM", "BEST_PERFORMANCE".
#' @param sort_by Row column the board is ordered by: avg (average), sum or max. The runtime checks the order. One of
#'   "avg", "sum", "max".
#' @param sort Sort direction. One of "ASC", "DESC".
#' @return
#' A `hoopR_data` tibble: Team leaderboard of a competition for one stat category (total, per-game average and
#'   single-game best). An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order
#'   (sportsdataverse-py `kzs_team_leaderboard`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | stats_category | character | Stat category of the board (PTS points, R rebounds, ASS assists ...): the request's, the rows do not echo it. |
#' | club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
#' | club_fullname | character | Club's full legal name. |
#' | club_logo_uuid | character | Club logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | club_code | character | Club 3-letter code. |
#' | team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
#' | team_name | character | Team name for the season, sponsor included. |
#' | games_played | integer | Games the team played in the competition. |
#' | sum | double | Season total of the requested statsCategory. |
#' | average | double | Per-game average of the statsCategory. |
#' | max | double | Single-game best of the statsCategory. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_team_leaderboard(competition_id = 579)")
#' @export
#' @family KZS Functions
kzs_team_leaderboard <- function(competition_id, stats_category = "PTS", order_type = "AVERAGE", sort_by = "avg", sort
                                  = "DESC") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  stats_category <- .kzs_choice(stats_category, .KZS_STATS_CATEGORIES, "stats_category", call = call)
  order_type <- .kzs_choice(order_type, c("AVERAGE", "SUM", "BEST_PERFORMANCE"), "order_type", call = call)
  sort_by <- .kzs_choice(sort_by, c("avg", "sum", "max"), "sort_by", call = call)
  sort <- .kzs_choice(sort, c("ASC", "DESC"), "sort", call = call)
  raw <- .kzs_get("/competitions/{competition_id}/teamStats", ids = list(competition_id = competition_id),
                  query = list(limit = 1000L, statsCategory = stats_category, orderType = order_type, sortBy = sort_by,
                  sort = sort), call = call)
  .kzs_out(.kzs_parse("team_leaderboard", raw), "KZS Team Leaderboard from api.kzs.si")
}

#' @title
#' **Get KZS Matches**
#' @description
#' Matches of a competition (optionally inside a from/to window) with the Genius LiveStats id.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @param date_from Earliest tip-off, an ISO instant such as 2025-10-01T00:00:00.000Z (a bare date is a 400). Omitted
#'   = the whole competition.
#' @param date_to Latest tip-off, an ISO instant such as 2025-10-31T23:59:59.000Z. Omitted = the whole competition.
#' @return
#' A `hoopR_data` tibble: Matches of a competition (optionally inside a from/to window) with the Genius LiveStats id.
#'   An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_matches`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | KZS match id. Joins to `/matches/{matchId}` (and its /playByPlay, /stats) and stats `matchId`. |
#' | competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
#' | competition_name | character | Competition name (Slovenian; the sponsor name changes: Liga Telemach 2007-15, NovaKBM 2015-24, OTP banka 2024-). |
#' | competition_type | character | Competition type (code table). |
#' | competition_phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
#' | competition_phase_name | character | Phase name, Slovenian ('Redni del' = regular season, '1. del' = first stage). |
#' | transferred | logical | True when the match was carried over from an earlier phase (results transferred). |
#' | season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
#' | season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
#' | genius_match_id | integer | Genius LiveStats match id parsed from fiba_live_stats_url (org KZS); null before 2015/16. |
#' | organiser_team_id | integer | Team id of the organiser (home) side; null in older headers, which send an empty organiser. |
#' | round | integer | Round (matchday) number within the phase. |
#' | fiba_live_stats_url | character | Genius Sports LiveStats URL `'https://fibalivestats.dcd.shared.geniussports.com/u/KZS/{geniusMatchId}/'`; the number is the Genius match id that keys genius-livestats/ data.json. Absent before 2015-16 (no live stats). |
#' | game_index | integer | Game number within the round (fixture order). |
#' | date_time | character | Tip-off, UTC (ISO 8601 'Z'). |
#' | attendance | integer | Spectators (0 when not recorded). |
#' | sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
#' | sport_hall_address | character | Venue address, one line. |
#' | sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
#' | first_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. First (home) side. |
#' | first_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. First (home) team. |
#' | is_first_team_placeholder | logical | True when the first (home) slot is a bracket placeholder, not yet a team. |
#' | second_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. Second (away) side. |
#' | second_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. Second (away) team. |
#' | is_second_team_placeholder | logical | True when the second (away) slot is a placeholder. |
#' | first_team_name | character | First (home) team name. |
#' | first_team_short_name | character | First team short name ('' when none). |
#' | second_team_name | character | Second (away) team name. |
#' | second_team_short_name | character | Second team short name ('' when none). |
#' | first_team_score | integer | First (home) team final score. |
#' | second_team_score | integer | Second (away) team final score. |
#' | score_inserted_manually | logical | True when the score was typed in by the federation rather than taken from the live-stats feed. |
#' | first_team_logo_uuid | character | First (home) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}` (PNG). |
#' | second_team_logo_uuid | character | Second (away) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}` (PNG). |
#' | first_team_code | character | First team 3-letter code (club code). |
#' | second_team_code | character | Second team 3-letter code. |
#' | status | character | Match status: FINISHED in every sample (POSTPONED filtered by the site on other lists). |
#' | delegated | logical | True once officials are assigned to the match. |
#' | referee1_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee1_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee1_person_first_name | character | The official's given name. |
#' | referee1_person_last_name | character | The official's family name. |
#' | referee1_person_gender | character | MALE or FEMALE. |
#' | referee1_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | referee2_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee2_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee2_person_first_name | character | The official's given name. |
#' | referee2_person_last_name | character | The official's family name. |
#' | referee2_person_gender | character | MALE or FEMALE. |
#' | referee2_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | referee3_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee3_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee3_person_first_name | character | The official's given name. |
#' | referee3_person_last_name | character | The official's family name. |
#' | referee3_person_gender | character | MALE or FEMALE. |
#' | referee3_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | commissioner_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | commissioner_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | commissioner_person_first_name | character | The official's given name. |
#' | commissioner_person_last_name | character | The official's family name. |
#' | commissioner_person_gender | character | MALE or FEMALE. |
#' | commissioner_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | referee_controller_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee_controller_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee_controller_person_first_name | character | The official's given name. |
#' | referee_controller_person_last_name | character | The official's family name. |
#' | referee_controller_person_gender | character | MALE or FEMALE. |
#' | referee_controller_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | match_evaluation_id | integer | Id of the officials' evaluation record (internal; no public route). |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_matches(
#'     competition_id = 579, date_from = "2025-10-01T00:00:00.000Z",
#'     date_to = "2025-10-31T23:59:59.000Z"
#'   ))
#' }
#' @export
#' @family KZS Functions
kzs_matches <- function(competition_id, date_from = NULL, date_to = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  date_from <- .kzs_opt_str(date_from, "date_from", call = call)
  date_to <- .kzs_opt_str(date_to, "date_to", call = call)
  raw <- .kzs_get("/matches/", ids = list(), query = list(limit = 1000L, competitionId = competition_id,
                  from = date_from, to = date_to), call = call)
  .kzs_out(.kzs_parse("matches", raw), "KZS Matches from api.kzs.si")
}

#' @title
#' **Get KZS Match Header**
#' @description
#' Match header: teams, scores, venue, officials' names, best performers and status.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Match header: teams, scores, venue, officials' names, best performers and status. An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_match`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | KZS match id. Joins to `/matches/{matchId}` (and its /playByPlay, /stats) and stats `matchId`. |
#' | competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
#' | competition_name | character | Competition name (Slovenian; the sponsor name changes: Liga Telemach 2007-15, NovaKBM 2015-24, OTP banka 2024-). |
#' | competition_type | character | Competition type (code table). |
#' | competition_phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
#' | competition_phase_name | character | Phase name, Slovenian (see `phases[].name`). |
#' | transferred | logical | True when the match was carried over from an earlier phase (results transferred). |
#' | season_id | integer | Opaque KZS season id (27 = 2026/2027); the sdv season is the END year in season. |
#' | season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
#' | genius_match_id | integer | Genius LiveStats match id parsed from fiba_live_stats_url (org KZS); null before 2015/16. |
#' | organiser_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. The organising (home) team. |
#' | round | integer | Round (matchday) number within the phase. |
#' | fiba_live_stats_url | character | Genius Sports LiveStats URL `'https://fibalivestats.dcd.shared.geniussports.com/u/KZS/{geniusMatchId}/'`; the number is the Genius match id that keys genius-livestats/ data.json. Absent before 2015-16 (no live stats). |
#' | game_index | integer | Game number within the round (fixture order). |
#' | date_time | character | Tip-off, UTC (ISO 8601 'Z'). |
#' | attendance | integer | Spectators (0 when not recorded). |
#' | first_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. First (home) side. |
#' | first_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
#' | first_team_name | character | First (home) team name; absent on 2007-08 headers. |
#' | first_team_home_jersey_color | character | First team home colour, hex. |
#' | first_team_guest_jersey_color | character | First team away colour, hex. |
#' | first_team_logo_uuid | character | First (home) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | first_team_code | character | First team 3-letter code. |
#' | first_team_forfeited | logical | True when this team forfeited. |
#' | first_team_is_placeholder | logical | True when the slot is a bracket placeholder. |
#' | first_team_best_performer_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | first_team_best_performer_player_first_name | character | The player's given name as registered with KZS. |
#' | first_team_best_performer_player_last_name | character | The player's family name as registered with KZS. |
#' | first_team_best_performer_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | first_team_best_performer_efficiency | integer | Efficiency (PIR) in the match. |
#' | first_team_best_performer_points | integer | Points in the match. |
#' | first_team_best_performer_rebounds | integer | Rebounds in the match. |
#' | first_team_best_performer_assists | integer | Assists in the match. |
#' | first_team_best_performer_steals | integer | Steals in the match. |
#' | first_team_best_performer_blocks | integer | Blocks in the match. |
#' | second_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. Second (away) side. |
#' | second_team_team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
#' | second_team_name | character | Second (away) team name; absent on 2007-08 headers. |
#' | second_team_home_jersey_color | character | Second team home colour, hex. |
#' | second_team_guest_jersey_color | character | Second team away colour, hex. |
#' | second_team_logo_uuid | character | Second (away) team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | second_team_code | character | Second team 3-letter code. |
#' | second_team_forfeited | logical | True when this team forfeited. |
#' | second_team_is_placeholder | logical | True when the slot is a bracket placeholder. |
#' | second_team_best_performer_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | second_team_best_performer_player_first_name | character | The player's given name as registered with KZS. |
#' | second_team_best_performer_player_last_name | character | The player's family name as registered with KZS. |
#' | second_team_best_performer_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | second_team_best_performer_efficiency | integer | Efficiency (PIR) in the match. |
#' | second_team_best_performer_points | integer | Points in the match. |
#' | second_team_best_performer_rebounds | integer | Rebounds in the match. |
#' | second_team_best_performer_assists | integer | Assists in the match. |
#' | second_team_best_performer_steals | integer | Steals in the match. |
#' | second_team_best_performer_blocks | integer | Blocks in the match. |
#' | sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
#' | sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
#' | first_team_score | integer | First (home) team final score. |
#' | second_team_score | integer | Second (away) team final score. |
#' | score_inserted_manually | logical | True when the score was typed in by the federation rather than taken from the live-stats feed. |
#' | status | character | Match status: FINISHED in every sample (the capture banks final games only); the site also filters POSTPONED matches. |
#' | referee1_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee1_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee1_person_first_name | character | The official's given name. |
#' | referee1_person_last_name | character | The official's family name. |
#' | referee1_person_gender | character | MALE or FEMALE. |
#' | referee1_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | referee2_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee2_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee2_person_first_name | character | The official's given name. |
#' | referee2_person_last_name | character | The official's family name. |
#' | referee2_person_gender | character | MALE or FEMALE. |
#' | referee2_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | referee3_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee3_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee3_person_first_name | character | The official's given name. |
#' | referee3_person_last_name | character | The official's family name. |
#' | referee3_person_gender | character | MALE or FEMALE. |
#' | referee3_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | commissioner_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | commissioner_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | commissioner_person_first_name | character | The official's given name. |
#' | commissioner_person_last_name | character | The official's family name. |
#' | commissioner_person_gender | character | MALE or FEMALE. |
#' | commissioner_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | referee_controller_id | integer | Official id (referee/commissioner registry); a different key space from `person.id`. /referees/ and /commissioners/ are in the site bundle but not captured. |
#' | referee_controller_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | referee_controller_person_first_name | character | The official's given name. |
#' | referee_controller_person_last_name | character | The official's family name. |
#' | referee_controller_person_gender | character | MALE or FEMALE. |
#' | referee_controller_ranks | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | gender | character | MALE or FEMALE. |
#' | live_stats | logical | True when the match has live stats (box score and play-by-play). |
#' | without_stats | logical | True when the match keeps no statistics. |
#' | delegated | logical | True once officials are assigned to the match. |
#' | home_jersey_color | character | Home jersey colour, hex '#RRGGBB'. |
#' | guest_jersey_color | character | Away jersey colour, hex. |
#' | bests | character | Each team's top player per stat. |
#' | match_evaluation_id | integer | Id of the officials' evaluation record (internal; no public route). |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_match(match_id = 101839))
#' }
#' @export
#' @family KZS Functions
kzs_match <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("match", raw), "KZS Match Header from api.kzs.si")
}

#' @title
#' **Get KZS Period Scores**
#' @description
#' Points by match part (quarters and overtimes) from the match header.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Points by match part (quarters and overtimes) from the match header. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_period_scores`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
#' | score_id | integer | Period-score row id. |
#' | match_part | character | Period: QUARTER1-QUARTER4, then OT1 for the first overtime (OT2 and on by the same pattern, unobserved). |
#' | first_team_score | integer | First (home) team points in the period. |
#' | second_team_score | integer | Second (away) team points in the period. |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_period_scores(match_id = 101839))
#' }
#' @export
#' @family KZS Functions
kzs_period_scores <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("period_scores", raw), "KZS Period Scores from api.kzs.si")
}

#' @title
#' **Get KZS Play-by-Play**
#' @description
#' Play-by-play of a final game (2015/16 on, with gaps), one row per action with shot x/y.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/playByPlay`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Play-by-play of a final game (2015/16 on, with gaps), one row per action with shot x/y. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_pbp`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
#' | action_number | integer | 1-based position of the action in the feed, which is in game order. |
#' | team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
#' | source | character | Feed the action came from: GENIUS_SPORTS in every sample. |
#' | clock | character | Time remaining in the period, 'MM:SS:CC' (minutes, seconds, hundredths): '09:56:00' = 9:56 left. |
#' | action_type | character | Action type (code table). |
#' | sub_type | character | Action subtype ('' when none; code table). |
#' | qualifiers | character | Semicolon-separated qualifiers ('' when none; code table). |
#' | x | double | Location along the court length, 0-100 percent (see the coordinate section): shots, and from 2020-21 fouls and turnovers; 0.0 when the row has no location. |
#' | y | double | Location across the court width, 0-100 percent (see the coordinate section); 0.0 when the row has no location. |
#' | area | character | Court zone of the action (code table): set on shots, and from 2020-21 on located fouls and turnovers; '' on rows without a location and on every shot of early 2015-16 games. |
#' | side | character | Basket end: LEFT (x~0) or RIGHT (x~100). Absent on non-shot rows before 2020-21 and on some 2020-21 rows (read absent on a shot as LEFT). |
#' | success | logical | True when the shot / free throw was made (true on non-shot rows). |
#' | score1 | integer | First (home) team score after the action, a numeric STRING. |
#' | score2 | integer | Second (away) team score after the action, a numeric STRING. |
#' | period | integer | Period number; overtime restarts at 1 with periodType OVERTIME. |
#' | period_type | character | REGULAR or OVERTIME. |
#' | part | character | Period label: QUARTER1-QUARTER4, then OT1 (OT2 and on by the same pattern, unobserved). |
#' | match_team_player_id | integer | Match-player id: the player's entry in this one match; NOT the player id. No captured route is keyed by it: join on `playerId` on the same row. |
#' | player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | match_team_player_first_name | character | The acting player's given name, as entered for this match. |
#' | match_team_player_last_name | character | The acting player's family name, as entered for this match. |
#' | team_application_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
#' | team_name | character | Team name for the season, sponsor included (e.g. 'Perspektiva Ilirija'). |
#' | match_team_id | integer | Match-team id: this team's entry in this one match (unique per match and side). Joins to play-by-play `matchTeamId`; NOT a team id. |
#' | player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | shirt_number | character | Shirt number worn by the acting player, sent as a string. |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_pbp(match_id = 101839))
#' }
#' @export
#' @family KZS Functions
kzs_pbp <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/playByPlay", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("pbp", raw), "KZS Play-by-Play from api.kzs.si")
}

#' @title
#' **Get KZS Play-by-Play Players**
#' @description
#' The players the play-by-play feed lists for each side of a final game.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/playByPlay`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @return
#' A `hoopR_data` tibble: The players the play-by-play feed lists for each side of a final game. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_pbp_players`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
#' | team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
#' | player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. Players listed here are the first (home) team. |
#' | first_name | character | The home player's (as in the feed) given name. |
#' | last_name | character | The home player's (as in the feed) family name. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_pbp_players(match_id = 101839)")
#' @export
#' @family KZS Functions
kzs_pbp_players <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/playByPlay", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("pbp_players", raw), "KZS Play-by-Play Players from api.kzs.si")
}

#' @title
#' **Get KZS Player Box Score**
#' @description
#' Box score of a final game (2015/16 on): one row per player of both teams.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Box score of a final game (2015/16 on): one row per player of both teams. An empty valid
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_box_score`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
#' | team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
#' | team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
#' | team_name | character | Name of the team for the season, sponsor included. |
#' | minutes | double | The player's minutes played, decimal minutes (39.67 = 39 min 40 s); the team line sums its players (225.0 = 5 x 45 with overtime). |
#' | two_pm | integer | The player's two-point field goals made. |
#' | two_pa | integer | The player's two-point field goals attempted. |
#' | two_p_perc | double | The player's two-point percentage, 0-100. |
#' | three_pm | integer | The player's three-point field goals made. |
#' | three_pa | integer | The player's three-point field goals attempted. |
#' | three_p_perc | double | The player's three-point percentage, 0-100. |
#' | f_tm | integer | The player's free throws made. |
#' | f_ta | integer | The player's free throws attempted. |
#' | f_t_perc | double | The player's free-throw percentage, 0-100. |
#' | fg_m | integer | The player's field goals made. |
#' | fg_a | integer | The player's field goals attempted. |
#' | fg_perc | double | The player's field-goal percentage, 0-100. |
#' | offensive_rebounds | integer | The player's offensive rebounds. |
#' | defensive_rebounds | integer | The player's defensive rebounds. |
#' | total_rebounds | integer | The player's total rebounds. |
#' | assists | integer | The player's assists. |
#' | steals | integer | The player's steals. |
#' | turnovers | integer | The player's turnovers. |
#' | blocks_in_favor | integer | The player's shots blocked (blocks made). |
#' | blocks_against | integer | The player's own shots that were blocked. |
#' | foul_commited | integer | The player's fouls committed. |
#' | foul_received | integer | The player's fouls drawn. |
#' | p_ir | integer | The player's PIR, performance index rating ((points + rebounds + assists + steals + blocks + fouls drawn) - (missed field goals + missed free throws + turnovers + shots blocked + fouls committed)). |
#' | plus_minus | integer | The player's plus-minus: points scored minus allowed while on court (team line: the final margin). |
#' | assists_turnover_ratio | double | The player's assist-to-turnover ratio (0 in every sample: not computed). |
#' | defensive_rating | double | The player's defensive rating (0 in every sample: not computed). |
#' | efficiency | integer | The player's efficiency as the feed computes it (equal to `pIR` on 2025-26 team lines). |
#' | points | integer | The player's points. |
#' | efficiency_custom | double | The player's custom efficiency as the federation computes it (equal to `efficiency` on player rows; 0 on team lines). |
#' | efficiency_game_score | double | The player's game score (0 in every sample: not computed). |
#' | fast_break_points_attempted | integer | The player's fast-break attempts (0 in every sample: not computed). |
#' | fast_break_points_made | integer | The player's fast-break makes (0 in every sample: not computed). |
#' | usage_percentage | double | The player's usage percentage (0 in every sample: not computed). |
#' | m_vp_votes | integer | The player's MVP votes (0 in every sample). |
#' | minus | integer | The player's points allowed on court (0 in every sample: not computed). |
#' | offensive_rating | double | The player's offensive rating (0 in every sample: not computed). |
#' | p_er | double | The player's PER (0 in every sample: not computed). |
#' | plus | integer | The player's points scored on court (0 in every sample: not computed). |
#' | points_fast_break | integer | The player's fast-break points. |
#' | points_in_the_paint | integer | The player's points in the paint. |
#' | points_in_the_paint_attempted | integer | The player's paint attempts (0 in every sample: not computed). |
#' | points_in_the_paint_made | integer | The player's paint makes (0 in every sample: not computed). |
#' | points_second_chance | integer | The player's second-chance points. |
#' | second_chance_points_attempted | integer | The player's second-chance attempts (0 in every sample: not computed). |
#' | second_chance_points_made | integer | The player's second-chance makes (0 in every sample: not computed). |
#' | true_shooting_attempts | integer | The player's true-shooting attempts (0 in every sample: not computed). |
#' | true_shooting_percentage | double | The player's true-shooting percentage (0 in every sample: not computed). |
#' | player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | match_team_player_firstname | character | The player's given name, as entered for this match (lower-case n in this route). |
#' | match_team_player_lastname | character | The player's family name, as entered for this match (lower-case n in this route). |
#' | match_team_player_year_of_birth | character | Birth year from the match entry, sent as a string ('2002'); the profile `person.yearOfBirth` is an integer. |
#' | jersey_number | character | Shirt number worn, sent as a string ('1', '55'). |
#' | starting_lineup | logical | True when the player started. |
#' | captain | logical | Games as captain. |
#' | played | logical | True when the player got on court. |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_box_score(match_id = 101839))
#' }
#' @export
#' @family KZS Functions
kzs_box_score <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/stats", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("box_score", raw), "KZS Player Box Score from api.kzs.si")
}

#' @title
#' **Get KZS Team Box Score**
#' @description
#' Team totals of a final game's box score, one row per side.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @return
#' A `hoopR_data` tibble: Team totals of a final game's box score, one row per side. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_team_box_score`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
#' | team_side | character | Which side of the match the row belongs to: home (the organiser, firstTeam on the wire) or away. |
#' | team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
#' | team_name | character | Name of the team for the season, sponsor included. |
#' | minutes | double | Team minutes: the sum of its players (200.0 = 5 x 40; 0.0 on 2015-16 team lines). |
#' | two_pm | integer | The team's two-point field goals made. |
#' | two_pa | integer | The team's two-point field goals attempted. |
#' | two_p_perc | double | The team's two-point percentage, 0-100. |
#' | three_pm | integer | The team's three-point field goals made. |
#' | three_pa | integer | The team's three-point field goals attempted. |
#' | three_p_perc | double | The team's three-point percentage, 0-100. |
#' | f_tm | integer | The team's free throws made. |
#' | f_ta | integer | The team's free throws attempted. |
#' | f_t_perc | double | The team's free-throw percentage, 0-100. |
#' | fg_m | integer | The team's field goals made. |
#' | fg_a | integer | The team's field goals attempted. |
#' | fg_perc | double | The team's field-goal percentage, 0-100. |
#' | offensive_rebounds | integer | The team's offensive rebounds. |
#' | defensive_rebounds | integer | The team's defensive rebounds. |
#' | total_rebounds | integer | The team's total rebounds. |
#' | assists | integer | The team's assists. |
#' | steals | integer | The team's steals. |
#' | turnovers | integer | The team's turnovers. |
#' | blocks_in_favor | integer | The team's shots blocked (blocks made). |
#' | blocks_against | integer | The team's own shots that were blocked. |
#' | foul_commited | integer | The team's fouls committed. |
#' | foul_received | integer | The team's fouls drawn. |
#' | p_ir | integer | The team's PIR, performance index rating ((points + rebounds + assists + steals + blocks + fouls drawn) - (missed field goals + missed free throws + turnovers + shots blocked + fouls committed)). |
#' | plus_minus | integer | The team's plus-minus: points scored minus allowed while on court (team line: the final margin). |
#' | assists_turnover_ratio | double | The team's assist-to-turnover ratio (0 in every sample: not computed). |
#' | defensive_rating | double | The team's defensive rating (0 in every sample: not computed). |
#' | efficiency | integer | Team efficiency (PIR); -1 on 2015-16 team lines (not computed). |
#' | points | integer | The team's points. |
#' | efficiency_custom | double | The team's custom efficiency as the federation computes it (equal to `efficiency` on player rows; 0 on team lines). |
#' | efficiency_game_score | double | The team's game score (0 in every sample: not computed). |
#' | fast_break_points_attempted | integer | The team's fast-break attempts (0 in every sample: not computed). |
#' | fast_break_points_made | integer | The team's fast-break makes (0 in every sample: not computed). |
#' | usage_percentage | double | The team's usage percentage (0 in every sample: not computed). |
#' | m_vp_votes | integer | The team's MVP votes (0 in every sample). |
#' | minus | integer | The team's points allowed on court (0 in every sample: not computed). |
#' | offensive_rating | double | The team's offensive rating (0 in every sample: not computed). |
#' | p_er | double | The team's PER (0 in every sample: not computed). |
#' | plus | integer | The team's points scored on court (0 in every sample: not computed). |
#' | points_fast_break | integer | The team's fast-break points. |
#' | points_in_the_paint | integer | The team's points in the paint. |
#' | points_in_the_paint_attempted | integer | The team's paint attempts (0 in every sample: not computed). |
#' | points_in_the_paint_made | integer | The team's paint makes (0 in every sample: not computed). |
#' | points_second_chance | integer | The team's second-chance points. |
#' | second_chance_points_attempted | integer | The team's second-chance attempts (0 in every sample: not computed). |
#' | second_chance_points_made | integer | The team's second-chance makes (0 in every sample: not computed). |
#' | true_shooting_attempts | integer | The team's true-shooting attempts (0 in every sample: not computed). |
#' | true_shooting_percentage | double | The team's true-shooting percentage (0 in every sample: not computed). |
#' | bench_points | integer | Points by players who did not start. |
#' | biggest_lead | integer | Biggest lead, points. |
#' | biggest_scoring_run | integer | Biggest unanswered scoring run, points. |
#' | fouls_bench_technical | integer | Technical fouls charged to the bench (not the coach). |
#' | fouls_coach_disqualifying | integer | Disqualifying fouls charged to the head coach. |
#' | fouls_coach_technical | integer | Technical fouls charged to the head coach. |
#' | fouls_disqualifying | integer | Disqualifying fouls by players (ejections). |
#' | fouls_offensive | integer | Offensive (charging) fouls by players. |
#' | fouls_on | integer | Fouls drawn by the team. |
#' | fouls_personal | integer | Personal fouls by players, all kinds that count toward fouling out. |
#' | fouls_team | integer | Team fouls (0 in every sample). |
#' | fouls_technical | integer | Technical fouls by players. |
#' | fouls_technical_other | integer | Other technical fouls (0 in every sample). |
#' | fouls_throw_in | integer | Throw-in fouls (0 in every sample). |
#' | fouls_total | integer | All fouls committed. |
#' | fouls_unsportsmanlike | integer | Unsportsmanlike (flagrant) fouls by players. |
#' | fouled_out | integer | Players fouled out (0 in every sample). |
#' | lead_changes | integer | Lead changes in the game. |
#' | points_from_turnovers | integer | Points off opponent turnovers. |
#' | time_leading | double | Time the team led, decimal minutes. |
#' | times_scores_level | integer | Times the score was tied. |
#' | rebounds_team | integer | Team rebounds (not credited to a player). |
#' | rebounds_team_defensive | integer | Defensive rebounds credited to the team, not a player. |
#' | rebounds_team_offensive | integer | Offensive rebounds credited to the team, not a player. |
#' | turnovers_team | integer | Team turnovers (not credited to a player). |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_team_box_score(match_id = 101839))
#' }
#' @export
#' @family KZS Functions
kzs_team_box_score <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/stats", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("team_box_score", raw), "KZS Team Box Score from api.kzs.si")
}

#' @title
#' **Get KZS Score by Minute**
#' @description
#' The score at the end of each minute of a final game.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @return
#' A `hoopR_data` tibble: The score at the end of each minute of a final game. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_score_changes`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | KZS match id. Joins to `/matches/{matchId}` (and its /playByPlay, /stats) and stats `matchId`. |
#' | minute | integer | Game minute (1-40, then overtime minutes). |
#' | score1 | integer | First (home) team score at the end of the minute, an integer. |
#' | score2 | integer | Second (away) team score at the end of the minute, an integer. |
#' | total_minutes | integer | Game length in minutes (40, 45 with one overtime). |
#' @eval .intl_details(.kzs_seasons_details, "kzs_score_changes(match_id = 101839)")
#' @export
#' @family KZS Functions
kzs_score_changes <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/stats", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("score_changes", raw), "KZS Score by Minute from api.kzs.si")
}

#' @title
#' **Get KZS Standings**
#' @description
#' Standings of a competition, one row per team in each phase (and group).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/standings`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: Standings of a competition, one row per team in each phase (and group). An empty valid
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | phase_id | integer | Competition-phase id. Joins to `competitions[].competitionPhaseId` on matches and `/competitions/{competitionId}` `phases[].id`. |
#' | phase_name | character | Phase name, Slovenian (see `phases[].name`). |
#' | phase_type | character | Phase format (code table). |
#' | group_id | integer | Group id inside the phase (null when the table is the phase's own). |
#' | group_name | character | Group name inside the phase (null when the table is the phase's own). |
#' | position | integer | 1-based position of the row in its table, in the order the API lists it (the wire has no rank column). |
#' | team_id | integer | Team id: one club team in one season (Ilirija 2025-26 = 17551). Joins to `/teams/{teamId}`, standings `teamId`, box-score `teamId` and the `teamId` query params. |
#' | team_name | character | Team name for the season, sponsor included. |
#' | club_code | character | Club 3-letter code. |
#' | logo_uuid | character | Team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | games_played | integer | Games played in the phase. |
#' | won | integer | Wins in the phase. |
#' | lost | integer | Losses in the phase. |
#' | pts_plus | integer | Points scored by the team through its games played. |
#' | pts_minus | integer | Points allowed. |
#' | home_won | integer | Home games the team has won. |
#' | home_lost | integer | Home games the team has lost. |
#' | away_won | integer | Away games the team has won. |
#' | away_lost | integer | Away games the team has lost. |
#' | points | integer | Table points: 2 per win, 1 per loss (Krka 26-1 = 53). |
#' | draws | integer | Draws (0: basketball has none). |
#' | lost_points | integer | Table points deducted (0 in every sample). |
#' | tie_break_position | integer | Final position after tie-breaks (absent on playoff-phase rows). |
#' | pts_difference | integer | Point differential (scored - allowed). |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_standings(competition_id = 579))
#' }
#' @export
#' @family KZS Functions
kzs_standings <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/matches/standings", ids = list(), query = list(competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("standings", raw), "KZS Standings from api.kzs.si")
}

#' @title
#' **Get KZS Playing Days**
#' @description
#' Match days of a competition and the number of games on each.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{competition_id}/playingDays`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: Match days of a competition and the number of games on each. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_playing_days`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | date | character | Calendar date of the match day, 'YYYY-MM-DD'. |
#' | no_of_games | integer | Matches on that day. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_playing_days(competition_id = 579)")
#' @export
#' @family KZS Functions
kzs_playing_days <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/matches/{competition_id}/playingDays", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("playing_days", raw), "KZS Playing Days from api.kzs.si")
}

#' @title
#' **Get KZS Teams**
#' @description
#' Teams entered in a competition.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teams/`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: Teams entered in a competition. An empty valid answer raises `hoopR_no_data`; the columns
#'   are always these, in this order (sportsdataverse-py `kzs_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | team_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
#' | team_application_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
#' | club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
#' | club_member | logical | True when the club is a KZS member (false on nested copies that omit it). |
#' | team_internal_ranking | character | The club's internal team letter for the category (A = first team, B = second team). |
#' | category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
#' | rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
#' | gender | character | MALE or FEMALE. |
#' | sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
#' | sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
#' | name | character | Team name for the season (sponsor name included). |
#' | code | character | Team 3-letter code. |
#' | home_jersey_color | character | Home jersey colour, hex '#RRGGBB'. |
#' | guest_jersey_color | character | Away jersey colour, hex. |
#' | logo_uuid | character | Team logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | home_team_color | character | Home colour, hex. |
#' | guest_team_color | character | Away colour, hex. |
#' | short_name | character | Team short name ('' when none). |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_teams(competition_id = 579))
#' }
#' @export
#' @family KZS Functions
kzs_teams <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/teams/", ids = list(), query = list(limit = 1000L, competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("teams", raw), "KZS Teams from api.kzs.si")
}

#' @title
#' **Get KZS Team Profile**
#' @description
#' Team profile: club, home hall, colours and the competitions the team entered.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teams/{team_id}`
#' @param team_id (required) Team id (team_id in kzs_teams): one club team in one season, e.g. 17551. Not the
#'   match-team id nor the club id.
#' @return
#' A `hoopR_data` tibble: Team profile: club, home hall, colours and the competitions the team entered. An empty valid
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_team`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
#' | team_application_id | integer | Team-application id: the team's registration (entry) for the season; play-by-play `teamApplicationId` is the same key space. |
#' | club_id | integer | Club id: the club across seasons and categories (Ilirija = 16). No captured route is keyed by it. |
#' | club_member | logical | True when the club is a KZS member (false on nested copies that omit it). |
#' | category | character | Age category: ABSOLUTE (senior) or U8-U23 / ANY (code table in kzs-returns.md). |
#' | rank | character | Tier: FIRST-FOURTH or TOURNAMENT (code table). |
#' | gender | character | MALE or FEMALE. |
#' | sport_hall_id | integer | Sport hall (venue) id. `/sportHalls/{id}` is in the site bundle, not captured. |
#' | sport_hall_name | character | Name of the venue (sports hall) where the game is played or the team is based. |
#' | sport_hall_address_id | integer | Id of the venue's address record. |
#' | sport_hall_address_post_office_id | integer | Post-office id (FMS internal). |
#' | sport_hall_address_post_office_zip_code | character | Postal code (REDACTED under a club `addresses[]` row; kept for venues). |
#' | sport_hall_address_post_office_name | character | Post-office town. |
#' | sport_hall_address_post_office_municipality | character | Municipality, upper case. |
#' | sport_hall_address_post_office_country | character | Country, ISO 3166-1 alpha-2 (SI). |
#' | sport_hall_address_street | character | Venue street (a public sports hall). |
#' | sport_hall_address_house_number | character | Venue house number, a string ('6 A'). |
#' | name | character | Team name for the season (sponsor name included). |
#' | code | character | Team 3-letter code. |
#' | season_id | integer | Season id: OPAQUE, not a year (1 = 2000/2001 ... 27 = 2026/2027, 31 = 1991/1992). The season `name` is 'START/END'; the sdv season is the END year (the second half of `name`). |
#' | season_name | character | Season, 'START/END' (2025/2026); sdv season = the END year. |
#' | season_is_active | logical | True for the current season only (2026/2027 on 2026-10-12). |
#' | season_active | logical | Same as `isActive`. |
#' | short_name | character | Team short name ('' when none). |
#' | home_jersey_color | character | Home jersey colour, hex '#RRGGBB'. |
#' | guest_jersey_color | character | Away jersey colour, hex. |
#' | logo_uuid | character | Logo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | season | integer | Season of the registration. |
#' | competitions | character | Competitions of the team this season (id, name, rule, phases). |
#' @eval .intl_details(.kzs_seasons_details, "kzs_team(team_id = 17551)")
#' @export
#' @family KZS Functions
kzs_team <- function(team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  team_id <- .kzs_int_arg(team_id, "team_id", call = call)
  raw <- .kzs_get("/teams/{team_id}", ids = list(team_id = team_id), query = list(), call = call)
  .kzs_out(.kzs_parse("team", raw), "KZS Team Profile from api.kzs.si")
}

#' @title
#' **Get KZS Team Summary**
#' @description
#' A team's record, form and best players in one competition (the body echoes neither id).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teams/{team_id}/general`
#' @param team_id (required) Team id (team_id in kzs_teams): one club team in one season, e.g. 17551. Not the
#'   match-team id nor the club id.
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: A team's record, form and best players in one competition (the body echoes neither id). An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py
#'   `kzs_team_general`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | won | integer | Wins in the competition (all phases). |
#' | lost | integer | Losses in the competition. |
#' | last_games | character | Recent results, 'W' or 'L' per game (order unverified). |
#' | best_points_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | best_points_player_identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
#' | best_points_player_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | best_points_player_person_first_name | character | The player's given name. |
#' | best_points_player_person_last_name | character | The player's family name. |
#' | best_points_player_person_year_of_birth | integer | Year of birth (players: public bio). |
#' | best_points_player_nationality_id | integer | Country id (FMS internal; use the ISO codes). |
#' | best_points_player_nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
#' | best_points_player_nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
#' | best_points_player_nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
#' | best_points_player_nationality_eng_name | character | Country name in English. |
#' | best_points_player_homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
#' | best_points_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | best_points_player_positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | best_average_points | double | That player's points per game. |
#' | best_rebounds_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | best_rebounds_player_identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
#' | best_rebounds_player_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | best_rebounds_player_person_first_name | character | The player's given name. |
#' | best_rebounds_player_person_last_name | character | The player's family name. |
#' | best_rebounds_player_person_year_of_birth | integer | Year of birth (players: public bio). |
#' | best_rebounds_player_nationality_id | integer | Country id (FMS internal; use the ISO codes). |
#' | best_rebounds_player_nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
#' | best_rebounds_player_nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
#' | best_rebounds_player_nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
#' | best_rebounds_player_nationality_eng_name | character | Country name in English. |
#' | best_rebounds_player_homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
#' | best_rebounds_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | best_rebounds_player_positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | best_average_rebounds | double | That player's rebounds per game. |
#' | best_assists_player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | best_assists_player_identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
#' | best_assists_player_person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | best_assists_player_person_first_name | character | The player's given name. |
#' | best_assists_player_person_last_name | character | The player's family name. |
#' | best_assists_player_person_year_of_birth | integer | Year of birth (players: public bio). |
#' | best_assists_player_nationality_id | integer | Country id (FMS internal; use the ISO codes). |
#' | best_assists_player_nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
#' | best_assists_player_nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
#' | best_assists_player_nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
#' | best_assists_player_nationality_eng_name | character | Country name in English. |
#' | best_assists_player_homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
#' | best_assists_player_photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | best_assists_player_positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | best_average_assists | double | That player's assists per game. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_team_general(competition_id = 579, team_id = 17551)")
#' @export
#' @family KZS Functions
kzs_team_general <- function(team_id, competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  team_id <- .kzs_int_arg(team_id, "team_id", call = call)
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/teams/{team_id}/general", ids = list(team_id = team_id),
                  query = list(competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("team_general", raw), "KZS Team Summary from api.kzs.si")
}

#' @title
#' **Get KZS Team Roster**
#' @description
#' A team's roster in one competition (the rows carry no team or competition id).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teamPlayers/`
#' @param team_id (required) Team id (team_id in kzs_teams): one club team in one season, e.g. 17551. Not the
#'   match-team id nor the club id.
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @return
#' A `hoopR_data` tibble: A team's roster in one competition (the rows carry no team or competition id). An empty
#'   valid answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_roster`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Team id: one club team in one season (joins kzs_teams); not the match-team id and not the club id. |
#' | competition_id | integer | Competition id: one per competition per season (men's first league 2025/26 = 579, 2026/27 = 608). |
#' | roster_entry_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | player_id | integer | Player id (KZS player registry). Joins to `/players/{playerId}`, box-score and play-by-play `playerId`. |
#' | identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
#' | person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | first_name | character | The player's given name. |
#' | last_name | character | The player's family name. |
#' | year_of_birth | integer | Year of birth (players: public bio). |
#' | nationality_id | integer | Country id (FMS internal; use the ISO codes). |
#' | nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
#' | nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
#' | nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
#' | nationality_eng_name | character | Country name in English. |
#' | homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
#' | photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' | jersey_number | character | Shirt number worn, sent as a string ('1', '55'). |
#' @eval .intl_details(.kzs_seasons_details, "kzs_roster(competition_id = 579, team_id = 17551)")
#' @export
#' @family KZS Functions
kzs_roster <- function(team_id, competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  team_id <- .kzs_int_arg(team_id, "team_id", call = call)
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/teamPlayers/", ids = list(), query = list(limit = 1000L, teamId = team_id,
                  competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("roster", raw), "KZS Team Roster from api.kzs.si")
}

#' @title
#' **Get KZS Player Profile**
#' @description
#' Player profile: names, year of birth, nationality and positions.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/players/{player_id}`
#' @param player_id (required) Player registry id (player_id in a box score or roster), e.g. 106285. Not the person
#'   id.
#' @return
#' A `hoopR_data` tibble: Player profile: names, year of birth, nationality and positions. An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_player`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | identification_number | integer | Player's KZS registration (licence) number; a different key space from the player id, used by no captured route. |
#' | person_id | integer | Person id: the federation's person record behind a player, coach or official; a different key space from player, coach and official ids. |
#' | first_name | character | The player's given name. |
#' | last_name | character | The player's family name. |
#' | year_of_birth | integer | Year of birth (players: public bio). |
#' | nationality_id | integer | Country id (FMS internal; use the ISO codes). |
#' | nationality_alpha2_code | character | ISO 3166-1 alpha-2 country code. |
#' | nationality_alpha3_code | character | ISO 3166-1 alpha-3 country code. |
#' | nationality_name | character | Country name in Slovenian (e.g. 'Zdruzene drzave' = United States); use `engName` or the ISO codes. |
#' | nationality_eng_name | character | Country name in English. |
#' | homegrown | logical | True when the player counts as homegrown (domaci igralec) for roster limits. |
#' | photo_uuid | character | Player photo: image file id, served at `https://api.kzs.si/public/images/{uuid}`. |
#' | positions | character | Unobserved: null, or an empty array, in every sample, so its type and meaning are unconfirmed. |
#' @eval .intl_details(.kzs_seasons_details, "kzs_player(player_id = 106285)")
#' @export
#' @family KZS Functions
kzs_player <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  player_id <- .kzs_int_arg(player_id, "player_id", call = call)
  raw <- .kzs_get("/players/{player_id}", ids = list(player_id = player_id), query = list(), call = call)
  .kzs_out(.kzs_parse("player", raw), "KZS Player Profile from api.kzs.si")
}

#' @title
#' **Get KZS Player Season Stats**
#' @description
#' A player's totals and per-game averages in each competition of one season.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/players/{player_id}/stats`
#' @param player_id (required) Player registry id (player_id in a box score or roster), e.g. 106285. Not the person
#'   id.
#' @param season (required) Season END year (2027 = 2026/2027); the wrapper maps it to KZS' opaque season id.
#' @return
#' A `hoopR_data` tibble: A player's totals and per-game averages in each competition of one season. An empty valid
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sportsdataverse-py `kzs_player_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Player registry id of the request (the body does not echo it). |
#' | season_id | integer | Opaque KZS season id (27 = 2026/2027); the sdv season is the END year in season. |
#' | season | integer | Season END year (2026/2027 = 2027), from the row's own season name or id, else from the request. |
#' | competition_id | integer | Competition id: one per competition per season (men's top league 2025-26 = 579, 2026-27 = 608). Joins to `/competitions/{competitionId}` and the `competitionId` query params. |
#' | a1 | integer | Season total: free throws attempted. |
#' | a2 | integer | Season total: two-pointers attempted. |
#' | a3 | integer | Season total: three-pointers attempted. |
#' | pts | integer | Season total: points. |
#' | ass | integer | Season total: assists. |
#' | blag | integer | Season total: own shots blocked (blocks against). |
#' | blfv | integer | Season total: blocks made (blocks in favour). |
#' | captain | integer | Games as captain. |
#' | m1 | integer | Season total: free throws made. |
#' | m2 | integer | Season total: two-pointers made. |
#' | m3 | integer | Season total: three-pointers made. |
#' | mins | double | Season total: minutes played (decimal minutes). |
#' | pfcm | integer | Season total: fouls committed. |
#' | pfrv | integer | Season total: fouls received. |
#' | rd | integer | Season total: defensive rebounds. |
#' | ro | integer | Season total: offensive rebounds. |
#' | st | integer | Season total: steals. |
#' | startinglineup | integer | Games the player started in the competition. |
#' | tov | integer | Season total: turnovers. |
#' | played | integer | Games the player played in the competition. |
#' | plus_minus | integer | Season total: the team's point difference while the player was on court. |
#' | efficiency | integer | Season total: efficiency (PIR). |
#' | avgpts | double | Per game: points. |
#' | avga1 | double | Per game: free throws attempted. |
#' | avga2 | double | Per game: two-pointers attempted. |
#' | avga3 | double | Per game: three-pointers attempted. |
#' | avgass | double | Per game: assists. |
#' | avgblag | double | Per game: own shots blocked (blocks against). |
#' | avgblfv | double | Per game: blocks made (blocks in favour). |
#' | avgm1 | double | Per game: free throws made. |
#' | avgm2 | double | Per game: two-pointers made. |
#' | avgm3 | double | Per game: three-pointers made. |
#' | avgmins | double | Per game: minutes played (decimal minutes). |
#' | avgpfcm | double | Per game: fouls committed. |
#' | avgpfrv | double | Per game: fouls received. |
#' | avgrd | double | Per game: defensive rebounds. |
#' | avgro | double | Per game: offensive rebounds. |
#' | avgsecs | integer | Per game: seconds (0 in every sample: unused). |
#' | avgst | double | Per game: steals. |
#' | avgtov | double | Per game: turnovers. |
#' | avgplus_minus | double | Per game: the team's point difference while the player was on court. |
#' | avgefficiency | double | Per game: efficiency (PIR). |
#' | live_stats | logical | True when the competition has live stats. |
#' | competition_name | character | Competition name, Slovenian (e.g. 'Liga OTP banka', 'Pokal Spar'). |
#' | competition_rank | character | Tier of the competition (code table). |
#' | competition_category | character | Category of the competition (code table). |
#' | competition_gender | character | MALE or FEMALE competition. |
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_player_stats(player_id = 106285, season = 2026))
#' }
#' @export
#' @family KZS Functions
kzs_player_stats <- function(player_id, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  player_id <- .kzs_int_arg(player_id, "player_id", call = call)
  raw <- .kzs_get("/players/{player_id}/stats", ids = list(player_id = player_id), query = list(season = season),
                  call = call)
  .kzs_out(.kzs_parse("player_stats", raw), "KZS Player Season Stats from api.kzs.si")
}
