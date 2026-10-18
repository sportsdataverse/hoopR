# pleague.R -- P. LEAGUE+ (Taiwan) wrappers over pleagueofficial.com and the third-party vendor
# api.preciser.io, at parity with sdv-py sportsdataverse/basketball/plg (origin/main e3d232e): 11 site
# wrappers, 7 vendor wrappers and the team crosswalk. Runtime, refusals and frames: R/pleague_utils.R.
# Generated from tools/codegen/endpoints/pleague{,_preciser}.yaml and manual_column_descriptions.yaml of
# that sdv-py commit (ASCII only: Chinese text is glossed as '(Chinese text)').

#' @title
#' **Get P. LEAGUE+ Schedule**
#' @description
#' Schedule and results of one season and stage (pre-season, regular season, playoffs or finals): one row per game,
#'   away team first.
#'
#' Endpoint: `GET https://pleagueofficial.com/schedule-{stage}/{season slug}`
#' @param season Required. Season END year (2025 = the site's slug '2024-25'). The slug is '<season - 1>-<the last
#'   two digits of season>'. The first season is 2020-21 (`season=2021`); earlier slugs redirect.
#' @param stage Stage: pre-season ((Chinese text), exhibition games), regular-season ((Chinese text)), playoffs
#'   ((Chinese text)) or finals ((Chinese text)). A stage a season does not have (2025-26 pre-season) answers
#'   hoopR_no_data.
#' @return
#' A `hoopR_data` tibble: Schedule and results of one season and stage (pre-season, regular season, playoffs or
#'   finals): one row per game, away team first. An empty valid answer is a zero-row tibble with these columns, in
#'   this order (sdv-py `pleague_schedule`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2025 = the site's slug '2024-25'): the first year of the slug plus one. |
#' | season_slug | character | The site's season slug as printed: the START year, then the END year's last two digits ('2024-25'). |
#' | stage | character | Stage slug: pre-season ((Chinese text), exhibition games before the season), regular-season ((Chinese text)), playoffs ((Chinese text)) or finals ((Chinese text), the championship series). |
#' | gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The \{gid\} of /game/\{gid\}. Cross-checked with the page's trackGame() call. |
#' | date | Date | Game date, Asia/Taipei (UTC+8) local time. |
#' | weekday_zh | character | Weekday as one Chinese character: (Chinese text) Sun, (Chinese text) Mon, (Chinese text) Tue, (Chinese text) Wed, (Chinese text) Thu, (Chinese text) Fri, (Chinese text) Sat. |
#' | time | character | Scheduled tip-off 'HH:MM', Asia/Taipei (UTC+8) local time. |
#' | starred | logical | True when the date cell carries the site's star icon (a highlighted game). |
#' | game_label | character | Game label as printed: 'G01' = game 1 of the stage, 'PLAYOFFS Game1' / 'PLAYOFFS A G1' = playoff game (series A / B), 'FINALS G1' / 'Final Game1' = finals game, '(Chinese text)G1' = game 1 of the first 'stop' ((Chinese text), a round-robin hub weekend; 2020-21). |
#' | venue_zh | character | Venue (arena) name in Traditional Chinese. |
#' | attendance | integer | Spectators: the first number of the page's 'N / M' seat cell; 0 on future games. |
#' | capacity | integer | Seats: the second number of the 'N / M' seat cell (the venue capacity as the site records it); 0 on future games. |
#' | phase | character | Row state from the page's CSS class: before_today = the date is past (the score is the result), is_future = not yet played (both scores 0), is_today. A past game printing 0-0 may be a series game that was never played: check the game page's status. |
#' | away_team_id | integer | P. LEAGUE+ club id on the site (stable across seasons AND renames): 1 = Taipei Fubon Braves, 2 = Taoyuan Pauian Pilots, 3 = Hsinchu Jko / Toplus Lioneers, 4 = Formosa Taishin Dreamers, 5 = Kaohsiung 17LIVE Steelers, 6 = New Taipei Kings, 7 = TSG Ghosthawks, 8 = Yankey Ark. NOT a Preciser team uuid (that joins through the standings team_uuid). |
#' | away_name_zh | character | Away team's name on that date in Traditional Chinese (short or long form; (Chinese text) = Braves, (Chinese text) = Pilots, (Chinese text) = Lioneers, (Chinese text) = Dreamers, (Chinese text) = Steelers, (Chinese text) = Kings, (Chinese text) = Ghosthawks, (Chinese text) = Yankey Ark). Printed names change by season (short and long forms, renames): key on the id, not the name. |
#' | away_name_en | character | Away team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
#' | away_logo | character | Away team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo_\{team\}_\{epoch\}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
#' | away_score | integer | Away team's final points (0 on a future game). |
#' | home_team_id | integer | P. LEAGUE+ club id on the site (stable across seasons AND renames): 1 = Taipei Fubon Braves, 2 = Taoyuan Pauian Pilots, 3 = Hsinchu Jko / Toplus Lioneers, 4 = Formosa Taishin Dreamers, 5 = Kaohsiung 17LIVE Steelers, 6 = New Taipei Kings, 7 = TSG Ghosthawks, 8 = Yankey Ark. NOT a Preciser team uuid (that joins through the standings team_uuid). |
#' | home_name_zh | character | Home team's name on that date in Traditional Chinese (short or long form). Printed names change by season (short and long forms, renames): key on the id, not the name. |
#' | home_name_en | character | Home team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
#' | home_logo | character | Home team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo_\{team\}_\{epoch\}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
#' | home_score | integer | Home team's final points (0 on a future game). |
#' @details
#' * Unofficial use of a public source: these wrappers read pleagueofficial.com (P. LEAGUE+, Taiwan's men's
#'   league), keyless. The site's /user-policy (members' terms, section 11) reserves all content on the site to the
#'   service and its rights holders and forbids use, copying, adaptation or distribution without authorisation (it
#'   says nothing about automated access); robots.txt holds only Cloudflare content-signal comment lines with no
#'   Allow, Disallow or Crawl-delay rule. Use for reference only; payloads are not redistributed as release assets,
#'   and a data release needs owner sign-off. Requests are spaced at least 1 s apart per host, retries included.
#' * Access: the site sits behind Cloudflare. sdv-py fetches it with curl_cffi (Chrome TLS); this R port sends a
#'   browser User-Agent through libcurl, which was served on a live check (2026-10-18); Cloudflare may still answer
#'   a request with an HTTP 403 challenge page (`hoopR_asset_fetch`). Redirects are not followed: the site answers
#'   an unknown `gid` or a season before 2020-21 with a 302 to the home page (`hoopR_no_data`).
#' * Coverage: schedules, standings and player tables from 2020-21 (`season = 2021`); box scores for every finished
#'   game from 2020-21; play-by-play (with shot x / y) from 2022-23 (gid 191 on). 2020-21 and 2021-22 pages embed
#'   an empty game uuid, so they have no play-by-play and no Preciser data (`hoopR_no_data`). A game is keyed by
#'   `gid`: ONE global integer sequence over every stage and season. Only finished games are served: an unplayed
#'   game, or a box or play-by-play that does not match its game page (the routes echo no id, so the game page is
#'   fetched first, cached for the session, and the body's scores, quarters and points are checked against it),
#'   raises `hoopR_asset_fetch`.
#' * Seasons are END years (2025 = the site's slug '2024-25'). Text is Traditional Chinese as printed (names,
#'   venues, play-by-play phrases); the column descriptions gloss it in English. Ids: `team_id` (1-8) is stable
#'   across renames; the box `player_id` is the player-team membership. The box `random_id` is UNRELIABLE before
#'   2022-23 (gid 13 gives one player another player's page id): join box rows on `player_id`, and box rows to
#'   Preciser shots on `person_id`, never on `random_id`. The date of birth is dropped from the player frame;
#'   officials appear by name only.
#' * Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, a redirect, a stage
#'   the season does not have, a game with no play-by-play, a season before 2020-21), `hoopR_bad_request` (an
#'   invalid argument, HTTP 400 / 422) and `hoopR_asset_fetch` (any other non-200, a dead connection, an empty or
#'   unreadable body, a page for another game, season, stage or player, an unfinished game, layout drift, a
#'   play-by-play phrase outside the observed vocabulary). HTTP 429 / 502 / 503 / 504 are retried, up to three
#'   attempts; HTTP 500 is NOT retried (the site answers 500 for an unknown id). Wrappers raise; they never warn
#'   and return empty.
#' @examples
#' \donttest{
#'   try(pleague_schedule(season = 2025))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_schedule <- function(season, stage = "regular-season") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("schedule", list(season = season, stage = stage), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Game**
#' @description
#' Header of one finished game: date, venue, both clubs with their score and the Preciser game uuid.
#'
#' Endpoint: `GET https://pleagueofficial.com/game/{gid}`
#' @param gid Required. P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season
#'   (197 = the 2022-23 opener, 662 = the 2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished games
#'   are served.
#' @return
#' A `hoopR_data` tibble: Header of one finished game: date, venue, both clubs with their score and the Preciser
#'   game uuid. An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_game`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The \{gid\} of /game/\{gid\}. |
#' | uuid | character | Preciser game uuid (key space: the analytics vendor's games, a version-1 uuid), embedded in the game page as getPlayByPlay('uuid'); keys the play-by-play and every pleague_preciser wrapper. Null before 2022-23 (the page embeds an empty string: no play-by-play or vendor data). |
#' | status_zh | character | Status badge: (Chinese text) = finished. The only value the wrappers serve (anything else raises hoopR_asset_fetch). |
#' | finished | logical | True when the status badge is (Chinese text) (finished); always true for a served game. |
#' | date | Date | Game date from the header, Asia/Taipei (UTC+8) local time. |
#' | time | character | Tip-off 'HH:MM' from the header, Asia/Taipei (UTC+8) local time. |
#' | venue_zh | character | Venue (arena) name in Traditional Chinese. |
#' | game_label_zh | character | Stage and game number as printed in the header: '(Chinese text)G1' = regular season game 1 ('(Chinese text)G01' on 2020-21 pages); (Chinese text) = playoffs, (Chinese text) = finals. |
#' | away_name_zh | character | Away team's name on that date in Traditional Chinese (short or long form; (Chinese text) = Braves, (Chinese text) = Pilots, (Chinese text) = Lioneers, (Chinese text) = Dreamers, (Chinese text) = Steelers, (Chinese text) = Kings, (Chinese text) = Ghosthawks, (Chinese text) = Yankey Ark). Printed names change by season (short and long forms, renames): key on the id, not the name. |
#' | away_name_en | character | Away team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
#' | away_logo | character | Away team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo_\{team\}_\{epoch\}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
#' | away_score | integer | Away team's final points (0 on a future game). |
#' | home_name_zh | character | Home team's name on that date in Traditional Chinese (short or long form). Printed names change by season (short and long forms, renames): key on the id, not the name. |
#' | home_name_en | character | Home team's English name on that date; renames change it. Null on 2020-21 game pages (no English name is printed). |
#' | home_logo | character | Home team logo url as printed by the page: protocol-relative ('//d36fypkbmmogz6.cloudfront.net/upload/p_team/logo_\{team\}_\{epoch\}.png'); some game pages print a malformed 'https:////d36...'. The trailing number is the upload time. |
#' | home_score | integer | Home team's final points (0 on a future game). |
#' | overtimes | integer | Number of overtime periods played (overtime cells with points on the page). |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_game(gid = 197))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_game <- function(gid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("game", list(gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Periods**
#' @description
#' Points each team scored in each quarter and overtime of one finished game.
#'
#' Endpoint: `GET https://pleagueofficial.com/game/{gid}`
#' @param gid Required. P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season
#'   (197 = the 2022-23 opener, 662 = the 2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished games
#'   are served.
#' @return
#' A `hoopR_data` tibble: Points each team scored in each quarter and overtime of one finished game. An empty valid
#'   answer is a zero-row tibble with these columns, in this order (sdv-py `pleague_periods`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The \{gid\} of /game/\{gid\}. |
#' | period | character | Period label: Q1-Q4, then OT1, OT2 for overtime. |
#' | period_no | integer | 1-based position of the period: 1-4 for Q1-Q4, then 5 for OT1, 6 for OT2. |
#' | home_points | integer | Home points scored IN the period (not cumulative). |
#' | away_points | integer | Away points scored IN the period (not cumulative). |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_periods(gid = 197))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_periods <- function(gid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("periods", list(gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Officials**
#' @description
#' The referee and the two umpires printed under the header of one finished game (names only).
#'
#' Endpoint: `GET https://pleagueofficial.com/game/{gid}`
#' @param gid Required. P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season
#'   (197 = the 2022-23 opener, 662 = the 2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished games
#'   are served.
#' @return
#' A `hoopR_data` tibble: The referee and the two umpires printed under the header of one finished game (names
#'   only). An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_officials`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The \{gid\} of /game/\{gid\}. |
#' | official_no | integer | 1-based position of the official in the printed line (referee first). |
#' | role | character | Role translated: referee ((Chinese text), the crew chief), first_umpire ((Chinese text), literally 'first inspector'), second_umpire ((Chinese text)). Null for a role this table does not know. |
#' | role_zh | character | Official's role as printed: (Chinese text) = referee, (Chinese text) = first umpire, (Chinese text) = second umpire. |
#' | name_zh | character | Official's name in Traditional Chinese. Names only: the page carries no ids or contact data. |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_officials(gid = 197))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_officials <- function(gid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("officials", list(gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Player Box Score**
#' @description
#' Player box score of one finished game: minutes, points, shooting splits, rebounds, assists, plus/minus, and the
#'   ratings from 2022-23; did-not-play rows included.
#'
#' Endpoint: `GET https://pleagueofficial.com/api/boxscore.preciser.php?id={gid}&away_tab=total&home_tab=total (after the game page)`
#' @param gid Required. P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season
#'   (197 = the 2022-23 opener, 662 = the 2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished games
#'   are served.
#' @return
#' A `hoopR_data` tibble: Player box score of one finished game: minutes, points, shooting splits, rebounds,
#'   assists, plus/minus, and the ratings from 2022-23; did-not-play rows included. An empty valid answer is a
#'   zero-row tibble with these columns, in this order (sdv-py `pleague_box_players`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The \{gid\} of /game/\{gid\}. |
#' | side | character | Which team the row belongs to: home or away. The box lists home first, the play-by-play and the schedule list away first. |
#' | player_id | integer | P. LEAGUE+ player-team membership id on the site (key space: the member id the player page passes to trackPlayer(), e.g. 40 = Lai Ting-En), cast to an integer. NOT the 8-character page id. Join box rows on it, never on the printed name. |
#' | person_id | character | Preciser person uuid (key space: the analytics vendor's persons): the join between a box row and a pleague_preciser_shots row. Present on played rows from 2022-23; null on 2020-21 and 2021-22 rows and did-not-play rows (the refs notes report some 2025-26 finals boxes without it; gid 716 has it). |
#' | random_id | character | The 8-character page id of /player/\{id\} (same space as player_page_id). Reliable from 2022-23 only: on 2020-21 and 2021-22 rows it is wrong for most players (gid 13 gives Lai Ting-En the page of Kao Kuo-Hao), so never join across eras on it. |
#' | name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
#' | jersey | character | Shirt number as printed, a string ('0', '00' and '10' differ). |
#' | starter | logical | True for a starter (the site's '(Chinese text)' marker). Null on did-not-play rows. |
#' | played | logical | True when the player has court time; false on a 'DNP' (did not play) row, whose statistics are null. |
#' | minutes | character | Minutes played 'mm:ss'. Null on did-not-play rows. |
#' | seconds | integer | Playing time in whole seconds: the site's seconds column in 2020-21 and 2021-22, derived from minutes from 2022-23. Null on did-not-play rows. |
#' | points | integer | Points scored. Null on did-not-play rows. |
#' | reb_off | integer | Offensive rebounds. Null on did-not-play rows. |
#' | reb_def | integer | Defensive rebounds. Null on did-not-play rows. |
#' | reb | integer | Total rebounds (offensive plus defensive). Null on did-not-play rows. |
#' | ast | integer | Assists. Null on did-not-play rows. |
#' | stl | integer | Steals. Null on did-not-play rows. |
#' | blk | integer | Blocks made. Null on did-not-play rows. |
#' | tov | integer | Turnovers committed. Null on did-not-play rows. |
#' | pf | integer | Personal fouls committed. Null on did-not-play rows. |
#' | plus_minus | integer | Plus/minus: the team's points minus the opponent's while the player was on court (signed). Null on did-not-play rows. |
#' | eff | integer | Efficiency: points + rebounds + assists + steals + blocks - missed field goals - missed free throws - turnovers (verified on every 2020-21 and 2021-22 row). Null on did-not-play rows. |
#' | fg2_made | integer | 2-point field goals made, from the site's 'made-attempted' string. Null on did-not-play rows. |
#' | fg2_att | integer | 2-point field goals attempted, from the site's 'made-attempted' string. Null on did-not-play rows. |
#' | fg2_pct | double | 2-point field-goal percentage, 0-100 (the site sends a number or a string). Null on did-not-play rows. |
#' | fg3_made | integer | 3-point field goals made, from the site's 'made-attempted' string. Null on did-not-play rows. |
#' | fg3_att | integer | 3-point field goals attempted, from the site's 'made-attempted' string. Null on did-not-play rows. |
#' | fg3_pct | double | 3-point field-goal percentage, 0-100. Null on did-not-play rows. |
#' | ft_made | integer | Free throws made, from the site's 'made-attempted' string. Null on did-not-play rows. |
#' | ft_att | integer | Free throws attempted, from the site's 'made-attempted' string. Null on did-not-play rows. |
#' | ft_pct | double | Free-throw percentage, 0-100. Null on did-not-play rows. |
#' | efg_pct | double | Effective field-goal percentage 0-100, (FGM + 0.5 x 3PM) / FGA x 100 (verified). 2020-21 and 2021-22 rows only; null from 2022-23. |
#' | ts_pct | double | True-shooting percentage 0-100, PTS / (2 x (FGA + 0.44 x FTA)) x 100 (verified). 2020-21 and 2021-22 rows only; null from 2022-23. |
#' | usage_pct | double | Usage percentage as the site prints it, 0-100; the standard usage formula reproduces it on only 685 of 3,932 rows, so the formula is unverified. 2020-21 and 2021-22 rows only. |
#' | position | character | Position code on some 2020-21 and 2021-22 rows ('G' guard, 'F' forward, 'C' centre); null on the rest and from 2022-23. |
#' | ortg | double | Offensive rating: the team's points scored per 100 offensive possessions while the player was on court (2022-23 on; null before). Null on did-not-play rows. |
#' | drtg | double | Defensive rating: the opponent's points per 100 of its possessions while the player was on court, lower is better (2022-23 on). Null on did-not-play rows. |
#' | netrtg | double | Net rating, ortg minus drtg (exact on every checked row; 2022-23 on). Null on did-not-play rows. |
#' | pace | double | Pace: 48 x the team's offensive possessions / minutes on court, the team's possessions per 48 minutes with this player on court (verified on 1,124 of 1,149 rows; 2022-23 on). Null on did-not-play rows. |
#' | ast_ratio | double | Assist ratio 0-100: assists per 100 of the player's own plays. The common formula AST / (FGA + 0.5 x FTA + AST + TOV) reproduces it on 919 of 1,174 rows, so the exact formula is unverified (2022-23 on). |
#' | to_ratio | double | Turnover ratio 0-100: turnovers per 100 of the player's own plays; same unverified formula family as ast_ratio (917 of 1,174 rows; 2022-23 on). |
#' | off_possessions | integer | The team's offensive possessions while the player was on court (the base of ortg; 2022-23 on). Null on did-not-play rows. |
#' | opp_off_possessions | integer | The opponent's offensive possessions while the player was on court (the base of drtg; 2022-23 on). Null on did-not-play rows. |
#' | opp_pts_second_chance | integer | Opponent second-chance points while the player was on court (2022-23 on). Null on did-not-play rows. |
#' | opp_pts_fast_break | integer | Opponent fast-break points while the player was on court (2022-23 on). Null on did-not-play rows. |
#' | opp_pts_off_turnover | integer | Opponent points off turnovers while the player was on court (2022-23 on). Null on did-not-play rows. |
#' | opp_pts_paint | integer | Opponent points in the paint while the player was on court (2022-23 on). Null on did-not-play rows. |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_box_players(gid = 197))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_box_players <- function(gid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("box_players", list(gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Team Box Score**
#' @description
#' Team totals of one finished game: the box score's total row, home then away.
#'
#' Endpoint: `GET https://pleagueofficial.com/api/boxscore.preciser.php?id={gid}&away_tab=total&home_tab=total (after the game page)`
#' @param gid Required. P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season
#'   (197 = the 2022-23 opener, 662 = the 2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished games
#'   are served.
#' @return
#' A `hoopR_data` tibble: Team totals of one finished game: the box score's total row, home then away. An empty
#'   valid answer is a zero-row tibble with these columns, in this order (sdv-py `pleague_box_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The \{gid\} of /game/\{gid\}. |
#' | side | character | Which team the row belongs to: home or away. The box lists home first, the play-by-play and the schedule list away first. |
#' | minutes | character | Team minutes 'mm:ss' ('240:00' = 5 players x 48 min; more with overtime). |
#' | seconds | integer | Team seconds on court (14400 = 240 minutes): the site's value in 2020-21 and 2021-22, derived from minutes from 2022-23. |
#' | points | integer | Team points; equals the final score (the runtime checks it). |
#' | fg2_made | integer | Team 2-point field goals made. |
#' | fg2_att | integer | Team 2-point field goals attempted. |
#' | fg2_pct | double | Team 2-point percentage, 0-100. |
#' | fg3_made | integer | Team 3-point field goals made. |
#' | fg3_att | integer | Team 3-point field goals attempted. |
#' | fg3_pct | double | Team 3-point percentage, 0-100. |
#' | ft_made | integer | Team free throws made. |
#' | ft_att | integer | Team free throws attempted. |
#' | ft_pct | double | Team free-throw percentage, 0-100. |
#' | reb | integer | Team total rebounds, including team rebounds that no player row carries (so it can exceed the sum of the player rows). |
#' | reb_off | integer | Team offensive rebounds. |
#' | reb_def | integer | Team defensive rebounds. |
#' | ast | integer | Team assists in the game (the total row). |
#' | stl | integer | Team steals in the game. |
#' | blk | integer | Team blocks made in the game. |
#' | tov | integer | Team turnovers. |
#' | pf | integer | Team personal fouls. |
#' | plus_minus | integer | Sum of the players' plus/minus (2020-21 and 2021-22 only; null from 2022-23). |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_box_teams(gid = 197))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_box_teams <- function(gid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("box_teams", list(gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Play-by-Play**
#' @description
#' Play-by-play of one finished game (2022-23 on) in game order, with shot x / y and the clip references.
#'
#' Endpoint: `GET https://pleagueofficial.com/api/playbyplay.php?uuid={uuid} (after the game page, which holds the uuid)`
#' @param gid Required. P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season
#'   (197 = the 2022-23 opener, 662 = the 2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished games
#'   are served.
#' @return
#' A `hoopR_data` tibble: Play-by-play of one finished game (2022-23 on) in game order, with shot x / y and the
#'   clip references. An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_pbp`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The \{gid\} of /game/\{gid\}. |
#' | seq | integer | Position of the play in game order, 1-based (the fragment lists plays oldest first within the fragment). |
#' | period | character | Period label: Q1-Q4, then OT1, OT2 for overtime. |
#' | period_no | integer | 1-based position of the period: 1-4 for Q1-Q4, then 5 for OT1, 6 for OT2. |
#' | clock | character | Game clock REMAINING in the period 'mm:ss' (counts down; Q1 opens at 12:00, OT at 05:00). |
#' | seconds_left | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
#' | side | character | Side of the acting team: away or home (the fragment places the play in the away or home column). |
#' | jersey | character | Shirt number of the acting player as printed; null on team rows and where the name is printed without a number. |
#' | player_zh | character | Acting player's name as printed; null on team rows (a team rebound, timeout or shot-clock violation). The page prints no player ids: join to the box on side, jersey and name_zh. |
#' | action | character | Action code from the vocabulary observed on 258,183 plays of 404 finished 2022-23..2025-26 games (82 phrases plus the blank row; an unseen phrase is refused as layout drift). The code = meaning \[Traditional Chinese phrase, events\]: ast = assist \[17,020\]; blk = block \[3,181\]; fg2_alley_oop_made = 2-point alley-oop, made \[205\]; fg2_alley_oop_missed = 2-point alley-oop, missed \[81\]; fg2_driving_layup_made = 2-point driving layup, made \[4,281\]; fg2_driving_layup_missed = 2-point driving layup, missed \[3,961\]; fg2_dunk_made = 2-point dunk, made \[1,316\]; fg2_dunk_missed = 2-point dunk, missed \[162\]; fg2_fadeaway_jumper_made = 2-point fadeaway jumper, made \[583\]; fg2_fadeaway_jumper_missed = 2-point fadeaway jumper, missed \[1,121\]; fg2_floater_made = 2-point floater, made \[1,920\]; fg2_floater_missed = 2-point floater, missed \[3,052\]; fg2_hook_shot_made = 2-point hook shot, made \[610\]; fg2_hook_shot_missed = 2-point hook shot, missed \[773\]; fg2_jump_shot_made = 2-point jump shot, made \[1,657\]; fg2_jump_shot_missed = 2-point jump shot, missed \[3,606\]; fg2_layup_made = 2-point layup, made \[4,428\]; fg2_layup_missed = 2-point layup, missed \[3,403\]; fg2_pull_up_jumper_made = 2-point pull-up jumper, made \[1,004\]; fg2_pull_up_jumper_missed = 2-point pull-up jumper, missed \[1,564\]; fg2_putback_made = 2-point putback / tip-in, made \[2,138\]; fg2_putback_missed = 2-point putback / tip-in, missed \[1,539\]; fg2_step_back_shot_made = 2-point step-back shot, made \[243\]; fg2_step_back_shot_missed = 2-point step-back shot, missed \[410\]; fg2_turnaround_jumper_made = 2-point turnaround jumper, made \[672\]; fg2_turnaround_jumper_missed = 2-point turnaround jumper, missed \[1,158\]; fg3_fadeaway_jumper_made = 3-point fadeaway jumper, made \[48\]; fg3_fadeaway_jumper_missed = 3-point fadeaway jumper, missed \[92\]; fg3_made = 3-point shot, style not recorded, made \[7,817\]; fg3_missed = 3-point shot, style not recorded, missed \[17,046\]; fg3_pull_up_jumper_made = 3-point pull-up jumper, made \[480\]; fg3_pull_up_jumper_missed = 3-point pull-up jumper, missed \[922\]; fg3_step_back_shot_made = 3-point step-back shot, made \[245\]; fg3_step_back_shot_missed = 3-point step-back shot, missed \[559\]; fg3_turnaround_jumper_made = 3-point turnaround jumper, made \[10\]; fg3_turnaround_jumper_missed = 3-point turnaround jumper, missed \[23\]; fg_made = field goal made, shot type and distance not recorded \[158\]; fg_missed = field goal missed, shot type and distance not recorded \[168\]; foul = foul, kind not recorded (team row) \[18\]; foul_bench_technical = technical foul on the bench \[35\]; foul_coach_technical = technical foul on the coach \[75\]; foul_disqualifying = disqualifying foul \[2\]; foul_drawn = foul drawn (the opponent's foul on this player) \[17,035\]; foul_offensive = offensive foul committed \[1,024\]; foul_personal = personal foul committed \[15,745\]; foul_technical = technical foul \[210\]; foul_unsportsmanlike = unsportsmanlike foul \[261\]; ft_made = free throw 1 of 1 awarded, made \[1,326\]; ft_made = free throw 1 of 3 awarded, made \[128\]; ft_made = free throw 1 of 2 awarded, made \[5,187\]; ft_made = free throw 3, made \[149\]; ft_made = free throw 2, made \[5,798\]; ft_missed = free throw 1 of 1 awarded, missed \[669\]; ft_missed = free throw 1 of 3 awarded, missed \[67\]; ft_missed = free throw 1 of 2 awarded, missed \[2,736\]; ft_missed = free throw 3, missed \[46\]; ft_missed = free throw 2, missed \[2,319\]; jump_ball_lost = jump ball lost \[404\]; jump_ball_won = jump ball won \[708\]; reb_def = defensive rebound (a team rebound has no player) \[29,537\]; reb_off = offensive rebound (a team rebound has no player) \[12,379\]; review_coach_challenge = video review: coach's challenge (2025-26 onward; the printed text ends with a bare comma) \[videoReview, coachChallenge,, 82\]; review_instant_replay = video review: instant-replay system, started by the officials (2025-26 onward) \[videoReview, instantReplaySystem,, 67\]; review_instant_replay_1 = video review: instant-replay system, variant printed with a trailing '1' (meaning unexplained; the row also prints the running score and the points tag '+videoReview') \[videoReview, instantReplaySystem, 1, 6\]; stl = steal \[7,361\]; sub_in = substitution: enters the game \[25,505\]; sub_out = substitution: leaves the game \[25,532\]; timeout = timeout (a team row) \[2,854\]; tov_3sec = turnover: 3-second violation \[249\]; tov_5sec = turnover: 5-second violation \[40\]; tov_8sec = turnover: 8-second violation \[26\]; tov_backcourt = turnover: backcourt violation \[96\]; tov_bad_pass = turnover: bad pass \[6,325\]; tov_ball_handling = turnover: ball-handling \[3,547\]; tov_carrying = turnover: carrying the ball \[47\]; tov_double_dribble = turnover: double dribble \[53\]; tov_offensive = turnover: offensive (kind not recorded) \[1,007\]; tov_offensive_goaltending = turnover: offensive goaltending \[4\]; tov_other = turnover: other \[51\]; tov_out_of_bounds = turnover: ball out of bounds \[441\]; tov_shot_clock = turnover: shot-clock violation \[489\]; tov_travel = turnover: travelling \[718\]; unlabelled = row has a player but no action text; in the corpus a shot with x/y followed by a rebound, i.e. a missed shot (inferred) \[(blank), 169\]. |
#' | action_zh | character | The action phrase as printed, Traditional Chinese ((Chinese text) = dunk, made; '#35 (Chinese text)' = '#35 \{player\} dunk, made'); blank on an unlabelled row. Each of the 82 observed phrases maps to one action code (see `action`). |
#' | action_en | character | English meaning of the action code (see action); null for a code outside the observed table. |
#' | text_zh | character | The whole printed text of the play, e.g. '#35 (Chinese text)' = '#35 \{player\} dunk, made'. |
#' | ft_number | integer | Which free throw of the trip this is (1, 2 or 3), from (Chinese text); null on every other play. |
#' | ft_awarded | integer | Free throws awarded in the trip (1, 2 or 3) from (Chinese text); set only on the FIRST free throw's row, null otherwise. |
#' | points | integer | Points scored by the play from the '+2' / '+3' / '+1' tag; null when the tag is a bare '+'. |
#' | score_away | integer | Away score after the play, from the 'A - H' cell (AWAY first, unlike the box); null on plays that print no score (substitutions, rebounds, jump balls). |
#' | score_home | integer | Home score after the play, from the 'A - H' cell; null when the play prints no score. |
#' | x | double | Shot / play x: PERCENT (0-100) of the court LENGTH in the PHYSICAL court frame (not normalised per team): baskets near x = 5 and x = 95, teams swap ends at half-time. The Preciser shot list uses a home-attacks-95 frame: x_vendor = 100 - x in the halves where the home team attacks x < 50. Null on plays without a location. Court 28.75 m long. |
#' | y | double | Shot / play y: PERCENT (0-100) of the court WIDTH in the physical frame (baskets at y = 50); y_vendor = 100 - y in the halves where the home team attacks x < 50. Which sideline is y = 0 is unverified. Court 15.25 m wide. |
#' | nice_play | logical | True when the site stars the play (a nice_play row class and a starred clip). |
#' | video_uuid | character | Clip uuid (key space: the clip vendor tryspot); null on plays without a clip (about 3 in 4). The clip urls are never kept: they carry a vendor access key. |
#' | synergy_play_id | character | Synergy Sports play uuid of the clip (the site links Synergy); a string on every one of the 50,862 clips in the corpus. |
#' | video_stat_category | character | The clip's own stat label (ast, blk, ft_made, ft_miss, pfoul, reb_d, reb_o, stl, three_made, three_miss, timeout, turnover, two_made, two_miss): it names the PLAY the clip shows, not always this row's action (a rebound row carries the missed shot's clip). |
#' | tryspot_player_id | integer | Player id in the clip vendor's key space (an integer such as 59476); NOT the box player_id. |
#' | video_created_at | character | When the clip was created, UTC ISO 8601 with milliseconds. |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_pbp(gid = 197))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_pbp <- function(gid) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("pbp", list(gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Standings**
#' @description
#' Regular-season standings of one season: record, scoring averages, home / away and recent form.
#'
#' Endpoint: `GET https://pleagueofficial.com/standings/{season slug}`
#' @param season Required. Season END year (2025 = the site's slug '2024-25'). The slug is '<season - 1>-<the last
#'   two digits of season>'. The first season is 2020-21 (`season=2021`); earlier slugs redirect.
#' @return
#' A `hoopR_data` tibble: Regular-season standings of one season: record, scoring averages, home / away and recent
#'   form. An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2025 = the site's slug '2024-25'): the first year of the slug plus one. |
#' | season_slug | character | The site's season slug as printed: the START year, then the END year's last two digits ('2024-25'). |
#' | rank | integer | Rank on the page (1 = best); ties are not shared. |
#' | team_id | integer | P. LEAGUE+ club id on the site (stable across seasons AND renames): 1 = Taipei Fubon Braves, 2 = Taoyuan Pauian Pilots, 3 = Hsinchu Jko / Toplus Lioneers, 4 = Formosa Taishin Dreamers, 5 = Kaohsiung 17LIVE Steelers, 6 = New Taipei Kings, 7 = TSG Ghosthawks, 8 = Yankey Ark. NOT a Preciser team uuid (that joins through the standings team_uuid). |
#' | team_zh | character | Team short name in Traditional Chinese. |
#' | team_uuid | character | Preciser team uuid cut from the logo url (photonew.preciser.io/plg/teams/\{uuid\}.png): the join between the site team_id and the vendor's home_id / away_id / team_id. Clubs: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
#' | team_logo | character | Team logo url (photonew.preciser.io/plg/teams/\{team uuid\}.png). |
#' | games_played | integer | Games played ((Chinese text) GP). |
#' | wins | integer | Games won so far this season ((Chinese text) W). |
#' | losses | integer | Games lost so far this season ((Chinese text) L). |
#' | win_pct | double | Win percentage 0-100 as a whole percent ('68 percent' -> 68.0; (Chinese text) PCT). |
#' | games_behind | double | Games behind the leader ((Chinese text)). |
#' | points_for_avg | double | Points scored per game ((Chinese text)). |
#' | points_against_avg | double | Points allowed per game ((Chinese text)). |
#' | point_diff_avg | double | Average point margin ((Chinese text)). |
#' | home_record | character | Home record 'W-L' ((Chinese text)). |
#' | away_record | character | Away record 'W-L' ((Chinese text)). |
#' | streak | character | Current streak: W\{n\} wins or L\{n\} losses ((Chinese text)). |
#' | last_n | integer | Games in the 'last games' column ((Chinese text)10(Chinese text) = the last 10), read from the header. |
#' | last_n_record | character | Record 'W-L' over the last last_n games ((Chinese text)N(Chinese text)). |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_standings(season = 2025))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_standings <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("standings", list(season = season), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Player Season Stats**
#' @description
#' Player season averages and totals of one season and stage: shooting, rebounds, assists and fouls.
#'
#' Endpoint: `GET https://pleagueofficial.com/stat-player/{season slug}/{stage_sn}`
#' @param season Required. Season END year (2025 = the site's slug '2024-25'). The slug is '<season - 1>-<the last
#'   two digits of season>'. The first season is 2020-21 (`season=2021`); earlier slugs redirect.
#' @param stage_sn Required. Stage select value of the player table: 2 = regular season, 3 = playoffs, 4 = finals.
#' @return
#' A `hoopR_data` tibble: Player season averages and totals of one season and stage: shooting, rebounds, assists
#'   and fouls. An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_stat_player`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2025 = the site's slug '2024-25'): the first year of the slug plus one. |
#' | season_slug | character | The site's season slug as printed: the START year, then the END year's last two digits ('2024-25'). |
#' | stage_sn | integer | Stage select value: 2 = regular season, 3 = playoffs, 4 = finals (echo of the request, checked against the page's selected option). |
#' | stage | character | Stage slug: pre-season ((Chinese text), exhibition games before the season), regular-season ((Chinese text)), playoffs ((Chinese text)) or finals ((Chinese text), the championship series). |
#' | player_page_id | character | The 8-character page id of /player/\{id\} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
#' | name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
#' | jersey | character | Shirt number as a string (the player's number in the latest game). |
#' | team_zh | character | Team name in Traditional Chinese as the page prints it (a traded player shows the current team). |
#' | games | integer | Games played ((Chinese text)). |
#' | minutes_avg | character | Minutes per game 'mm:ss' ((Chinese text)). |
#' | minutes_total | character | Total minutes 'mmm:ss' ((Chinese text)). |
#' | fg2_made_avg | double | Per-game average of 2-point makes ((Chinese text)). |
#' | fg2_made_total | integer | Season total of 2-point makes ((Chinese text)). |
#' | fg2_att_avg | double | Per-game average of 2-point attempts ((Chinese text)). |
#' | fg2_att_total | integer | Season total of 2-point attempts ((Chinese text)). |
#' | fg3_made_avg | double | Per-game average of 3-point makes ((Chinese text)). |
#' | fg3_made_total | integer | Season total of 3-point makes ((Chinese text)). |
#' | fg3_att_avg | double | Per-game average of 3-point attempts ((Chinese text)). |
#' | fg3_att_total | integer | Season total of 3-point attempts ((Chinese text)). |
#' | ft_made_avg | double | Per-game average of free-throw makes ((Chinese text)). |
#' | ft_made_total | integer | Season total of free-throw makes ((Chinese text)). |
#' | ft_att_avg | double | Per-game average of free-throw attempts ((Chinese text)). |
#' | ft_att_total | integer | Season total of free-throw attempts ((Chinese text)). |
#' | points_avg | double | Per-game average of points ((Chinese text)). |
#' | points_total | integer | Season total of points ((Chinese text)). |
#' | reb_off_avg | double | Per-game average of offensive rebounds ((Chinese text)). |
#' | reb_off_total | integer | Season total of offensive rebounds ((Chinese text)). |
#' | reb_def_avg | double | Per-game average of defensive rebounds ((Chinese text)). |
#' | reb_def_total | integer | Season total of defensive rebounds ((Chinese text)). |
#' | reb_avg | double | Per-game average of total rebounds ((Chinese text)). |
#' | reb_total | integer | Season total of total rebounds ((Chinese text)). |
#' | ast_avg | double | Per-game average of assists ((Chinese text)). |
#' | ast_total | integer | Season total of assists ((Chinese text)). |
#' | stl_avg | double | Per-game average of steals ((Chinese text)). |
#' | stl_total | integer | Season total of steals ((Chinese text)). |
#' | blk_avg | double | Per-game average of blocks ((Chinese text)). |
#' | blk_total | integer | Season total of blocks ((Chinese text)). |
#' | tov_avg | double | Per-game average of turnovers ((Chinese text)). |
#' | tov_total | integer | Season total of turnovers ((Chinese text)). |
#' | pf_avg | double | Per-game average of personal fouls ((Chinese text)). |
#' | pf_total | integer | Season total of personal fouls ((Chinese text)). |
#' | fg2_pct | double | 2-point percentage 0-100 ((Chinese text); the cell holds the same value as average and total). |
#' | fg3_pct | double | 3-point percentage 0-100 ((Chinese text); same value as average and total). |
#' | ft_pct | double | Free-throw percentage 0-100 ((Chinese text); same value as average and total). |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_stat_player(season = 2025, stage_sn = 2))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_stat_player <- function(season, stage_sn) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("stat_player", list(season = season, stage_sn = stage_sn), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Player**
#' @description
#' One player's profile: names, club, jersey, position, height, weight and birthplace.
#'
#' Endpoint: `GET https://pleagueofficial.com/player/{player_page_id}`
#' @param player_page_id Required. The 8-character page id of /player/\{id\} (e.g. '1JbPozLB' = Lai Ting-En);
#'   `player_page_id` in pleague_stat_player, `random_id` in pleague_box_players from 2022-23 (unreliable before).
#' @return
#' A `hoopR_data` tibble: One player's profile: names, club, jersey, position, height, weight and birthplace. An
#'   empty valid answer is a zero-row tibble with these columns, in this order (sdv-py `pleague_player`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_page_id | character | The 8-character page id of /player/\{id\} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
#' | player_id | integer | P. LEAGUE+ player-team membership id (the box player_id), read from the page's trackPlayer() call, e.g. 40 = Lai Ting-En. NOT the 8-character page id. |
#' | name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
#' | name_en | character | Player name in Latin letters. |
#' | team_zh | character | Current team's short name in Traditional Chinese. |
#' | team_en | character | Current team's English name. |
#' | jersey | character | Shirt number as printed, a string ('0', '00' and '10' differ). |
#' | position | character | Position letter: G guard, F forward, C centre. |
#' | nickname | character | Nickname ((Chinese text)); null when blank. |
#' | tenure | character | Years of service ((Chinese text)) as the page prints it, with a prime character ('0''). |
#' | height_cm | double | Height in centimetres ((Chinese text)). |
#' | weight_kg | double | Weight in kilograms ((Chinese text)). |
#' | birthplace_zh | character | Birthplace in Traditional Chinese ((Chinese text); a country for foreign players). The date of birth is dropped on purpose. |
#' | status_zh | character | Player status ((Chinese text)): (Chinese text) = import (foreign player), (Chinese text) = local (Taiwanese) player. |
#' | education | character | Education lines ((Chinese text)) as printed, joined with '; '. |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_player(player_page_id = "1JbPozLB"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_player <- function(player_page_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("player", list(player_page_id = player_page_id), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Player Seasons**
#' @description
#' One player's season totals and per-game averages, league and East Asia Super League, with a career row.
#'
#' Endpoint: `GET https://pleagueofficial.com/player/{player_page_id}`
#' @param player_page_id Required. The 8-character page id of /player/\{id\} (e.g. '1JbPozLB' = Lai Ting-En);
#'   `player_page_id` in pleague_stat_player, `random_id` in pleague_box_players from 2022-23 (unreliable before).
#' @return
#' A `hoopR_data` tibble: One player's season totals and per-game averages, league and East Asia Super League, with
#'   a career row. An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_player_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_page_id | character | The 8-character page id of /player/\{id\} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
#' | competition | character | Table block: plg (the league's tables) or easl (the East Asia Super League block, present only for players with games there). |
#' | table | character | totals (the (Chinese text) table: season totals) or averages (the (Chinese text) table: per game). |
#' | season | integer | Season END year of the slug; null on the career row. |
#' | season_slug | character | Season slug as printed ('2025-26'), or 'career' for the final totals / averages row. |
#' | games | integer | Games played ((Chinese text)). |
#' | minutes | character | Minutes 'mm:ss' (a season total in the totals table, a per-game average in the averages table). |
#' | points | double | Points (total in the totals table, per game in the averages table; (Chinese text)). |
#' | reb | double | Rebounds (total / per game; (Chinese text)). |
#' | ast | double | Assists (total / per game; (Chinese text)). |
#' | stl | double | Steals (total / per game; (Chinese text)). |
#' | blk | double | Blocks (total / per game; (Chinese text)). |
#' | tov | double | Turnovers (total / per game; (Chinese text)). |
#' | pf | double | Personal fouls (total / per game; (Chinese text)). |
#' | fg2_made | double | 2-point makes: the first number of the page's '56 - 103' cell (total / per game). |
#' | fg2_att | double | 2-point attempts: the second number of the cell. |
#' | fg2_pct | double | 2-point percentage 0-100 ('54.4 percent' -> 54.4). |
#' | fg3_made | double | 3-point makes (total / per game). |
#' | fg3_att | double | 3-point attempts (total / per game). |
#' | fg3_pct | double | 3-point percentage 0-100. |
#' | ft_made | double | Free-throw makes (total / per game). |
#' | ft_att | double | Free-throw attempts (total / per game). |
#' | ft_pct | double | Free-throw percentage 0-100. |
#' @inherit pleague_schedule details
#' @examples
#' \donttest{
#'   try(pleague_player_seasons(player_page_id = "1JbPozLB"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_player_seasons <- function(player_page_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("player_seasons", list(player_page_id = player_page_id), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Preciser Shots**
#' @description
#' Every field-goal attempt of one finished game with court x / y (vendor frame), zone, style and result.
#'
#' Endpoint: `GET https://api.preciser.io/v1/chart-data/id/{uuid}`
#' @param uuid Required. The Preciser game uuid the site's game page embeds (`uuid` of pleague_game; empty before
#'   2022-23, which have no vendor data), e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).
#' @param gid Optional. The site's game id for this uuid. When given the runtime also fetches the site's game page
#'   and box (cached) and checks the vendor body against them (uuid, final score, made shots, roster and minutes);
#'   the uuid must be the game page's. Without it only the checks the body allows by itself run.
#' @return
#' A `hoopR_data` tibble: Every field-goal attempt of one finished game with court x / y (vendor frame), zone,
#'   style and result. An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_preciser_shots`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
#' | shot_no | integer | 1-based position in the order the vendor sent the shots, which is NOT guaranteed game order: sort on period and seconds_left. |
#' | period | integer | Period number: 1-4, 5 and up for overtime (OT1 = 5). |
#' | period_label | character | Period label: Q1-Q4, then OT1, OT2. |
#' | clock | character | Game clock REMAINING in the period 'mm:ss' (counts down). |
#' | seconds_left | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
#' | side | character | Which team took the shot: home or away, from the shooter's team uuid against home_id / away_id. |
#' | team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
#' | person_id | character | Preciser person uuid (key space: the vendor's persons): equal to the site box person_id of the same player, the join between this row and pleague_box_players (2022-23 on). |
#' | player_name | character | Shooter's name as printed (Traditional Chinese or a transliteration); equals the box name_zh. |
#' | type | character | Shot value: 2pt or 3pt. |
#' | subtype | character | Shot style: jumpShot, layup, drivingLayup, floatingJumpShot (floater), tipIn (putback), pullUpJumpShot, fadeAway, dunk, turnAroundJumpShot, hookShot, stepBackJumpShot, alleyOop; null on a few shots (7 of 2,566). |
#' | area | character | Shot zone, English label '\{side\} \{distance band\}': 'Center 8ft' (restricted-area band, within 8 ft), 'Center 8-16ft', 'Left 8-16ft', 'Right 8-16ft', 'Left 16-23ft', 'Center 16-23ft', 'Right 16-23ft', 'Left Center 16-23ft', ... and the three-point zones; null on some shots. |
#' | success | logical | True when the shot was made, false when missed. |
#' | x | double | Shot x: PERCENT (0-100) of the court LENGTH in the VENDOR frame, in which the HOME team always attacks the basket at x = 95 and the away team the basket at x = 5 (the frame does not flip at half-time). x_vendor = 100 - x_pbp in the halves where the home team attacks x < 50 (pleague_pbp.x is the physical frame). Court 28.75 m long: distance = hypot((x - 5) x 0.2875, (y - 50) x 0.1525) m (mean error 0.010 m on 1,893 shots). |
#' | y | double | Shot y: PERCENT (0-100) of the court WIDTH in the vendor frame (baskets at y = 50); y_vendor = 100 - y_pbp in the halves where the home team attacks x < 50 (held for 166 of the 168 shots of gid 197 matched to the play-by-play; one shot differs in y only). Which sideline is y = 0 is unverified. Court 15.25 m wide. |
#' | message_zh | character | Play text in Traditional Chinese, '\{player\}((Chinese text))(Chinese text)((Chinese text))\{distance\}(Chinese text)\{shot\}' = '\{player\} made / missed a \{distance\} m \{shot\}'; the distance is in metres and matches x / y. |
#' | has_video | logical | True when the shot has a clip. The clip url is never kept: it carries a vendor access key. |
#' | home_team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
#' | away_team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
#' @details
#' * Unofficial use of a THIRD-PARTY host: api.preciser.io is the analytics vendor behind the P. LEAGUE+ game page,
#'   not the league's own API. It is keyless, CORS-open, has no robots.txt (404) and no terms were found; it serves
#'   the data the league's own game page displays. The league's /user-policy reserves its content, so payloads are
#'   not redistributed as release assets and a data release needs owner sign-off. Requests are spaced at least 1 s
#'   apart per host, retries included.
#' * Wrappers take the Preciser game uuid (the `uuid` column of [pleague_game()]; empty before 2022-23, which have
#'   no vendor data). Pass the optional `gid` to verify the body against the site's game page and box: the shot
#'   list and the rotation echo nothing about the game, so only then are the uuid, the final score, the made-shot
#'   counts, the roster and the court time (rotation minutes within 30 s of the box) checked. An unknown uuid
#'   answers 200 `[]` (`hoopR_no_data`) or HTTP 500 (`hoopR_asset_fetch`, not retried).
#' * Id key spaces: the vendor names teams by uuid (`team_uuid` / `home_team_uuid` / `away_team_uuid`) and persons
#'   by `person_id` (the same value as the site box row's `person_id`); the site's `team_id` (1-8) joins to a team
#'   uuid through [pleague_team_crosswalk()] (the standings logo file name).
#' * Shot x / y are in the VENDOR frame (percent of the court, the home team always attacks x = 95) while the
#'   site's play-by-play x / y are in the physical court frame (teams swap ends at half-time): x_vendor = 100 -
#'   x_pbp and y_vendor = 100 - y_pbp in the halves where the home team attacks x < 50. The court is 28.75 x 15.25
#'   m. Clip urls carry a vendor access key (?key=): it is scrubbed from every body, a body that still holds one is
#'   refused, and no frame keeps a url.
#' * Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, a body of `[]`, empty
#'   rotation lists), `hoopR_bad_request` (a uuid that is not a uuid, a `gid` that is not an integer, HTTP 400 /
#'   422) and `hoopR_asset_fetch` (any other failed or wrong answer, including a `gid` whose game has another uuid
#'   and a redirect off the vendor host). HTTP 429 / 502 / 503 / 504 are retried, up to three attempts.
#' @examples
#' \donttest{
#'   try(pleague_preciser_shots(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_preciser_shots <- function(uuid, gid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("preciser_shots", list(uuid = uuid, gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Preciser Summary Teams**
#' @description
#' Post-game team comparison of one finished game: totals, situational points, lead tracker and top performer.
#'
#' Endpoint: `GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`
#' @param uuid Required. The Preciser game uuid the site's game page embeds (`uuid` of pleague_game; empty before
#'   2022-23, which have no vendor data), e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).
#' @param gid Optional. The site's game id for this uuid. When given the runtime also fetches the site's game page
#'   and box (cached) and checks the vendor body against them (uuid, final score, made shots, roster and minutes);
#'   the uuid must be the game page's. Without it only the checks the body allows by itself run.
#' @return
#' A `hoopR_data` tibble: Post-game team comparison of one finished game: totals, situational points, lead tracker
#'   and top performer. An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_preciser_summary_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
#' | side | character | Which team the row belongs to: home or away. |
#' | team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
#' | team_name_zh | character | Team full name in Traditional Chinese ((Chinese text) = Taipei Fubon Braves, (Chinese text) = Taoyuan Pauian Pilots, (Chinese text) = Hsinchu Toplus Lioneers, (Chinese text) = Formosa Dreamers, (Chinese text) = Kaohsiung 17LIVE Steelers, (Chinese text) = New Taipei Kings, (Chinese text) = TSG Ghosthawks). |
#' | color | character | Team colour as a CSS hex string. |
#' | logo_url | character | Team logo url (photonew.preciser.io/plg/teams/\{team uuid\}.png). |
#' | points | integer | Team points (the comparison block). |
#' | rebounds | integer | Team total rebounds (the comparison block). |
#' | assists | integer | Team assists (the comparison block). |
#' | steals | integer | Team steals (the comparison block). |
#' | blocks | integer | Team blocks made (the comparison block). |
#' | turnovers | integer | Team turnovers. |
#' | fg_made | integer | Team field goals MADE: the vendor's key is field_goal_percentage but the value is a count of makes. |
#' | fg2_pct | double | Team 2-point percentage 0-100. |
#' | fg3_pct | double | Team 3-point percentage 0-100. |
#' | ft_pct | double | Team free-throw percentage 0-100. |
#' | fast_break_points | double | Team fast-break points. |
#' | paint_points | double | Team points in the paint. |
#' | second_chance_points | double | Team second-chance points. |
#' | biggest_lead | integer | The team's largest lead in points. |
#' | biggest_scoring_run | integer | The team's longest unanswered scoring run, in points. |
#' | time_leading_seconds | integer | Seconds the team led. |
#' | lead_changes | integer | Number of lead changes in the game (the same for both rows). |
#' | top_player_name | character | Name of the team's top performer (Traditional Chinese or a transliteration). |
#' | top_player_jersey | character | Shirt number of the top performer as a string. |
#' | top_player_points | integer | Points of the top performer in the game. |
#' | top_player_rebounds | integer | Total rebounds of the top performer in the game. |
#' | top_player_assists | integer | Assists of the top performer in the game. |
#' @inherit pleague_preciser_shots details
#' @examples
#' \donttest{
#'   try(pleague_preciser_summary_teams(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_preciser_summary_teams <- function(uuid, gid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("preciser_summary_teams", list(uuid = uuid, gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Preciser Score Log**
#' @description
#' Scoring log of one finished game (scoring events only, with the running score).
#'
#' Endpoint: `GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`
#' @param uuid Required. The Preciser game uuid the site's game page embeds (`uuid` of pleague_game; empty before
#'   2022-23, which have no vendor data), e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).
#' @param gid Optional. The site's game id for this uuid. When given the runtime also fetches the site's game page
#'   and box (cached) and checks the vendor body against them (uuid, final score, made shots, roster and minutes);
#'   the uuid must be the game page's. Without it only the checks the body allows by itself run.
#' @return
#' A `hoopR_data` tibble: Scoring log of one finished game (scoring events only, with the running score). An empty
#'   valid answer is a zero-row tibble with these columns, in this order (sdv-py `pleague_preciser_score_log`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
#' | seq | integer | 1-based position of the scoring event in game order. |
#' | period | character | Period label: Q1-Q4, then OT1, OT2 (the vendor sends it in lower case). |
#' | period_no | integer | 1-based position of the period: 1-4 for Q1-Q4, 5 for OT1, 6 for OT2. |
#' | clock | character | Game clock REMAINING in the period 'mm:ss' (counts down). |
#' | seconds_left | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
#' | home_score | integer | Home score after the event. |
#' | away_score | integer | Away score after the event. |
#' @inherit pleague_preciser_shots details
#' @examples
#' \donttest{
#'   try(pleague_preciser_score_log(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_preciser_score_log <- function(uuid, gid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("preciser_score_log", list(uuid = uuid, gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Preciser Lead Flow**
#' @description
#' Score at each minute mark of one finished game, with the score difference (the lead tracker).
#'
#' Endpoint: `GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`
#' @param uuid Required. The Preciser game uuid the site's game page embeds (`uuid` of pleague_game; empty before
#'   2022-23, which have no vendor data), e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).
#' @param gid Optional. The site's game id for this uuid. When given the runtime also fetches the site's game page
#'   and box (cached) and checks the vendor body against them (uuid, final score, made shots, roster and minutes);
#'   the uuid must be the game page's. Without it only the checks the body allows by itself run.
#' @return
#' A `hoopR_data` tibble: Score at each minute mark of one finished game, with the score difference (the lead
#'   tracker). An empty valid answer is a zero-row tibble with these columns, in this order (sdv-py
#'   `pleague_preciser_lead_flow`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
#' | seq | integer | 1-based position of the minute mark in game order. |
#' | period | character | Period label: Q1-Q4, then OT1, OT2 (the vendor sends it in lower case). |
#' | period_no | integer | 1-based position of the period: 1-4 for Q1-Q4, 5 for OT1, 6 for OT2. |
#' | clock | character | Game clock REMAINING in the period 'mm:ss' (counts down). |
#' | seconds_left | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
#' | home_score | integer | Home score after the event. |
#' | away_score | integer | Away score after the event. |
#' | score_difference | integer | home_score minus away_score (positive = home leads). |
#' @inherit pleague_preciser_shots details
#' @examples
#' \donttest{
#'   try(pleague_preciser_lead_flow(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_preciser_lead_flow <- function(uuid, gid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("preciser_lead_flow", list(uuid = uuid, gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Preciser Win Probability**
#' @description
#' The vendor's home-team win probability by minute for one finished game.
#'
#' Endpoint: `GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`
#' @param uuid Required. The Preciser game uuid the site's game page embeds (`uuid` of pleague_game; empty before
#'   2022-23, which have no vendor data), e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).
#' @param gid Optional. The site's game id for this uuid. When given the runtime also fetches the site's game page
#'   and box (cached) and checks the vendor body against them (uuid, final score, made shots, roster and minutes);
#'   the uuid must be the game page's. Without it only the checks the body allows by itself run.
#' @return
#' A `hoopR_data` tibble: The vendor's home-team win probability by minute for one finished game. An empty valid
#'   answer is a zero-row tibble with these columns, in this order (sdv-py `pleague_preciser_win_probability`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
#' | minute | integer | Minute mark: 0 is the tip-off (50 percent); 49 entries for a 48-minute game. |
#' | home_win_pct | double | The home team's win probability in percent (0-100) at that minute; the vendor documents no method. |
#' @inherit pleague_preciser_shots details
#' @examples
#' \donttest{
#'   try(pleague_preciser_win_probability(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_preciser_win_probability <- function(uuid, gid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("preciser_win_probability", list(uuid = uuid, gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Preciser Rotation**
#' @description
#' On-court stints of every player of one finished game (the rotation chart).
#'
#' Endpoint: `GET https://api.preciser.io/game/rotation/chart/o/plg/gameId/{uuid}`
#' @param uuid Required. The Preciser game uuid the site's game page embeds (`uuid` of pleague_game; empty before
#'   2022-23, which have no vendor data), e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).
#' @param gid Optional. The site's game id for this uuid. When given the runtime also fetches the site's game page
#'   and box (cached) and checks the vendor body against them (uuid, final score, made shots, roster and minutes);
#'   the uuid must be the game page's. Without it only the checks the body allows by itself run.
#' @return
#' A `hoopR_data` tibble: On-court stints of every player of one finished game (the rotation chart). An empty valid
#'   answer is a zero-row tibble with these columns, in this order (sdv-py `pleague_preciser_rotation`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
#' | side | character | Which team the row belongs to: home or away. |
#' | name_zh | character | Player name (Traditional Chinese); equals the site box name_zh, which is how the runtime checks the roster. |
#' | jersey | integer | Shirt number (an integer here; the box prints it as a string). |
#' | started | logical | True when the player started the game. |
#' | stint_no | integer | 1-based position of the stint among the player's stints, in game order. |
#' | start_period | character | Period in which the stint starts (Q1-Q4, OT1, ...). |
#' | start_clock | character | Clock REMAINING in start_period when the stint starts, 'm:ss'. |
#' | start_seconds | integer | Seconds elapsed on the game clock when the stint starts (cumulative across periods). |
#' | end_period | character | Period in which the stint ends. |
#' | end_clock | character | Clock REMAINING in end_period when the stint ends, 'm:ss'. |
#' | end_seconds | integer | Seconds elapsed on the game clock when the stint ends (cumulative across periods). |
#' @inherit pleague_preciser_shots details
#' @examples
#' \donttest{
#'   try(pleague_preciser_rotation(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_preciser_rotation <- function(uuid, gid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("preciser_rotation", list(uuid = uuid, gid = gid), call = rlang::current_env())
}

#' @title
#' **Get P. LEAGUE+ Preciser Injury Report**
#' @description
#' Injury report of one finished game: one row per team.
#'
#' Endpoint: `GET https://api.preciser.io/game/injury/list/o/plg/gameId/{uuid}`
#' @param uuid Required. The Preciser game uuid the site's game page embeds (`uuid` of pleague_game; empty before
#'   2022-23, which have no vendor data), e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).
#' @param gid Optional. The site's game id for this uuid. When given the runtime also fetches the site's game page
#'   and box (cached) and checks the vendor body against them (uuid, final score, made shots, roster and minutes);
#'   the uuid must be the game page's. Without it only the checks the body allows by itself run.
#' @return
#' A `hoopR_data` tibble: Injury report of one finished game: one row per team. An empty valid answer is a zero-row
#'   tibble with these columns, in this order (sdv-py `pleague_preciser_injury`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
#' | side | character | Which team the row belongs to: home or away. |
#' | team_uuid | character | Preciser team uuid (key space: the vendor's teams; the file name of the club logo). Joins the site team_id through pleague_standings.team_uuid: 1 = e86394aa-3d88-11ed-8ba8-7f44ba46b0b1 ((Chinese text), Taipei Fubon Braves); 2 = e865bb20-3d88-11ed-a956-7f44ba46b0b1 ((Chinese text), Taoyuan Pauian Pilots (Taoyuan Pilots from 2024-25)); 3 = e8674343-3d88-11ed-98b4-7f44ba46b0b1 ((Chinese text), Hsinchu Jko Lioneers (Toplus Lioneers from 2023-24)); 4 = e869743f-3d88-11ed-925e-7f44ba46b0b1 ((Chinese text), Formosa Taishin Dreamers (Formosa Dreamers from 2022-23)); 5 = e86cac11-3d88-11ed-8637-7f44ba46b0b1 ((Chinese text), Kaohsiung 17LIVE Steelers); 6 = e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1 ((Chinese text), New Taipei Kings); 7 = 3c3a601a-358a-11ed-ab92-711c34ed1298 ((Chinese text), TSG Ghosthawks); 8 = bf957f5a-9389-11f0-812c-a38482ec4d30 ((Chinese text), Yankey Ark). |
#' | team_name_zh | character | Team short name in Traditional Chinese ('(Chinese text)' = Lioneers). |
#' | team_name_en | character | Team short English name ('Lioneers'). |
#' | color | character | Team colour as a CSS hex string. |
#' | logo_url | character | Team logo url (photonew.preciser.io/plg/teams/\{team uuid\}.png). |
#' | injury_report | character | The team's injury report as a JSON string; null when the vendor sent null. It was null on all 16 sampled games, so its shape is unverified. |
#' @inherit pleague_preciser_shots details
#' @examples
#' \donttest{
#'   try(pleague_preciser_injury(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_preciser_injury <- function(uuid, gid = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("preciser_injury", list(uuid = uuid, gid = gid), call = rlang::current_env())
}

#' @title
#' **Get the P. LEAGUE+ Team Crosswalk**
#' @description
#' P. LEAGUE+ site `team_id` (1-8) to Preciser team uuid, for every club ever listed. The site's `team_id` is
#'   stable across seasons and renames; the vendor keys teams by uuid (`team_uuid` / `home_team_uuid` /
#'   `away_team_uuid` of the `pleague_preciser_*()` frames). Persons need no table: the Preciser `person_id` is the
#'   site box row's `person_id`. A constant table: no request is made.
#' @return
#' A `hoopR_data` tibble of eight rows (sdv-py `pleague_team_crosswalk`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | P. LEAGUE+ site team id (1-8), stable across seasons and renames. |
#' | team_uuid | character | Preciser team uuid of the same club (team_uuid of the pleague_preciser frames). |
#' @examples
#' \donttest{
#'   pleague_team_crosswalk()
#' }
#' @export
#' @family P. LEAGUE+ Functions
pleague_team_crosswalk <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  out <- dplyr::tibble(team_id = as.integer(names(.PLEAGUE_TEAMS)), team_uuid = unname(.PLEAGUE_TEAMS))
  make_hoopR_data(out, "P. LEAGUE+ Team Crosswalk", Sys.time())
}
