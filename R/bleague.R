# bleague.R -- the exported B.LEAGUE (Japan) `bleague_*()` wrappers.
#
# Column types and descriptions follow sdv-py's bleague_parsers.SPECS and
# manual_column_descriptions.yaml (sdv-py e3d232ebc9); the runtime and parsers live in
# bleague_utils.R.

# The @details of every bleague topic that shares the bleague_game_info() notes (roxygen @eval .intl_details()).
.bleague_game_info_details <- c(
  "The B.LEAGUE (Japan Professional Basketball League: B1, B2, B3) wrappers mirror",
  "sdv-py's `sportsdataverse.basketball.bleague` wrappers of the same names: same",
  "arguments, the same snake_case columns and types, one row per sdv-py row.",
  "",
  "**Unofficial and unsupported.** The game contexts are JSON objects in",
  "B.LEAGUE's own public S3 bucket (`b-league.s3.amazonaws.com`, the store its game",
  "pages read), and the schedule, standings and game_detail pages of",
  "`www.bleague.jp` are parsed here. Neither host publishes terms for this use",
  "(the site's /terms/ answers 404; robots.txt sets a Crawl-delay only for msnbot",
  "and bingbot). Requests are spaced at least one second apart per host; 429 and",
  "5xx answers are retried (three attempts). SportsDataverse has not ruled on the",
  "site's terms, so the data is not redistributed as release assets.",
  "",
  "**Seasons** are END years (`season = 2026` is 2025-26); the site's own `Year` /",
  "`year=` is the START year, so the request sends `year = season - 1`. Game",
  "wrappers take the global `schedule_key` (one integer sequence across B1, B2, B3",
  "and every season: 1 = the 2016-17 opener, 5856 in 2020-21, 500017 in 2022-23,",
  "504734 / 505508 B1 / B2 and 10693 B3 in 2025-26); list a day's keys with",
  "[bleague_schedule()].",
  "",
  "**Feeds.** A game is read from the v2 feed (B1/B2 from 2020-21), else the v1",
  "feed (B3 and B1/B2 2018-2020), else the game page's embedded copy (the only",
  "source of 2016-17 and 2017-18), decided at run time. v2 ids are strings, v1 ids",
  "integers: both become text here. v1 adds leaders and the score track; the",
  "team-rebound codes 18 / 19 are swapped between the feeds and a v1 substitution",
  "is one row where v2 has two. Player and team names are Japanese (English names",
  "only on the box score and header). Game wrappers serve FINISHED games only.",
  "Each game wrapper fetches the context itself (two requests): fetch once per",
  "game per wrapper you need.",
  "",
  "**Errors** are classed conditions, never a warning plus an empty frame:",
  "`hoopR_no_data` (no source holds the game, a schedule day without games, HTTP",
  "404), `hoopR_bad_request` (a non-integer or out-of-range argument, HTTP 400 /",
  "422) and `hoopR_asset_fetch` (any other failure: another status, a transport",
  "error, a non-JSON or non-HTML body, an error or changed body, an unfinished",
  "game, a context or page for another game, season, tab or day, a truncated",
  "schedule list, or layout drift). All inherit `hoopR_error`."
)

#' @title
#' **B.LEAGUE Game Info**
#' @description
#' **Game header of one B.LEAGUE game: competition, round, venue, officials, tip-off,
#' both teams and the scores.**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' One row. `year` is the season START year and `season` the END year (`year + 1`). Team
#' ids are text (the v1 feed sends integers, v2 strings). `home_score_p1` ... `p14` are
#' the points scored IN each period (the v1 header carries 14 slots, v2 four; use
#' [bleague_period_scores()] for the played periods). The v1 header has many columns v2
#' lacks (`game_no`, `event`, winning / losing streaks, weather, report text); they are
#' `NA` on v2. `temperature` and `humidity` were `NA` in every observed body, so their
#' type is an assumption.
#' @param schedule_key (*integer* required): B.LEAGUE ScheduleKey, one global
#'   sequence across B1, B2, B3 and every season, e.g. `504734` (B1 2025-26 sec 1,
#'   Alvark Tokyo v Utsunomiya Brex); the `schedule_key` column of [bleague_schedule()].
#' @param season (*integer* optional): a guard, the season END year the game must
#'   belong to; a context whose `Year` differs raises `hoopR_asset_fetch`. `NULL`
#'   (default) = no check (the key alone selects the game).
#' @eval .intl_details(.bleague_game_info_details)
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | year | integer | Season START year as the site stores it (2025 = 2025-26); season is the END year. |
#' | code | integer | Feed/organisation code repeated on every row: 546 on v2, 6 on v1; meaning unverified. |
#' | event | integer | Competition type (v1 header only): 2 B1 league, 3 B1 Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2 playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs; null on v2. |
#' | convention_key | character | ConventionKey as text (key space: competition-seasons, taikai): v2 '514' = B1 2025-26, v1 102 = B3 2025-26. Key on (feed, convention_key); the feeds may number independently. |
#' | convention_class | integer | Competition class code (1 on every sample); meaning unverified. |
#' | round | integer | Round (setsu) within the competition-season; playoffs use 100+ (101). Integer. |
#' | game_no | integer | Game number within the competition (v1 header only); null on v2. |
#' | schedule_state | integer | Schedule state code (v1 header only; 2 on the final-game sample); meaning unverified. |
#' | schedule_conference | integer | Conference code (v1 header only); meaning unverified. |
#' | interleague | logical | True for an inter-league game (v1 header only). |
#' | stadium_cd | character | StadiumCD as text (key space: B.LEAGUE venues; stability unverified). |
#' | attendance | integer | Announced attendance. |
#' | game_datetime | POSIXct | Scheduled tip-off as a UTC instant (the feed's JST wall clock minus nine hours). |
#' | game_start_time | POSIXct | Actual start as a UTC instant (v1 header only; epoch seconds on the 2016-17 embed). |
#' | game_end_time | POSIXct | Actual end as a UTC instant (v1 header only). |
#' | max_period | integer | Number of periods the game had (4 plus overtimes). |
#' | current_period | integer | Period the context was last written in (the last period for a final game). |
#' | rest_time | integer | Clock remaining when last written (v1 header only; 0 for a final game). |
#' | game_ended | logical | True when the game has ended; the runtime serves only games where this and record_fixed are true. |
#' | record_fixed | logical | True when the record is finalised (no more corrections expected). |
#' | box_exists | logical | True when the box score exists. |
#' | pbp_exists | logical | True when play-by-play exists. |
#' | picture_exists | logical | True when photos exist (v1 header only). |
#' | report_exists | logical | True when a game report text exists (v1 header only). |
#' | home_win | logical | True when the home team won (v1 header only); null on v2. |
#' | commissioner_id | character | Commissioner id as text; null when none is assigned. |
#' | referee_id | character | Crew-chief referee RefereeID as text (key space: officials; stability unverified). |
#' | sub_referee_id1 | character | Second referee RefereeID as text. |
#' | sub_referee_id2 | character | Third referee RefereeID as text. |
#' | temperature | numeric | Temperature; null in every observed body, so its dtype is an assumption. |
#' | humidity | numeric | Humidity; null in every observed body, so its dtype is an assumption. |
#' | convention_name_j | character | Competition name in Japanese (e.g. the Resona Group B.LEAGUE 2025-26 B1 regular season). |
#' | convention_name_e | character | Competition name in English; empty (null) on early v1 bodies. |
#' | convention_title_j | character | Competition title in Japanese (v1 header only). |
#' | convention_title_e | character | Competition title in English (v1 header only). |
#' | stadium_name_j | character | Venue name in Japanese (e.g. TOYOTA ARENA TOKYO, AGF Suzuka Gymnasium). |
#' | stadium_name_e | character | Venue name in English; often empty (null). |
#' | court | character | Court number at the venue (v1 header only). |
#' | report | character | Game report text (v1 header only); usually empty (null). |
#' | weather | character | Weather text (v1 header only); null in every observed body. |
#' | schedule_class_name_j | character | Schedule class name in Japanese (v1 header only); usually empty. |
#' | schedule_class_name_e | character | Schedule class name in English (v1 header only); usually empty. |
#' | schedule_class_short_name_j | character | Schedule class short name in Japanese (v1 header only); usually empty. |
#' | schedule_class_short_name_e | character | Schedule class short name in English (v1 header only); usually empty. |
#' | commissioner_name_j | character | Commissioner name in Japanese (names only; no contact data is published). |
#' | commissioner_name_e | character | Commissioner name in English (v1 header only). |
#' | referee_name_j | character | Crew-chief referee name in Japanese (name only; no contact data is published). |
#' | referee_name_e | character | Crew-chief referee name in English (v1 header only). |
#' | sub_referee_name_j1 | character | Second referee name in Japanese. |
#' | sub_referee_name_e1 | character | Second referee name in English (v1 header only). |
#' | sub_referee_name_j2 | character | Third referee name in Japanese. |
#' | sub_referee_name_e2 | character | Third referee name in English (v1 header only). |
#' | home_team_id | character | Home team id. B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | home_team_name_j | character | Home team name in Japanese (official name). |
#' | home_team_name_e | character | Home team name in English, uppercase. |
#' | home_team_short_name_j | character | Home team short name in Japanese (e.g. the short form of Alvark Tokyo). |
#' | home_team_short_name_e | character | Home team short name in English (e.g. A TOKYO). |
#' | home_team_sub_name_j | character | Home team sub name in Japanese (v1 header only); usually empty. |
#' | home_team_sub_name_e | character | Home team sub name in English (v1 header only); usually empty. |
#' | home_score | integer | Home team final score. |
#' | home_winning_count | integer | Home team winning streak (v1 header only); null in every observed body. |
#' | home_losing_count | integer | Home team losing streak (v1 header only); null in every observed body. |
#' | away_team_id | character | Away team id. B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | away_team_name_j | character | Away team name in Japanese (official name). |
#' | away_team_name_e | character | Away team name in English, uppercase. |
#' | away_team_short_name_j | character | Away team short name in Japanese (e.g. the short form of Alvark Tokyo). |
#' | away_team_short_name_e | character | Away team short name in English (e.g. A TOKYO). |
#' | away_team_sub_name_j | character | Away team sub name in Japanese (v1 header only); usually empty. |
#' | away_team_sub_name_e | character | Away team sub name in English (v1 header only); usually empty. |
#' | away_score | integer | Away team final score. |
#' | away_winning_count | integer | Away team winning streak (v1 header only); null in every observed body. |
#' | away_losing_count | integer | Away team losing streak (v1 header only); null in every observed body. |
#' | home_score_p1 | integer | Home team points scored IN period 1 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p2 | integer | Home team points scored IN period 2 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p3 | integer | Home team points scored IN period 3 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p4 | integer | Home team points scored IN period 4 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p5 | integer | Home team points scored IN period 5 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p6 | integer | Home team points scored IN period 6 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p7 | integer | Home team points scored IN period 7 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p8 | integer | Home team points scored IN period 8 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p9 | integer | Home team points scored IN period 9 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p10 | integer | Home team points scored IN period 10 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p11 | integer | Home team points scored IN period 11 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p12 | integer | Home team points scored IN period 12 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p13 | integer | Home team points scored IN period 13 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | home_score_p14 | integer | Home team points scored IN period 14 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p1 | integer | Away team points scored IN period 1 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p2 | integer | Away team points scored IN period 2 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p3 | integer | Away team points scored IN period 3 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p4 | integer | Away team points scored IN period 4 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p5 | integer | Away team points scored IN period 5 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p6 | integer | Away team points scored IN period 6 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p7 | integer | Away team points scored IN period 7 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p8 | integer | Away team points scored IN period 8 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p9 | integer | Away team points scored IN period 9 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p10 | integer | Away team points scored IN period 10 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p11 | integer | Away team points scored IN period 11 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p12 | integer | Away team points scored IN period 12 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p13 | integer | Away team points scored IN period 13 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' | away_score_p14 | integer | Away team points scored IN period 14 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
#' @family B.LEAGUE
#' @export
#' @examples
#' \donttest{
#'   try(bleague_game_info(schedule_key = 504734))
#' }
bleague_game_info <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_game_info(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Period Scores**
#' @description
#' **Points each team scored in each period of one B.LEAGUE game, overtime included.**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' One row per (period, team side): `points` are scored IN the period (not cumulative).
#' Periods run 1 to the game's `MaxPeriod` (4 when the header has none); a period whose
#' score slot is missing is skipped.
#' @inheritParams bleague_game_info
#' @eval .intl_details(.bleague_game_info_details, "bleague_period_scores(schedule_key = 504734)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | period | integer | Period number: 1-4 regulation; overtime numbering is unverified (no overtime sample). |
#' | team_side | character | Side of the game the row belongs to: home or away. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | points | integer | Points the team scored IN this period (not cumulative); from the header's score slots. |
#' @family B.LEAGUE
#' @export
bleague_period_scores <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_period_scores(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Player Box**
#' @description
#' **Player box score of one B.LEAGUE game: one row per (player, period category), both
#' teams.**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' Rows with `category` 1 (a player), one per `period_category` (1-4 quarters, 15 / 16
#' halves, 18 the whole game; overtime categories are unverified). `seconds_played` is
#' `play_time` in seconds (`DNP` = `NA`). The v2 feed sends `""` as a placeholder (not
#' 0) in some cells; those are `NA` here. The efficiency definition differs by feed, the
#' advanced columns (`plus_minus`, `ast_to`, `efg`, `ts`, `usg`) exist from 2022-23 on
#' v2 only, and `dunks` / `ptpft` exist on v1 only.
#' @inheritParams bleague_game_info
#' @inherit bleague_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | team_side | character | Side of the game the row belongs to: home or away. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | category | integer | Row category: 1 = player, 2 = team / coaches row (team-credited stats; on v1 it names the head coach), 3 = team totals. One row per (category, player, period category). |
#' | period_category | integer | Period category: 1-4 = quarters 1-4, 15 = first half, 16 = second half, 18 = whole game. Overtime codes are unverified. |
#' | team_name_j | character | Team name in Japanese (official name, e.g. Alvark Tokyo). |
#' | team_name_e | character | Team name in English, uppercase ('ALVARK TOKYO'). |
#' | player_id | character | B.LEAGUE PlayerID as text (key space: B.LEAGUE persons, stable across seasons and clubs: Makoto Hiejima = '8589'). A string on v2, an integer on v1; both are text here. Null where the row names no player. |
#' | player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
#' | player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
#' | player_name_e | character | Player name in English ('Makoto Hiejima'); null on team and totals rows. |
#' | play_time | character | Minutes played as the feed's 'mm:ss'; 'DNP' = did not play. Totals rows hold 5 x the period length ('200:00' for the game). |
#' | on_court | logical | True for the five players on court when the context was last written (for a final game, at the final buzzer); the same value on every period row of the player. Null on v2 team and totals rows. |
#' | display_order | integer | Display order of the row (v1 only), integer; null on v2. |
#' | starter | logical | True when the player started; false for the bench; null on team and totals rows. (The feed sends 1 / null on v2 and a boolean on v1.) |
#' | seconds_played | integer | Time on court in seconds, parsed from play_time (50:00 = 3000); null for DNP and blank. |
#' | points | integer | Points scored. The v2 feed sends '' (a placeholder, not 0) on the team row of quarters; null here. |
#' | fg3_made | integer | Three-point field goals made (v2 placeholder '' on quarter team rows becomes null). |
#' | fg3_attempted | integer | Three-point field goals attempted. |
#' | fg2_made | integer | Two-point field goals made. |
#' | fg2_attempted | integer | Two-point field goals attempted. |
#' | ft_made | integer | Free throws made. |
#' | ft_attempted | integer | Free throws attempted. |
#' | fouls | integer | Personal fouls committed (F). |
#' | fouls_drawn | integer | Fouls drawn (FD). |
#' | reb_off | integer | Offensive rebounds (OR). |
#' | reb_def | integer | Defensive rebounds (DR). |
#' | reb | integer | Total rebounds. |
#' | turnovers | integer | Turnovers (TO). |
#' | assists | integer | Assists credited to the player or team (AS). |
#' | steals | integer | Steals credited to the player or team (ST). |
#' | blocks | integer | Blocks made (BS). |
#' | blocks_received | integer | Shots of this player or team that were blocked (BSON). |
#' | ptfb | integer | Fast-break figure; equals the summary's fast-break points on the one game checked, but whether it counts points or baskets is unverified. |
#' | pt2in | integer | Inside-the-paint figure: on v2 a COUNT of made inside-the-paint 2PT (the summary holds 2x that in points); on v1 points in the paint (0 on B3, whose 2PT shots are never split by paint). |
#' | pt2nd | integer | Second-chance figure; smaller than the summary's second-chance points, so likely made baskets; unverified. |
#' | ptpft | integer | Points off turnovers; v1 box rows only, null on v2. |
#' | dunks | integer | Dunks made (PT2DUNK); v1 box rows only, null on v2. |
#' | efficiency | integer | Efficiency rating (kokendo), era-dependent: v2 = points + rebounds + assists + steals + blocks + fouls drawn - missed FG - missed FT - turnovers - fouls - shots blocked (PIR); v1 omits fouls drawn, fouls and shots blocked. |
#' | plus_minus | integer | Plus/minus: team point difference while on court. v2 from 2022-23 only; null on totals and half rows. |
#' | ast_to | numeric | Assist-to-turnover ratio (0 when no turnovers). v2 from 2022-23 only; null on half rows. |
#' | efg | numeric | Effective field-goal percentage as a FRACTION 0-1 (3PT weighted 1.5x); the site multiplies by 100. v2 from 2022-23 only. |
#' | ts | numeric | True-shooting percentage as a FRACTION 0-1; the site multiplies by 100. v2 from 2022-23 only. |
#' | usg | numeric | Usage rate in PERCENT 0-100. v2 from 2022-23 only; absent on totals rows. |
#' | off_rtg | numeric | Offensive rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' | def_rtg | numeric | Defensive rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' | net_rtg | numeric | Net rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' | poss | numeric | Possessions. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' @family B.LEAGUE
#' @export
#' @examples
#' \donttest{
#'   try(bleague_player_box(schedule_key = 504734))
#' }
bleague_player_box <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_player_box(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Team Box**
#' @description
#' **Team rows of the box score of one B.LEAGUE game: the team / coaches row and the
#' team totals, per period category.**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' Rows with `category` 2 (team-credited stats; on v1 the row names the head coach in
#' `player_id` and `player_name_*`) and 3 (the team totals, whose `play_time` is five
#' times the period length: `200:00` for the game), one per `period_category`. The same
#' columns as [bleague_player_box()]. The v2 totals row carries no `TeamID`; `team_id`
#' is filled from the game header.
#' @inheritParams bleague_game_info
#' @inherit bleague_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | team_side | character | Side of the game the row belongs to: home or away. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | category | integer | Row category: 1 = player, 2 = team / coaches row (team-credited stats; on v1 it names the head coach), 3 = team totals. One row per (category, player, period category). |
#' | period_category | integer | Period category: 1-4 = quarters 1-4, 15 = first half, 16 = second half, 18 = whole game. Overtime codes are unverified. |
#' | team_name_j | character | Team name in Japanese (official name, e.g. Alvark Tokyo). |
#' | team_name_e | character | Team name in English, uppercase ('ALVARK TOKYO'). |
#' | player_id | character | B.LEAGUE PlayerID as text (key space: B.LEAGUE persons, stable across seasons and clubs: Makoto Hiejima = '8589'). A string on v2, an integer on v1; both are text here. Null where the row names no player. |
#' | player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
#' | player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
#' | player_name_e | character | Player name in English ('Makoto Hiejima'); null on team and totals rows. |
#' | play_time | character | Minutes played as the feed's 'mm:ss'; 'DNP' = did not play. Totals rows hold 5 x the period length ('200:00' for the game). |
#' | on_court | logical | True for the five players on court when the context was last written (for a final game, at the final buzzer); the same value on every period row of the player. Null on v2 team and totals rows. |
#' | display_order | integer | Display order of the row (v1 only), integer; null on v2. |
#' | starter | logical | True when the player started; false for the bench; null on team and totals rows. (The feed sends 1 / null on v2 and a boolean on v1.) |
#' | seconds_played | integer | Time on court in seconds, parsed from play_time (50:00 = 3000); null for DNP and blank. |
#' | points | integer | Points scored. The v2 feed sends '' (a placeholder, not 0) on the team row of quarters; null here. |
#' | fg3_made | integer | Three-point field goals made (v2 placeholder '' on quarter team rows becomes null). |
#' | fg3_attempted | integer | Three-point field goals attempted. |
#' | fg2_made | integer | Two-point field goals made. |
#' | fg2_attempted | integer | Two-point field goals attempted. |
#' | ft_made | integer | Free throws made. |
#' | ft_attempted | integer | Free throws attempted. |
#' | fouls | integer | Personal fouls committed (F). |
#' | fouls_drawn | integer | Fouls drawn (FD). |
#' | reb_off | integer | Offensive rebounds (OR). |
#' | reb_def | integer | Defensive rebounds (DR). |
#' | reb | integer | Total rebounds. |
#' | turnovers | integer | Turnovers (TO). |
#' | assists | integer | Assists credited to the player or team (AS). |
#' | steals | integer | Steals credited to the player or team (ST). |
#' | blocks | integer | Blocks made (BS). |
#' | blocks_received | integer | Shots of this player or team that were blocked (BSON). |
#' | ptfb | integer | Fast-break figure; equals the summary's fast-break points on the one game checked, but whether it counts points or baskets is unverified. |
#' | pt2in | integer | Inside-the-paint figure: on v2 a COUNT of made inside-the-paint 2PT (the summary holds 2x that in points); on v1 points in the paint (0 on B3, whose 2PT shots are never split by paint). |
#' | pt2nd | integer | Second-chance figure; smaller than the summary's second-chance points, so likely made baskets; unverified. |
#' | ptpft | integer | Points off turnovers; v1 box rows only, null on v2. |
#' | dunks | integer | Dunks made (PT2DUNK); v1 box rows only, null on v2. |
#' | efficiency | integer | Efficiency rating (kokendo), era-dependent: v2 = points + rebounds + assists + steals + blocks + fouls drawn - missed FG - missed FT - turnovers - fouls - shots blocked (PIR); v1 omits fouls drawn, fouls and shots blocked. |
#' | plus_minus | integer | Plus/minus: team point difference while on court. v2 from 2022-23 only; null on totals and half rows. |
#' | ast_to | numeric | Assist-to-turnover ratio (0 when no turnovers). v2 from 2022-23 only; null on half rows. |
#' | efg | numeric | Effective field-goal percentage as a FRACTION 0-1 (3PT weighted 1.5x); the site multiplies by 100. v2 from 2022-23 only. |
#' | ts | numeric | True-shooting percentage as a FRACTION 0-1; the site multiplies by 100. v2 from 2022-23 only. |
#' | usg | numeric | Usage rate in PERCENT 0-100. v2 from 2022-23 only; absent on totals rows. |
#' | off_rtg | numeric | Offensive rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' | def_rtg | numeric | Defensive rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' | net_rtg | numeric | Net rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' | poss | numeric | Possessions. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
#' @family B.LEAGUE
#' @export
#' @examples
#' \donttest{
#'   try(bleague_team_box(schedule_key = 504734))
#' }
bleague_team_box <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_team_box(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Team Summary**
#' @description
#' **Team summary of one B.LEAGUE game per period category, in long form (one row per
#' team side).**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' The feed's `Summaries` rows hold both teams side by side; they are split into two
#' rows (`team_side` home / away). `period_category` is 1-4 (quarters), 15 / 16 (halves)
#' or 18 (the whole game). `paint_points`, `points_off_turnover`, `second_chance_points`
#' and `fast_break_points` are POINTS here (unlike the box score's counts of the same
#' wire names). `lead_changes` and `ties` belong to the whole row and repeat on both
#' sides.
#' @inheritParams bleague_game_info
#' @eval .intl_details(.bleague_game_info_details, "bleague_team_summary(schedule_key = 504734)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | period_category | integer | Period category: 1-4 = quarters 1-4, 15 = first half, 16 = second half, 18 = whole game. Overtime codes are unverified. |
#' | team_side | character | Side of the game the row belongs to: home or away. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | team_name_j | character | Team name in Japanese. |
#' | team_name_e | character | Team name in English, uppercase. |
#' | fg_made | integer | Field goals made (PTM). |
#' | fg_attempted | integer | Field goals attempted (PTA). |
#' | fg_pct | numeric | Field-goal percentage 0-100, one decimal. |
#' | fg2_made | integer | Two-point field goals made. |
#' | fg2_attempted | integer | Two-point field goals attempted. |
#' | fg2_pct | numeric | Two-point percentage 0-100. |
#' | fg3_made | integer | Three-point field goals made. |
#' | fg3_attempted | integer | Three-point field goals attempted. |
#' | fg3_pct | numeric | Three-point percentage 0-100. |
#' | ft_made | integer | Free throws made. |
#' | ft_attempted | integer | Free throws attempted. |
#' | ft_pct | numeric | Free-throw percentage 0-100. |
#' | reb_off | integer | Offensive rebounds. |
#' | reb_def | integer | Defensive rebounds. |
#' | reb | integer | Total rebounds. |
#' | assists | integer | Assists credited to the team in the period category. |
#' | turnovers | integer | Turnovers committed by the team in the period category. |
#' | steals | integer | Steals made by the team in the period category. |
#' | blocks | integer | Blocks made by the team in the period category. |
#' | blocks_received | integer | Shots blocked by the opponent. |
#' | fouls | integer | Fouls committed. |
#' | fouls_drawn | integer | Fouls drawn. |
#' | paint_points | integer | Points in the paint (inside-the-paint 2PT points; 2x the players' PT2IN count on v2). |
#' | points_off_turnover | integer | Points off turnovers. |
#' | second_chance_points | integer | Second-chance points. |
#' | fast_break_points | integer | Fast-break points. |
#' | max_lead | integer | Largest lead of the team in the period category (0 if it never led). |
#' | lead_last | integer | Lead statistic (LeadLast), integer; meaning unverified (7 for the home side on all checked games). |
#' | lead_last_home | integer | Home score-like value tied to lead_last; meaning unverified. A string on v2 quarter / game rows. |
#' | lead_last_away | integer | Away score-like value tied to lead_last; meaning unverified. |
#' | lead_changes | integer | Lead changes in the period category (LeadCount); the same on both side rows. |
#' | ties | integer | Times the score was tied in the period category (TieCount); the same on both side rows. |
#' @family B.LEAGUE
#' @export
bleague_team_summary <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_team_summary(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Play-by-Play**
#' @description
#' **Play-by-play of one finished B.LEAGUE game, in game order, every feed in one
#' shape.**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' One row per logged event, oldest first (`event_no` ascends; v2 counts in steps of
#' 1000). `action`, `qualifier2` and `qualifier3` are English slugs for the numeric
#' codes (`NA` for a code no sample contains); the team-rebound codes 18 / 19 mean
#' opposite things on the two feeds and `action` follows the `feed` column. A v1
#' substitution is ONE row (`action` `substitution`, `player_id` out, `player2_id` in),
#' a v2 one is two rows (`player_out` / `player_in`). `home_score` / `away_score` split
#' the running `score`. `x` / `y` / `area_code` / `success` exist on v2 from 2022-23 and
#' `side` from 2025-26 (see [bleague_shots()]). `recorded_at` / `edited_at` are UTC
#' instants (POSIXct, tz UTC). Game-level rows (start, period, clock) carry `NA` team
#' and player columns.
#' @inheritParams bleague_game_info
#' @inherit bleague_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | period | integer | Period number: 1-4 regulation; overtime numbering is unverified (no overtime sample). |
#' | event_no | integer | Event sequence number, ascending in game order. v2 counts in steps of 1000 (inserted corrections may fall in between); v1 counts 1, 2, 3... |
#' | action_code | integer | ActionCD1, the primary action code: 1 / 2 3PT made / missed, 3 / 5 2PT outside the paint made / missed, 4 / 6 inside the paint, 7 / 8 free throw, 9 / 10 defensive / offensive rebound, 11 block, 12 assist, 13 turnover, 14 steal, 15 foul drawn, 16 and-one, 17 team turnover, 18 / 19 team rebounds (SWAPPED between feeds), 22-25 fouls, 80-85 game and clock events, 86 / 87 player in / out, 88 timeout, 89 substitution (v1). |
#' | action | character | English slug for action_code (fg3_made, ft_missed, rebound_def, foul_personal, player_in, ...). The team-rebound codes 18 / 19 follow the feed column; null for a code no sample contains. |
#' | qualifier_code2 | integer | ActionCD2, a secondary qualifier (shot type, free throws awarded on a fouls, scoring context, 24 s violation); one code space shared with qualifier_code3. Null when the row has none. |
#' | qualifier2 | character | English slug for qualifier_code2 (jump_shot, layup, dunk, free_throws_awarded_N, fast_break, second_chance, shooting_foul, ...); null when unknown. |
#' | qualifier_code3 | integer | ActionCD3, a tertiary qualifier (scoring context on made shots, shooting foul / foul-out on fouls); same code space as qualifier_code2. |
#' | qualifier3 | character | English slug for qualifier_code3; null when unknown. |
#' | team_side | character | Side of the acting team from HomeAway (1 home, 2 away); null on game-level rows and official timeouts. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | team_name_j | character | Acting team name in Japanese; null on game-level rows and official timeouts. |
#' | player_id | character | Primary actor PlayerID as text (key space: B.LEAGUE persons). On a v1 substitution it is the player going out. Null on team rows and game-level rows. |
#' | player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
#' | player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
#' | player2_id | character | Second actor PlayerID as text; on a v1 substitution the player coming in. v1 / embed only. |
#' | player2_no | character | Shirt number of the second actor (v1 / embed only). |
#' | player2_name_j | character | Second actor's name in Japanese (v1 / embed only). |
#' | rest_time | character | Game clock REMAINING in the period as the feed's 'mm:ss' text (counts down from 10:00). |
#' | clock_seconds | integer | Game clock remaining in the period in whole seconds (8:50 = 530), derived from rest_time. |
#' | score | character | Running score 'home-away' after the event (e.g. '2-4'); null on player-in rows and v1 substitutions. |
#' | home_score | integer | Home running score after the event, split from score. |
#' | away_score | integer | Away running score after the event, split from score. |
#' | period_end | logical | True on the closing row of a period (ActionCD1 83). |
#' | game_end | logical | True on the game-end row on v1 and the embed; false on EVERY v2 row, the game-end row (81) included, so use action instead. |
#' | x | numeric | Event x: percent (0-100) of the court LENGTH from the 'left' baseline (baskets near 5 and 95). Metres (x / 100 x 28) are an inference. 2022-23 onward on v2 only. |
#' | y | numeric | Event y: percent (0-100) of the court WIDTH (baskets at 50). Which sideline is y = 0 is unverified; metres (y / 100 x 15) are an inference. 2022-23 onward on v2 only. |
#' | area_code | integer | Shot-zone code 1-13 read from the site's shot-chart SVG: 1 restricted area, 2 rest of the paint, 3 / 7 baseline mid-range, 4 / 6 wing mid-range, 5 top-of-the-key mid-range, 8 / 12 corner 3, 9 / 11 wing 3, 10 top 3, 13 deep band. Of each pair the first is the side far along the baseline. Also set on turnover and foul rows; 2022-23 onward. |
#' | area | character | English zone slug for area_code (restricted_area, paint, baseline_mid_range, wing_mid_range, top_of_key_mid_range, corner_3, wing_3, top_3, deep_3); mirrored codes share a slug. |
#' | success | logical | Outcome flag: true = made / successful, false = missed; true on non-shot rows. v2 from 2022-23 only. |
#' | side | character | Basket the play is charted at: 'left' (x near 0) or 'right' (x near 100); flips at half-time. Present from 2025-26 only; earlier seasons leave it null and the end must be inferred from x. |
#' | play_text | character | Play description in Japanese: '#\{shirt\} \{surname\} \{action\} (\{running count\})'; a circle marks a make, a cross a miss, and an arrow a v1 substitution (out to in). |
#' | recorded_at | POSIXct | When the event was logged, as a UTC instant (v2 stores UTC text, v1 a JST-offset .NET date, the embed epoch seconds). |
#' | edited_at | POSIXct | When the event was last edited, as a UTC instant; null when never edited. |
#' | code | integer | Feed/organisation code repeated on every row: 546 on v2, 6 on v1; meaning unverified. |
#' @family B.LEAGUE
#' @export
#' @examples
#' \donttest{
#'   try(bleague_pbp(schedule_key = 504734))
#' }
bleague_pbp <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_pbp(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Shots**
#' @description
#' **Field-goal attempts of one B.LEAGUE game with their court position (play-by-play
#' rows that carry x / y).**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' One row per field-goal attempt (`ActionCD1` 1-6) with a location, oldest first. `x`
#' is the percent (0-100) of the court LENGTH from the `left` baseline and `y` the
#' percent of the WIDTH (the baskets sit near x = 5 and 95 at y = 50). Which sideline is
#' y = 0 is unverified, and metres (x / 100 x 28, y / 100 x 15) are an inference. `side`
#' (`left` / `right`) names the basket a shot is charted at, from 2025-26 only; teams
#' change ends at half-time. `in_paint` is `NA` on the B3 feed. Locations exist from
#' 2022-23 on the v2 feed only: any other game gives a zero-row tibble.
#' @inheritParams bleague_game_info
#' @inherit bleague_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | period | integer | Period number: 1-4 regulation; overtime numbering is unverified (no overtime sample). |
#' | event_no | integer | Event sequence number, ascending in game order. v2 counts in steps of 1000 (inserted corrections may fall in between); v1 counts 1, 2, 3... |
#' | team_side | character | Side of the acting team from HomeAway (1 home, 2 away); null on game-level rows and official timeouts. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | player_id | character | Primary actor PlayerID as text (key space: B.LEAGUE persons). On a v1 substitution it is the player going out. Null on team rows and game-level rows. |
#' | player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
#' | player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
#' | shot_type | character | 3pt or 2pt, from ActionCD1 (1-2 three-point, 3-6 two-point). |
#' | in_paint | logical | True for a two-point shot inside the paint, false outside; null for threes and on the B3 feed, whose 2PT codes do not split by paint. |
#' | made | logical | True when the shot was made (ActionCD1 odd for threes and 3 / 4), false when missed. |
#' | qualifier2 | character | English slug for the shot's ActionCD2 (jump_shot, layup, dunk); null when unknown. |
#' | qualifier3 | character | English slug for the shot's ActionCD3 (fast_break, points_off_turnover, second_chance, ...); null when none. |
#' | x | numeric | Event x: percent (0-100) of the court LENGTH from the 'left' baseline (baskets near 5 and 95). Metres (x / 100 x 28) are an inference. 2022-23 onward on v2 only. |
#' | y | numeric | Event y: percent (0-100) of the court WIDTH (baskets at 50). Which sideline is y = 0 is unverified; metres (y / 100 x 15) are an inference. 2022-23 onward on v2 only. |
#' | area_code | integer | Shot-zone code 1-13 read from the site's shot-chart SVG: 1 restricted area, 2 rest of the paint, 3 / 7 baseline mid-range, 4 / 6 wing mid-range, 5 top-of-the-key mid-range, 8 / 12 corner 3, 9 / 11 wing 3, 10 top 3, 13 deep band. Of each pair the first is the side far along the baseline. Also set on turnover and foul rows; 2022-23 onward. |
#' | area | character | English zone slug for area_code (restricted_area, paint, baseline_mid_range, wing_mid_range, top_of_key_mid_range, corner_3, wing_3, top_3, deep_3); mirrored codes share a slug. |
#' | side | character | Basket the play is charted at: 'left' (x near 0) or 'right' (x near 100); flips at half-time. Present from 2025-26 only; earlier seasons leave it null and the end must be inferred from x. |
#' | rest_time | character | Game clock REMAINING in the period as the feed's 'mm:ss' text (counts down from 10:00). |
#' | clock_seconds | integer | Game clock remaining in the period in whole seconds (8:50 = 530), derived from rest_time. |
#' | score | character | Running score 'home-away' after the event (e.g. '2-4'); null on player-in rows and v1 substitutions. |
#' @family B.LEAGUE
#' @export
#' @examples
#' \donttest{
#'   try(bleague_shots(schedule_key = 504734))
#' }
bleague_shots <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_shots(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Leaders**
#' @description
#' **Team leaders of one B.LEAGUE game per statistic and period category (v1 feed
#' only).**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' One row per (period category, category, team, player), ranked within the team (`rank`
#' 1 = best; ties share a rank and `tie_order` orders them). `category` 1 points, 2
#' assists, 3 steals, 4 blocks, 5 rebounds, 8 shots blocked (other codes are unnamed).
#' Only the v1 feed (B3, B1/B2 2018-2020, the 2016-17 embed) publishes leaders: a v2
#' game gives a zero-row tibble.
#' @inheritParams bleague_game_info
#' @eval .intl_details(.bleague_game_info_details, "bleague_leaders(schedule_key = 10693)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | period_category | integer | Period category: 1-4 = quarters 1-4, 15 = first half, 16 = second half, 18 = whole game. Overtime codes are unverified. |
#' | category | integer | Leader category code, decoded by matching count to the box score: 1 points, 2 assists, 3 steals, 4 blocks, 5 rebounds, 8 shots blocked. |
#' | category_name | character | English name of category (points, assists, steals, blocks, rebounds, blocks_received); null for an unknown code. |
#' | rank | integer | Rank within the team for the category (1 = best; ties share a rank). |
#' | tie_order | integer | Order within a tied rank (1 = first listed). |
#' | team_side | character | Side of the game the row belongs to: home or away. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | team_name_j | character | Team name in Japanese (official name, e.g. Alvark Tokyo). |
#' | player_id | character | B.LEAGUE PlayerID as text (key space: B.LEAGUE persons, stable across seasons and clubs: Makoto Hiejima = '8589'). A string on v2, an integer on v1; both are text here. Null where the row names no player. |
#' | player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
#' | player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
#' | count | integer | The player's value in the category for the period category. |
#' | reb_off_count | integer | Offensive-rebound count carried on the row (filled for the rebounds category). |
#' | reb_def_count | integer | Defensive-rebound count carried on the row (filled for the rebounds category). |
#' @family B.LEAGUE
#' @export
bleague_leaders <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_leaders(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Score Track**
#' @description
#' **Running score after each scoring event of one B.LEAGUE game (v1 feed only; the
#' site's score-track chart).**
#'
#' Endpoint: `GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
#' (the v1 feed, or the game page's embed, when v2 does not hold the game).
#'
#' One row per scoring event: `event_index` is the index of the event (0 = the 0-0 start
#' row, then 1, 2, ...; the chart's x axis, NOT a clock) and `home_points` /
#' `away_points` the running totals. Only the v1 feed publishes it: a v2 game gives a
#' zero-row tibble.
#' @inheritParams bleague_game_info
#' @eval .intl_details(.bleague_game_info_details, "bleague_score_track(schedule_key = 10693)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
#' | period | integer | Period number: 1-4 regulation; overtime numbering is unverified (no overtime sample). |
#' | event_index | integer | Index of the scoring event, 0 = the 0-0 start row, then 1, 2... (the score track's x axis; NOT a clock). |
#' | home_points | integer | Home running total after the event. |
#' | away_points | integer | Away running total after the event. |
#' @family B.LEAGUE
#' @export
bleague_score_track <- function(schedule_key, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_score_track(.bleague_context(schedule_key, season, call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Schedule**
#' @description
#' **Games of one day of one B.LEAGUE competition and division: schedule keys, clubs,
#' scores, venue, tip-off.**
#'
#' Endpoint: `GET https://www.bleague.jp/schedule/`
#'
#' One row per game of that day with its `schedule_key` (the key every game wrapper
#' takes), local date, round, both clubs (`team_id` is text; names are the page's short
#' Japanese names), final score, venue and tip-off time (a bare Japan-time `HH:MM`).
#' `tab` is the division (1 = B1, 2 = B2, 3 = B3) and `event` the competition type;
#' `season` is the END year.
#' @param season (*integer* required): season END year (`2026` = 2025-26); the site's
#'   own year is the START year, so the request sends `season - 1`.
#' @param tab (*integer* required): division tab: 1 = B1, 2 = B2, 3 = B3.
#' @param month (*integer* required): calendar month 1-12 of the game day (seasons
#'   run September to June).
#' @param day (*integer* required): day of month of the game day.
#' @param event (*integer* optional): competition type: 2 B1 league, 3 B1
#'   Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2 playoffs,
#'   11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs. `NULL` (default)
#'   = the league competition of the tab (2 / 7 / 15).
#' @inherit bleague_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
#' | event | integer | Competition type of the page: 2 B1 league, 3 B1 Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2 playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs. |
#' | schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The \{schedule_key\} every game wrapper takes and the schedule page's list-item id. |
#' | date | Date | Local game date, derived from the requested month and day (September to June; months 7-12 fall in the season's START year). |
#' | round_label | character | Round label as printed in Japanese, 'dai N setsu' (round N); playoffs print other labels. |
#' | round | integer | Round number parsed from round_label; null when the label is not 'dai N setsu' (round N). |
#' | home_team_id | character | Home club TeamID as text, mapped from the page's club filter. B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | home_team | character | Home club short name in Japanese as the page prints it (e.g. Osaka). |
#' | home_score | integer | Home final score; null for a game without one. |
#' | away_team_id | character | Away club TeamID as text, mapped from the page's club filter. B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | away_team | character | Away club short name in Japanese as the page prints it (e.g. San-en). |
#' | away_score | integer | Away final score; null for a game without one. |
#' | prefecture | character | Prefecture of the venue in Japanese (e.g. Osaka Prefecture); null when the page gives none. |
#' | venue | character | Venue name in Japanese, abbreviated by the page (e.g. Ookini for Osaka Edion Arena). |
#' | tip_time | character | Tip-off time 'HH:MM' in JST (no offset on the page); null when absent. |
#' | state | character | Score-state label on the page (FINAL for a finished game); null when absent. |
#' @family B.LEAGUE
#' @export
#' @examples
#' \donttest{
#'   try(bleague_schedule(season = 2026, tab = 1, month = 10, day = 4))
#' }
bleague_schedule <- function(season, tab, month, day, event = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_schedule(.bleague_schedule_page(season, tab, month, day, event,
                                                call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Schedule Clubs**
#' @description
#' **The club filter of the B.LEAGUE schedule page: every club of the season and
#' division with its team id.**
#'
#' Endpoint: `GET https://www.bleague.jp/schedule/`
#'
#' One row per club the page's filter lists, which maps a team id to the short Japanese
#' name the schedule uses. Reads the same page as [bleague_schedule()] (one request).
#' @inheritParams bleague_schedule
#' @eval .intl_details(.bleague_game_info_details, "bleague_schedule_clubs(season = 2026, tab = 1, month = 10, day = 4)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
#' | event | integer | Competition type of the page: 2 B1 league, 3 B1 Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2 playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | name | character | Club short name in Japanese as the schedule page prints it (e.g. Hokkaido). |
#' @family B.LEAGUE
#' @export
bleague_schedule_clubs <- function(season, tab, month, day, event = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_schedule_clubs(.bleague_schedule_page(season, tab, month, day, event,
                                                call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Schedule Events**
#' @description
#' **The competitions the B.LEAGUE schedule page offers for one season and division (the
#' `event` filter).**
#'
#' Endpoint: `GET https://www.bleague.jp/schedule/`
#'
#' One row per competition type (2 B1 league, 3 B1 Championship, 5 all-star, 7 B2
#' league, 15 B3 league, ...) with its Japanese label; `selected` marks the one the page
#' was asked for. Reads the same page as [bleague_schedule()] (one request).
#' @inheritParams bleague_schedule
#' @eval .intl_details(.bleague_game_info_details, "bleague_schedule_events(season = 2026, tab = 1, month = 10, day = 4)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
#' | event_id | integer | Competition type code (see event); the page's event filter value. |
#' | label | character | Competition label in Japanese (e.g. B1 league, all-star game, B1 Championship). |
#' | selected | logical | True for the competition the page was asked for. |
#' @family B.LEAGUE
#' @export
bleague_schedule_events <- function(season, tab, month, day, event = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_schedule_events(.bleague_schedule_page(season, tab, month, day, event,
                                                call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Schedule Days**
#' @description
#' **The days of the asked month on which the B.LEAGUE competition has games (the page's
#' date strip).**
#'
#' Endpoint: `GET https://www.bleague.jp/schedule/`
#'
#' One row per game day of the requested month, as a `Date`: loop over them with
#' [bleague_schedule()] to list every `schedule_key` of a season. Reads the same page as
#' [bleague_schedule()] (one request).
#' @inheritParams bleague_schedule
#' @eval .intl_details(.bleague_game_info_details, "bleague_schedule_days(season = 2026, tab = 1, month = 10, day = 4)")
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
#' | event | integer | Competition type of the page: 2 B1 league, 3 B1 Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2 playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs. |
#' | date | Date | Local date of a game day in the requested month (a date strip entry). |
#' @family B.LEAGUE
#' @export
bleague_schedule_days <- function(season, tab, month, day, event = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_schedule_days(.bleague_schedule_page(season, tab, month, day, event,
                                                call = rlang::current_env()))
}

#' @title
#' **B.LEAGUE Standings**
#' @description
#' **Standings of one B.LEAGUE season and division, one row per club per table
#' (conference, division or wild card).**
#'
#' Endpoint: `GET https://www.bleague.jp/standings/`
#'
#' One row per club per table. `section` is the table heading in Japanese (East, Central
#' and West divisions, wild card; B2 and B3 may have one table with a different heading)
#' and `section_en` its English name for those four. A club can appear in a division
#' table and in the wild-card table. `win_pct` is a 0-1 fraction. The page shows the
#' standings as of the request, not a season end.
#' @inheritParams bleague_schedule
#' @inherit bleague_game_info details
#' @return A `hoopR_data` tibble with these columns:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
#' | tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
#' | season_label | character | Season label of the selected option (2025-26). |
#' | section | character | Table heading in Japanese (East, Central and West divisions, wild card); section_en is its English name. |
#' | section_en | character | English name of section for the four known headings; null for any other heading. |
#' | rank | integer | Rank in that table; a club in a division table also appears in the wild-card table. |
#' | team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
#' | team | character | Club name in Japanese as the standings page prints it (e.g. Chiba Jets). |
#' | team_short | character | Club short name in Japanese (e.g. Chiba J). |
#' | wins | integer | Games won so far this season in the table. |
#' | losses | integer | Games lost so far this season in the table. |
#' | win_pct | numeric | Win percentage as a 0-1 fraction. |
#' | games_behind | numeric | Games behind the table leader. |
#' | points_for | integer | Points scored over the season to date. |
#' | points_against | integer | Points allowed over the season to date. |
#' | point_diff | integer | Point differential. |
#' | home_record | character | Home record W-L. |
#' | away_record | character | Away record W-L. |
#' | last_n | integer | Length of the recent-form window the page shows: 5 or 10 games. |
#' | last_n_record | character | Record W-L over the last_n games. |
#' | streak | character | Current streak as printed: W5 = five straight wins, L1 = one loss. |
#' | division_title | character | Division-title mark as printed; null when none ('--'). |
#' @family B.LEAGUE
#' @export
#' @examples
#' \donttest{
#'   try(bleague_standings(season = 2026, tab = 1))
#' }
bleague_standings <- function(season, tab) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_standings(.bleague_standings_page(season, tab, call = rlang::current_env()))
}
