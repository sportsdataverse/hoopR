# tbf.R -- the TBF `tbf_*()` family: Turkish Basketball Federation app API (BSL, TBL, KBSL).
#
# R mirror of sdv-py sportsdataverse/basketball/tbf (e3d232e): same names, arguments, defaults
# and columns. Runtime and parsers: R/tbf_utils.R.

#' @title
#' **TBF Seasons**
#' @description
#' The 20 most recent TBF seasons, domestic and international (a server cap), newest first.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Season/get-seasons`
#' @return A `hoopR_data` tibble. One row per season, newest first. `season` is the END year of the label (2026-2027 -> 2027); `international` marks the odd `UA-` seasons.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'   | season_label | character | Season label as TBF writes it, 'YYYY-YYYY' (start and end year). |
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | start_date | Date | Season start, Turkey local time (Europe/Istanbul, UTC+3), ISO 8601 without zone: domestic seasons run 07-01 to 06-30, international ones 10-01 to 09-30. |
#'   | end_date | Date | Season end, Turkey local time (Europe/Istanbul, UTC+3), ISO 8601 without zone ('2027-06-30T23:59:00'). |
#'   | international | logical | True for the international UA- seasons (odd season ids); false for domestic ones. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_seasons())
#' }
tbf_seasons <- function() {
  .tbf_wrap("seasons", list(),
            type = "TBF Seasons", call = rlang::current_env())
}

#' @title
#' **TBF Leagues**
#' @description
#' The featured leagues (league-season activities) of one TBF season: BSL, TBL, KBSL and the others.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-leagues-for-filter`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @return A `hoopR_data` tibble. One row per league: BSL, TBL, KBSL, TKBL, TB2L and the youth leagues with their `activity_id`.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
#'   | name | character | Activity name '`<LEAGUE>` YYYY-YYYY' ('BSL 2026-2027'). |
#'   | display_name | character | League short name ('BSL', 'KBSL', 'TBL', 'TKBL', 'TB2L', 'BGL', 'BGLK', 'KBBL'). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | gender | character | Gender in Turkish: 'Erkek' = men, 'Kadin' = women. |
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'   | season_label | character | Season label as TBF writes it, 'YYYY-YYYY' (start and end year). |
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | sort | integer | Display order in the app (integer, 1 = first: BSL). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leagues(season = 2027))
#' }
tbf_leagues <- function(season) {
  .tbf_wrap("leagues", list(season = season),
            type = "TBF Leagues", call = rlang::current_env())
}

#' @title
#' **TBF League Seasons**
#' @description
#' Every season of one TBF league (bsl back to 1966-67) with its activity and season ids.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-leagues-and-seasons-by-prefix`
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per season of the league, newest first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
#'   | activity_name | character | League-season name as TBF prints it ('BSL 2026-2027'; the top flight reads 'TBL 2006-2007' until 2007-08). |
#'   | url | character | League-season slug, '`<prefix>`-`<YYYY>`-`<YYYY>`' (bsl-2026-2027). |
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'   | season_label | character | Season label as TBF writes it, 'YYYY-YYYY' (start and end year). |
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_league_seasons(competition = "bsl"))
#' }
tbf_league_seasons <- function(competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("league_seasons", list(competition = competition),
            type = "TBF League Seasons", call = rlang::current_env())
}

#' @title
#' **TBF Weeks**
#' @description
#' The weeks (rounds) of one league-season, playoff rounds included.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-league-weeks`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per week in play order; `week` is the value the schedule and standings take.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | activity_id | integer | Activity id of the request's league-season (key space: TBF league-seasons). |
#'   | season | integer | Season END year of the request (2027 = 2026-2027). |
#'   | competition | character | TBF league of the request: bsl, tbl or kbsl. |
#'   | week | character | Week number as a string; the value the week argument of tbf_standings and tbf_schedule takes. |
#'   | phase | integer | Phase code (devre = half / phase): 1 = first half of the regular season, 2 = second half, 3 = playoff quarter-final, 4 = semi-final, 5 = final. |
#'   | phase_name | character | Phase name in Turkish on playoff weeks (Playoff Final = final); null on regular-season weeks. |
#'   | label | character | Week label: 'Hafta N' (week N) or the playoff round name. |
#'   | is_current | logical | True on the current (or last played) week; exactly one row. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_weeks(competition = "bsl", season = 2027))
#' }
tbf_weeks <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("weeks", list(season = season, competition = competition),
            type = "TBF Weeks", call = rlang::current_env())
}

#' @title
#' **TBF Standings**
#' @description
#' League table of one league-season after a week (default the latest), one row per team and group.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/League/get-standings-table`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @param week Week (hafta) number as returned by [tbf_weeks()], e.g. 1; playoff rounds continue the numbering
#' (31-33 in 2025-26). Default: the latest week for standings, every week for the schedule.
#' @return A `hoopR_data` tibble. One row per team and group. Tie-break detail rows (`tiedRows`) are not included.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | group | character | Group name (grup); empty for a single-group league. |
#'   | activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
#'   | team_process_id | integer | Team-season id (teamProcessId = takimIslemId, a team REGISTRATION; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The team_process_id argument of the team wrappers; not the stable club_id. |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | week | integer | The week the table is computed after (hafta); equals the week argument, else the latest. |
#'   | rank | integer | League rank (sira) after that week. |
#'   | played | integer | Games played (o = oynanan). |
#'   | won | integer | Games won (g = galibiyet). |
#'   | lost | integer | Games lost (m = maglubiyet). |
#'   | points_for | integer | Points scored (a = atilan). |
#'   | points_against | integer | Points conceded (y = yenilen). |
#'   | points | integer | League points (puan): 2 for a win, 1 for a loss. |
#'   | head_to_head_points | integer | Head-to-head league points among teams tied on points (icP = ic puan). |
#'   | head_to_head_diff | integer | Head-to-head point difference among teams tied on points (icA = ic averaj). |
#'   | total_diff | integer | Total point difference over all games (toA = toplam averaj). |
#'   | excluded | integer | Exclusion marker (ihrac = expulsion); 0 for teams still in the league. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_standings(competition = "bsl", season = 2027))
#' }
tbf_standings <- function(season, competition = "bsl", week = NULL) {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("standings", list(season = season, competition = competition, week = week),
            type = "TBF Standings", call = rlang::current_env())
}

#' @title
#' **TBF Schedule**
#' @description
#' Schedule and results of one league-season: the games of one week, or of every week.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/get-all-matches-for-filter`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @param week Week (hafta) number as returned by [tbf_weeks()], e.g. 1; playoff rounds continue the numbering
#' (31-33 in 2025-26). Default: the latest week for standings, every week for the schedule.
#' @return A `hoopR_data` tibble. One row per game. Scores are null before the game; `status_id` 1 = played, 4 = not played, 19 = no date yet.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | match_code | character | TBF short game code ('1EA4917'); unique per game, meaning of the letters unverified. |
#'   | genius_id | integer | Genius Sports LiveStats match id (TBF spells it genuisId); joins the genius family. Null when TBF stored none: every game before 2018-19, many 2021-25 games and games not yet assigned one. |
#'   | activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
#'   | activity_name | character | Activity name ('BSL 2026-2027'). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'   | season_label | character | Season label as TBF writes it, 'YYYY-YYYY' (start and end year). |
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | tipoff | POSIXct | Tip-off as a naive timestamp in Turkey local time (Europe/Istanbul, UTC+3); the API sends no offset. |
#'   | match_date | Date | Tip-off date 'YYYY-MM-DD' (Turkey local). |
#'   | week | character | Week label: 'N. Hafta' (week N) or the playoff round ('Playoff Final'). |
#'   | phase | integer | Phase code as an integer: 1 = first half of the regular season; see tbf_weeks. |
#'   | status_id | integer | Game status code: 1 = played (Oynandi), 4 = not played (Oynanmadi), 19 = fixture without a date and time. Cast to an integer from the 1 / 1.0 the API sends. |
#'   | home_team_process_id | integer | Team-season id (teamProcessId = takimIslemId, 'team registration'; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The TeamProcessId parameter of the /Team/ routes. Not the club id (takimID / teamId of the team lists). |
#'   | home_team | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | home_score | integer | Home points (null before the game; the API sends '' ). |
#'   | away_team_process_id | integer | Team-season id (teamProcessId = takimIslemId, 'team registration'; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The TeamProcessId parameter of the /Team/ routes. Not the club id (takimID / teamId of the team lists). |
#'   | away_team | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | away_score | integer | Away points (null before the game; the API sends '' ). |
#'   | venue | character | Venue (salon) name. |
#'   | province | character | Province (il) of the venue, uppercase Turkish ('ISTANBUL'). |
#'   | gender | character | Gender in Turkish: Erkek = men, Kadin = women. |
#'   | broadcast_channel | character | Broadcaster ('beINSports', 'HT SPOR', 'Youtube / TBF TV'), or ''. |
#'   | has_overtime | logical | Overtime flag (uzatma = overtime). Reliability unverified: false on every one of 64 BSL 2025-26 games checked. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_schedule(competition = "bsl", season = 2027, week = 1))
#' }
tbf_schedule <- function(season, competition = "bsl", week = NULL) {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("schedule", list(season = season, competition = competition, week = week),
            type = "TBF Schedule", call = rlang::current_env())
}

#' @title
#' **TBF Daily Matches**
#' @description
#' Every TBF game played on one date, grouped by competition, optionally for one league-season.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/get-daily-matches`
#' @param match_date Required. Game date 'YYYY-MM-DD' (Turkey local date), e.g. '2026-10-11'.
#' @param season Optional, with competition: Season END year (2027 = the 2026-2027 season). TBF keys a
#' league-season by internal season and activity ids; the runtime reads them from the league's season list by
#' the END year of the label. A year the list lacks raises `hoopR_no_data`. Default: games of every
#' competition.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl. Optional, with season. Default: every
#' competition.
#' @return A `hoopR_data` tibble. One row per game with its `group_name` (the competition group the app shows).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | group_name | character | Competition group the app shows the game under (grup adi). |
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | match_code | character | TBF short game code ('1EA4917'); unique per game, meaning of the letters unverified. |
#'   | genius_id | integer | Genius Sports LiveStats match id (TBF spells it genuisId); joins the genius family. Null when TBF stored none: every game before 2018-19, many 2021-25 games and games not yet assigned one. |
#'   | activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
#'   | activity_name | character | Activity name ('BSL 2026-2027'). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'   | season_label | character | Season label as TBF writes it, 'YYYY-YYYY' (start and end year). |
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | tipoff | POSIXct | Tip-off as a naive timestamp in Turkey local time (Europe/Istanbul, UTC+3); the API sends no offset. |
#'   | match_date | Date | Tip-off date 'YYYY-MM-DD'; equals the MatchDate parameter (checked). |
#'   | week | character | Week (hafta) label or number: 'N. Hafta' on schedule rows, the number on standings rows, a playoff round name later in the season. |
#'   | phase | integer | Phase code as a string ('1' = first half of the regular season); see get-league-weeks devre_ID. |
#'   | status_id | integer | Game status code: 1 = played (Oynandi), 4 = not played (Oynanmadi), 19 = fixture without a date and time. Cast to an integer from the 1 / 1.0 the API sends. |
#'   | home_team_process_id | integer | Team-season id (teamProcessId = takimIslemId, 'team registration'; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The TeamProcessId parameter of the /Team/ routes. Not the club id (takimID / teamId of the team lists). |
#'   | home_team | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | home_score | integer | Home points (null before the game). |
#'   | away_team_process_id | integer | Team-season id (teamProcessId = takimIslemId, 'team registration'; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The TeamProcessId parameter of the /Team/ routes. Not the club id (takimID / teamId of the team lists). |
#'   | away_team | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | away_score | integer | Away points (null before the game). |
#'   | venue | character | Venue (salon) name. |
#'   | province | character | Province (il) of the venue when sent, uppercase Turkish; null otherwise. |
#'   | gender | character | Gender in Turkish when sent; empty on get-daily-matches, so null. |
#'   | broadcast_channel | character | Broadcaster ('beINSports', 'HT SPOR', 'Youtube / TBF TV'), or ''. |
#'   | has_overtime | logical | Overtime flag (uzatma = overtime). Reliability unverified: false on every one of 64 BSL 2025-26 games checked. |
#'   | status | character | Game status text in Turkish: Oynandi = played, Oynanmadi = not played. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_daily_matches(match_date = "2026-10-11"))
#' }
tbf_daily_matches <- function(match_date, season = NULL, competition = NULL) {
  .tbf_check_competition(competition, call = rlang::current_env(), optional = TRUE)
  .tbf_wrap("daily_matches", list(match_date = match_date, season = season, competition = competition),
            type = "TBF Daily Matches", call = rlang::current_env())
}

#' @title
#' **TBF Game Header**
#' @description
#' Game header of a finished game: teams, coaches, final score, officials, venue and the Genius LiveStats id.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-header`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | match_code | character | TBF short game code ('1EA4917'). |
#'   | genius_id | integer | Genius Sports LiveStats match id (TBF spells it genuisId); joins the genius family. Null when TBF stored none: every game before 2018-19, many 2021-25 games and games not yet assigned one. |
#'   | activity_id | integer | Activity id (faaliyet = activity; key space: TBF league-SEASONS, new every season: BSL 2026-27 = 22214, BSL 2025-26 = 20728, TBL 2026-27 = 22215, KBSL 2026-27 = 22209). Cast to an integer from the 22214 / 22214.0 the API sends. |
#'   | activity_name | character | Activity name ('BSL 2026-2027'). |
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'   | season_label | character | Season label 'YYYY-YYYY' (seasonName). |
#'   | season | integer | Season END year, read from the season label (seasonName). |
#'   | tipoff | POSIXct | Tip-off as a naive timestamp in Turkey local time (Europe/Istanbul, UTC+3). |
#'   | status_id | integer | Game status code: 1 = played (Oynandi), 4 = not played (Oynanmadi), 19 = fixture without a date and time. Cast to an integer from the 1 / 1.0 the API sends. |
#'   | status | character | Game status text in Turkish: Oynandi = played. Only finished games are served. |
#'   | venue | character | Venue name (location) as TBF prints it. |
#'   | attendance | integer | Spectator count (matchSpectatorCount); 0 when not recorded. |
#'   | has_overtime | logical | Overtime flag (uzatma = overtime). Reliability unverified: false on every one of 64 BSL 2025-26 games checked. |
#'   | broadcast_channel | character | Broadcaster (matchBroadcastChannel), e.g. beINSports, or null. |
#'   | home_team_process_id | integer | Home team-season id (key space: TBF team registrations; the header calls it homeTeamProcessId). |
#'   | home_team | character | Home team name as registered for that season, uppercase with Turkish letters. |
#'   | home_coach | character | Home head coach name, uppercase. |
#'   | home_score | integer | Home final score. |
#'   | away_team_process_id | integer | Away team-season id (key space: TBF team registrations). |
#'   | away_team | character | Away team name as registered for that season, uppercase with Turkish letters. |
#'   | away_coach | character | Away head coach name, uppercase. |
#'   | away_score | integer | Away final score. |
#'   | referee | character | Main referee's name (names only: no contact or birth data is returned). |
#'   | first_assistant_referee | character | First assistant referee's name. |
#'   | second_assistant_referee | character | Second assistant referee's name. |
#'   | commissioner | character | Commissioner's (temsilci = representative) name. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_game_header(match_id = 346279))
#' }
tbf_game_header <- function(match_id) {
  .tbf_wrap("game_header", list(match_id = match_id),
            type = "TBF Game Header", call = rlang::current_env())
}

#' @title
#' **TBF Game Players**
#' @description
#' Game roster from the header: every listed player of both sides (names and shirt numbers, no usable ids).
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-header`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per rostered player. The header carries no usable player id; join on name + shirt number + side.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | side | character | Side of the game the row belongs to: home or away (from the route's isHome flag or home / away block). |
#'   | team | character | Team name for the roster row; empty in the samples, so null. |
#'   | player_name | character | Player name as the header roster lists it. |
#'   | jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
#'   | is_starter | logical | True for a starter in the header roster (isStarter). |
#'   | is_active | logical | True when the player is flagged active in the header (isActive). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_game_players(match_id = 346279))
#' }
tbf_game_players <- function(match_id) {
  .tbf_wrap("game_players", list(match_id = match_id),
            type = "TBF Game Players", call = rlang::current_env())
}

#' @title
#' **TBF Player Box Score**
#' @description
#' Player box score of a finished game: minutes, shooting splits, rebounds, assists, +/- and efficiency.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-istatistik`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per player who is on the sheet; `is_starter` marks the starting five (none flagged in 2006-07).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | side | character | Side of the game the row belongs to: home or away (from the route's isHome flag or home / away block). |
#'   | team_process_id | integer | Team-season id of the player's side (from the game header; key space: TBF team registrations). |
#'   | player_id | integer | TBF person id (key space: TBF persons, stable across seasons and clubs: 196413). The same value as person_id in the player and team tables and the player_id argument of tbf_player_career. |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
#'   | is_starter | logical | True for the starting five (homeTopFive / awayTopFive block); none are flagged in 2006-07. |
#'   | seconds_played | integer | Time on court in seconds, parsed from the 'mm:ss' or 'hh:mm:ss' text the API sends (team totals sum their players, so 200:00 = 12000). |
#'   | points | integer | Points scored in the game (or season) the row covers. |
#'   | fg_made | integer | Field goals made, 2PT + 3PT (successfulShots). |
#'   | fg_attempted | integer | Field goals attempted, 2PT + 3PT (shotAttempts). |
#'   | fg_pct | integer | Field-goal percentage 0-100, rounded to an integer by the API. |
#'   | fg2_made | integer | Two-point field goals MADE (the API calls it twoPointShots; attempts are fg2_attempted). |
#'   | fg2_attempted | integer | Two-point field goals attempted (twoPointShotAttempts). |
#'   | fg2_pct | integer | Two-point percentage 0-100, an integer. |
#'   | fg3_made | integer | Three-point field goals MADE (the API calls it threePointShots). |
#'   | fg3_attempted | integer | Three-point field goals attempted (threePointShotAttempts). |
#'   | fg3_pct | integer | Three-point percentage 0-100, an integer. |
#'   | ft_made | integer | Free throws MADE (serbest atis; the API calls it freeThrows). |
#'   | ft_attempted | integer | Free throws attempted (freeThrowAttempts). |
#'   | ft_pct | integer | Free-throw percentage 0-100, an integer. |
#'   | off_rebounds | integer | Offensive rebounds (hucum ribaundu). |
#'   | def_rebounds | integer | Defensive rebounds (savunma ribaundu). |
#'   | rebounds | integer | Total rebounds (toplam ribaund). |
#'   | assists | integer | Assists in this game (asist). |
#'   | steals | integer | Steals in this game (top calma). |
#'   | blocks | integer | Shots this player blocked in this game (blok). |
#'   | turnovers | integer | Turnovers committed in this game (top kaybi). |
#'   | fouls | integer | Personal fouls committed (faul). |
#'   | fouls_drawn | integer | Fouls drawn (rivalFoul = foul committed by the opponent). |
#'   | blocks_received | integer | Own shots blocked by an opponent (blocksReceived). |
#'   | plus_minus | integer | Plus/minus while on court (plusMinus); null when the API sends ''. |
#'   | efficiency | integer | Efficiency rating (verimlilik puani, PIR): points + rebounds + assists + steals + blocks + fouls drawn - missed shots - turnovers - fouls. An integer on player rows. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_player_box(match_id = 346279))
#' }
tbf_player_box <- function(match_id) {
  .tbf_wrap("player_box", list(match_id = match_id),
            type = "TBF Player Box Score", call = rlang::current_env())
}

#' @title
#' **TBF Team Box Score**
#' @description
#' Team totals of a finished game with the team-credited rebounds, turnovers and fouls.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-istatistik`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. Two rows: home, then away. Minutes are the players' summed seconds.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | side | character | Side of the game the row belongs to: home or away (from the route's isHome flag or home / away block). |
#'   | team_process_id | integer | Team-season id of the side (from the game header; key space: TBF team registrations). |
#'   | seconds_played | integer | Time on court in seconds, parsed from the 'mm:ss' or 'hh:mm:ss' text the API sends (team totals sum their players, so 200:00 = 12000). |
#'   | points | integer | Points scored in the game (or season) the row covers. |
#'   | fg_made | integer | Team field goals made, 2PT + 3PT. |
#'   | fg_attempted | integer | Team field goals attempted, 2PT + 3PT. |
#'   | fg_pct | integer | Team field-goal percentage 0-100, rounded to an integer by the API. |
#'   | fg2_made | integer | Team two-point field goals MADE (the API calls it twoPointShots). |
#'   | fg2_attempted | integer | Team two-point field goals attempted. |
#'   | fg2_pct | integer | Team two-point percentage 0-100, an integer. |
#'   | fg3_made | integer | Team three-point field goals MADE (the API calls it threePointShots). |
#'   | fg3_attempted | integer | Team three-point field goals attempted. |
#'   | fg3_pct | integer | Team three-point percentage 0-100, an integer. |
#'   | ft_made | integer | Team free throws MADE. |
#'   | ft_attempted | integer | Team free throws attempted. |
#'   | ft_pct | integer | Team free-throw percentage 0-100, an integer. |
#'   | off_rebounds | integer | Offensive rebounds (hucum ribaundu). |
#'   | def_rebounds | integer | Defensive rebounds (savunma ribaundu). |
#'   | rebounds | integer | Total rebounds (toplam ribaund). |
#'   | assists | integer | Assists in this game (asist). |
#'   | steals | integer | Steals in this game (top calma). |
#'   | blocks | integer | Shots this player blocked in this game (blok). |
#'   | turnovers | integer | Turnovers committed in this game (top kaybi). |
#'   | fouls | integer | Personal fouls committed (faul). |
#'   | fouls_drawn | integer | Fouls drawn by the team (rivalFoul). |
#'   | blocks_received | integer | Team shots blocked by the opponent. |
#'   | efficiency | integer | Team efficiency rating (verimlilik puani): the players' ratings summed; a number on team rows. |
#'   | team_off_rebounds | integer | Team offensive rebounds not credited to a player (homeTeamStats). |
#'   | team_def_rebounds | integer | Team defensive rebounds not credited to a player. |
#'   | team_rebounds | integer | Team rebounds not credited to a player (offensive + defensive). |
#'   | team_turnovers | integer | Team turnovers not credited to a player. |
#'   | team_fouls | integer | Team fouls not credited to a player (bench / coach technicals); 0 in the samples. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_team_box(match_id = 346279))
#' }
tbf_team_box <- function(match_id) {
  .tbf_wrap("team_box", list(match_id = match_id),
            type = "TBF Team Box Score", call = rlang::current_env())
}

#' @title
#' **TBF Play-by-Play**
#' @description
#' Play-by-play of a finished game (2025-26 onward), in game order, with the running score and an English
#' gloss.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/game-flow`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per event. Games before 2025-26 raise `hoopR_no_data`. The feed has no player id.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | action_number | integer | Play sequence number (actionNumber); gaps are deleted or hidden actions. Rows are in the API's game order, and a period-end line can carry a LOWER number than the last play of the period (884 after 885 in the sample), so sort by period and clock, not by this number. |
#'   | period | integer | Period number (quarterNumber): 1-4; overtime numbering is unverified. |
#'   | period_type | integer | Period type code: 1 = regulation, 2 = overtime (from the app code; no overtime game in the samples). |
#'   | clock | character | Game clock REMAINING in the period as 'mm:ss' (counts down from 10:00). |
#'   | seconds_remaining | integer | Game clock remaining in the period, in seconds. |
#'   | home_score | integer | Running home score after the play (the home half of the 'home-away' score text). |
#'   | away_score | integer | Running away score after the play (the away half of the score text). |
#'   | side | character | Side of the acting team (isHome); null on game events (period start / end, game end). |
#'   | player_name | character | Acting player's name; null on game events. The feed carries no player id. |
#'   | jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
#'   | action | character | Play type in Turkish exactly as TBF sends it (77 values seen). |
#'   | action_en | character | English gloss of the Turkish action, from the refs action vocabulary; null for an action not in it. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_pbp(match_id = 346279))
#' }
tbf_pbp <- function(match_id) {
  .tbf_wrap("pbp", list(match_id = match_id),
            type = "TBF Play-by-Play", call = rlang::current_env())
}

#' @title
#' **TBF Shots**
#' @description
#' Every field-goal attempt of a finished game (2025-26 onward) with its court position.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/shot-chart`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per attempt. `x` and `y` are percentages of a horizontal full court.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | period | integer | Period number of the attempt: 1-4; overtime numbering is unverified. |
#'   | period_type | integer | Period type code: 1 = regulation, 2 = overtime (from the app code; no overtime game in the samples). |
#'   | side | character | Side of the shooting team (isHome). |
#'   | shot_player_id | integer | Shooter id in the SHOT-CHART key space, which is NOT the TBF person id of the box score (Quentin Peterson = 2814324 here, 501076 as a TBF person): join shots to box rows on player_name + jersey_number + side. |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
#'   | x | integer | Court x position: integer percent (0-100) of the LENGTH of a horizontal full court from the LEFT baseline (baskets near 5 and 95); teams change ends at half-time. Metres (x / 100 x 28) are an inference. |
#'   | y | integer | Court y position: integer percent (0-100) of the court WIDTH from the BOTTOM sideline (baskets near 50), verified from the app's drawing code (top = 100 - y). Metres (y / 100 x 15) are an inference. |
#'   | made | logical | True when the attempt was made (isSucceed). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_shots(match_id = 346279))
#' }
tbf_shots <- function(match_id) {
  .tbf_wrap("shots", list(match_id = match_id),
            type = "TBF Shots", call = rlang::current_env())
}

#' @title
#' **TBF Period Scores**
#' @description
#' Points each side scored in each period of a finished game, overtime included.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-ozet`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per side and period (home first).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | side | character | Side of the score: home (homeTeamScore) or away (awayTeamScore). |
#'   | period | integer | Period number (quarter): 1-4 regulation; overtime numbering is unverified. |
#'   | period_type | integer | Period type code: 1 = regulation, 2 = overtime (from the app code; no overtime game in the samples). |
#'   | points | integer | Points the side scored IN the period (not cumulative). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_period_scores(match_id = 346279))
#' }
tbf_period_scores <- function(match_id) {
  .tbf_wrap("period_scores", list(match_id = match_id),
            type = "TBF Period Scores", call = rlang::current_env())
}

#' @title
#' **TBF Highlights**
#' @description
#' Team comparison of a finished game: rebounds, paint points, fast-break points, lead changes and more.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-ozet`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per statistic with the home and away value.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | title | character | Statistic name in Turkish (Ribaund = rebounds, Asist = assists, Top Kaybi = turnovers). |
#'   | category | character | Statistic code (leaderCategory), e.g. PointsFromPaint, LeadChanges, TimeLeading. |
#'   | home_value | character | Home value exactly as sent (a string: '90', or '28:38' for TimeLeading). |
#'   | away_value | character | Away value exactly as sent (a string: '89', or '8:19' for TimeLeading). |
#'   | home_number | double | Home value as a number; null for a time value such as TimeLeading. |
#'   | away_number | double | Away value as a number; null for a time value such as TimeLeading. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_highlights(match_id = 346279))
#' }
tbf_highlights <- function(match_id) {
  .tbf_wrap("highlights", list(match_id = match_id),
            type = "TBF Highlights", call = rlang::current_env())
}

#' @title
#' **TBF Game Leaders**
#' @description
#' Game leaders of a finished game per statistic category (top five each).
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Match/mac-leader`
#' @param match_id Required. TBF game id (integer), e.g. 346279; match_id in [tbf_schedule()]. One global
#' sequence across leagues and seasons. Only a finished game is served.
#' @return A `hoopR_data` tibble. One row per leader, best first within a category.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | match_id | integer | TBF game id (key space: TBF games, ONE global sequence across leagues and seasons: 62552 in 2006-07, 346279 in 2026-27). The match_id argument of every game wrapper; the routes echo it as a string or null, the runtime stamps the integer asked for. |
#'   | category | character | Leader category code (leaderCategory), e.g. VerimlilikPuani = efficiency rating. |
#'   | category_label | character | Leader category label in Turkish (leaderCategoryDescription), e.g. Verimlilik Puani. |
#'   | rank | integer | Position in the category's list, 1 = best (top five per category). |
#'   | side | character | Side of the leader's team (isHome). |
#'   | player_id | integer | TBF person id of the leader (key space: TBF persons; equals the box score player_id). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
#'   | value | double | The leader's value in the category (points, rebounds, ...). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_game_leaders(match_id = 346279))
#' }
tbf_game_leaders <- function(match_id) {
  .tbf_wrap("game_leaders", list(match_id = match_id),
            type = "TBF Game Leaders", call = rlang::current_env())
}

#' @title
#' **TBF Players**
#' @description
#' Every player registered in one league-season (birth dates are not returned).
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-player-list`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per registered player. Birth dates are not returned.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year of the request. |
#'   | competition | character | League prefix the row reports (bsl, tbl or kbsl); equals the request's competition. |
#'   | person_id | integer | TBF person id (kisiID; key space: TBF persons, stable across seasons and clubs). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | nationality | character | Nationality as a TURKISH country name (ABD = United States); see the nationality_code. |
#'   | nationality_code | character | Nationality code (tabiyetKisa), ISO 3166-1 alpha-3 except GB for the United Kingdom. |
#'   | club_id | integer | Stable club id (takimID / teamId of the team lists; key space: TBF clubs, the same across seasons and leagues: Tofas = 13). Not the team-season id (team_process_id). |
#'   | team_name | character | Team name for that season, uppercase with Turkish letters. |
#'   | jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
#'   | prefix | character | League prefix of the row (bsl, tbl, kbsl); the runtime refuses any other than the request's. |
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_players(competition = "bsl", season = 2027))
#' }
tbf_players <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("players", list(season = season, competition = competition),
            type = "TBF Players", call = rlang::current_env())
}

#' @title
#' **TBF Player Career**
#' @description
#' One player's career: a row per season and competition with totals (birth date is not returned).
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-player-detail-profile-and-career-info/{player_id}`
#' @param player_id Required. TBF person id, e.g. 196413; person_id in [tbf_players()] and the box score.
#' @return A `hoopR_data` tibble. One row per career season and competition. Totals and averages rows are not included.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | person_id | integer | TBF person id of the player asked for (the player_id argument). |
#'   | player_name | character | Player's full name from the profile (the same on every row). |
#'   | nationality | character | Nationality as a TURKISH country name from the profile (country). |
#'   | height_cm | integer | Height in centimetres from the profile; null when TBF has none. |
#'   | season_label | character | Career season as TBF writes it (seasonCode), e.g. 2025-2026. |
#'   | season | integer | Career season END year, read from the season label. |
#'   | team_name | character | Team the player represented that season, uppercase with Turkish letters (teamName). |
#'   | activity_name | character | League-season name (activityName), e.g. 'BSL 2025-2026'. |
#'   | activity_type_id | integer | Competition type id (faaliyetTuruId): 1 = BSL, 4 = TBL, 79 = BGL. |
#'   | activity_id | integer | Activity id of the league-season (faaliyetAltAlaniId; key space: TBF league-seasons). |
#'   | games | integer | Games played (macSayisi = game count). |
#'   | seconds_played | integer | Total time on court that season in seconds (formattedTotalSeconds 'hh:mm:ss'). |
#'   | points | integer | Points scored in the game (or season) the row covers. |
#'   | assists | integer | Assists in that season and competition. |
#'   | fg_made | integer | Field goals made (fieldGoalsMade), 2PT + 3PT. |
#'   | fg_attempted | integer | Field goals attempted (fieldGoalsAttempted), 2PT + 3PT. |
#'   | fg3_made | integer | Three-point field goals made (threePointsMade). |
#'   | fg3_attempted | integer | Three-point field goals attempted (threePointsAttempted). |
#'   | ft_made | integer | Free throws made (the API spells the field freeThows). |
#'   | ft_attempted | integer | Free throws attempted (freeThowsAttempted). |
#'   | off_rebounds | integer | Offensive rebounds in that season and competition. |
#'   | def_rebounds | integer | Defensive rebounds in that season and competition. |
#'   | rebounds | integer | Total rebounds in that season and competition. |
#'   | steals | integer | Steals in that season and competition. |
#'   | turnovers | integer | Turnovers (the API spells the field tournovers). |
#'   | blocks | integer | Blocks in that season and competition. |
#'   | fouls | integer | Personal fouls (the API spells the field fauls). |
#'   | efficiency | integer | Efficiency rating total (playerEfficiency, PIR) for that season and competition. |
#'   | fouls_drawn | integer | Fouls drawn (yapilanFaul). |
#'   | blocks_received | integer | Own shots blocked by an opponent (yenilenBlok). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_player_career(player_id = 196413))
#' }
tbf_player_career <- function(player_id) {
  .tbf_wrap("player_career", list(player_id = player_id),
            type = "TBF Player Career", call = rlang::current_env())
}

#' @title
#' **TBF Teams**
#' @description
#' Every team registered in one league-season with its team-season id (team_process_id) and club id.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-teams-by-leauge`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per team registration.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | team_process_id | integer | Team-season id (teamProcessId = takimIslemId, a team REGISTRATION; key space: TBF team registrations, a NEW id per club per league-season: Tofas = 265995 in BSL 2026-27). The team_process_id argument of the team wrappers; not the stable club_id. |
#'   | club_id | integer | Stable club id (takimID / teamId of the team lists; key space: TBF clubs, the same across seasons and leagues: Tofas = 13). Not the team-season id (team_process_id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters. |
#'   | city | character | Home city (teamCityName), uppercase Turkish. |
#'   | code | character | Team short code (teamCode). |
#'   | season_id | integer | Internal TBF season id (key space: TBF seasons, global across leagues: 174 = 2026-2027, 172 = 2025-2026; the odd ids are international UA- seasons). Never an sdv key: use season (END year). |
#'   | season_label | character | Season label 'YYYY-YYYY' of the league-season. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_teams(competition = "bsl", season = 2027))
#' }
tbf_teams <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("teams", list(season = season, competition = competition),
            type = "TBF Teams", call = rlang::current_env())
}

#' @title
#' **TBF Team Player Stats**
#' @description
#' Season player statistics of one team-season: totals, percentages and per-game averages.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-detail-statistic`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param team_process_id Required. Team-season id (team registration), e.g. 265995 = Tofas in BSL 2026-27;
#' team_process_id in [tbf_teams()] and [tbf_schedule()]. New for every club in every league-season; not the
#' stable club_id.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per player.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
#'   | person_id | integer | TBF person id (code; key space: TBF persons, stable across seasons and clubs). |
#'   | jersey_number | character | Shirt number (oyuncuNo) as a string. |
#'   | first_name | character | Player's first name. |
#'   | last_name | character | Player's last name. |
#'   | games | integer | Games played (macSayisi). |
#'   | seconds_played | integer | Season total time on court in seconds (sureToplam 'hh:mm:ss'). |
#'   | points | integer | Season total points (sayiToplam; the API sends it as a string). |
#'   | fg_made | integer | Season field goals made (agBasarili; sent as a string). |
#'   | fg_attempted | integer | Season field goals attempted (agDeneme). |
#'   | fg2_made | integer | Season two-point field goals made (puan20Toplam). |
#'   | fg2_attempted | integer | Season two-point field goals attempted (puan21Toplam). |
#'   | fg3_made | integer | Season three-point field goals made (puan30Toplam). |
#'   | fg3_attempted | integer | Season three-point field goals attempted (puan31Toplam). |
#'   | ft_made | integer | Season free throws made (sA0Toplam). |
#'   | ft_attempted | integer | Season free throws attempted (sA1Toplam). |
#'   | def_rebounds | integer | Season defensive rebounds (drToplam). |
#'   | off_rebounds | integer | Season offensive rebounds (hrToplam). |
#'   | rebounds | integer | Season total rebounds (trToplam). |
#'   | assists | integer | Season assists (asistToplam). |
#'   | blocks | integer | Season blocks (blokToplam). |
#'   | steals | integer | Season steals (topCalmaToplam). |
#'   | turnovers | integer | Season turnovers (topKaybiToplam). |
#'   | fouls | integer | Season personal fouls (faulToplam). |
#'   | plus_minus | double | Season plus/minus contribution (oyunaKatki = contribution to the game), a decimal string. |
#'   | efficiency | integer | Season efficiency rating total (vpToplam, verimlilik puani). |
#'   | fg_pct | double | Field-goal percentage 0-100 with two decimals (agYuzdesi). |
#'   | fg2_pct | double | Two-point percentage 0-100 with two decimals (ikilikYuzdesi). |
#'   | fg3_pct | double | Three-point percentage 0-100 with two decimals (uclukYuzdesi). |
#'   | ft_pct | double | Free-throw percentage 0-100 with two decimals (serbestAtisYuzdesi). |
#'   | seconds_per_game | integer | Average time on court per game in seconds (sureOrtalama 'hh:mm:ss'). |
#'   | points_per_game | double | Points per game (sayiOrtalama). |
#'   | rebounds_per_game | double | Rebounds per game (trOrtalama). |
#'   | assists_per_game | double | Assists per game (asistOrtalama). |
#'   | steals_per_game | double | Steals per game (topCalmaOrtalama). |
#'   | blocks_per_game | double | Blocks per game (blokOrtalama). |
#'   | turnovers_per_game | double | Turnovers per game (topKaybiOrtalama). |
#'   | efficiency_per_game | double | Efficiency rating per game (vpOrtalama). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_team_player_stats(season = 2027, team_process_id = 265995))
#' }
tbf_team_player_stats <- function(season, team_process_id, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("team_player_stats", list(season = season, team_process_id = team_process_id, competition = competition),
            type = "TBF Team Player Stats", call = rlang::current_env())
}

#' @title
#' **TBF Team Games**
#' @description
#' Games and results of one team-season, scheduled games included.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-detail-matches-by-season-and-league`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param team_process_id Required. Team-season id (team registration), e.g. 265995 = Tofas in BSL 2026-27;
#' team_process_id in [tbf_teams()] and [tbf_schedule()]. New for every club in every league-season; not the
#' stable club_id.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per game of the team (scheduled games included).
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
#'   | match_id | integer | TBF game id (key space: TBF games, one global sequence). |
#'   | match_code | character | TBF short game code. |
#'   | tipoff | POSIXct | Tip-off as a naive timestamp in Turkey local time (tarih). |
#'   | week | character | Week label (formattedWeek), e.g. '1. Hafta'. |
#'   | city | character | City of the venue (sehir), uppercase Turkish. |
#'   | venue | character | Venue name (salon). |
#'   | home_team_process_id | integer | Home team-season id (takimAId; key space: TBF team registrations). |
#'   | home_team | character | Home team name (takimA). |
#'   | home_score | integer | Home points (skorA); null before the game. |
#'   | away_team_process_id | integer | Away team-season id (takimBId). |
#'   | away_team | character | Away team name (takimB). |
#'   | away_score | integer | Away points (skorB); null before the game. |
#'   | team_is_home | logical | True when the asked team was the home side (isHome). |
#'   | team_won | logical | True when the asked team won (isWin); false for a loss or an unplayed game. |
#'   | is_played | logical | True once the game has been played (isPlayed). |
#'   | status | character | Game status text in Turkish: Oynandi = played, Oynanmadi = not played (durum). |
#'   | status_id | integer | Game status code (durumId): 1 = played, 4 = not played. |
#'   | has_overtime | logical | Overtime flag (uzatma = overtime). Reliability unverified: false on every one of 64 BSL 2025-26 games checked. |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_team_games(season = 2027, team_process_id = 265995))
#' }
tbf_team_games <- function(season, team_process_id, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("team_games", list(season = season, team_process_id = team_process_id, competition = competition),
            type = "TBF Team Games", call = rlang::current_env())
}

#' @title
#' **TBF Team Roster**
#' @description
#' Roster of one team-season with games, minutes and per-game points and efficiency (birth dates dropped).
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-active-player-list-by-season-and-league`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param team_process_id Required. Team-season id (team registration), e.g. 265995 = Tofas in BSL 2026-27;
#' team_process_id in [tbf_teams()] and [tbf_schedule()]. New for every club in every league-season; not the
#' stable club_id.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per rostered person. Birth dates are not returned.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
#'   | person_id | integer | TBF person id (personId; key space: TBF persons). |
#'   | first_name | character | Given name as registered with TBF, mixed case ('Yigitcan'). |
#'   | last_name | character | Family name as registered with TBF, mixed case ('Saybir'). |
#'   | nationality | character | Nationality as a TURKISH country name (country); there is no code on this route. |
#'   | height_cm | integer | Height in centimetres; null when TBF has none. |
#'   | jersey_number | character | Shirt number as a string, so '0' and '00' stay distinct. |
#'   | games | integer | Games played (macSayisi = game count). |
#'   | seconds_played | integer | Season time on court in seconds (sure 'hh:mm:ss'). |
#'   | points_per_game | double | Points per game (sayi). |
#'   | efficiency_per_game | double | Efficiency rating per game (verimlilikPuani). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_team_roster(season = 2027, team_process_id = 265995))
#' }
tbf_team_roster <- function(season, team_process_id, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("team_roster", list(season = season, team_process_id = team_process_id, competition = competition),
            type = "TBF Team Roster", call = rlang::current_env())
}

#' @title
#' **TBF Team Staff**
#' @description
#' Coaching and club staff of one team-season.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Team/get-team-detail-team-staff-by-season-and-league`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param team_process_id Required. Team-season id (team registration), e.g. 265995 = Tofas in BSL 2026-27;
#' team_process_id in [tbf_teams()] and [tbf_schedule()]. New for every club in every league-season; not the
#' stable club_id.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. One row per staff member.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | team_process_id | integer | Team-season id of the request (key space: TBF team registrations). |
#'   | person_id | integer | TBF person id of the staff member (code; staff are TBF persons too). |
#'   | first_name | character | Given name(s) as registered with TBF, uppercase ('MEVLUT TULGA'). |
#'   | last_name | character | Family name as registered with TBF, uppercase ('ONGOREN'). |
#'   | role | character | Staff role in Turkish as sent (job), e.g. Antrenor = head coach. |
#'   | role_code | integer | Staff sub-role code (subRolesCode). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_team_staff(season = 2027, team_process_id = 265995))
#' }
tbf_team_staff <- function(season, team_process_id, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("team_staff", list(season = season, team_process_id = team_process_id, competition = competition),
            type = "TBF Team Staff", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Points**
#' @description
#' Season leaders in points: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-point-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_points(competition = "bsl", season = 2027))
#' }
tbf_leaders_points <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_points", list(season = season, competition = competition),
            type = "TBF Leaders: Points", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Assists**
#' @description
#' Season leaders in assists: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-asist-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_assists(competition = "bsl", season = 2027))
#' }
tbf_leaders_assists <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_assists", list(season = season, competition = competition),
            type = "TBF Leaders: Assists", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Blocks**
#' @description
#' Season leaders in blocks: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-blok-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_blocks(competition = "bsl", season = 2027))
#' }
tbf_leaders_blocks <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_blocks", list(season = season, competition = competition),
            type = "TBF Leaders: Blocks", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Rebounds**
#' @description
#' Season leaders in rebounds: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-ribound-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_rebounds(competition = "bsl", season = 2027))
#' }
tbf_leaders_rebounds <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_rebounds", list(season = season, competition = competition),
            type = "TBF Leaders: Rebounds", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Steals**
#' @description
#' Season leaders in steals: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-top-calma-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_steals(competition = "bsl", season = 2027))
#' }
tbf_leaders_steals <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_steals", list(season = season, competition = competition),
            type = "TBF Leaders: Steals", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Minutes**
#' @description
#' Season leaders in minutes played: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-duration-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_minutes(competition = "bsl", season = 2027))
#' }
tbf_leaders_minutes <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_minutes", list(season = season, competition = competition),
            type = "TBF Leaders: Minutes", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Threes**
#' @description
#' Season leaders in three-point field goals made: the server's top 20 by season total and by per-game
#' average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-3Point-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_threes(competition = "bsl", season = 2027))
#' }
tbf_leaders_threes <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_threes", list(season = season, competition = competition),
            type = "TBF Leaders: Threes", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Turnovers**
#' @description
#' Season leaders in turnovers: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-top-kaybi-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_turnovers(competition = "bsl", season = 2027))
#' }
tbf_leaders_turnovers <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_turnovers", list(season = season, competition = competition),
            type = "TBF Leaders: Turnovers", call = rlang::current_env())
}

#' @title
#' **TBF Leaders: Efficiency**
#' @description
#' Season leaders in efficiency rating: the server's top 20 by season total and by per-game average.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Player/get-mvp-leaders`
#' @param season Required. Season END year (2027 = the 2026-2027 season). TBF keys a league-season by internal
#' season and activity ids; the runtime reads them from the league's season list by the END year of the label.
#' A year the list lacks raises `hoopR_no_data`.
#' @param competition TBF league: bsl (Basketbol Super Ligi), tbl (second tier) or kbsl (women's Super Ligi).
#' The top flight was named TBL until 2007-08 and is listed under bsl.
#' @return A `hoopR_data` tibble. Up to 20 rows per `kind` (`total` and `average`), best first.
#'   Every column below is always present (a zero-row tibble keeps them and their types); an answer
#'   with nothing in it raises `hoopR_no_data`, as in sdv-py.
#'
#'   | col_name | type | description |
#'   |---|---|---|
#'   | season | integer | Season END year (2027 = the 2026-2027 season), read from the 'YYYY-YYYY' label or the request; the sdv season key. Not the internal TBF season id (season_id). |
#'   | competition | character | TBF league the row belongs to: bsl, tbl or kbsl (the request's competition, or the league prefix the API reports). |
#'   | category | character | Statistic of the wrapper: points, assists, blocks, rebounds, steals, minutes, threes, turnovers or efficiency. |
#'   | kind | character | total = the server's top 20 by season TOTAL; average = the top 20 by PER-GAME average. |
#'   | rank | integer | Rank in the list, 1 = best (the API's order). |
#'   | person_id | integer | TBF person id (oyuncuKodu, sent as a string; key space: TBF persons). |
#'   | player_name | character | Player name as TBF prints it for that route (title case, Turkish letters kept). |
#'   | team_process_id | integer | Team-season id (takimKodu, sent as a string; key space: TBF team registrations; despite the name NOT the club id). |
#'   | team_name | character | Team name as registered for that season, uppercase with Turkish letters (sponsor name: 'PIZZABULLS BORDO BANDIRMA'). |
#'   | games | integer | Games played (macSayisi, sent as a string). |
#'   | value | double | The ranked statistic: the season total for kind total, the per-game average for kind average (the API names the field grup and sends it as a string). |
#'
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. SportsDataverse has
#' not ruled on TBF's terms, so payloads are not redistributed as release assets. The vendor's origin hosts
#' (nikayazilim.com) serve the same data without Cloudflare but are deliberately not used, redirects are never
#' followed, and www.tbf.org.tr's interactive Turnstile is neither used nor automated.
#'
#' Coverage: season and competition are parameters (`bsl` Basketbol Super Ligi, back to 1966-67 in the league
#' list; `tbl` second tier; `kbsl` women, both from 2015-16). Game wrappers serve FINISHED games only (an
#' unfinished game raises `hoopR_asset_fetch`). Box scores exist from 2006-07 (no starters flagged that
#' season); play-by-play and shots from 2025-26 only, an earlier finished game raises `hoopR_no_data`. Every
#' game carries a Genius LiveStats id (`genius_id`, joins the `genius` family) from 2018-19 on some seasons
#' and on every game of 2025-26 and later. Birth dates, contact details, photos and logos are dropped. Names
#' and category labels are Turkish; the column descriptions give the English gloss.
#'
#' Errors: `hoopR_no_data` when TBF has nothing for the request (HTTP 404, an unknown game or player, a season
#' the league list lacks, an empty list, a finished game before 2025-26 asked for play-by-play or shots);
#' `hoopR_bad_request` for an invalid argument or HTTP 400 / 422; `hoopR_asset_fetch` when the fetch failed or
#' the answer is not the one asked for (an unfinished game, a body for another game, season, league or team,
#' an error envelope, a redirect, a partial page or a changed capped list). All inherit `hoopR_error`.
#' Timestamps are Turkey local time (`Europe/Istanbul`).
#' @family TBF
#' @export
#' @examples
#' \donttest{
#'   try(tbf_leaders_efficiency(competition = "bsl", season = 2027))
#' }
tbf_leaders_efficiency <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_efficiency", list(season = season, competition = competition),
            type = "TBF Leaders: Efficiency", call = rlang::current_env())
}
