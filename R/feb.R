# The @details of every feb topic that shares the feb_game_info() notes (roxygen @eval .intl_details()).
.feb_game_info_details <- c(
  "The Spanish Basketball Federation (FEB) wrappers cover Primera FEB, Segunda",
  "FEB and Liga Femenina Endesa (plus the federation's other groups on the same",
  "routes). They mirror sdv-py's `sportsdataverse.basketball.feb` wrappers of",
  "the same names: same arguments, the same snake_case columns and types, one",
  "row per sdv-py row.",
  "",
  "**Legal notice.** The FEB's aviso legal (legal notice) asserts",
  "intellectual-property rights over the site's content and its databases (the",
  "EU database right). It has no explicit scraping clause, and robots.txt",
  "answers 404 on both hosts. Fetching for your own use on your own machine is",
  "how these wrappers are meant to be used; check the notice before you",
  "republish the data.",
  "",
  "**Unofficial and unsupported.** The LiveStats API",
  "(`intrafeb.feb.es`) is the federation's own widget backend, not a documented",
  "public API. It needs a bearer token, which is public: it is read from the",
  "home page of `baloncestoenvivo.feb.es` at run time, kept in memory for the R",
  "session (24 h validity, renewed once on an HTTP 401) and never printed,",
  "logged or written. Requests are spaced at least one second apart per host;",
  "429 and 5xx answers are retried (three attempts).",
  "",
  "**Coverage.** The game routes answer from 2020-21 (Liga Femenina Endesa from",
  "its first game; Primera FEB from 2021-03-12, so its earlier 2020-21 games",
  "and every earlier season answer 404). 2020-21 play-by-play is text only. The",
  "schedule pages go back to 1996-97 (`season = 1997`).",
  "",
  "**Seasons** are END years (`season = 2027` is 2026-27); the site's own `t`",
  "key is the START year, so the request sends `t = season - 1`.",
  "",
  "**Errors** are classed conditions, never a warning plus an empty frame:",
  "`hoopR_no_data` (HTTP 404, an unknown group, a schedule page with no games,",
  "an empty overview window), `hoopR_bad_request` (HTTP 400 / 422, or a",
  "`game_id`, `group` or `season` that is not a non-negative integer) and",
  "`hoopR_asset_fetch` (any other failure: another status, a transport error,",
  "a token the API still rejects after one renewal, a non-JSON or non-HTML",
  "body, an error or changed envelope, a play-by-play of another game, a page",
  "for another group or season, or layout drift). All inherit `hoopR_error`."
)

#' @title
#' **FEB Game Info**
#' @description
#' **Game header of one FEB game: competition, tip-off, venue, officials,
#' status, both teams and the score.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`
#' (every game route carries the header; this reads the lightest one).
#' @param game_id (*integer* required): FEB game id, e.g. `2535725`; the
#'   `game_id` column of [feb_schedule()], [feb_results()] and [feb_overview()].
#' @eval .intl_details(.feb_game_info_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | comp_id | integer | Competition id (constant across seasons): 115 Primera FEB (LEB Oro), 118 Segunda FEB, 210 Liga Femenina Endesa, 214 LF Challenge, 218 LF-2, 111 Tercera FEB. Not the site's menu group. |
#' | competition | character | Competition name as printed that season, uppercase ('PRIMERA FEB'; 2020-21 'LIGA LEB ORO'). |
#' | group_label | character | The game's group (grupo) label, trimmed: 'Unico' = the single group, '"A"' = group A. It is the page's group label, not the site's menu group number. |
#' | period | integer | Current or last period number; 4 for a finished regulation game. |
#' | clock | character | 'FINAL' once the game is over, else the game clock 'mm:ss' remaining in the period. |
#' | start_time | POSIXct | Tip-off in Spanish local time (POSIXct, tz Europe/Madrid): the source carries no offset, so the zone is assumed. |
#' | venue | character | Venue (pabellon) name. |
#' | address | character | Venue street address, free text. |
#' | referee1 | character | Crew chief (arbitro principal), 'SURNAMES, NAME'. |
#' | referee2 | character | First umpire (arbitro auxiliar 1), 'SURNAMES, NAME'. |
#' | referee3 | character | Second umpire (arbitro auxiliar 2), 'SURNAMES, NAME'; null when the game had two referees. |
#' | status | integer | Game state code: 3 = finished (status_text FINISHED). Null on 2020-21 games. |
#' | status_text | character | Game state label in English ('FINISHED'). Null on 2020-21 games. |
#' | home_team_id | integer | Home team-season id (key space: FEB team registrations, new every season). |
#' | home_team | character | Home team name for the season (sponsor name, uppercase). |
#' | home_team_code | character | Home federation team code, 8 digits as a string. Null on 2020-21 games. |
#' | home_club_code | character | Home federation club code, 6 digits as a string. Null on 2020-21 games. |
#' | home_score | integer | Home points: the final score when clock is FINAL, else the live score. |
#' | away_team_id | integer | Away team-season id (key space: FEB team registrations, new every season). |
#' | away_team | character | Away team name for the season (sponsor name, uppercase). |
#' | away_team_code | character | Away federation team code, 8 digits as a string. Null on 2020-21 games. |
#' | away_club_code | character | Away federation club code, 6 digits as a string. Null on 2020-21 games. |
#' | away_score | integer | Away points: the final score when clock is FINAL, else the live score. |
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_game_info(game_id = 2535725))
#' }
feb_game_info <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_game_info(.feb_api_get("TeamStats", gid), as.integer(gid))
}

#' @title
#' **FEB Period Scores**
#' @description
#' **Points each team scored in each period of one FEB game.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`
#'
#' One row per period played; the points are scored IN the period, not
#' cumulative. Overtime numbering is unverified.
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_period_scores(game_id = 2535725)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | period | integer | Period number (1-4 regulation; overtime numbering is unverified, no overtime game is in the samples). |
#' | home_points | integer | Points the home team scored IN this period (not cumulative). |
#' | away_points | integer | Points the away team scored IN this period (not cumulative). |
#' @family FEB Functions
#' @export
feb_period_scores <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_period_scores(.feb_api_get("TeamStats", gid), as.integer(gid))
}

#' @title
#' **FEB Team Stats**
#' @description
#' **Team totals of both teams in one FEB game: shooting, rebounds, assists,
#' turnovers, fouls.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`
#'
#' One row per team, home first. `fastb`, `ptsto`, `secpts`, `bench` and
#' `paint` are null on every sampled game (the stat crews do not fill them);
#' `seconds_played` and `val` are null on these rows.
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_team_stats(game_id = 2535725)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | team_side | character | Side of the game the row belongs to: home or away (the feed's TEAM\[0\] / TEAM\[1\], or its 1/2 and 0/1 side codes, normalised). |
#' | team_id | integer | Team-season id (key space: FEB team registrations; a NEW id every season, e.g. HLA Alicante = 979989 in 2025-26 and 1008687 in 2026-27). Joins the schedule's home_team_id / away_team_id; not a club or player id. |
#' | team | character | Team name as registered for the season (sponsor name, uppercase: 'HLA ALICANTE'). |
#' | team_code | character | Federation team code, 8 digits as a string: the 6-digit club_code plus a 2-digit team suffix ('03058600'). Null on 2020-21 games. |
#' | club_code | character | Federation club code, 6 digits as a string (the first 6 digits of team_code). Whether it is stable across seasons is unverified. Null on 2020-21 games. |
#' | seconds_played | integer | Seconds on court (the feed's min, an integer count of seconds: 1064 = 17:44; a team row sums its players, 12000 = 200:00). Null on /TeamStats rows. |
#' | min_formatted | character | Time played as 'mm:ss'; '0:00' on /TeamStats rows (only box-score totals carry a value). |
#' | pts | integer | Team points: the final score when the game is over, else the live score. |
#' | p1m | integer | Free throws made (tiros libres; integer as a string). |
#' | p1a | integer | Free throws attempted (integer as a string). |
#' | p1p | double | Free-throw percentage, 0-100, as a string with a DECIMAL COMMA ('77,3'); '0,0' when no attempts. |
#' | p2m | integer | Two-point field goals made (integer as a string). |
#' | p2a | integer | Two-point field goals attempted (integer as a string). |
#' | p2p | double | Two-point percentage, 0-100, string with a decimal comma ('54,1'). |
#' | p3m | integer | Three-point field goals made (integer as a string). |
#' | p3a | integer | Three-point field goals attempted (integer as a string). |
#' | p3p | double | Three-point percentage, 0-100, string with a decimal comma ('47,6'). |
#' | fgm | integer | Field goals made, 2PT + 3PT (tiros de campo; integer as a string). |
#' | fga | integer | Field goals attempted, 2PT + 3PT (integer as a string). |
#' | fgp | double | Field-goal percentage, 0-100, string with a decimal comma ('51,7'). |
#' | ro | integer | Offensive rebounds (rebotes ofensivos; integer as a string). |
#' | rd | integer | Defensive rebounds (rebotes defensivos; integer as a string). |
#' | rt | integer | Total rebounds (rebotes totales; integer as a string). |
#' | assist | integer | Assists (asistencias; integer as a string). |
#' | st | integer | Steals (balones robados, page column BR; integer as a string). |
#' | to | integer | Turnovers (balones perdidos, page column BP; integer as a string). |
#' | bs | integer | Blocks made (tapones a favor, page column TF; integer as a string). |
#' | tc | integer | Shots of this team that were blocked (tapones en contra, page column TC). Null on /TeamStats rows. |
#' | mt | integer | Dunks (mates, page column MT). Null on /TeamStats rows. |
#' | pf | integer | Personal fouls committed (faltas cometidas, page column FC; integer as a string). |
#' | rf | integer | Fouls received / drawn (faltas recibidas, page column FR; integer as a string). |
#' | fouls | integer | Team fouls committed in the game (equals pf on the samples). |
#' | val | integer | FEB efficiency rating (valoracion). Null on /TeamStats rows, filled on box-score totals. |
#' | fastb | integer | Fast-break points. Null on every sampled game: the federation's stat crews do not fill it. |
#' | ptsto | integer | Points off turnovers. Null on every sampled game: the federation's stat crews do not fill it. |
#' | secpts | integer | Second-chance points. Null on every sampled game: the federation's stat crews do not fill it. |
#' | bench | integer | Bench points. Null on every sampled game: the federation's stat crews do not fill it. |
#' | paint | integer | Points in the paint. Null on every sampled game: the federation's stat crews do not fill it. |
#' @family FEB Functions
#' @export
feb_team_stats <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_team_stats(.feb_api_get("TeamStats", gid), as.integer(gid))
}

#' @title
#' **FEB Player Box Score**
#' @description
#' **Per-player box score of one FEB game: minutes, points, shooting splits,
#' rebounds, assists, fouls and plus/minus.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/BoxScore/{game_id}`
#'
#' One row per player and team. `p1` / `p2` / `p3` are free throws, two- and
#' three-point field goals (`m` made, `a` attempted, `p` percentage 0-100);
#' `seconds_played` is the provider's `min` (seconds, not minutes);
#' `player_id` is the FEB person id (stable across seasons) and
#' `shirt_number` stays a string (`"00"` is not `"0"`).
#' @inheritParams feb_game_info
#' @inherit feb_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | team_side | character | Side of the game the row belongs to: home or away (the feed's TEAM\[0\] / TEAM\[1\], or its 1/2 and 0/1 side codes, normalised). |
#' | team_id | integer | Team-season id (key space: FEB team registrations; a NEW id every season, e.g. HLA Alicante = 979989 in 2025-26 and 1008687 in 2026-27). Joins the schedule's home_team_id / away_team_id; not a club or player id. |
#' | team | character | Team name as registered for the season (sponsor name, uppercase: 'HLA ALICANTE'). |
#' | player_id | integer | FEB person id: stable across seasons and clubs (A. Jorda Rodriguez = 1676991 in 2025-26 and 2026-27). Joins the box score, play-by-play, shots and leaders; not the per-season licence_id. |
#' | shirt_number | character | Shirt number (dorsal) as a string, so '00' and '0' stay distinct. The shot feed names the shooter by this number. |
#' | player | character | Player name as 'I. SURNAME(S)', uppercase ('V. AGUILAR HERNANDEZ'). |
#' | starter | logical | True when the player was in the starting five (the page's I column), false when on the bench. |
#' | captain | logical | True for the team captain. Null on 2020-21 games, where the feed does not send it. |
#' | seconds_played | integer | Seconds on court (the feed's min, an integer count of seconds: 1064 = 17:44; a team row sums its players, 12000 = 200:00). Null on /TeamStats rows. |
#' | min_formatted | character | Time played as 'mm:ss'. |
#' | pts | integer | Points scored (the team's points on team rows; the final score when the clock is FINAL, else live). |
#' | p1m | integer | Free throws made (tiros libres; integer as a string). |
#' | p1a | integer | Free throws attempted (integer as a string). |
#' | p1p | double | Free-throw percentage, 0-100, as a string with a DECIMAL COMMA ('77,3'); '0,0' when no attempts. |
#' | p2m | integer | Two-point field goals made (integer as a string). |
#' | p2a | integer | Two-point field goals attempted (integer as a string). |
#' | p2p | double | Two-point percentage, 0-100, string with a decimal comma ('54,1'). |
#' | p3m | integer | Three-point field goals made (integer as a string). |
#' | p3a | integer | Three-point field goals attempted (integer as a string). |
#' | p3p | double | Three-point percentage, 0-100, string with a decimal comma ('47,6'). |
#' | fgm | integer | Field goals made, 2PT + 3PT (tiros de campo; integer as a string). |
#' | fga | integer | Field goals attempted, 2PT + 3PT (integer as a string). |
#' | fgp | double | Field-goal percentage, 0-100, string with a decimal comma ('51,7'). |
#' | ro | integer | Offensive rebounds (rebotes ofensivos; integer as a string). |
#' | rd | integer | Defensive rebounds (rebotes defensivos; integer as a string). |
#' | rt | integer | Total rebounds (rebotes totales; integer as a string). |
#' | reb | integer | Total rebounds (the same count as rt). |
#' | assist | integer | Assists (asistencias; integer as a string). |
#' | st | integer | Steals (balones robados, page column BR; integer as a string). |
#' | to | integer | Turnovers (balones perdidos, page column BP; integer as a string). |
#' | bs | integer | Blocks made (tapones a favor, page column TF; integer as a string). |
#' | tc | integer | Shots of this player/team that were blocked (tapones en contra / recibidos, page column TC; integer as a string). |
#' | mt | integer | Dunks (mates, page column MT; integer as a string). |
#' | pf | integer | Personal fouls committed (faltas cometidas, page column FC; integer as a string). |
#' | rf | integer | Fouls received / drawn (faltas recibidas, page column FR; integer as a string). |
#' | pllss | integer | Plus/minus while the player was on court (balance, page column +/-), signed integer. |
#' | val | integer | FEB efficiency rating (valoracion): points + rebounds + assists + steals + blocks + fouls drawn - missed shots - turnovers - shots blocked - fouls committed. |
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_player_box(game_id = 2535725))
#' }
feb_player_box <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_player_box(.feb_api_get("BoxScore", gid), as.integer(gid))
}

#' @title
#' **FEB Play-by-Play**
#' @description
#' **Play-by-play of one FEB game (KeyFacts): every shot, rebound, foul,
#' substitution and timeout, in Spanish text with coded actions, oldest play
#' first.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/KeyFacts/{game_id}`
#'
#' A body whose plays name another game is refused (`hoopR_asset_fetch`), not
#' returned. 2020-21 games are text only: `action`, the ids, the parameters,
#' the position and the log times are `NA` there.
#' @inheritParams feb_game_info
#' @inherit feb_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | play_num | integer | Play sequence number, 1 = the first play of the game; unique per game. The parser sorts by it (the feed lists newest first). |
#' | period | integer | Period number of the play. |
#' | clock | character | Game clock REMAINING in the period as 'mm:ss' (it counts down from 10:00). |
#' | clock_seconds | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
#' | team_side | character | Side of the acting team: home (feed code 1) or away (2); null on period lines. |
#' | team_id | integer | Team-season id of the acting team (new every season); null on period lines and 2020-21 games. |
#' | player_id | integer | FEB person id of the actor (stable across seasons); null on team, period and 2020-21 lines. |
#' | license_id | integer | Per-season player licence id of the actor (changes when the player re-registers; A. Jorda Rodriguez = 10901171 in 2025-26, 11266668 in 2026-27). Null on team and period lines and 2020-21 games. |
#' | action | character | Action code: shoot, fthrow, rebound, assist, recovery (steal), lose (turnover), blockshot, foul, subst, timeout, period. Null on 2020-21 games. |
#' | text | character | Play description in Spanish: '(TEAM) I. SURNAME: ACTION (running count)'; 2020-21 games use older wording and are text only. |
#' | score_home | integer | Home score AFTER the play; filled on scoring plays only. |
#' | score_away | integer | Away score AFTER the play; filled on scoring plays only. |
#' | x | double | Court x position of a shoot line: percent (0-100) of the length of a horizontal full-court image, origin top-left (the same scale as feb_shots). Null when the action has none and on 2020-21 games. |
#' | y | double | Court y position of a shoot line: percent (0-100) of the width from the top edge (the same scale as feb_shots). Null when the action has none and on 2020-21 games. |
#' | log_param1 | character | Action parameter 1 (string). Team and player actions: a pseudo-GUID '00000000-0000-000\{side\}-0000-\{game id, 12 digits\}' (side 1 home, 2 away); period lines: the period number. |
#' | log_param2 | character | Action parameter 2 (string). The actor's licence id on shoot, fthrow, foul, rebound, assist, recovery and blockshot lines; period lines: '0' start, '1' end; lose: '0' or '1' (meaning unverified). |
#' | log_param3 | character | Action parameter 3 (string). fthrow: '1' made, '0' missed; subst: the outgoing player's licence; foul: a foul-type code. Others unverified. |
#' | log_param4 | character | Action parameter 4 (string). shoot and fthrow: '1' made, '0' missed; foul: the licence of the fouled player; lose: a licence (role unverified). |
#' | log_param5 | character | Action parameter 5 (string); action-dependent, meaning unverified. |
#' | log_param6 | character | Action parameter 6 (string). shoot: shot value '2' or '3'; fthrow: '1'; foul: free throws awarded. |
#' | log_param7 | character | Action parameter 7 (string); action-dependent, meaning unverified. |
#' | log_param8 | character | Action parameter 8 (string): a small integer on shoot, foul and lose lines (by distribution a zone or sub-type code); unverified. |
#' | log_param9 | character | Action parameter 9 (string); blank or null in every sampled game. |
#' | log_param10 | character | Action parameter 10 (string): '1' on almost every foul; meaning unverified. |
#' | log_time | POSIXct | Wall-clock time the play was logged, Spanish local time (POSIXct, tz Europe/Madrid). NA on 2020-21 games. |
#' | log_time_utc | POSIXct | The log time in UTC (POSIXct, tz UTC). NA on 2020-21 games. |
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_pbp(game_id = 2535725))
#' }
feb_pbp <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_pbp(.feb_api_get("KeyFacts", gid), as.integer(gid))
}

#' @title
#' **FEB Shots**
#' @description
#' **Every field-goal attempt of one FEB game with its court position (percent
#' of a full-court image).**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/ShotChart/{game_id}`
#'
#' Free throws are not in the feed. `x` / `y` are percent (0-100) of a
#' horizontal full-court image, origin top-left; teams change ends at
#' half-time. The feed names the shooter by shirt number: `player_id` is
#' resolved through the game's roster (side + shirt number) and is `NA` when
#' that pair is not unique.
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_shots(game_id = 2535725)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | period | integer | Period number of the attempt. |
#' | clock | character | Game clock REMAINING in the period at the shot, 'mm:ss' (the play-by-play line's time). |
#' | clock_seconds | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
#' | team_side | character | Side of the shooter: home (feed code 0) or away (feed code 1; play-by-play uses 1/2). |
#' | team_id | integer | Team-season id of the shooter's team (from the shot chart's TEAM list); new every season. |
#' | shirt_number | character | Shirt number (dorsal) as a string, so '00' and '0' stay distinct. The shot feed names the shooter by this number. |
#' | player_id | integer | FEB person id of the shooter, resolved from side + shirt number in the game's roster; null when that pair is not unique. The feed itself carries no player id. |
#' | made | logical | True when the shot was made, false when missed. Free throws are not in the feed. |
#' | x | double | Court x position: percent (0-100) of the length of a horizontal full-court image, origin top-left. Teams change ends at half-time; metres (x/100 x 28) are an unverified inference. |
#' | y | double | Court y position: percent (0-100) of the width of a horizontal full-court image from the top edge; baskets sit near y = 50. Metres (y/100 x 15) are an unverified inference. |
#' @family FEB Functions
#' @export
feb_shots <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_shots(.feb_api_get("ShotChart", gid), as.integer(gid))
}

#' @title
#' **FEB Game Leaders**
#' @description
#' **Each team's top players of one FEB game by points, rebounds, assists and
#' fouls.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/Ranking/{game_id}`
#'
#' One row per team, category and ranked player (`rank` 1 = the leader, in the
#' order the feed lists them).
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_leaders(game_id = 2535725)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | team_side | character | Side of the game the row belongs to: home or away (the feed's TEAM\[0\] / TEAM\[1\], or its 1/2 and 0/1 side codes, normalised). |
#' | team_id | integer | Team-season id (key space: FEB team registrations; a NEW id every season, e.g. HLA Alicante = 979989 in 2025-26 and 1008687 in 2026-27). Joins the schedule's home_team_id / away_team_id; not a club or player id. |
#' | team | character | Team name as registered for the season (sponsor name, uppercase: 'HLA ALICANTE'). |
#' | category | character | Leader category: points, rebounds, assists or fouls (the feed's Puntos, Rebotes, Asistencias, Faltas). |
#' | rank | integer | Place in the team's category list, 1 = the leader, in the order the feed lists them. |
#' | player_id | integer | FEB person id: stable across seasons and clubs (A. Jorda Rodriguez = 1676991 in 2025-26 and 2026-27). Joins the box score, play-by-play, shots and leaders; not the per-season licence_id. |
#' | shirt_number | character | Shirt number (dorsal) as a string, so '00' and '0' stay distinct. The shot feed names the shooter by this number. |
#' | player | character | Player name as 'I. SURNAME(S)', uppercase ('V. AGUILAR HERNANDEZ'). |
#' | starter | logical | True when the player was in the starting five (the page's I column), false when on the bench. |
#' | captain | logical | True for the team captain. Null on 2020-21 games, where the feed does not send it. |
#' | value | integer | The player's count in the row's category (points, rebounds, assists or personal fouls). |
#' @family FEB Functions
#' @export
feb_leaders <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_leaders(.feb_api_get("Ranking", gid), as.integer(gid))
}

#' @title
#' **FEB Overview**
#' @description
#' **Today's (or the latest) games of every live FEB competition, with scores
#' and status.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/overview`
#'
#' One row per game across the competitions with games in the window. An off
#' day with no competitions raises `hoopR_no_data`; a game listed under
#' another competition is refused (`hoopR_asset_fetch`).
#' @eval .intl_details(.feb_game_info_details, "feb_overview()")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | comp_id | integer | Competition id (constant across seasons): 115 Primera FEB (LEB Oro), 118 Segunda FEB, 210 Liga Femenina Endesa, 214 LF Challenge, 218 LF-2, 111 Tercera FEB. Not the site's menu group. |
#' | comp_code | integer | Season-specific competition edition code (e.g. 23473 = Primera FEB 2026-27). |
#' | competition | character | Competition name as printed that season, uppercase ('PRIMERA FEB'; 2020-21 'LIGA LEB ORO'). |
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route. |
#' | round_id | integer | Round id; 0 in every sample (the route does not fill it). |
#' | stage | character | Stage code as a string; '0' in every sample (meaning unverified). |
#' | venue | character | Name of the venue (pabellon) where the game is played. |
#' | start_time | POSIXct | Tip-off in Spanish local time (POSIXct, tz Europe/Madrid; the source has no offset). |
#' | start_time_utc | POSIXct | Tip-off in UTC (POSIXct, tz UTC). |
#' | period | integer | Current or last period (4 when finished). |
#' | clock | character | 'FINAL' once finished, else the game clock ('00:00' before tip-off). |
#' | status | integer | Game state code: 3 = finished, 1 = scheduled (seen 2026-10-12); the live codes are unverified. |
#' | home_team_id | integer | Home team-season id (new every season; joins the schedule pages). |
#' | home_team | character | Home team name for the season. |
#' | home_team_code | character | Home federation team code, 8 digits as a string. |
#' | home_club_code | character | Home federation club code, 6 digits as a string. |
#' | home_abbreviation | character | Home team three-letter abbreviation ('PAL'). |
#' | home_score | integer | Home points (0 before tip-off). |
#' | away_team_id | integer | Away team-season id (new every season; joins the schedule pages). |
#' | away_team | character | Away team name for the season. |
#' | away_team_code | character | Away federation team code, 8 digits as a string. |
#' | away_club_code | character | Away federation club code, 6 digits as a string. |
#' | away_abbreviation | character | Away team three-letter abbreviation. |
#' | away_score | integer | Away points (0 before tip-off). |
#' | period_scores | character | Points per period as 'home-away' pairs joined by ';' ('16-16;19-16;10-21;14-14'); null before tip-off. |
#' @family FEB Functions
#' @export
feb_overview <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .feb_parse_overview(.feb_api_get("overview"))
}

#' @title
#' **FEB Schedule**
#' @description
#' **Full schedule of one group (phase) of a FEB competition season: every
#' round, game, result and team-season id.**
#'
#' Endpoint: `GET https://baloncestoenvivo.feb.es/calendario.aspx?g={group}&t={season - 1}`
#'
#' Played games carry no date or time on this page: use `round_date` or
#' [feb_game_info()]'s `start_time`. The page renders only the FIRST phase of
#' the group (Segunda FEB shows group A); other phases and the playoffs need an
#' ASP.NET postback and are not modelled. A page for another group or season
#' is refused (`hoopR_asset_fetch`), an unknown group is `hoopR_no_data`.
#' @param group (*integer* required): The site's menu group: 1 Primera FEB, 2
#'   Segunda FEB, 4 Liga Femenina Endesa, 9 and 10 LF-2, 67 LF Challenge, 73
#'   Copa de Espana, 74 Liga U. A group is not a competition id (see
#'   `comp_id`).
#' @param season (*integer* required): Season END year (`2027` = 2026-27),
#'   sent to the site as its START-year key `t = season - 1`.
#' @inherit feb_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | group | integer | The site's menu group (1 Primera FEB, 2 Segunda FEB, 4 Liga Femenina Endesa); not a competition id. |
#' | season | integer | Season END year (2027 = 2026-27), the site's START-year key plus one. |
#' | competition | character | Competition name on the page header ('PRIMERA FEB'). |
#' | round | integer | Round number (jornada) the game belongs to. |
#' | round_label | character | Round heading as printed ('Jornada 4 16/10/2026'). |
#' | round_date | Date | Date of the round (the heading's date); played games carry no date of their own on this page. |
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | home_team_id | integer | Home team-season id (new every season; joins feb_overview and the game wrappers). |
#' | home_team | character | Home team name, uppercase. |
#' | away_team_id | integer | Away team-season id (new every season). |
#' | away_team | character | Away team name, uppercase. |
#' | result_text | character | Result cell verbatim: 'home-away' points when played; before the game the calendar shows the Spanish weekday, date and time and the results page shows '*-*'. |
#' | home_score | integer | Home points; null before the game. |
#' | away_score | integer | Away points; null before the game. |
#' | status | character | played when the result cell holds a score, scheduled otherwise. |
#' | weekday | character | English weekday of a scheduled game (translated from the Spanish cell); null for played games. |
#' | date | Date | Game date; null for played games on the schedule page (use round_date). |
#' | time | character | Tip-off 'HH:MM', Spanish local time; null for played games on the schedule page. |
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_schedule(group = 1, season = 2027))
#' }
feb_schedule <- function(group, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rec <- .feb_page("calendar", group, season)
  .feb_frame(rec$games, .feb_specs$schedule, "schedule")
}

#' @title
#' **FEB Results**
#' @description
#' **Latest round's results and the next round's fixtures of a FEB competition
#' season.**
#'
#' Endpoint: `GET https://baloncestoenvivo.feb.es/resultados.aspx?g={group}&t={season - 1}`
#'
#' `section` is `results` (the LATEST round of the shown phase; for a finished
#' season the last playoff round) or `next_round` (empty once the season is
#' over). `comp_id` ties the site group to the API's competition id (group 1
#' -> 115, 2 -> 118, 4 -> 210).
#' @inheritParams feb_schedule
#' @inherit feb_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | group | integer | The site's menu group (1 Primera FEB, 2 Segunda FEB, 4 Liga Femenina Endesa); not a competition id. |
#' | season | integer | Season END year (2027 = 2026-27), the site's START-year key plus one. |
#' | competition | character | Competition name on the page header ('PRIMERA FEB'). |
#' | comp_id | integer | Competition id (CompID) read from the page; ties the site group to the API (group 1 -> 115, 2 -> 118, 4 -> 210). |
#' | section | character | Which table the row comes from: results (the latest round) or next_round (the following fixtures). |
#' | round_title | character | Title of the table as printed ('Resultados Jornada 3(09/10/2026)'). |
#' | game_id | integer | FEB game id (one global sequence): the \{gameId\} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
#' | home_team_id | integer | Home team-season id (new every season; joins feb_overview and the game wrappers). |
#' | home_team | character | Home team name, uppercase. |
#' | away_team_id | integer | Away team-season id (new every season). |
#' | away_team | character | Away team name, uppercase. |
#' | result_text | character | Result cell verbatim: 'home-away' points when played; before the game the calendar shows the Spanish weekday, date and time and the results page shows '*-*'. |
#' | home_score | integer | Home points; null before the game. |
#' | away_score | integer | Away points; null before the game. |
#' | status | character | played when the result cell holds a score, scheduled otherwise. |
#' | date | Date | Game date; null for played games on the schedule page (use round_date). |
#' | time | character | Tip-off 'HH:MM', Spanish local time; null for played games on the schedule page. |
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_results(group = 1, season = 2027))
#' }
feb_results <- function(group, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rec <- .feb_page("results", group, season)
  .feb_frame(rec$results, .feb_specs$results, "results")
}

#' @title
#' **FEB Standings**
#' @description
#' **League table of a FEB competition season (live standings, or the final
#' classification once it is over).**
#'
#' Endpoint: `GET https://baloncestoenvivo.feb.es/resultados.aspx?g={group}&t={season - 1}`
#'
#' `table` is `live` (the in-season table) or `final` (the final
#' classification: only `position` and the team, every other statistic is
#' `NA`); the page shows one of the two. Only the first phase of the group is
#' shown.
#' @inheritParams feb_schedule
#' @inherit feb_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | group | integer | The site's menu group (1 Primera FEB, 2 Segunda FEB, 4 Liga Femenina Endesa); not a competition id. |
#' | season | integer | Season END year (2027 = 2026-27), the site's START-year key plus one. |
#' | competition | character | Competition name on the page header ('PRIMERA FEB'). |
#' | comp_id | integer | Competition id (CompID) read from the page; ties the site group to the API (group 1 -> 115, 2 -> 118, 4 -> 210). |
#' | table | character | live = the in-season league table; final = the final classification once the season is over. |
#' | position | integer | Rank in the table (Po). |
#' | team_id | integer | Team-season id (new every season; joins the schedule and game wrappers). |
#' | team | character | Team name as printed in the table (sponsor name, uppercase). |
#' | played | integer | Games played (PJ); null in the final classification. |
#' | won | integer | Games won (PG); null in the final classification. |
#' | lost | integer | Games lost (PP); null in the final classification. |
#' | points_for | integer | Points scored (PF); null in the final classification. |
#' | points_against | integer | Points conceded (PC); null in the final classification. |
#' | point_diff | integer | Point difference (DIF), signed; null in the final classification. |
#' | win_pct | double | Win percentage, 0-100 (the page's '100,0%', decimal comma converted). |
#' | streak | integer | Current streak as a signed integer: +3 = three wins in a row, -2 = two losses. |
#' | streak_text | character | The streak cell verbatim ('+3'). |
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_standings(group = 1, season = 2027))
#' }
feb_standings <- function(group, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rec <- .feb_page("results", group, season)
  .feb_frame(rec$standings, .feb_specs$standings, "standings")
}
