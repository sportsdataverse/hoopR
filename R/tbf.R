# tbf.R -- the TBF `tbf_*()` family: Turkish Basketball Federation app API (BSL, TBL, KBSL).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/tbf (e3d232e): same names, arguments, defaults
# and columns. Runtime and parsers: R/tbf_utils.R.

#' @title
#' **TBF Seasons**
#' @description
#' The 20 most recent TBF seasons, domestic and international (a server cap), newest first.
#'
#' Endpoint: `GET https://miniappapi.tbf.org.tr/webapi-service/api/Season/get-seasons`
#' @eval .returns_rd("tbf_seasons", inline = FALSE, unit = "season")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_leagues", inline = FALSE, unit = "league")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_league_seasons", inline = FALSE, unit = "season of the league")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_weeks", inline = FALSE, unit = "week in play order")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_standings", inline = FALSE, unit = "team and group")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_schedule", inline = FALSE, unit = "game")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_daily_matches", inline = FALSE, unit = "game with its group_name")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_game_header", inline = FALSE, unit = "game")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_game_players", inline = FALSE, unit = "rostered player")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_game_players(match_id = 346279)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_player_box", inline = FALSE, unit = "player who is on the sheet")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_team_box", inline = FALSE, unit = "team in the game")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_pbp", inline = FALSE, unit = "event")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_shots", inline = FALSE, unit = "attempt")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_period_scores", inline = FALSE, unit = "side and period")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_highlights", inline = FALSE, unit = "statistic with the home and away value")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_highlights(match_id = 346279)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_game_leaders", inline = FALSE, unit = "leader")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_game_leaders(match_id = 346279)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_players", inline = FALSE, unit = "registered player")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_player_career", inline = FALSE, unit = "career season and competition")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_player_career(player_id = 196413)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_teams", inline = FALSE, unit = "team registration")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_team_player_stats", inline = FALSE, unit = "player")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_team_player_stats(season = 2027, team_process_id = 265995)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_team_games", inline = FALSE, unit = "game of the team")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_team_games(season = 2027, team_process_id = 265995)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_team_roster", inline = FALSE, unit = "rostered person")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
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
#' @eval .returns_rd("tbf_team_staff", inline = FALSE, unit = "staff member")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_team_staff(season = 2027, team_process_id = 265995)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_points", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_points(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_assists", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_assists(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_blocks", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_blocks(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_rebounds", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_rebounds(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_steals", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_steals(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_minutes", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_minutes(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_threes", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_threes(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_turnovers", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_turnovers(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
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
#' @eval .returns_rd("tbf_leaders_efficiency", inline = FALSE, unit = "leader and `kind`")
#' @details
#' Official TBF app API, unofficial for SportsDataverse: the backend of the Turkish Basketball Federation's
#' mobile app (miniappapi.tbf.org.tr), which serves BSL, TBL, KBSL and the other TBF leagues. It needs no key;
#' robots.txt answers 404 on the host, and the runtime spaces requests at least 1 s apart. TBF's
#' terms were not reviewed; check them before you republish the data. The vendor's origin hosts
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
#'
#' ```r
#'  tbf_leaders_efficiency(competition = "bsl", season = 2027)
#' ```
#' @concept TBF Functions
#' @seealso [family_tbf] lists every function in this family.
#' @export
tbf_leaders_efficiency <- function(season, competition = "bsl") {
  .tbf_check_competition(competition, call = rlang::current_env())
  .tbf_wrap("leaders_efficiency", list(season = season, competition = competition),
            type = "TBF Leaders: Efficiency", call = rlang::current_env())
}
