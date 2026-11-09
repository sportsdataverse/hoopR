# kbl.R -- KBL (Korean Basketball League) wrappers over api.kbl.or.kr, the data API behind www.kbl.or.kr,
# at parity with sportsdataverse-py sportsdataverse/basketball/kbl (origin/main e3d232ebc9). Transport, scope checks and
# refusals: R/kbl_runtime.R; frames: R/kbl_parsers.R; columns and code tables: R/kbl_tables.R.
# WKBL (the women's league) is not covered.

# The @details of every kbl topic that shares the kbl_seasons() notes (roxygen @eval .intl_details()).
.kbl_seasons_details <- c(
  "* Unofficial and unsupported: these wrappers read api.kbl.or.kr, the data API behind the www.kbl.or.kr React site",
  "  (stats vendor sports2i). No key, cookie or proxy is needed, but two request headers must be present (Channel and",
  "  TeamCode; the runtime sends WEB and XX). www.kbl.or.kr/robots.txt returns the SPA's HTML and",
  "  api.kbl.or.kr/robots.txt a 500 error envelope, so no policy or Crawl-delay is published (checked 2026-10-12); the",
  "  site's terms (/terms/list) were not reviewed for data reuse. The runtime waits at least 1 s before every request,",
  "  retries included.",
  "* Not wrapped: the site's /record/* and `/player/player/{pcode}` pages are rendered by the sports2i widget from two",
  "  other hosts (kbl-api.sports2i.com and api-stats.kbl.or.kr: team four factors, clutch, hustle, shot dashboards,",
  "  all-time leaders). WKBL (the women's league) is not covered.",
  "* Seasons are END years (2026 = 2025-26). KBL numbers seasons AND D-League (reserve league) editions with one",
  "  sequential seasonCode; division picks 'kbl' or 'd_league' and game_code the competition inside the season, and",
  "  the wrapper sends the API's glkey. The playoff routes take the REGULAR-SEASON key; the old route serves",
  "  seasonCode below 45 and the new one 45 on, and the wrapper picks it.",
  "* Ids: gmkey `S{seasonCode}G{gameCode}N{gameNo}` (a string, an object only inside the new playoff bracket),",
  "  team_code (two-digit string with a leading zero, not stable across ownership changes) and pcode (six-digit",
  "  string, the same on every route). The play-by-play carries no pcode: join its player_name to the game's box score",
  "  on name and team_code. isEnded is unreliable (0 on every finished game through 2005-06), so a game is final when",
  "  isEnded is 1 or when it is dated before today (KST), both teams scored and its play-by-play reached the game-end",
  "  row; anything else raises `hoopR_asset_fetch`. The first game call also fetches the header (and, for such a game,",
  "  the play-by-play) once; the answer is cached for the process.",
  "* Coverage: box scores and play-by-play from the first season (1997); shot x/y from 2006-07 (an earlier game's shot",
  "  chart is empty: a zero-row tibble); advanced rates are filled from 1997-98 on (the vendor computes them from the",
  "  box); screen assists and deflections are 0 before the recent seasons. fg is TWO-point field goals made (dunks",
  "  included), fgt all field goals, and a made dunk is its own row in the play-by-play. Shot x/y are pixels on the",
  "  site's 726 x 412 full-court image; basket names the target end and teams switch at half-time, so normalise with",
  "  basket before stacking shots.",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, or the API has nothing",
  "  for the request: an empty list, a final game with no box score, no playoff bracket, no rounds, no schedule rows",
  "  in the window), `hoopR_bad_request` (a malformed gmkey, a season that is not an END year between 1997 and 2027,",
  "  an unknown division or game_code, or bad schedule dates, raised before any request) and `hoopR_asset_fetch` (any",
  "  other non-2xx including the unknown-id HTTP 500 and the HTTP 400 the API answers without its two headers, the KBL",
  "  error envelope, an empty or non-JSON body, a game that is not final, or a body for another game, season or window",
  "  than the one asked for). HTTP 500 is the API's deterministic answer to an unknown id and is not retried. Wrappers",
  "  raise; they never warn and return empty."
)

#' @title
#' **Get KBL Seasons**
#' @description
#' Every KBL regular season (1997 to the next one) with its competition key and date range, newest first.
#'
#' Endpoint: `GET https://api.kbl.or.kr/season/list`
#' @eval .returns_rd("kbl_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.kbl_seasons_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(kbl_seasons())
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_simple_get("/season/list", call = rlang::current_env())
  .kbl_out("seasons", raw, "KBL Seasons from api.kbl.or.kr")
}

#' @title
#' **Get KBL Teams**
#' @description
#' The current ten clubs with Korean and English names and the code of each club's D-League side.
#'
#' Endpoint: `GET https://api.kbl.or.kr/common/teamList`
#' @eval .returns_rd("kbl_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_teams())
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_teams <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_simple_get("/common/teamList", call = rlang::current_env())
  .kbl_out("teams", raw, "KBL Teams from api.kbl.or.kr")
}

#' @title
#' **Get KBL Schedule**
#' @description
#' Every game (all competitions, KBL and D-League) of a season or of a date window, with scores and venue.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/list`
#' @param season Season END year (2026 = 2025-26): the window from the first to the last game of that END year's KBL
#'   and D-League editions, fetched as at most two requests (one per calendar year). Pass this or from_date and
#'   to_date.
#' @param from_date First date of a window, YYYYMMDD (KST). Needs to_date; inside one calendar year the API answers
#'   the whole window in one request (up to 396 games a year, no paging).
#' @param to_date Last date of the window, YYYYMMDD (KST), not before from_date.
#' @eval .returns_rd("kbl_schedule", inline = FALSE, unit = "game")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_schedule(from_date = "20251101", to_date = "20251102"))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_schedule <- function(season = NULL, from_date = NULL, to_date = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_schedule_get(season, from_date, to_date, call = rlang::current_env())
  .kbl_out("schedule", raw, "KBL Schedule from api.kbl.or.kr")
}

#' @title
#' **Get KBL Game Header**
#' @description
#' Game header of a final game: teams, final score, overtimes, venue, attendance, officials and coaches.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_game", inline = FALSE, unit = "game")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_game(gmkey = "S47G01N49"))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_game <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("header", gmkey, call = rlang::current_env())
  .kbl_out("game", raw, "KBL Game Header from api.kbl.or.kr")
}

#' @title
#' **Get KBL Period Scores**
#' @description
#' Points by period (quarters and overtimes) and side of a final game, from the game header.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_period_scores", inline = FALSE, unit = "team and period")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_period_scores(gmkey = "S47G01N49"))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_period_scores <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("header", gmkey, call = rlang::current_env())
  .kbl_out("period_scores", raw, "KBL Period Scores from api.kbl.or.kr")
}

#' @title
#' **Get KBL Play-by-Play**
#' @description
#' Play-by-play (the site's text cast) of a final game, one row per event, from 1997-98 on.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/text-cast`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_pbp", inline = FALSE, unit = "event")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_pbp(gmkey = "S47G01N49"))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_pbp <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("text_cast", gmkey, call = rlang::current_env())
  .kbl_out("pbp", raw, "KBL Play-by-Play from api.kbl.or.kr")
}

#' @title
#' **Get KBL Player Box Score**
#' @description
#' Player box score of a final game with the vendor's advanced rates, one row per player of both teams.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/player-stat`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_player_box", inline = FALSE, unit = "player of both teams")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_player_box(gmkey = "S47G01N49"))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_player_box <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("player_stat", gmkey, call = rlang::current_env())
  .kbl_out("player_box", raw, "KBL Player Box Score from api.kbl.or.kr")
}

#' @title
#' **Get KBL Team Box Score**
#' @description
#' Team box score of a final game with advanced rates and team-only counts, one row per team.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/team-record`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_team_box", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_team_box(gmkey = "S47G01N49"))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_team_box <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("team_record", gmkey, call = rlang::current_env())
  .kbl_out("team_box", raw, "KBL Team Box Score from api.kbl.or.kr")
}

#' @title
#' **Get KBL Shots**
#' @description
#' Shot chart of a final game (2006-07 on): every charted shot with x/y pixels on the full-court image.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/match-chart`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_shots", inline = FALSE, unit = "shot")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_shots(gmkey = "S47G01N49"))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_shots <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("match_chart", gmkey, call = rlang::current_env())
  .kbl_out("shots", raw, "KBL Shots from api.kbl.or.kr")
}

#' @title
#' **Get KBL Score Track**
#' @description
#' Lead tracker and score chart of a final game: home margin and both scores at eight checkpoints per period.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/match-chart`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_score_track", inline = FALSE, unit = "checkpoint of the game")
#' @eval .intl_details(.kbl_seasons_details, 'kbl_score_track(gmkey = "S47G01N49")')
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_score_track <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("match_chart", gmkey, call = rlang::current_env())
  .kbl_out("score_track", raw, "KBL Score Track from api.kbl.or.kr")
}

#' @title
#' **Get KBL Game Leaders**
#' @description
#' Each team's leader per category (points, rebounds, assists, steals, blocks) in a final game.
#'
#' Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/match-chart`
#' @param gmkey Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the 2025-26 regular season's game 49):
#'   season_code, game_code and game_no of kbl_schedule. Only final games are served; a malformed key is a
#'   `hoopR_bad_request`.
#' @eval .returns_rd("kbl_game_leaders", inline = FALSE, unit = "leaderboard entry")
#' @eval .intl_details(.kbl_seasons_details, 'kbl_game_leaders(gmkey = "S47G01N49")')
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_game_leaders <- function(gmkey) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_game_get("match_chart", gmkey, call = rlang::current_env())
  .kbl_out("game_leaders", raw, "KBL Game Leaders from api.kbl.or.kr")
}

#' @title
#' **Get KBL Player Totals**
#' @description
#' Season player totals of one competition (every player with at least one game).
#'
#' Endpoint: `GET https://api.kbl.or.kr/leagues/{season}/stats/players`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @param division 'kbl' (the KBL itself, the default) or 'd_league' (the KBL D-League reserve league, seasonGrade 2,
#'   which has its own season codes; it starts with the 2009 summer edition).
#' @param game_code Competition inside the season, two digits: '01' regular season (default; the first stage of a
#'   D-League edition), '03' playoffs, '04' championship final, '07' EASL, '08' D-League stage 2, '10' All-Star,
#'   '11'/'13' cups, '14' Open Match Day. Only '01' was probed live.
#' @eval .returns_rd("kbl_player_totals", inline = FALSE, unit = "player")
#' @eval .intl_details(.kbl_seasons_details, "kbl_player_totals(season = 2025)")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_player_totals <- function(season, division = "kbl", game_code = "01") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .kbl_check_division(division, call = rlang::current_env())
  raw <- .kbl_season_get("season_players", season, division, game_code, call = rlang::current_env())
  .kbl_out("player_totals", raw, "KBL Player Totals from api.kbl.or.kr")
}

#' @title
#' **Get KBL Standings**
#' @description
#' Standings of one competition with each team's season totals.
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/rank/{season}`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @param division 'kbl' (the KBL itself, the default) or 'd_league' (the KBL D-League reserve league, seasonGrade 2,
#'   which has its own season codes; it starts with the 2009 summer edition).
#' @param game_code Competition inside the season, two digits: '01' regular season (default; the first stage of a
#'   D-League edition), '03' playoffs, '04' championship final, '07' EASL, '08' D-League stage 2, '10' All-Star,
#'   '11'/'13' cups, '14' Open Match Day. Only '01' was probed live.
#' @eval .returns_rd("kbl_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_standings(season = 2025))
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_standings <- function(season, division = "kbl", game_code = "01") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .kbl_check_division(division, call = rlang::current_env())
  raw <- .kbl_season_get("rank", season, division, game_code, call = rlang::current_env())
  .kbl_out("standings", raw, "KBL Standings from api.kbl.or.kr")
}

#' @title
#' **Get KBL Team Tracks**
#' @description
#' Each team's standing after every game of the season, one row per team and game.
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/rank/{season}/team-tracks`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @param division 'kbl' (the KBL itself, the default) or 'd_league' (the KBL D-League reserve league, seasonGrade 2,
#'   which has its own season codes; it starts with the 2009 summer edition).
#' @param game_code Competition inside the season, two digits: '01' regular season (default; the first stage of a
#'   D-League edition), '03' playoffs, '04' championship final, '07' EASL, '08' D-League stage 2, '10' All-Star,
#'   '11'/'13' cups, '14' Open Match Day. Only '01' was probed live.
#' @eval .returns_rd("kbl_team_tracks", inline = FALSE, unit = "team and game")
#' @eval .intl_details(.kbl_seasons_details, "kbl_team_tracks(season = 2025)")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_team_tracks <- function(season, division = "kbl", game_code = "01") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .kbl_check_division(division, call = rlang::current_env())
  raw <- .kbl_season_get("team_tracks", season, division, game_code, call = rlang::current_env())
  .kbl_out("team_tracks", raw, "KBL Team Tracks from api.kbl.or.kr")
}

#' @title
#' **Get KBL Rounds**
#' @description
#' The season's round calendar (the KBL plays six rounds) with each round's first and last date.
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/rank/{season}/team-tracks`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @param division 'kbl' (the KBL itself, the default) or 'd_league' (the KBL D-League reserve league, seasonGrade 2,
#'   which has its own season codes; it starts with the 2009 summer edition).
#' @param game_code Competition inside the season, two digits: '01' regular season (default; the first stage of a
#'   D-League edition), '03' playoffs, '04' championship final, '07' EASL, '08' D-League stage 2, '10' All-Star,
#'   '11'/'13' cups, '14' Open Match Day. Only '01' was probed live.
#' @eval .returns_rd("kbl_rounds", inline = FALSE, unit = "round")
#' @eval .intl_details(.kbl_seasons_details, "kbl_rounds(season = 2025)")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_rounds <- function(season, division = "kbl", game_code = "01") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .kbl_check_division(division, call = rlang::current_env())
  raw <- .kbl_season_get("team_tracks", season, division, game_code, call = rlang::current_env())
  .kbl_out("rounds", raw, "KBL Rounds from api.kbl.or.kr")
}

#' @title
#' **Get KBL Playoff Seeds**
#' @description
#' The regular-season finish that seeds the playoffs (the top six).
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/playoff/{season}`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @eval .returns_rd("kbl_playoff_seeds", inline = FALSE, unit = "seeded team")
#' @eval .intl_details(.kbl_seasons_details, "kbl_playoff_seeds(season = 2025)")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_playoff_seeds <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_season_get("playoff", season, call = rlang::current_env())
  .kbl_out("playoff_seeds", raw, "KBL Playoff Seeds from api.kbl.or.kr")
}

#' @title
#' **Get KBL Playoff Series**
#' @description
#' The playoff series (quarterfinals, semifinals, final): wins and losses of each team in each series.
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/playoff/{season}`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @eval .returns_rd("kbl_playoff_series", inline = FALSE, unit = "team in a playoff series")
#' @eval .intl_details(.kbl_seasons_details, "kbl_playoff_series(season = 2025)")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_playoff_series <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_season_get("playoff", season, call = rlang::current_env())
  .kbl_out("playoff_series", raw, "KBL Playoff Series from api.kbl.or.kr")
}

#' @title
#' **Get KBL Playoff Games**
#' @description
#' The games of the playoff bracket (2024-25 on; the older bracket format lists no games).
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/playoff/{season}`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @eval .returns_rd("kbl_playoff_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.kbl_seasons_details, "kbl_playoff_games(season = 2025)")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_playoff_games <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_season_get("playoff", season, call = rlang::current_env())
  .kbl_out("playoff_games", raw, "KBL Playoff Games from api.kbl.or.kr")
}

#' @title
#' **Get KBL Round MVPs**
#' @description
#' The round MVPs of a season with their totals over the round.
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/round-mvp/{season}`
#' @param season Season END year (2026 = 2025-26; the inaugural 1997 season is 1997, the latest 2027). kbl_runtime
#'   maps it to the KBL seasonCode (47 = 2025-26).
#' @eval .returns_rd("kbl_round_mvps", inline = FALSE, unit = "round MVP")
#' @eval .intl_details(.kbl_seasons_details, "kbl_round_mvps(season = 2025)")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_round_mvps <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_season_get("round_mvp", season, call = rlang::current_env())
  .kbl_out("round_mvps", raw, "KBL Round MVPs from api.kbl.or.kr")
}

#' @title
#' **Get KBL Current Standings**
#' @description
#' Current standings of the active season (no parameter): record, games behind, streaks, splits.
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/rank/team`
#' @eval .returns_rd("kbl_current_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.kbl_seasons_details, "kbl_current_standings()")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_current_standings <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_simple_get("/league/rank/team", call = rlang::current_env())
  .kbl_out("current_standings", raw, "KBL Current Standings from api.kbl.or.kr")
}

#' @title
#' **Get KBL Season Leaders**
#' @description
#' Current season leaders per category (no parameter): points, rebounds, assists, steals, blocks, shooting.
#'
#' Endpoint: `GET https://api.kbl.or.kr/league/season-leader`
#' @eval .returns_rd("kbl_season_leaders", inline = FALSE, unit = "leaderboard entry")
#' @eval .intl_details(.kbl_seasons_details, "kbl_season_leaders()")
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_season_leaders <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_simple_get("/league/season-leader", call = rlang::current_env())
  .kbl_out("season_leaders", raw, "KBL Season Leaders from api.kbl.or.kr")
}

#' @title
#' **Get KBL Players**
#' @description
#' The site's player directory (current and former players) with their current or last team.
#'
#' Endpoint: `GET https://api.kbl.or.kr/players`
#' @eval .returns_rd("kbl_players", inline = FALSE, unit = "player")
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_players())
#' }
#' @export
#' @concept KBL Functions
#' @seealso [family_kbl] lists every function in this family.
kbl_players <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_simple_get("/players", call = rlang::current_env())
  .kbl_out("players", raw, "KBL Players from api.kbl.or.kr")
}
