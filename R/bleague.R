# bleague.R -- the exported B.LEAGUE (Japan) `bleague_*()` wrappers.
#
# Column types and descriptions follow sportsdataverse-py's bleague_parsers.SPECS and
# manual_column_descriptions.yaml (sportsdataverse-py e3d232ebc9); the runtime and parsers live in
# bleague_utils.R.

# The @details of every bleague topic that shares the bleague_game_info() notes (roxygen @eval .intl_details()).
.bleague_game_info_details <- c(
  "The B.LEAGUE (Japan Professional Basketball League: B1, B2, B3) wrappers mirror",
  "sportsdataverse-py's `sportsdataverse.basketball.bleague` wrappers of the same names: same",
  "arguments, the same snake_case columns and types, one row per sportsdataverse-py row.",
  "",
  "**Unofficial and unsupported.** The game contexts are JSON objects in",
  "B.LEAGUE's own public S3 bucket (`b-league.s3.amazonaws.com`, the store its game",
  "pages read), and the schedule, standings and game_detail pages of",
  "`www.bleague.jp` are parsed here. Neither host publishes terms for this use",
  "(the site's /terms/ answers 404; robots.txt sets a Crawl-delay only for msnbot",
  "and bingbot). Requests are spaced at least one second apart per host; 429 and",
  "5xx answers are retried (three attempts). The site's terms were",
  "not reviewed; check them before you republish the data.",
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
#' @eval .intl_details(.bleague_game_info_details, full = TRUE)
#' @eval .returns_rd("bleague_game_info", inline = FALSE, unit = "game")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .returns_rd("bleague_period_scores", inline = FALSE, unit = "team and period")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .intl_details(.bleague_game_info_details)
#' @eval .returns_rd("bleague_player_box", inline = FALSE, unit = "player, period and category")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .intl_details(.bleague_game_info_details)
#' @eval .returns_rd("bleague_team_box", inline = FALSE, unit = "team in the game")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .returns_rd("bleague_team_summary", inline = FALSE, unit = "team side")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .intl_details(.bleague_game_info_details)
#' @eval .returns_rd("bleague_pbp", inline = FALSE, unit = "logged event")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .intl_details(.bleague_game_info_details)
#' @eval .returns_rd("bleague_shots", inline = FALSE, unit = "field-goal attempt")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .returns_rd("bleague_leaders", inline = FALSE, unit = "period, statistic and rank")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .returns_rd("bleague_score_track", inline = FALSE, unit = "scoring event")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .intl_details(.bleague_game_info_details)
#' @eval .returns_rd("bleague_schedule", inline = FALSE, unit = "game")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .returns_rd("bleague_schedule_clubs", inline = FALSE, unit = "club the page's filter lists")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .returns_rd("bleague_schedule_events", inline = FALSE, unit = "competition type")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .returns_rd("bleague_schedule_days", inline = FALSE, unit = "game day of the requested month")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
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
#' @eval .intl_details(.bleague_game_info_details)
#' @eval .returns_rd("bleague_standings", inline = FALSE, unit = "club per table")
#' @concept B.LEAGUE Functions
#' @seealso [family_b_league] lists every function in this family.
#' @export
#' @examples
#' \donttest{
#'   try(bleague_standings(season = 2026, tab = 1))
#' }
bleague_standings <- function(season, tab) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .bleague_parse_standings(.bleague_standings_page(season, tab, call = rlang::current_env()))
}
