# kbl.R -- KBL (Korean Basketball League) wrappers over api.kbl.or.kr, the data API behind www.kbl.or.kr,
# at parity with sdv-py sportsdataverse/basketball/kbl (origin/main e3d232ebc9). Transport, scope checks and
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
#' @return
#' A `hoopR_data` tibble: Every KBL regular season (1997 to the next one) with its competition key and date range,
#'   newest first. The columns are always these, in this order (sdv-py `kbl_seasons`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
#' | glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the /leagues and /league/rank routes. |
#' | season_name | character | Season label: 'YYYY-YYYY' for a KBL season (e.g. '2025-2026'), '1997' for the inaugural season. |
#' | season_name_full | character | Division label in Korean: the first-team (top-division) season. |
#' | season_grade | integer | Division: 1 = the KBL itself, 2 = the KBL D-League (reserve league). |
#' | season_category | character | Category code of the competition: R regular season, PO playoffs, CP final, D1/D2 D-League stages, AS All-Star, EG/CU cups, EA EASL, OM Open Match Day (table below). |
#' | game_code | character | Competition type within the season: 01 regular season (the only value the list returns). |
#' | start_date | Date | First date of the season, YYYYMMDD. |
#' | end_date | Date | Last date of the season, YYYYMMDD. |
#' @eval .intl_details(.kbl_seasons_details)
#' @examples
#' \donttest{
#'   try(kbl_seasons())
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: The current ten clubs with Korean and English names and the code of each club's D-League
#'   side. The columns are always these, in this order (sdv-py `kbl_teams`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | team_code_d | character | Team code of the club's D-League (reserve) side, in the same team-code space as `teamCode`. |
#' | team_name | character | Team short name (Korean, no space, e.g. Changwon LG); the English form is `teamNameEn`. |
#' | team_name_full | character | Team full name (Korean). |
#' | team_name_en | character | Team short name in English. |
#' | team_name_full_en | character | Team full name in English (e.g. 'CHANGWON LG SAKERS'). |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_teams())
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Every game (all competitions, KBL and D-League) of a season or of a date window, with scores
#'   and venue. The columns are always these, in this order (sdv-py `kbl_schedule`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every `/match/{gmkey}` route. |
#' | glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the /leagues and /league/rank routes. |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
#' | season_name | character | Season label as sent: 'YYYY-YYYY' for a KBL season, '1997' for the inaugural one, a D-League edition label, or an empty string on EASL rows. |
#' | season_grade | integer | Division: 1 = the KBL itself, 2 = the KBL D-League (reserve league). |
#' | game_code | character | Competition type within the season (2-digit string; code table in the README and below): 01 regular season, 03 playoffs, 04 final, ... |
#' | game_no | integer | Game number within the competition (glkey); the N part of the gmkey. |
#' | season_category | character | Category code of the competition: R regular season, PO playoffs, CP final, D1/D2 D-League stages, AS All-Star, EG/CU cups, EA EASL, OM Open Match Day (table below). |
#' | season_category_name | character | Category name in Korean (regular season, playoffs, championship final, D-League stage 1 / 2, All-Star Game, cups, 'KBL' Cup, 'EASL', 'OPEN MATCH DAY'). |
#' | game_date | Date | Game date (KST). |
#' | week_day | character | Day of the week in Korean (one Hangul syllable, Monday to Sunday). |
#' | game_start | character | Tip-off time, HHMM (KST). |
#' | game_end | character | End time, HHMM (KST); '0000' or blanks when not recorded. |
#' | game_time | integer | Duration of the game in minutes (a numeric string on the wire; null on some rows). |
#' | home_team_code | character | Home team code. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | away_team_code | character | Away team code. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | home_team_name | character | Home team short name (Korean, e.g. Goyang Sono). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | away_team_name | character | Away team short name (Korean, e.g. Changwon LG). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | home_team_name_full | character | Home team full name (Korean). |
#' | away_team_name_full | character | Away team full name (Korean). |
#' | home_score | integer | Home team points (scoreH). |
#' | away_score | integer | Away team points (scoreA). |
#' | is_started | integer | 1 when the game has started. Unreliable for old games (0 on finished 1997-2006 games in /match/list). |
#' | is_ended | integer | 1 when the game is over. Unreliable: 0 on every finished game through 2005-06 and on some later ones (e.g. S45G01N95's header); the capture treats a past-dated game with scores as final. |
#' | playing_quarter | character | Period in progress: 'X' when none (before or after the game), else e.g. 'Q4' or 'EQ1'. Can stay stale after the game (the overtime sample says 'EQ1'). |
#' | stadium_name | character | Venue short name (Korean). |
#' | stadium_name_full | character | Venue full name (Korean). |
#' | stadium_name_en | character | Venue name in English; an empty string, or the Korean name, for some old venues. |
#' | tv | character | Broadcaster name(s), e.g. 'tvN SPORTS', 'SPOTV2 / SPOTV ON'. |
#' | tv_code | character | Broadcaster code(s), comma-separated (e.g. 'T24,T25'); the site uses it instead of `tv` from seasonCode 45. |
#' | article_id | integer | Id of the game's news article on kbl.or.kr; null when none. |
#' | challenge_id | integer | Id of the game in KBL Challenge (the site's prediction game); null when none. |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_schedule(from_date = "20251101", to_date = "20251102"))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Game header of a final game: teams, final score, overtimes, venue, attendance, officials and
#'   coaches. The columns are always these, in this order (sdv-py `kbl_game`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every `/match/{gmkey}` route. |
#' | glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the /leagues and /league/rank routes. |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
#' | season_name | character | Season label: 'YYYY-YYYY' for a KBL season (e.g. '2025-2026'), '1997' for the 1997 inaugural season, or the D-League edition name (e.g. '2010KBLWINTER'). |
#' | season_grade | integer | Division: 1 = the KBL itself, 2 = the KBL D-League (reserve league). |
#' | game_code | character | Competition type within the season (2-digit string; code table in the README and below): 01 regular season, 03 playoffs, 04 final, ... |
#' | game_no | integer | Game number within the competition (glkey); the N part of the gmkey. |
#' | season_category_name | character | Category name in Korean (regular season, playoffs, championship final, D-League stage 1 / 2, All-Star Game, cups, 'KBL' Cup, 'EASL', 'OPEN MATCH DAY'). |
#' | game_date | Date | Game date (KST). |
#' | week_day | character | Day of the week in Korean (one Hangul syllable, Monday to Sunday). |
#' | game_start | character | Tip-off time, HHMM (KST). |
#' | game_end | character | End time, HHMM (KST); '0000' or blanks when not recorded. |
#' | game_time | integer | Duration of the game in minutes. |
#' | home_team_code | character | Home team code. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | away_team_code | character | Away team code. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | home_team_name | character | Home team short name (Korean, e.g. Goyang Sono). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | away_team_name | character | Away team short name (Korean, e.g. Changwon LG). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | home_team_name_full | character | Home team full name (Korean). |
#' | away_team_name_full | character | Away team full name (Korean). |
#' | home_score | integer | Home team final points, summed from the period scores (the header carries no totals). |
#' | away_score | integer | Away team final points, summed from the period scores (the header carries no totals). |
#' | overtimes | integer | Number of overtime periods played (0 for a game decided in regulation). |
#' | is_started | integer | 1 when the game has started. Unreliable for old games (0 on finished 1997-2006 games in /match/list). |
#' | is_ended | integer | 1 when the game is over. Unreliable: 0 on every finished game through 2005-06 and on some later ones (e.g. S45G01N95's header); the capture treats a past-dated game with scores as final. |
#' | playing_quarter | character | Period in progress: 'X' when none (before or after the game), else e.g. 'Q4' or 'EQ1'. Can stay stale after the game (the overtime sample says 'EQ1'). |
#' | stadium_name | character | Venue short name (Korean). |
#' | stadium_name_full | character | Venue full name (Korean). |
#' | stadium_name_en | character | Venue name in English; an empty string, or the Korean name, for some old venues. |
#' | crowds | integer | Attendance of the game (spectators). |
#' | tv | character | Broadcaster name(s), e.g. 'tvN SPORTS', 'SPOTV2 / SPOTV ON'. |
#' | tv_code | character | Broadcaster code(s), comma-separated (e.g. 'T24,T25'); the site uses it instead of `tv` from seasonCode 45. |
#' | detail_url | character | Path of the game page on www.kbl.or.kr. |
#' | highlight_url | character | URL of the game's page on Naver Sports. |
#' | referee_main | character | Crew chief's name (officials appear by name only). |
#' | referees_sub | character | JSON list of the umpires' names (officials appear by name only). |
#' | home_manager | character | Home head coach's name (officials and coaches appear by name only). |
#' | away_manager | character | Away head coach's name (officials and coaches appear by name only). |
#' | home_coaches | character | JSON list of the home assistant coaches' names (staff appear by name only). |
#' | away_coaches | character | JSON list of the away assistant coaches' names (staff appear by name only). |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_game(gmkey = "S47G01N49"))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Points by period (quarters and overtimes) and side of a final game, from the game header.
#'   The columns are always these, in this order (sdv-py `kbl_period_scores`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
#' | side | character | Which side of the game the row belongs to: home or away. |
#' | team_code | character | Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
#' | period | integer | Period number: 1-4 for the quarters, 5, 6, ... for the overtimes (the wire says X1 in the play-by-play, EQ1 in the match chart). |
#' | period_label | character | Period label: Q1-Q4, then OT1, OT2, ... (normalised from the wire's X1 / EQ1 / eq1). |
#' | score | integer | Points the side scored in the period. |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_period_scores(gmkey = "S47G01N49"))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Play-by-play (the site's text cast) of a final game, one row per event, from 1997-98 on. The
#'   columns are always these, in this order (sdv-py `kbl_pbp`); an empty valid answer raises `hoopR_no_data`, a valid
#'   body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
#' | action_number | integer | 1-based position of the event in the feed, which is in game order (the wire's n is 0 on every row of some games). |
#' | event_number | integer | Sequence number of the event in the game (1-based); 0 on every row of some games (e.g. S45G01N95), so order by array position. |
#' | period | integer | Period number: 1-4 for the quarters, 5, 6, ... for the overtimes (the wire says X1 in the play-by-play, EQ1 in the match chart). |
#' | period_label | character | Period label: Q1-Q4, then OT1, OT2, ... (normalised from the wire's X1 / EQ1 / eq1). |
#' | minutes_left | integer | Minutes remaining in the period (10-minute quarters, 5-minute overtimes). |
#' | seconds_left | integer | Seconds part of the time remaining (0-59). |
#' | clock_seconds_left | integer | Seconds left in the period (minutes_left * 60 + seconds_left); quarters are 10 minutes, overtimes 5. |
#' | team_code | character | Team code of the acting team (the KBL team code, as `tcodeH`/`tcodeA`); '' (or ' ' in 1997-98) on game events such as period start/end. |
#' | player_name | character | Player name in Korean; absent on team and game events. |
#' | player_name_en | character | Player name in English / romanized; absent on team and game events. |
#' | action_code | character | Action code (string, e.g. '201'); table in the returns md. |
#' | action | character | English meaning of action_code (kbl_codes.ACTIONS), translated from the site's Korean label; null for an unknown code. |
#' | action_ko | character | The site's own Korean label of action_code (Hangul, e.g. the label for two-point field goal made). |
#' | points | integer | Points the event scored: 2 for a made two-point shot or dunk (201, 207), 3 for a made three (205), 1 for a made free throw (203); null otherwise. |
#' | substitution_code | character | Substitution sub-type code on substitution-out (102) rows (e.g. '101_0'); table in the returns md. |
#' | substitution | character | English meaning of substitution_code on substitution-out rows (e.g. 106_1 = fouled out, five fouls); null otherwise. |
#' | foul_code | character | Foul type code (the site reads an f field; no sampled row carries it): PNF personal, TCF technical, FRF unsportsmanlike, FTF fighting, PCF punching, EBF elbow. |
#' | foul | character | English meaning of foul_code (e.g. TCF = technical foul). No sampled row carries a foul code, so this is unverified. |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_pbp(gmkey = "S47G01N49"))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Player box score of a final game with the vendor's advanced rates, one row per player of
#'   both teams. The columns are always these, in this order (sdv-py `kbl_player_box`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | home_away | character | Side (string): '1' home, '2' away; '3' on both teams' rows in the 1997-98 sample, so join on `player.tcode` instead. |
#' | started | integer | 1 when the player started the game, else 0. |
#' | pcode | character | KBL player code (6-digit string). Joins to `pcode` on every route and to `playerNo` in /league/round-mvp. |
#' | player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
#' | player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
#' | team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | back_num | character | Jersey number (string). |
#' | pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
#' | player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |
#' | score | integer | Points. This game. |
#' | fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). This game. |
#' | fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). This game. |
#' | fgt | integer | Field goals made, two- and three-point (fg + threep). This game. |
#' | fgt_a | integer | Field-goal attempts, two- and three-point (fgA + threepA). This game. |
#' | threep | integer | Three-point field goals made (action 205). This game. |
#' | threep_a | integer | Three-point attempts, made + missed (205 + 206). This game. |
#' | ft | integer | Free throws made (action 203). This game. |
#' | ft_a | integer | Free-throw attempts, made + missed (203 + 204). This game. |
#' | dk | integer | Dunks made (action 207); included in `fg`. This game. |
#' | dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). This game. |
#' | rb | integer | Total rebounds (offr + defr; team rebounds are `teamR`). This game. |
#' | offr | integer | Offensive rebounds (action 209). This game. |
#' | defr | integer | Defensive rebounds (action 210). This game. |
#' | ast | integer | Assists (action 211). This game. |
#' | stl | integer | Steals (action 212). This game. |
#' | bs | integer | Blocked shots (action 213). This game. |
#' | to | integer | Turnovers (action 214). This game. |
#' | foul | integer | Personal fouls (wft + woft). This game. |
#' | wft | integer | Fouls that awarded free throws (action 215). This game. |
#' | woft | integer | Fouls that awarded no free throws (action 216). This game. |
#' | pp | integer | Field goals made in the paint. This game. |
#' | pp_a | integer | Field-goal attempts in the paint. This game. |
#' | pscore | integer | Points in the paint (2 * pp). This game. |
#' | sast | integer | Screen assists (action 226; tracked in recent seasons only, 0 before). This game. |
#' | dfl | integer | Deflections (action 227; tracked in recent seasons only, 0 before). This game. |
#' | gd | integer | Good-defense plays (action 221). This game. |
#' | idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). This game. |
#' | fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). This game. |
#' | ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). This game. |
#' | tf | integer | Probably technical fouls (unverified; 0 in most rows). This game. |
#' | inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. This game. |
#' | inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. This game. |
#' | play_min | integer | Minutes of playing time; add `playSec` seconds. This game. |
#' | play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. This game. |
#' | fo | integer | Fouls drawn (the player rows of a team sum to the opponent's `foul`, checked on the 2025-26 sample game). This game. |
#' | margin_cn | integer | Plus-minus: the point margin while the player was on court. This game. |
#' | offrtg | double | Offensive rating: points scored per 100 possessions (estimated). This game. |
#' | defrtg | double | Defensive rating: points allowed per 100 possessions (estimated). This game. |
#' | netrtg | double | Net rating: offrtg - defrtg. This game. |
#' | efg_rt | double | Effective field-goal percentage, 0-100. This game. |
#' | ts_rt | double | True-shooting percentage, 0-100. This game. |
#' | ast_rt | double | Assist rate: share of teammates' field goals assisted while on court, 0-100. This game. |
#' | ast_to | double | Assist-to-turnover ratio. This game. |
#' | ast_ratio | double | Assist ratio: assists per 100 possessions used. This game. |
#' | oreb_rt | double | Offensive-rebound percentage, 0-100. This game. |
#' | dreb_rt | double | Defensive-rebound percentage, 0-100. This game. |
#' | reb_rt | double | Total-rebound percentage, 0-100. This game. |
#' | pace | double | Possessions per 40 minutes (estimated; a player row covers his minutes on court). This game. |
#' | tov_rt | double | Turnover rate: turnovers per 100 possessions, 0-100. This game. |
#' | poss | double | Possessions (estimated). This game. |
#' | per | double | Player efficiency rating (KBL's formula; scale unverified). This game. |
#' | pie | double | Player impact estimate: share of the game's positive events, as a percentage. This game. |
#' | usg_rt | double | Usage rate: share of team possessions used while on court, 0-100. This game. |
#' | to_ratio | double | Turnover ratio: turnovers per 100 possessions used. This game. |
#' | minutes_played | double | Playing time in minutes (play_min + play_sec / 60), derived. |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_player_box(gmkey = "S47G01N49"))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Team box score of a final game with advanced rates and team-only counts, one row per team.
#'   The columns are always these, in this order (sdv-py `kbl_team_box`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | score | integer | Points. This game, team total. |
#' | fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). This game, team total. |
#' | fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). This game, team total. |
#' | fgt | integer | Field goals made, two- and three-point (fg + threep). This game, team total. |
#' | fgt_a | integer | Field-goal attempts, two- and three-point (fgA + threepA). This game, team total. |
#' | threep | integer | Three-point field goals made (action 205). This game, team total. |
#' | threep_a | integer | Three-point attempts, made + missed (205 + 206). This game, team total. |
#' | ft | integer | Free throws made (action 203). This game, team total. |
#' | ft_a | integer | Free-throw attempts, made + missed (203 + 204). This game, team total. |
#' | dk | integer | Dunks made (action 207); included in `fg`. This game, team total. |
#' | dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). This game, team total. |
#' | rb | integer | Total rebounds (offr + defr; team rebounds are `teamR`). This game, team total. |
#' | offr | integer | Offensive rebounds (action 209). This game, team total. |
#' | defr | integer | Defensive rebounds (action 210). This game, team total. |
#' | ast | integer | Assists (action 211). This game, team total. |
#' | stl | integer | Steals (action 212). This game, team total. |
#' | bs | integer | Blocked shots (action 213). This game, team total. |
#' | to | integer | Turnovers (action 214). This game, team total. |
#' | foul | integer | Personal fouls (wft + woft). This game, team total. |
#' | wft | integer | Fouls that awarded free throws (action 215). This game, team total. |
#' | woft | integer | Fouls that awarded no free throws (action 216). This game, team total. |
#' | pp | integer | Field goals made in the paint. This game, team total. |
#' | pp_a | integer | Field-goal attempts in the paint. This game, team total. |
#' | pscore | integer | Points in the paint (2 * pp). This game, team total. |
#' | sast | integer | Screen assists (action 226; tracked in recent seasons only, 0 before). This game, team total. |
#' | dfl | integer | Deflections (action 227; tracked in recent seasons only, 0 before). This game, team total. |
#' | gd | integer | Good-defense plays (action 221). This game, team total. |
#' | idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). This game, team total. |
#' | fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). This game, team total. |
#' | ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). This game, team total. |
#' | tf | integer | Probably technical fouls (unverified; 0 in most rows). This game, team total. |
#' | inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. This game, team total. |
#' | inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. This game, team total. |
#' | play_min | integer | Minutes of playing time summed over the players (200 = 5 x 40 in regulation); add playSec. This game, team total. |
#' | play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. This game, team total. |
#' | bf | integer | Meaning unverified (probably bench fouls; 0 in every game sample). This game, team total. |
#' | foulout | integer | Players fouled out (unverified). This game, team total. |
#' | team_r | integer | Team rebounds (action 218). This game, team total. |
#' | tfb | integer | Team fast breaks (action 217). This game, team total. |
#' | tto | integer | Team turnovers (action 223). This game, team total. |
#' | fb_score_cn | integer | Fast-break points. This game, team total. |
#' | turnover_score_cn | integer | Points off turnovers. This game, team total. |
#' | sec_chance_score_cn | integer | Second-chance points. This game, team total. |
#' | bench_score_cn | integer | Bench points. This game, team total. |
#' | max_conti_score_cn | integer | Longest scoring run: the most consecutive points without an opponent score. This game, team total. |
#' | max_lead_score_cn | integer | Largest lead, in points. This game, team total. |
#' | score_high_time_cn | integer | Seconds the team led (the two teams' values sum to less than the 2,400-second game when it was tied or level at times). This game, team total. |
#' | offrtg | double | Offensive rating: points scored per 100 possessions (estimated). This game, team total. |
#' | defrtg | double | Defensive rating: points allowed per 100 possessions (estimated). This game, team total. |
#' | netrtg | double | Net rating: offrtg - defrtg. This game, team total. |
#' | efg_rt | double | Effective field-goal percentage, 0-100. This game, team total. |
#' | ts_rt | double | True-shooting percentage, 0-100. This game, team total. |
#' | ast_rt | double | Assist rate: share of teammates' field goals assisted while on court, 0-100. This game, team total. |
#' | ast_to | double | Assist-to-turnover ratio. This game, team total. |
#' | ast_ratio | double | Assist ratio: assists per 100 possessions used. This game, team total. |
#' | oreb_rt | double | Offensive-rebound percentage, 0-100. This game, team total. |
#' | dreb_rt | double | Defensive-rebound percentage, 0-100. This game, team total. |
#' | reb_rt | double | Total-rebound percentage, 0-100. This game, team total. |
#' | pace | double | Possessions per 40 minutes (estimated; a player row covers his minutes on court). This game, team total. |
#' | tov_rt | double | Turnover rate: turnovers per 100 possessions, 0-100. This game, team total. |
#' | poss | double | Possessions (estimated). This game, team total. |
#' | minutes_played | double | Playing time in minutes (play_min + play_sec / 60), derived. |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_team_box(gmkey = "S47G01N49"))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Shot chart of a final game (2006-07 on): every charted shot with x/y pixels on the
#'   full-court image. The columns are always these, in this order (sdv-py `kbl_shots`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
#' | pcode | character | KBL player code (six-digit string) of the shooter. |
#' | player_name | character | Shooter's name in Korean. |
#' | player_name_en | character | Shooter's name in English / romanized. |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | period | integer | Period number: 1-4 for the quarters, 5, 6, ... for the overtimes (the wire says X1 in the play-by-play, EQ1 in the match chart). |
#' | period_label | character | Period label: Q1-Q4, then OT1, OT2, ... (normalised from the wire's X1 / EQ1 / eq1). |
#' | x | integer | Shot location x, pixels on the site's 726 x 412 full-court image (origin top-left, x along the court, right); see basket. |
#' | y | integer | Shot location y, pixels on the 726 x 412 full-court image (origin top-left, y down). |
#' | made | logical | True when the shot went in (wire o = 'O'), False when it missed ('X'). |
#' | basket | character | Target basket: '1' the right-hand one (x > 363), '2' the left-hand one; teams switch baskets at half-time. |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_shots(gmkey = "S47G01N49"))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Lead tracker and score chart of a final game: home margin and both scores at eight
#'   checkpoints per period. The columns are always these, in this order (sdv-py `kbl_score_track`); an empty valid
#'   answer raises `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
#' | period | integer | Period number: 1-4 for the quarters, 5, 6, ... for the overtimes (the wire says X1 in the play-by-play, EQ1 in the match chart). |
#' | period_label | character | Period label: Q1-Q4, then OT1, OT2, ... (normalised from the wire's X1 / EQ1 / eq1). |
#' | checkpoint | integer | 1-based checkpoint inside the period: eight per period, evenly spaced is assumed (every 75 s of a quarter; unverified), the last at the period's end. |
#' | home_margin | integer | Home margin (home minus away points) at the checkpoint. |
#' | home_score | integer | Home team points: cumulative at the checkpoint on the score track, the final total (all periods summed) on a game row, the full-time score in the schedule. |
#' | away_score | integer | Away team points: cumulative at the checkpoint on the score track, the final total (all periods summed) on a game row, the full-time score in the schedule. |
#' @eval .intl_details(.kbl_seasons_details, 'kbl_score_track(gmkey = "S47G01N49")')
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Each team's leader per category (points, rebounds, assists, steals, blocks) in a final game.
#'   The columns are always these, in this order (sdv-py `kbl_game_leaders`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | game_no | integer | Game number inside the competition (glkey): the N part of the gmkey. |
#' | part | character | Category code: score points, rb rebounds, ast assists, stl steals, bs blocks. |
#' | side | character | Side of the leader: home or away. |
#' | pcode | character | KBL player code (six-digit string) of the team's leader in the category. |
#' | player_name | character | Leader's name in Korean (foreign players in Hangul transliteration). |
#' | player_name_en | character | Leader's name in English / romanized. |
#' | team_name | character | The leader's team short name (Korean). |
#' | value | double | The leader's total in the category in this game. |
#' | play_min | integer | Minutes the leader played this game; add play_sec seconds. |
#' | play_sec | integer | Seconds part of the leader's playing time (0-59). |
#' @eval .intl_details(.kbl_seasons_details, 'kbl_game_leaders(gmkey = "S47G01N49")')
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Season player totals of one competition (every player with at least one game). The columns
#'   are always these, in this order (sdv-py `kbl_player_totals`); an empty valid answer raises `hoopR_no_data`, a
#'   valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the season routes. |
#' | pcode | character | KBL player code (six-digit string). |
#' | player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
#' | player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | back_num | character | Jersey number (string). |
#' | pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
#' | player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |
#' | game_count | integer | Games played (this season or competition). |
#' | start_count | integer | Meaning unverified: up to 4 x gameCount in every sampled row, so probably quarters started. |
#' | score | integer | Points. Season total for the competition (glkey). |
#' | fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). Season total for the competition (glkey). |
#' | fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). Season total for the competition (glkey). |
#' | fgt | integer | Field goals made, two- and three-point (fg + threep). Season total for the competition (glkey). |
#' | fgt_a | integer | Field-goal attempts, two- and three-point (fgA + threepA). Season total for the competition (glkey). |
#' | threep | integer | Three-point field goals made (action 205). Season total for the competition (glkey). |
#' | threep_a | integer | Three-point attempts, made + missed (205 + 206). Season total for the competition (glkey). |
#' | ft | integer | Free throws made (action 203). Season total for the competition (glkey). |
#' | ft_a | integer | Free-throw attempts, made + missed (203 + 204). Season total for the competition (glkey). |
#' | dk | integer | Dunks made (action 207); included in `fg`. Season total for the competition (glkey). |
#' | dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). Season total for the competition (glkey). |
#' | rb | integer | Total rebounds (offr + defr; team rebounds are `teamR`). Season total for the competition (glkey). |
#' | offr | integer | Offensive rebounds (action 209). Season total for the competition (glkey). |
#' | defr | integer | Defensive rebounds (action 210). Season total for the competition (glkey). |
#' | ast | integer | Assists (action 211). Season total for the competition (glkey). |
#' | stl | integer | Steals (action 212). Season total for the competition (glkey). |
#' | bs | integer | Blocked shots (action 213). Season total for the competition (glkey). |
#' | to | integer | Turnovers (action 214). Season total for the competition (glkey). |
#' | foul | integer | Personal fouls (wft + woft). Season total for the competition (glkey). |
#' | wft | integer | Fouls that awarded free throws (action 215). Season total for the competition (glkey). |
#' | woft | integer | Fouls that awarded no free throws (action 216). Season total for the competition (glkey). |
#' | pp | integer | Field goals made in the paint. Season total for the competition (glkey). |
#' | pp_a | integer | Field-goal attempts in the paint. Season total for the competition (glkey). |
#' | pscore | integer | Points in the paint (2 * pp). Season total for the competition (glkey). |
#' | sast | integer | Screen assists (action 226; tracked in recent seasons only, 0 before). Season total for the competition (glkey). |
#' | dfl | integer | Deflections (action 227; tracked in recent seasons only, 0 before). Season total for the competition (glkey). |
#' | gd | integer | Good-defense plays (action 221). Season total for the competition (glkey). |
#' | idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). Season total for the competition (glkey). |
#' | fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). Season total for the competition (glkey). |
#' | ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). Season total for the competition (glkey). |
#' | tf | integer | Probably technical fouls (unverified; 0 in most rows). Season total for the competition (glkey). |
#' | inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. Season total for the competition (glkey). |
#' | inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. Season total for the competition (glkey). |
#' | play_min | integer | Minutes of playing time; add `playSec` seconds. Season total for the competition (glkey). |
#' | play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. Season total for the competition (glkey). |
#' | foulout | integer | Meaning unverified: values exceed games played (70 for a 40-game player with 74 fouls); possibly fouls drawn, as this route has no `fo`. |
#' | minutes_played | double | Playing time in minutes (play_min + play_sec / 60), derived. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_player_totals(season = 2025)")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Standings of one competition with each team's season totals. The columns are always these,
#'   in this order (sdv-py `kbl_standings`); an empty valid answer raises `hoopR_no_data`, a valid body with no rows
#'   for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | game_code | character | Competition type within the season (2-digit string; code table in the README and below): 01 regular season, 03 playoffs, 04 final, ... |
#' | rank | integer | Standing (1 = first). |
#' | team_code | character | Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
#' | team_name | character | Team short name (Korean, e.g. Wonju DB). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | team_name_full | character | Team full name (Korean). |
#' | game_count | integer | Games played (this season or competition). |
#' | wins | integer | Season wins of the team (the wire's TWin). |
#' | losses | integer | Season losses of the team (the wire's TLoss). |
#' | draws | integer | Draws (TDraw, always 0). |
#' | win_rate | double | Win fraction, 0-1. |
#' | win_diff | double | Games behind the leader. |
#' | home_wins | integer | Wins in the team's home games. |
#' | home_losses | integer | Losses in the team's home games. |
#' | away_wins | integer | Wins in the team's away games. |
#' | away_losses | integer | Losses in the team's away games. |
#' | conti_win | integer | Current winning streak (0 when the last game was a loss). |
#' | conti_loss | integer | Current losing streak (0 when the last game was a win). |
#' | conti_date | Date | Date (YYYYMMDD) the current streak started (inferred; unverified). |
#' | max_win | integer | Longest winning streak of the season. |
#' | max_loss | integer | Longest losing streak of the season. |
#' | last_game_date | Date | Date of the latest game counted in the row, YYYYMMDD. |
#' | last_five | character | The last five results as a comma-separated string, most recent first: 1 win, 0 loss (the name is cut short in the API). |
#' | last_game_won | logical | True when the team's latest game was a win (the wire's win; a boolean, not a count). |
#' | last_game_lost | logical | True when the team's latest game was a loss (inferred from conti_loss). |
#' | last_game_drawn | logical | True when the team's latest game was a draw (always false). |
#' | game_flag | logical | Boolean flag in the standings row; meaning unverified (true in the sample). |
#' | updated_at | character | When the standings row was written (ISO 8601 UTC timestamp). |
#' | score | integer | Points. Team season total for the competition (glkey). |
#' | fg | integer | Two-point field goals made, dunks included: 201 + 207 rows (score = 2*fg + 3*threep + ft holds on every sampled box). Team season total for the competition (glkey). |
#' | fg_a | integer | Two-point field-goal attempts, made + missed, dunks included: 201 + 202 + 207 + 208 rows (checked per team on S47G01N49). Team season total for the competition (glkey). |
#' | threep | integer | Three-point field goals made (action 205). Team season total for the competition (glkey). |
#' | threep_a | integer | Three-point attempts, made + missed (205 + 206). Team season total for the competition (glkey). |
#' | ft | integer | Free throws made (action 203). Team season total for the competition (glkey). |
#' | ft_a | integer | Free-throw attempts, made + missed (203 + 204). Team season total for the competition (glkey). |
#' | dk | integer | Dunks made (action 207); included in `fg`. Team season total for the competition (glkey). |
#' | dk_a | integer | Dunk attempts (made + missed, actions 207 + 208). Team season total for the competition (glkey). |
#' | ast | integer | Assists. Team season total for the competition (glkey). |
#' | bs | integer | Blocked shots. Team season total for the competition (glkey). |
#' | defr | integer | Defensive rebounds. Team season total for the competition (glkey). |
#' | offr | integer | Offensive rebounds. Team season total for the competition (glkey). |
#' | stl | integer | Steals. Team season total for the competition (glkey). |
#' | to | integer | Turnovers. Team season total for the competition (glkey). |
#' | team_r | integer | Team rebounds (action 218), unverified against `teamR`. Team season total for the competition (glkey). |
#' | pp | integer | Paint field goals made: 0 in every sampled row (see PScore). |
#' | pp_a | integer | Paint field-goal attempts: 0 in every sampled row (see PScore). |
#' | pscore | integer | Points in the paint (pp/ppA are 0 on this route in every sampled row). Team season total for the competition (glkey). |
#' | wft | integer | Fouls that awarded free throws (action 215). Team season total for the competition (glkey). |
#' | woft | integer | Fouls that awarded no free throws (action 216). Team season total for the competition (glkey). |
#' | foul_total | integer | Personal fouls over the season (foulTot). |
#' | tfb | integer | Team fast breaks (action 217). Team season total for the competition (glkey). |
#' | tto | integer | Team turnovers (action 223). Team season total for the competition (glkey). |
#' | tf | integer | Probably technical fouls (unverified; 0 in most rows). Team season total for the competition (glkey). |
#' | fb | integer | Fast breaks credited to the player (action 217 rows that name a player, as in 1997-98); 0 in recent seasons, where fast breaks are team rows (`tfb`). Team season total for the competition (glkey). |
#' | ef | integer | Meaning unverified (0 in every game sample; non-zero in some season totals). Team season total for the competition (glkey). |
#' | bf | integer | Meaning unverified (probably bench fouls; 0 in every game sample). Team season total for the competition (glkey). |
#' | gd | integer | Good-defense plays (action 221). Team season total for the competition (glkey). |
#' | idf | integer | Illegal-defense violations (action 219; an early-KBL rule, so non-zero only in old seasons). Team season total for the competition (glkey). |
#' | inout | integer | Times the player entered the game, the start included (checked on the 2025-26 sample game); a team row sums its players. Team season total for the competition (glkey). |
#' | inout1 | integer | Times the player was substituted out before the end (checked on the 2025-26 sample game); a team row sums its players. Team season total for the competition (glkey). |
#' | foulout | integer | Players fouled out (unverified). Team season total for the competition (glkey). |
#' | play_min | integer | Minutes of playing time; add `playSec` seconds. Team season total for the competition (glkey). |
#' | play_sec | integer | Seconds part of the playing time (0-59), added to `playMin`. Team season total for the competition (glkey). |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_standings(season = 2025))
#' }
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Each team's standing after every game of the season, one row per team and game. The columns
#'   are always these, in this order (sdv-py `kbl_team_tracks`); an empty valid answer raises `hoopR_no_data`, a valid
#'   body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the season routes. |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | team_name | character | Team short name in English (e.g. 'KT'). |
#' | game_number | integer | 1-based game number in the team's season: the n-th entry of the team's rank track. |
#' | rank | integer | Standing (1 = first): after the game_number-th game on the rank track, the current rank on the standings routes. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_team_tracks(season = 2025)")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: The season's round calendar (the KBL plays six rounds) with each round's first and last
#'   date. The columns are always these, in this order (sdv-py `kbl_rounds`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | game_code | character | Competition inside the season, two digits: 01 regular season, 03 playoffs, 04 final, 07 EASL, 08 D-League stage 2, 10 All-Star, 11/13 cups, 14 Open Match Day. |
#' | glkey | character | Competition key `S{seasonCode}G{gameCode}` (e.g. S47G01 = 2025-26 regular season): the id of the season routes. |
#' | round | integer | Round number of the season (the KBL plays six rounds). |
#' | from_date | Date | First date of the round, YYYYMMDD. |
#' | to_date | Date | Last date of the round, YYYYMMDD. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_rounds(season = 2025)")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: The regular-season finish that seeds the playoffs (the top six). The columns are always
#'   these, in this order (sdv-py `kbl_playoff_seeds`); an empty valid answer raises `hoopR_no_data`, a valid body
#'   with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
#' | game_code | character | Competition type of the standings: '01' regular season. |
#' | seed | integer | Final regular-season standing, i.e. the playoff seed (1-6). |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | team_name | character | Team short name (Korean, e.g. Wonju DB). English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | team_name_full | character | Team full name (Korean). |
#' @eval .intl_details(.kbl_seasons_details, "kbl_playoff_seeds(season = 2025)")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: The playoff series (quarterfinals, semifinals, final): wins and losses of each team in each
#'   series. The columns are always these, in this order (sdv-py `kbl_playoff_series`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: one sequential number over every season and D-League edition (47 = 2025-26, 48 = the 2025 D-League). |
#' | bracket_format | character | Playoff bracket format: old (seasons through 2023-24, per-team series results) or new (2024-25 on, bracket numbers and games). |
#' | round | character | Playoff round: quarterfinal (the last six, seeds 3-6), semifinal (the last four) or final; on the round-MVP and rounds frames the round number of the season. |
#' | series_no | integer | Series number inside the round (the wire's gameHoi, '1' or '2'; 1 for the final). |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | opponent_code | character | Team code of the series opponent; null when the opponent cannot be told from the body. |
#' | seed | integer | Regular-season finish that seeded the team (1-6), from the bracket's seed table; null for a team outside it. |
#' | wins | integer | Wins of the team in the series. |
#' | losses | integer | Losses of the team in the series. |
#' | game_date | Date | Date of a game of the series, KST (which one is unverified); old bracket format only. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_playoff_series(season = 2025)")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: The games of the playoff bracket (2024-25 on; the older bracket format lists no games). The
#'   columns are always these, in this order (sdv-py `kbl_playoff_games`); an empty valid answer raises
#'   `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code of the game (from the bracket's gmkey object). |
#' | gmkey | character | Game key `S{seasonCode}G{gameCode}N{gameNo}` (e.g. S47G01N49): the id of every game route and game frame. |
#' | game_code | character | Competition type of the game: 03 playoffs, 04 championship final. |
#' | game_no | integer | Game number inside the competition, from the bracket's gmkey object. |
#' | round | character | Playoff round: quarterfinal (the last six, seeds 3-6), semifinal (the last four) or final; on the round-MVP and rounds frames the round number of the season. |
#' | series_no | integer | Series number inside the round (1 or 2 for the quarterfinals and semifinals, 1 for the final). |
#' | game_date | Date | Game date, KST. |
#' | home_team_code | character | Home team code. Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
#' | away_team_code | character | Away team code. Team code: the KBL club in that season (two-digit string with a leading zero, e.g. '50' = Changwon LG). Joins kbl_teams team_code; not stable across ownership changes (the Anyang club is '40' in 1997-98, '70' today). |
#' | home_team_name | character | Home team short name (Korean). |
#' | away_team_name | character | Away team short name (Korean). |
#' | home_score | integer | Home team points. |
#' | away_score | integer | Away team points. |
#' | home_win | logical | 1 when the home team won, else 0. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_playoff_games(season = 2025)")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: The round MVPs of a season with their totals over the round. The columns are always these,
#'   in this order (sdv-py `kbl_round_mvps`); an empty valid answer raises `hoopR_no_data`, a valid body with no rows
#'   for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), derived from season_code through the crosswalk (kbl_codes.SEASONS). |
#' | season_code | integer | KBL season code: sequential over every season and D-League edition (2 = 1997-98, 47 = 2025-26); the crosswalk to the sdv END year is in the README. |
#' | round | integer | Round number of the season (the KBL plays six rounds). |
#' | pcode | character | KBL player code (six-digit string) of the round MVP (the wire's playerNo). |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | player_name | character | Round MVP's name in Korean (kname). |
#' | player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
#' | game_count | integer | Games played in the round. |
#' | total_seconds | integer | Playing time over the round in seconds (totalHour * 3600 + totalMinute * 60 + totalSecond; only the seconds part is non-zero in the samples). |
#' | total_score | integer | Points over the round. |
#' | total_rebound | integer | Rebounds over the round. |
#' | total_assist | integer | Assists over the round. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_round_mvps(season = 2025)")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Current standings of the active season (no parameter): record, games behind, streaks,
#'   splits. The columns are always these, in this order (sdv-py `kbl_current_standings`); an empty valid answer
#'   raises `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | rank | integer | Standing (1 = first). |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | team_name_full | character | Team full name (Korean, e.g. Changwon LG Sakers). |
#' | wins | integer | Wins (a count on this route; on `/league/rank/{glkey}` win is a boolean about the latest game). |
#' | losses | integer | Losses (a count on this route). |
#' | draws | integer | Draws (always 0 in basketball). |
#' | win_diff | double | Games behind the leader. |
#' | home_wins | integer | Wins in the team's home games. |
#' | home_losses | integer | Losses in the team's home games. |
#' | away_wins | integer | Wins in the team's away games. |
#' | away_losses | integer | Losses in the team's away games. |
#' | conti_win | integer | Current winning streak (0 when the last game was a loss). |
#' | conti_loss | integer | Current losing streak (0 when the last game was a win). |
#' | max_win | integer | Longest winning streak of the season. |
#' | max_loss | integer | Longest losing streak of the season. |
#' | last_five | character | The last five results as a comma-separated string, most recent first: 1 win, 0 loss. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_current_standings()")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: Current season leaders per category (no parameter): points, rebounds, assists, steals,
#'   blocks, shooting. The columns are always these, in this order (sdv-py `kbl_season_leaders`); an empty valid
#'   answer raises `hoopR_no_data`, a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | part | character | Leader category code: score, rb, ast, bs, stl, fgt, threep, ftR, fgtR, threepR or dk. |
#' | part_label | character | English meaning of part (kbl_codes.LEADER_PARTS), e.g. score = points per game. |
#' | rank | integer | Rank in the category. |
#' | value | double | The player's value in the category: a per-game average, or a percentage for the *R categories. |
#' | game_count | integer | Games played this season. |
#' | pcode | character | KBL player code (6-digit string). Joins to `pcode` on every route and to `playerNo` in /league/round-mvp. |
#' | player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
#' | player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
#' | team_code | character | KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | team_name | character | Team short name (Korean, e.g. Changwon LG), as it was at the time. English names: /common/teamList `teamNameEn` / `teamNameFullEn`, joined on the team code. |
#' | back_num | character | Jersey number (string). |
#' | pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
#' | player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |
#' @eval .intl_details(.kbl_seasons_details, "kbl_season_leaders()")
#' @export
#' @family KBL Functions
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
#' @return
#' A `hoopR_data` tibble: The site's player directory (current and former players) with their current or last team.
#'   The columns are always these, in this order (sdv-py `kbl_players`); an empty valid answer raises `hoopR_no_data`,
#'   a valid body with no rows for this frame is a zero-row tibble:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | pcode | character | KBL player code (6-digit string). Joins to `pcode` on every route and to `playerNo` in /league/round-mvp. |
#' | player_name | character | Player name in Korean (foreign players in Hangul transliteration). |
#' | player_name_en | character | Player name in English / romanized (sometimes Hangul for former players). |
#' | team_code | character | Team code of the player's current or last team. KBL team code (2-digit string, e.g. '50' = Changwon LG). Joins to /common/teamList `teamCode`, game `tcodeH`/`tcodeA`, `t` in text-cast. Not stable across ownership changes: the Anyang club is '40' (SBS) in 1997-98 and '70' today. D-League sides have their own codes (`teamCodeD`). |
#' | team_name | character | Short name (Korean) of the player's current or last team. |
#' | team_name_en | character | Current team short name in English (e.g. 'JUNG KWAN JANG'). |
#' | back_num | character | Jersey number (string). |
#' | pos | character | Position code (string): C center, FD forward, GD guard, FC forward-center, GF guard-forward; table in the returns md. |
#' | player_flag | character | Player type (string): '0' domestic, '1' foreign import, '2' Asian-quota player. |
#' | last_career | character | Meaning unverified: a season-code-like number, 'A' or ''. |
#' @inherit kbl_seasons details
#' @examples
#' \donttest{
#'   try(kbl_players())
#' }
#' @export
#' @family KBL Functions
kbl_players <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .kbl_simple_get("/players", call = rlang::current_env())
  .kbl_out("players", raw, "KBL Players from api.kbl.or.kr")
}
