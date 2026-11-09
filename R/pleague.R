# pleague.R -- P. LEAGUE+ (Taiwan) wrappers over pleagueofficial.com and the third-party vendor
# api.preciser.io, at parity with sportsdataverse-py sportsdataverse/basketball/plg (origin/main e3d232e): 11 site
# wrappers, 7 vendor wrappers and the team crosswalk. Runtime, refusals and frames: R/pleague_utils.R.
# Generated from tools/codegen/endpoints/pleague{,_preciser}.yaml and manual_column_descriptions.yaml of
# that sportsdataverse-py commit (ASCII only: Chinese text is glossed as '(Chinese text)').

# The @details of every pleague topic that shares the pleague_schedule() notes (roxygen @eval .intl_details()).
.pleague_schedule_details <- c(
  "* Unofficial use of a public source: these wrappers read pleagueofficial.com (P. LEAGUE+, Taiwan's men's",
  "  league), keyless. The site's /user-policy (members' terms, section 11) reserves all content on the site to the",
  "  service and its rights holders and forbids use, copying, adaptation or distribution without authorisation (it",
  "  says nothing about automated access); robots.txt holds only Cloudflare content-signal comment lines with no",
  "  Allow, Disallow or Crawl-delay rule. Use for reference only, and check the terms before you republish the data.",
  "  Requests are spaced at least 1 s apart per host, retries included.",
  "* Access: the site sits behind Cloudflare. sportsdataverse-py fetches it with curl_cffi (Chrome TLS); this R port sends a",
  "  browser User-Agent through libcurl, which was served on a live check (2026-10-18); Cloudflare may still answer",
  "  a request with an HTTP 403 challenge page (`hoopR_asset_fetch`). Redirects are not followed: the site answers",
  "  an unknown `gid` or a season before 2020-21 with a 302 to the home page (`hoopR_no_data`).",
  "* Coverage: schedules, standings and player tables from 2020-21 (`season = 2021`); box scores for every finished",
  "  game from 2020-21; play-by-play (with shot x / y) from 2022-23 (gid 191 on). 2020-21 and 2021-22 pages embed",
  "  an empty game uuid, so they have no play-by-play and no Preciser data (`hoopR_no_data`). A game is keyed by",
  "  `gid`: ONE global integer sequence over every stage and season. Only finished games are served: an unplayed",
  "  game, or a box or play-by-play that does not match its game page (the routes echo no id, so the game page is",
  "  fetched first, cached for the session, and the body's scores, quarters and points are checked against it),",
  "  raises `hoopR_asset_fetch`.",
  "* Seasons are END years (2025 = the site's slug '2024-25'). Text is Traditional Chinese as printed (names,",
  "  venues, play-by-play phrases); the column descriptions gloss it in English. Ids: `team_id` (1-8) is stable",
  "  across renames; the box `player_id` is the player-team membership. The box `random_id` is UNRELIABLE before",
  "  2022-23 (gid 13 gives one player another player's page id): join box rows on `player_id`, and box rows to",
  "  Preciser shots on `person_id`, never on `random_id`. The date of birth is dropped from the player frame;",
  "  officials appear by name only.",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, a redirect, a stage",
  "  the season does not have, a game with no play-by-play, a season before 2020-21), `hoopR_bad_request` (an",
  "  invalid argument, HTTP 400 / 422) and `hoopR_asset_fetch` (any other non-200, a dead connection, an empty or",
  "  unreadable body, a page for another game, season, stage or player, an unfinished game, layout drift, a",
  "  play-by-play phrase outside the observed vocabulary). HTTP 429 / 502 / 503 / 504 are retried, up to three",
  "  attempts; HTTP 500 is NOT retried (the site answers 500 for an unknown id). Wrappers raise; they never warn",
  "  and return empty."
)

#' @title
#' **Get P. LEAGUE+ Schedule**
#' @description
#' Schedule and results of one season and stage (pre-season, regular season, playoffs or finals): one row per game,
#'   away team first.
#'
#' Endpoint: `GET https://pleagueofficial.com/schedule-{stage}/{season slug}`
#' @param season Required. Season END year (2025 = the site's slug '2024-25'). The slug is `<season - 1>-<yy>` (yy: the last
#'   two digits of season). The first season is 2020-21 (`season=2021`); earlier slugs redirect.
#' @param stage Stage: pre-season ((Chinese text), exhibition games), regular-season ((Chinese text)), playoffs
#'   ((Chinese text)) or finals ((Chinese text)). A stage a season does not have (2025-26 pre-season) answers
#'   hoopR_no_data.
#' @eval .returns_rd("pleague_schedule", inline = FALSE, unit = "game")
#' @eval .intl_details(.pleague_schedule_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(pleague_schedule(season = 2025))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_game", inline = FALSE, unit = "game")
#' @eval .intl_details(.pleague_schedule_details)
#' @examples
#' \donttest{
#'   try(pleague_game(gid = 197))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_periods", inline = FALSE, unit = "period")
#' @eval .intl_details(.pleague_schedule_details)
#' @examples
#' \donttest{
#'   try(pleague_periods(gid = 197))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_officials", inline = FALSE, unit = "official")
#' @eval .intl_details(.pleague_schedule_details, "pleague_officials(gid = 197)")
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_box_players", inline = FALSE, unit = "player in the game")
#' @eval .intl_details(.pleague_schedule_details)
#' @examples
#' \donttest{
#'   try(pleague_box_players(gid = 197))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_box_teams", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.pleague_schedule_details)
#' @examples
#' \donttest{
#'   try(pleague_box_teams(gid = 197))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_pbp", inline = FALSE, unit = "play-by-play event")
#' @section Action codes:
#' Each code of `action`, its meaning and \[the number of plays\] in 258,183 plays of 404 finished 2022-23..2025-26 games (82 printed phrases plus the blank row):
#'
#' * `ast`: assist \[17,020\]
#' * `blk`: block \[3,181\]
#' * `fg2_alley_oop_made`: 2-point alley-oop, made \[205\]
#' * `fg2_alley_oop_missed`: 2-point alley-oop, missed \[81\]
#' * `fg2_driving_layup_made`: 2-point driving layup, made \[4,281\]
#' * `fg2_driving_layup_missed`: 2-point driving layup, missed \[3,961\]
#' * `fg2_dunk_made`: 2-point dunk, made \[1,316\]
#' * `fg2_dunk_missed`: 2-point dunk, missed \[162\]
#' * `fg2_fadeaway_jumper_made`: 2-point fadeaway jumper, made \[583\]
#' * `fg2_fadeaway_jumper_missed`: 2-point fadeaway jumper, missed \[1,121\]
#' * `fg2_floater_made`: 2-point floater, made \[1,920\]
#' * `fg2_floater_missed`: 2-point floater, missed \[3,052\]
#' * `fg2_hook_shot_made`: 2-point hook shot, made \[610\]
#' * `fg2_hook_shot_missed`: 2-point hook shot, missed \[773\]
#' * `fg2_jump_shot_made`: 2-point jump shot, made \[1,657\]
#' * `fg2_jump_shot_missed`: 2-point jump shot, missed \[3,606\]
#' * `fg2_layup_made`: 2-point layup, made \[4,428\]
#' * `fg2_layup_missed`: 2-point layup, missed \[3,403\]
#' * `fg2_pull_up_jumper_made`: 2-point pull-up jumper, made \[1,004\]
#' * `fg2_pull_up_jumper_missed`: 2-point pull-up jumper, missed \[1,564\]
#' * `fg2_putback_made`: 2-point putback / tip-in, made \[2,138\]
#' * `fg2_putback_missed`: 2-point putback / tip-in, missed \[1,539\]
#' * `fg2_step_back_shot_made`: 2-point step-back shot, made \[243\]
#' * `fg2_step_back_shot_missed`: 2-point step-back shot, missed \[410\]
#' * `fg2_turnaround_jumper_made`: 2-point turnaround jumper, made \[672\]
#' * `fg2_turnaround_jumper_missed`: 2-point turnaround jumper, missed \[1,158\]
#' * `fg3_fadeaway_jumper_made`: 3-point fadeaway jumper, made \[48\]
#' * `fg3_fadeaway_jumper_missed`: 3-point fadeaway jumper, missed \[92\]
#' * `fg3_made`: 3-point shot, style not recorded, made \[7,817\]
#' * `fg3_missed`: 3-point shot, style not recorded, missed \[17,046\]
#' * `fg3_pull_up_jumper_made`: 3-point pull-up jumper, made \[480\]
#' * `fg3_pull_up_jumper_missed`: 3-point pull-up jumper, missed \[922\]
#' * `fg3_step_back_shot_made`: 3-point step-back shot, made \[245\]
#' * `fg3_step_back_shot_missed`: 3-point step-back shot, missed \[559\]
#' * `fg3_turnaround_jumper_made`: 3-point turnaround jumper, made \[10\]
#' * `fg3_turnaround_jumper_missed`: 3-point turnaround jumper, missed \[23\]
#' * `fg_made`: field goal made, shot type and distance not recorded \[158\]
#' * `fg_missed`: field goal missed, shot type and distance not recorded \[168\]
#' * `foul`: foul, kind not recorded (team row) \[18\]
#' * `foul_bench_technical`: technical foul on the bench \[35\]
#' * `foul_coach_technical`: technical foul on the coach \[75\]
#' * `foul_disqualifying`: disqualifying foul \[2\]
#' * `foul_drawn`: foul drawn (the opponent's foul on this player) \[17,035\]
#' * `foul_offensive`: offensive foul committed \[1,024\]
#' * `foul_personal`: personal foul committed \[15,745\]
#' * `foul_technical`: technical foul \[210\]
#' * `foul_unsportsmanlike`: unsportsmanlike foul \[261\]
#' * `ft_made`: free throw 1 of 1 awarded, made \[1,326\]
#' * `ft_made`: free throw 1 of 3 awarded, made \[128\]
#' * `ft_made`: free throw 1 of 2 awarded, made \[5,187\]
#' * `ft_made`: free throw 3, made \[149\]
#' * `ft_made`: free throw 2, made \[5,798\]
#' * `ft_missed`: free throw 1 of 1 awarded, missed \[669\]
#' * `ft_missed`: free throw 1 of 3 awarded, missed \[67\]
#' * `ft_missed`: free throw 1 of 2 awarded, missed \[2,736\]
#' * `ft_missed`: free throw 3, missed \[46\]
#' * `ft_missed`: free throw 2, missed \[2,319\]
#' * `jump_ball_lost`: jump ball lost \[404\]
#' * `jump_ball_won`: jump ball won \[708\]
#' * `reb_def`: defensive rebound (a team rebound has no player) \[29,537\]
#' * `reb_off`: offensive rebound (a team rebound has no player) \[12,379\]
#' * `review_coach_challenge`: video review: coach's challenge (2025-26 onward; the printed text ends with a bare comma) \[videoReview, coachChallenge,, 82\]
#' * `review_instant_replay`: video review: instant-replay system, started by the officials (2025-26 onward) \[videoReview, instantReplaySystem,, 67\]
#' * `review_instant_replay_1`: video review: instant-replay system, variant printed with a trailing '1' (meaning unexplained; the row also prints the running score and the points tag '+videoReview') \[videoReview, instantReplaySystem, 1, 6\]
#' * `stl`: steal \[7,361\]
#' * `sub_in`: substitution: enters the game \[25,505\]
#' * `sub_out`: substitution: leaves the game \[25,532\]
#' * `timeout`: timeout (a team row) \[2,854\]
#' * `tov_3sec`: turnover: 3-second violation \[249\]
#' * `tov_5sec`: turnover: 5-second violation \[40\]
#' * `tov_8sec`: turnover: 8-second violation \[26\]
#' * `tov_backcourt`: turnover: backcourt violation \[96\]
#' * `tov_bad_pass`: turnover: bad pass \[6,325\]
#' * `tov_ball_handling`: turnover: ball-handling \[3,547\]
#' * `tov_carrying`: turnover: carrying the ball \[47\]
#' * `tov_double_dribble`: turnover: double dribble \[53\]
#' * `tov_offensive`: turnover: offensive (kind not recorded) \[1,007\]
#' * `tov_offensive_goaltending`: turnover: offensive goaltending \[4\]
#' * `tov_other`: turnover: other \[51\]
#' * `tov_out_of_bounds`: turnover: ball out of bounds \[441\]
#' * `tov_shot_clock`: turnover: shot-clock violation \[489\]
#' * `tov_travel`: turnover: travelling \[718\]
#' * `unlabelled`: row has a player but no action text; in the corpus a shot with x/y followed by a rebound, i.e. a missed shot (inferred) \[(blank), 169\]
#' @eval .intl_details(.pleague_schedule_details)
#' @examples
#' \donttest{
#'   try(pleague_pbp(gid = 197))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @param season Required. Season END year (2025 = the site's slug '2024-25'). The slug is `<season - 1>-<yy>` (yy: the last
#'   two digits of season). The first season is 2020-21 (`season=2021`); earlier slugs redirect.
#' @eval .returns_rd("pleague_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.pleague_schedule_details)
#' @examples
#' \donttest{
#'   try(pleague_standings(season = 2025))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @param season Required. Season END year (2025 = the site's slug '2024-25'). The slug is `<season - 1>-<yy>` (yy: the last
#'   two digits of season). The first season is 2020-21 (`season=2021`); earlier slugs redirect.
#' @param stage_sn Required. Stage select value of the player table: 2 = regular season, 3 = playoffs, 4 = finals.
#' @eval .returns_rd("pleague_stat_player", inline = FALSE, unit = "player")
#' @eval .intl_details(.pleague_schedule_details)
#' @examples
#' \donttest{
#'   try(pleague_stat_player(season = 2025, stage_sn = 2))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_player", inline = FALSE, unit = "player")
#' @eval .intl_details(.pleague_schedule_details, 'pleague_player(player_page_id = "1JbPozLB")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_player_seasons", inline = FALSE, unit = "player-season")
#' @eval .intl_details(.pleague_schedule_details, 'pleague_player_seasons(player_page_id = "1JbPozLB")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
pleague_player_seasons <- function(player_page_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .pleague_run("player_seasons", list(player_page_id = player_page_id), call = rlang::current_env())
}

# The @details of every pleague topic that shares the pleague_preciser_shots() notes (roxygen @eval .intl_details()).
.pleague_preciser_shots_details <- c(
  "* Unofficial use of a THIRD-PARTY host: api.preciser.io is the analytics vendor behind the P. LEAGUE+ game page,",
  "  not the league's own API. It is keyless, CORS-open, has no robots.txt (404) and no terms were found; it serves",
  "  the data the league's own game page displays. The league's /user-policy reserves its content, so check it",
  "  before you republish the data. Requests are spaced at least 1 s apart per host, retries included.",
  "* Wrappers take the Preciser game uuid (the `uuid` column of [pleague_game()]; empty before 2022-23, which have",
  "  no vendor data). Pass the optional `gid` to verify the body against the site's game page and box: the shot",
  "  list and the rotation echo nothing about the game, so only then are the uuid, the final score, the made-shot",
  "  counts, the roster and the court time (rotation minutes within 30 s of the box) checked. An unknown uuid",
  "  answers 200 `[]` (`hoopR_no_data`) or HTTP 500 (`hoopR_asset_fetch`, not retried).",
  "* Id key spaces: the vendor names teams by uuid (`team_uuid` / `home_team_uuid` / `away_team_uuid`) and persons",
  "  by `person_id` (the same value as the site box row's `person_id`); the site's `team_id` (1-8) joins to a team",
  "  uuid through [pleague_team_crosswalk()] (the standings logo file name).",
  "* Shot x / y are in the VENDOR frame (percent of the court, the home team always attacks x = 95) while the",
  "  site's play-by-play x / y are in the physical court frame (teams swap ends at half-time): x_vendor = 100 -",
  "  x_pbp and y_vendor = 100 - y_pbp in the halves where the home team attacks x < 50. The court is 28.75 x 15.25",
  "  m. Clip urls carry a vendor access key (?key=): it is scrubbed from every body, a body that still holds one is",
  "  refused, and no frame keeps a url.",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, a body of `[]`, empty",
  "  rotation lists), `hoopR_bad_request` (a uuid that is not a uuid, a `gid` that is not an integer, HTTP 400 /",
  "  422) and `hoopR_asset_fetch` (any other failed or wrong answer, including a `gid` whose game has another uuid",
  "  and a redirect off the vendor host). HTTP 429 / 502 / 503 / 504 are retried, up to three attempts."
)

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
#' @eval .returns_rd("pleague_preciser_shots", inline = FALSE, unit = "shot")
#' @eval .intl_details(.pleague_preciser_shots_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(pleague_preciser_shots(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf"))
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_preciser_summary_teams", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.pleague_preciser_shots_details, 'pleague_preciser_summary_teams(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_preciser_score_log", inline = FALSE, unit = "scoring event")
#' @eval .intl_details(.pleague_preciser_shots_details, 'pleague_preciser_score_log(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_preciser_lead_flow", inline = FALSE, unit = "minute mark")
#' @eval .intl_details(.pleague_preciser_shots_details, 'pleague_preciser_lead_flow(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_preciser_win_probability", inline = FALSE, unit = "minute")
#' @eval .intl_details(.pleague_preciser_shots_details, 'pleague_preciser_win_probability(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_preciser_rotation", inline = FALSE, unit = "player stint")
#' @eval .intl_details(.pleague_preciser_shots_details, 'pleague_preciser_rotation(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_preciser_injury", inline = FALSE, unit = "team")
#' @eval .intl_details(.pleague_preciser_shots_details, 'pleague_preciser_injury(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")')
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
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
#' @eval .returns_rd("pleague_team_crosswalk", inline = FALSE, unit = "team")
#' @examples
#' \donttest{
#'   pleague_team_crosswalk()
#' }
#' @export
#' @concept P. LEAGUE+ Functions
#' @seealso [family_p_league] lists every function in this family.
pleague_team_crosswalk <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  out <- dplyr::tibble(team_id = as.integer(names(.PLEAGUE_TEAMS)), team_uuid = unname(.PLEAGUE_TEAMS))
  make_hoopR_data(out, "P. LEAGUE+ Team Crosswalk", Sys.time())
}
