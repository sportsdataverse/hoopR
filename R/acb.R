# acb.R -- ACB (Liga Endesa, Spain) wrappers over api2.acb.com, at parity with sportsdataverse-py
# sportsdataverse/basketball/acb (origin/main e3d232ebc9). 45 wrappers over 33 routes. Transport, key and
# refusals: R/acb_runtime.R; frames: R/acb_parsers.R; field tables: R/acb_schema.R.

# The @details of every acb topic that shares the acb_match_header() notes (roxygen @eval .intl_details()).
.acb_match_header_details <- c(
  "* Legal notice (the aviso legal of acb.com): ACEB, S.A.U. claims intellectual property in the site's databases",
  "  (the EU sui generis database right) among its other content. It authorises viewing and private copies for",
  "  personal or journalistic use with the source credited, and requires prior express consent for distribution,",
  "  reproduction or public communication. These wrappers fetch on your behalf for your own use; check the notice",
  "  before you republish the data. robots.txt allows the paths.",
  "* Unofficial and unsupported: api2.acb.com is the .NET API behind acb.com and live.acb.com, not a documented",
  "  public API. It needs the header `X-APIKEY`, a public key shipped in acb.com's bundle: the runtime sends the",
  "  documented value (`$ACB_API_KEY` overrides it), re-reads the live bundle once on a 401, and never prints the",
  "  key.",
  "* Seasons: the API keys a season by `editionId` = season START year - 1935 (91 = 2026-27, 48 = 1983-84, the",
  "  first). The wrappers take `season`, the END year (2027 = 2026-27), and the runtime sends `editionId = season -",
  "  1936`. A route that omits `season` serves the current edition. `team_id` is a season-team entry (new every",
  "  season); `club_id` is the stable club.",
  "* Coverage: box scores from 1983-84 (old seasons carry only the whole-game period, quarter 0); play-by-play",
  "  and shots from 2016-17 (earlier games answer empty lists, which raise `hoopR_no_data`). Shot coordinates",
  "  come in two systems, split by match id: millimetres from the attacked basket from 2020-21 (`coord_system`",
  "  mm), a 0-100 full-court percent grid before (grid). A game that is not finished (`matchFinished` false)",
  "  raises `hoopR_asset_fetch` for the routes that report it.",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404 / 204, a route",
  "  whose rows are empty: an unknown id, a game outside a playoff series, play-by-play or shots before 2016-17,",
  "  a club with no games that season), `hoopR_bad_request` (a missing, unknown or non-integer argument or a",
  "  season before 1984, raised before any request; HTTP 400 / 422) and `hoopR_asset_fetch` (a key the API still",
  "  rejects after one re-read of the bundle, any other non-200 after three attempts, a non-JSON or",
  "  `problem+json` body, an error envelope or empty stub, a body for another season, round, club, player or",
  "  match, a game that is not finished). Wrappers raise; they never warn and return empty."
)

#' @title
#' **Get ACB Match Header**
#' @description
#' Match header: teams, status, score, bonus, current period and the content the site offers.
#'
#' One row. `status` is the API's `matchStatus` (`FINALIZED` once over); `home_score` / `away_score` are the
#' live or final score; `time_left` is the period clock as `'mm:ss'`; `start` is UTC; the `has_*` flags say
#' which panels (overview, play-by-play, box score, advanced stats) the site offers. `team_id` is the
#' season-team entry, `club_id` the stable club.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/MatchHeader/match-header`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_match_header", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(acb_match_header(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_match_header <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/MatchHeader/match-header", list(matchId = match_id), call = rlang::current_env())
  .acb_out("match_header", raw, "ACB Match Header from api2.acb.com")
}

#' @title
#' **Get ACB Period Scores**
#' @description
#' Points each team scored in each period of a game.
#'
#' One row per period: `quarter` (1-4, 5+ overtime), `home_score` and `away_score` are the points scored IN
#' that period, not cumulative. Old games list fewer periods.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/MatchHeader/match-header`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_period_scores", inline = FALSE, unit = "period")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_period_scores(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_period_scores <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/MatchHeader/match-header", list(matchId = match_id), call = rlang::current_env())
  .acb_out("period_scores", raw, "ACB Period Scores from api2.acb.com")
}

#' @title
#' **Get ACB Player Box**
#' @description
#' Per-player box score of a game, per period (quarter 0 = the whole game).
#'
#' One row per team, period and player. `quarter` 0 is the whole game, 1-4 the periods, 5+ overtime (games
#' before about 2010 carry only quarter 0). `team_side` is home or away (the feed lists the home team first).
#' `play_time` is `'mm:ss'` and `seconds_played` the same in seconds; counts are `Int64`. `player_id` is the
#' ACB licence number; `game_role` is the Spanish position.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_player_box", inline = FALSE, unit = "player and period")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_player_box(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_player_box <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Result/boxscores", list(matchId = match_id), call = rlang::current_env())
  .acb_out("player_box", raw, "ACB Player Box from api2.acb.com")
}

#' @title
#' **Get ACB Team Box**
#' @description
#' Team totals of a game per period: everything the team did, and the part credited to the team itself.
#'
#' Two rows per team and period: `scope` `total` is everything the team did (its players plus the team's own
#' events), `team` is the part credited to the team itself rather than a player (team rebounds, team
#' turnovers). `quarter` 0 is the whole game.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_team_box", inline = FALSE, unit = "team and period")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_team_box(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_team_box <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Result/boxscores", list(matchId = match_id), call = rlang::current_env())
  .acb_out("team_box", raw, "ACB Team Box from api2.acb.com")
}

#' @title
#' **Get ACB Box Info**
#' @description
#' Coaches and game facts per team: head coach, assistants, arena, attendance, referees.
#'
#' One row per team. `arena`, `attendance` and `referees` (joined with `'; '`) describe the game and repeat on
#' both rows; `assistant_coaches` is joined with `'; '`.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_box_info", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_box_info(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_box_info <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Result/boxscores", list(matchId = match_id), call = rlang::current_env())
  .acb_out("box_info", raw, "ACB Box Info from api2.acb.com")
}

#' @title
#' **Get ACB Play-by-Play**
#' @description
#' Play-by-play of a game (2016-17 onward): every shot, rebound, foul, turnover, substitution and time-out.
#'
#' One row per event. `play_type` is the API's event code and `play_name` its bundle name
#' (`acb_codes.PLAY_TYPES`; a code outside the table, such as the minute marker 600, has no name);
#' `turnover_type` decodes `play_tag`. The clock counts DOWN: `minute` / `second` are the time left in the
#' period and `clock_seconds` the same in seconds. `order` is not unique (the starting five share one);
#' `play_index` is the 1-based position in the feed. `is_home` is true for the home team's events (the feed's
#' `local`). `run_*` columns are the acting player's running box score AFTER the event. Games before 2016-17
#' answer no events (the wrapper raises `hoopR_no_data`).
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/PlayByPlay/play-by-play`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_pbp", inline = FALSE, unit = "event")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_pbp(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_pbp <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/PlayByPlay/play-by-play", list(matchId = match_id), call = rlang::current_env())
  .acb_out("pbp", raw, "ACB Play-by-Play from api2.acb.com")
}

#' @title
#' **Get ACB Shots**
#' @description
#' Every field-goal and free-throw attempt of a game (2016-17 onward) with its court position.
#'
#' One row per attempt. Two coordinate systems share `pos_x` / `pos_y`, told apart by `coord_system`: `mm`
#' (match ids from 2020-21) is millimetres from the centre of the attacked basket, every shot mirrored to one
#' basket, `pos_x` towards midcourt and `pos_y` across the court (negative = the shooter's left); `x_basket_m`
#' / `y_basket_m` are those in metres. `grid` (up to 2019-20) is a 0-100 percent grid over the full court, NOT
#' mirrored (teams switch ends at half time), and has no basket-relative metres (null). Free throws are (0, 0)
#' with a null `zone`; legacy zones are unreliable. The inference of units and origin is the refs' (arc and
#' sideline fit), not documented by ACB. `player_name` comes from the game's shooter list.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/MatchShots/match-shots`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_shots", inline = FALSE, unit = "attempt")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_shots(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_shots <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/MatchShots/match-shots", list(matchId = match_id), call = rlang::current_env())
  .acb_out("shots", raw, "ACB Shots from api2.acb.com")
}

#' @title
#' **Get ACB Lead Tracker**
#' @description
#' Score through a game, one row per scoring moment, with the margin.
#'
#' One row per point on the lead chart: the period, the clock left, both scores and `margin` = `home_score -
#' away_score`.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/lead-tracker`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_lead_tracker", inline = FALSE, unit = "scoring moment")
#' @eval .intl_details(.acb_match_header_details, "acb_lead_tracker(match_id = 105401)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_lead_tracker <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Overview/lead-tracker", list(matchId = match_id), call = rlang::current_env())
  .acb_out("lead_tracker", raw, "ACB Lead Tracker from api2.acb.com")
}

#' @title
#' **Get ACB Lead Stats**
#' @description
#' Lead statistics of a game (best run, maximum lead, time ahead, lead changes) per side.
#'
#' One row per statistic and side (`stat` is `best_score_run`, `max_difference`, `time_ahead` or
#' `lead_changes`; `side` home or away). `value` is the display value as sent (a count, or `'mm:ss'` for time
#' ahead); `bar_progress` is the length of the site's comparison bar.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/lead-tracker`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_lead_stats", inline = FALSE, unit = "statistic and side")
#' @eval .intl_details(.acb_match_header_details, "acb_lead_stats(match_id = 105401)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_lead_stats <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Overview/lead-tracker", list(matchId = match_id), call = rlang::current_env())
  .acb_out("lead_stats", raw, "ACB Lead Stats from api2.acb.com")
}

#' @title
#' **Get ACB Lineup**
#' @description
#' Players of a game with their game line, starters first.
#'
#' One row per team and player in feed order; `lineup_order` is the 1-based position (the feed lists the
#' starters first, then the bench). `is_playing` is true while the player is on court (false once the game is
#' over). `rebounds` is total rebounds, `fouls` personal fouls committed, `differential` the plus/minus.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/lineup`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_lineup", inline = FALSE, unit = "team and player")
#' @eval .intl_details(.acb_match_header_details, "acb_lineup(match_id = 105401)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_lineup <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Overview/lineup", list(matchId = match_id), call = rlang::current_env())
  .acb_out("lineup", raw, "ACB Lineup from api2.acb.com")
}

#' @title
#' **Get ACB Match Leaders**
#' @description
#' Each team's leaders of a game by category.
#'
#' One row per team, metric and rank (`metric` is the API's category, e.g. `rating`, `points`, `rebounds`,
#' `assists`; `rank` 1 is the leader). `value` is the player's count.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/match-leaders`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_match_leaders", inline = FALSE, unit = "team, statistic and rank")
#' @eval .intl_details(.acb_match_header_details, "acb_match_leaders(match_id = 105401)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_match_leaders <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Overview/match-leaders", list(matchId = match_id), call = rlang::current_env())
  .acb_out("match_leaders", raw, "ACB Match Leaders from api2.acb.com")
}

#' @title
#' **Get ACB Team Comparison**
#' @description
#' Team-versus-team comparison bars of a game per period.
#'
#' One row per period and statistic. `quarter` 0 is the whole game. `home_value` / `away_value` parse the bar's
#' display value (Spanish decimal comma, `'79,17%'` becomes 79.17; a count stays a count); for the shooting
#' statistics `*_made` / `*_attempted` parse the `'19/24'` subtitle. `*_is_highlighted` marks the side the site
#' highlights.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/match-team-comparison`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_team_comparison", inline = FALSE, unit = "period and statistic")
#' @eval .intl_details(.acb_match_header_details, "acb_team_comparison(match_id = 105401)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_team_comparison <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Overview/match-team-comparison", list(matchId = match_id), call = rlang::current_env())
  .acb_out("team_comparison", raw, "ACB Team Comparison from api2.acb.com")
}

#' @title
#' **Get ACB Playoff Series**
#' @description
#' The playoff series a game belongs to, one row per game of the series (HTTP 204 outside a series).
#'
#' One row per game of the series: `match_id` is that game and `requested_match_id` the game asked for (every
#' row repeats it). `home_team_id` / `away_team_id` are the team entries of THAT game, `series_home_*` the team
#' with home court. `series_home_wins` / `series_away_wins` are the series wins, `best_of` the series length as
#' sent (0 in the 2016-17 final sample: read it as unknown). A game outside a series answers HTTP 204
#' (`hoopR_no_data`).
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/serie`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_serie", inline = FALSE, unit = "game of the series")
#' @eval .intl_details(.acb_match_header_details, "acb_serie(match_id = 17718)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_serie <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Overview/serie", list(matchId = match_id), call = rlang::current_env())
  .acb_out("serie", raw, "ACB Playoff Series from api2.acb.com")
}

#' @title
#' **Get ACB Quick Facts**
#' @description
#' Pre-match facts per team: standing, record, recent results.
#'
#' One row per team (`team_side` home then away): `standing` is the league position, `wins` / `losses` the
#' record before the game, `last_results` the recent results joined with `'; '` (`WIN` / `LOSS`).
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Preview/quickfacts`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_quickfacts", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.acb_match_header_details, "acb_quickfacts(match_id = 105401)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_quickfacts <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Preview/quickfacts", list(matchId = match_id), call = rlang::current_env())
  .acb_out("quickfacts", raw, "ACB Quick Facts from api2.acb.com")
}

#' @title
#' **Get ACB Season Leaders**
#' @description
#' Each team's season leaders before a game, by category.
#'
#' One row per team, metric and rank, like `acb_match_leaders` but over the season so far; `value` is a total
#' or an average depending on the metric.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Preview/season-leaders`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_season_leaders", inline = FALSE, unit = "team, statistic and rank")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_season_leaders(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_season_leaders <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Preview/season-leaders", list(matchId = match_id), call = rlang::current_env())
  .acb_out("season_leaders", raw, "ACB Season Leaders from api2.acb.com")
}

#' @title
#' **Get ACB Match Advanced Stats**
#' @description
#' Team advanced statistics of a game against the team's season and win/loss splits.
#'
#' One row per team (`team_side`), statistic group and statistic: `match_value` is this game, `season_value`
#' the team's season value, `win_value` / `loss_value` its values in wins / losses, `*_diff` the game minus
#' that split. Groups: four_factors, game_rhythm, ball_handling, shooting, points, ratings, rebounds. All are
#' `Float64` (rates are percentages 0-100 unless the stat is a ratio, such as `pointsPerPossession`).
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/AdvancedStats/match-advanced-stats`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_match_advanced_stats", inline = FALSE, unit = "team, statistic group and statistic")
#' @eval .intl_details(.acb_match_header_details, "acb_match_advanced_stats(match_id = 105401)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_match_advanced_stats <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/AdvancedStats/match-advanced-stats", list(matchId = match_id), call = rlang::current_env())
  .acb_out("match_advanced_stats", raw, "ACB Match Advanced Stats from api2.acb.com")
}

#' @title
#' **Get ACB Player Advanced Stats**
#' @description
#' One player's advanced statistics in a game against his season and win/loss splits.
#'
#' One row per statistic group and statistic, with the same value columns as `acb_match_advanced_stats`.
#' `player_id` is the requested licence (the body names no player).
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/AdvancedStats/player-advanced-stats`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @param player_id (required) ACB licence number (integer): the person id everywhere (box score, play-by-play,
#'   shots, rosters). 20209407 = Edy Tavares, 20212243 = Olek Balcerowski. A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_player_advanced_stats", inline = FALSE, unit = "statistic group and statistic")
#' @eval .intl_details(.acb_match_header_details, "acb_player_advanced_stats(match_id = 105401, player_id = 20212243)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_player_advanced_stats <- function(match_id, player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/AdvancedStats/player-advanced-stats", list(matchId = match_id, playerLicense = player_id), call = rlang::current_env())
  .acb_out("player_advanced_stats", raw, "ACB Player Advanced Stats from api2.acb.com")
}

#' @title
#' **Get ACB Match List**
#' @description
#' The games of the round (or week) around a game.
#'
#' One row per game. `home_wins` / `home_losses` / `away_wins` / `away_losses` are the teams' series record in
#' a playoff series (null otherwise). `match_grouping` is `round` or `week`. `team_id` columns are season-team
#' entries; `club_id` is stable.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/matchlist`
#' @param match_id (required) ACB match id (integer), one global sequence for every competition: legacy ids
#'   (seasons up to 2019-20) sit below about 20000 (12559 = the 2005-06 final); ids from 2020-21 start around
#'   100000 (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole number; a whole double is
#'   accepted.
#' @param round_id (default `NULL`) Round id (integer): global across seasons, not the round number (6017 =
#'   Liga 2026-27 round 3). List them with `acb_competition_rounds` or `acb_calendar`. Omitted = the current (or
#'   last) round. A whole number; a whole double is accepted.
#' @param week_id (default `NULL`) Week id (integer): global across seasons (2989 = the week of 2026-10-10).
#'   List them with `acb_competition_weeks`. A whole number; a whole double is accepted.
#' @eval .returns_rd("acb_matchlist", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_matchlist(match_id = 105401))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_matchlist <- function(match_id, round_id = NULL, week_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Menu/matchlist", list(matchId = match_id, roundId = round_id, weekId = week_id), call = rlang::current_env())
  .acb_out("matchlist", raw, "ACB Match List from api2.acb.com")
}

#' @title
#' **Get ACB Competition Editions**
#' @description
#' Every competition edition (season) the API knows, one row per edition.
#'
#' One row per competition and edition: `edition_id` (START year - 1935), `season_start_year` and `season` (END
#' year), plus how many rounds and weeks the edition lists. `competition_name` is the API's name for the
#' competition (the Liga is `Liga Nacional` here).
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`
#' @param competition_ids (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for several. Omitted =
#'   the API's default competition. One or more whole numbers (a vector repeats `competitionIds` in the query).
#' @eval .returns_rd("acb_competition_editions", inline = FALSE, unit = "edition")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_competition_editions())
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_competition_editions <- function(competition_ids = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Menu/competition-data", list(competitionIds = competition_ids), call = rlang::current_env())
  .acb_out("competition_editions", raw, "ACB Competition Editions from api2.acb.com")
}

#' @title
#' **Get ACB Competition Rounds**
#' @description
#' The rounds of every competition edition: the round ids to crawl.
#'
#' One row per edition and round: the global `round_id` (the key of the round routes), `round_number` within
#' the phase and the sub-phase.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`
#' @param competition_ids (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for several. Omitted =
#'   the API's default competition. One or more whole numbers (a vector repeats `competitionIds` in the query).
#' @eval .returns_rd("acb_competition_rounds", inline = FALSE, unit = "edition and round")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_competition_rounds())
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_competition_rounds <- function(competition_ids = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Menu/competition-data", list(competitionIds = competition_ids), call = rlang::current_env())
  .acb_out("competition_rounds", raw, "ACB Competition Rounds from api2.acb.com")
}

#' @title
#' **Get ACB Competition Weeks**
#' @description
#' The weeks of every competition edition: the week ids to crawl.
#'
#' One row per edition and week: the global `week_id`, the Spanish `description` ('Semana 1') and the Monday
#' `start_date`.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`
#' @param competition_ids (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for several. Omitted =
#'   the API's default competition. One or more whole numbers (a vector repeats `competitionIds` in the query).
#' @eval .returns_rd("acb_competition_weeks", inline = FALSE, unit = "edition and week")
#' @eval .intl_details(.acb_match_header_details, "acb_competition_weeks()")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_competition_weeks <- function(competition_ids = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Menu/competition-data", list(competitionIds = competition_ids), call = rlang::current_env())
  .acb_out("competition_weeks", raw, "ACB Competition Weeks from api2.acb.com")
}

#' @title
#' **Get ACB Competition Current**
#' @description
#' The API's current pointers: competition, edition, week, round and match.
#'
#' One row: the ids the site opens by default, and the current match with its teams.
#'
#' Endpoint: `GET https://api2.acb.com/api/matchdata/Menu/competition-data`
#' @param competition_ids (default `NULL`) Competition id (1, 2, 3, 10) or a list of ids for several. Omitted =
#'   the API's default competition. One or more whole numbers (a vector repeats `competitionIds` in the query).
#' @eval .returns_rd("acb_competition_current", inline = FALSE, unit = "game of the current round")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_competition_current())
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_competition_current <- function(competition_ids = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/matchdata/Menu/competition-data", list(competitionIds = competition_ids), call = rlang::current_env())
  .acb_out("competition_current", raw, "ACB Competition Current from api2.acb.com")
}

#' @title
#' **Get ACB Round Matches**
#' @description
#' Games of one round (or week) with scores, status and broadcasters.
#'
#' One row per game. A round route returns the whole round, postponed games included. `broadcasters` joins the
#' channel names with `'; '`. The team columns are looked up in the body's team list; `week_id` is the selected
#' week.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/Competition/matches`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @param round_id (default `NULL`) Round id (integer): global across seasons, not the round number (6017 =
#'   Liga 2026-27 round 3). List them with `acb_competition_rounds` or `acb_calendar`. Omitted = the current (or
#'   last) round. A whole number; a whole double is accepted.
#' @param week_id (default `NULL`) Week id (integer): global across seasons (2989 = the week of 2026-10-10).
#'   List them with `acb_competition_weeks`. A whole number; a whole double is accepted.
#' @param is_round_selected (default `NULL`) With week_id: false = the games played that week across rounds;
#'   true resolves the week to one round. `TRUE` or `FALSE`, sent as `true` / `false`.
#' @eval .returns_rd("acb_round_matches", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_round_matches(round_id = 6017, season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_round_matches <- function(competition_id = NULL, season = NULL, round_id = NULL, week_id = NULL, is_round_selected = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Competition/matches", list(competitionId = competition_id, season = season, roundId = round_id, weekId = week_id, isRoundSelected = is_round_selected), call = rlang::current_env())
  .acb_out("round_matches", raw, "ACB Round Matches from api2.acb.com")
}

#' @title
#' **Get ACB Standings**
#' @description
#' League table after a round (default: the current round).
#'
#' One row per team: position, record, points for and against, home and away records. `round_id` is the round
#' the table is as of; `total_rounds` the rounds in the phase.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/Competition/standings`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @param round_id (default `NULL`) Standings after this round. Round id (integer): global across seasons, not
#'   the round number (6017 = Liga 2026-27 round 3). List them with `acb_competition_rounds` or `acb_calendar`.
#'   Omitted = the current (or last) round. A whole number; a whole double is accepted.
#' @eval .returns_rd("acb_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_standings(season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_standings <- function(competition_id = NULL, season = NULL, round_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Competition/standings", list(competitionId = competition_id, season = season, roundId = round_id), call = rlang::current_env())
  .acb_out("standings", raw, "ACB Standings from api2.acb.com")
}

#' @title
#' **Get ACB Standings Rounds**
#' @description
#' Standings history: each team's position after each round, with the round's game.
#'
#' One row per team and round: `position` after that round and the team's game of the round (`match_id`).
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/Competition/standings`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @param round_id (default `NULL`) Standings after this round. Round id (integer): global across seasons, not
#'   the round number (6017 = Liga 2026-27 round 3). List them with `acb_competition_rounds` or `acb_calendar`.
#'   Omitted = the current (or last) round. A whole number; a whole double is accepted.
#' @eval .returns_rd("acb_standings_rounds", inline = FALSE, unit = "team and round")
#' @eval .intl_details(.acb_match_header_details, "acb_standings_rounds(season = 2027)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_standings_rounds <- function(competition_id = NULL, season = NULL, round_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Competition/standings", list(competitionId = competition_id, season = season, roundId = round_id), call = rlang::current_env())
  .acb_out("standings_rounds", raw, "ACB Standings Rounds from api2.acb.com")
}

#' @title
#' **Get ACB Bracket**
#' @description
#' Playoff bracket: one row per series (quarter-final, semifinal, final).
#'
#' One row per series; `stage` is quarter_finals, semifinals or final. `home_wins` / `away_wins` are the series
#' score, `best_of` the series length, `n_games` the games listed. An edition with no playoffs yet raises
#' `hoopR_no_data`.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/Competition/bracket`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_bracket", inline = FALSE, unit = "series")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_bracket(season = 2026))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_bracket <- function(competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Competition/bracket", list(competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("bracket", raw, "ACB Bracket from api2.acb.com")
}

#' @title
#' **Get ACB Bracket Games**
#' @description
#' The games of every playoff series of a bracket, one row per game.
#'
#' One row per game; `series_*` columns describe its series and `stage` the round of the bracket.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/Competition/bracket`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_bracket_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details, "acb_bracket_games(season = 2026)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_bracket_games <- function(competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Competition/bracket", list(competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("bracket_games", raw, "ACB Bracket Games from api2.acb.com")
}

#' @title
#' **Get ACB Calendar**
#' @description
#' Every round of a season with its games: one call lists every game id.
#'
#' One row per game with its round (`round_id`, `round_number`) and the teams looked up in the body's team
#' list. The cheapest way to crawl a season: one call lists every game id.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/Calendar/season-calendar`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_calendar", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_calendar(season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_calendar <- function(competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Calendar/season-calendar", list(competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("calendar", raw, "ACB Calendar from api2.acb.com")
}

#' @title
#' **Get ACB League Zones**
#' @description
#' League-wide shooting by court zone for a season.
#'
#' One row per zone: `attempts`, `made` and `points_scored`. Zone names: restricted_area, paint, mid_range_left
#' / center / right, corner_three_left / right, wing_three_left / right, top_three.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/ShotChart/league-zones`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_league_zones", inline = FALSE, unit = "zone")
#' @eval .intl_details(.acb_match_header_details, "acb_league_zones(season = 2027)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_league_zones <- function(competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/ShotChart/league-zones", list(competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("league_zones", raw, "ACB League Zones from api2.acb.com")
}

#' @title
#' **Get ACB Teams**
#' @description
#' Teams entered in a competition edition.
#'
#' One row per team: the entry of the selected edition (`team_id`, new every season) and the club's latest
#' entry (`latest_team_id`). `club_id` is the stable key.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/teams`
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_teams(season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_teams <- function(competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/teams", list(competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("teams", raw, "ACB Teams from api2.acb.com")
}

#' @title
#' **Get ACB Team Matches**
#' @description
#' A club's games in a competition edition.
#'
#' One row per game, with `is_selected_local` true when the club played at home.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/team-matches`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_team_matches", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_team_matches(club_id = 2, season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_team_matches <- function(club_id, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/team-matches", list(clubId = club_id, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("team_matches", raw, "ACB Team Matches from api2.acb.com")
}

#' @title
#' **Get ACB Next Matches**
#' @description
#' A club's most recent and upcoming games.
#'
#' One row per game (recent and upcoming around today); same columns as `acb_matchlist`.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/next-matches`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @param number_of_matches (default `NULL`) How many games to return (the site asks for 5). A whole number; a
#'   whole double is accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_next_matches", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details, "acb_next_matches(club_id = 2, number_of_matches = 5)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_next_matches <- function(club_id, number_of_matches = NULL, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/next-matches", list(clubId = club_id, numberOfMatches = number_of_matches, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("next_matches", raw, "ACB Next Matches from api2.acb.com")
}

#' @title
#' **Get ACB Club Data**
#' @description
#' Club profile: arena, contacts and links.
#'
#' One row: the club's current team entry, the arena (name, address, capacity), foundation year, contact
#' details and social links. Several fields are null for many clubs.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/club-data`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_club_data", inline = FALSE, unit = "club")
#' @eval .intl_details(.acb_match_header_details, "acb_club_data(club_id = 2)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_club_data <- function(club_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/club-data", list(clubId = club_id), call = rlang::current_env())
  .acb_out("club_data", raw, "ACB Club Data from api2.acb.com")
}

#' @title
#' **Get ACB Current Roster**
#' @description
#' A club's players and staff for an edition (default: the current one).
#'
#' One row per person; `role` is player or staff (head coach and assistants). `person_id` is the ACB licence
#' number (a player's `player_id`). `height_cm` is the player's height in centimetres (null for staff); `age`
#' is the age now; `nationality` is Spanish and `nationality_iso` its ISO alpha-2 code. `temporary_roster` is
#' true while the roster is provisional. Absence lists are not parsed.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/current-roster`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_current_roster", inline = FALSE, unit = "person")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_current_roster(club_id = 2, season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_current_roster <- function(club_id, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/current-roster", list(clubId = club_id, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("current_roster", raw, "ACB Current Roster from api2.acb.com")
}

#' @title
#' **Get ACB Team Leaders**
#' @description
#' A club's statistical leaders for an edition and all-time.
#'
#' One row per scope, metric and rank. `scope` is `all_time` (club record holders, the API's `leaders`) or
#' `edition` (the selected season, `seasonLeaders`); `metric` is the API's category (`points`, `avg_points`,
#' `played_matches`...); `value` is a total or an average depending on the metric (Float64). The scope
#' assignment is inferred from the values.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/team-leaders`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @param number_of_players (required) Leaders per statistic; 0 is refused (HTTP 400). A whole number; a whole
#'   double is accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_team_leaders", inline = FALSE, unit = "scope, statistic and rank")
#' @eval .intl_details(.acb_match_header_details, "acb_team_leaders(club_id = 2, number_of_players = 3, season = 2027)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_team_leaders <- function(club_id, number_of_players, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/team-leaders", list(clubId = club_id, numberOfPlayers = number_of_players, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("team_leaders", raw, "ACB Team Leaders from api2.acb.com")
}

#' @title
#' **Get ACB Team Stats**
#' @description
#' A club's player season statistics for an edition: totals, averages and per-40 side by side.
#'
#' One row per player. `total_*` are season counts (`Int64`; `total_time_played` is seconds, `*_percentage` are
#' Float64), `avg_*` per-game averages and `per40_*` per-40-minute rates (Float64). `num_games` is games played
#' and `starter` games started.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/team-stats`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_team_stats", inline = FALSE, unit = "player of the club")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_team_stats(club_id = 2, season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_team_stats <- function(club_id, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/team-stats", list(clubId = club_id, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("team_stats", raw, "ACB Team Stats from api2.acb.com")
}

#' @title
#' **Get ACB Team Totals**
#' @description
#' A club's team season totals, averages and per-40 values for an edition.
#'
#' One row: the same `total_*` / `avg_*` / `per40_*` columns as `acb_team_stats`, for the team as a whole
#' (`team_id` is the season-team entry).
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/team-stats`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_team_totals", inline = FALSE, unit = "club-season")
#' @eval .intl_details(.acb_match_header_details, "acb_team_totals(club_id = 2, season = 2027)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_team_totals <- function(club_id, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/team-stats", list(clubId = club_id, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("team_totals", raw, "ACB Team Totals from api2.acb.com")
}

#' @title
#' **Get ACB Team Records**
#' @description
#' A club's single-game records (best performance per statistic).
#'
#' One row per statistic (`stat`): `value` is the record, with the game (`game_id`, `game_date`), the player
#' and both teams of that game. Records go back to 1983-84; `game_id` is a match id of the legacy sequence.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/TeamProfile/team-records`
#' @param club_id (required) ACB club id (integer), stable across seasons and sponsor names (2 = Barca, 9 =
#'   Real Madrid, 13 = Valencia Basket). Not the season-team `team_id`. A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_team_records", inline = FALSE, unit = "statistic")
#' @eval .intl_details(.acb_match_header_details, "acb_team_records(club_id = 2)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_team_records <- function(club_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/TeamProfile/team-records", list(clubId = club_id), call = rlang::current_env())
  .acb_out("team_records", raw, "ACB Team Records from api2.acb.com")
}

#' @title
#' **Get ACB Player Data**
#' @description
#' Player biography: birth, nationality, height, current team and social links.
#'
#' One row. `birth_date` is a date (the API sends DD-MM-YYYY); `height_m` is metres (the API sends `'2,20'`, a
#' decimal comma); `birth_country` / `nationality` are Spanish with ISO alpha-2 in `*_iso`; `licensing` is the
#' licence code as sent (for example `EUR` or `JFL`; meanings unverified). The current team columns are the
#' player's team entry for the edition.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/player-data`
#' @param player_id (required) ACB licence number (integer): the person id everywhere (box score, play-by-play,
#'   shots, rosters). 20209407 = Edy Tavares, 20212243 = Olek Balcerowski. A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_player_data", inline = FALSE, unit = "player")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_player_data(player_id = 20209407))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_player_data <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/PlayerProfile/player-data", list(playerLicenceId = player_id), call = rlang::current_env())
  .acb_out("player_data", raw, "ACB Player Data from api2.acb.com")
}

#' @title
#' **Get ACB Player Stats**
#' @description
#' A player's season statistics, one row per team and edition.
#'
#' One row per team-edition the player played: `total_*` counts, `avg_*` averages and `per40_*` per-40 rates as
#' in `acb_team_stats`. `edition_year` is the label (`'2026-2027'`).
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/player-stats`
#' @param player_id (required) ACB licence number (integer): the person id everywhere (box score, play-by-play,
#'   shots, rosters). 20209407 = Edy Tavares, 20212243 = Olek Balcerowski. A whole number; a whole double is
#'   accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year used as an UPPER bound: the rows keep the seasons up to this
#'   one (2026 drops the 2026-27 row). Omitted = all seasons. A whole number; a whole double is accepted.
#' @eval .returns_rd("acb_player_stats", inline = FALSE, unit = "team and edition")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_player_stats(player_id = 20209407))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_player_stats <- function(player_id, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/PlayerProfile/player-stats", list(playerLicenceId = player_id, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("player_stats", raw, "ACB Player Stats from api2.acb.com")
}

#' @title
#' **Get ACB Player Totals**
#' @description
#' A player's career totals, averages and per-40 values.
#'
#' One row: the same `total_*` / `avg_*` / `per40_*` columns as `acb_player_stats` over the player's whole ACB
#' career.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/player-stats`
#' @param player_id (required) ACB licence number (integer): the person id everywhere (box score, play-by-play,
#'   shots, rosters). 20209407 = Edy Tavares, 20212243 = Olek Balcerowski. A whole number; a whole double is
#'   accepted.
#' @param competition_id (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10
#'   Minicopa Endesa (youth). Omitted = the API's default competition. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year used as an UPPER bound for the career rows. Omitted = all
#'   seasons. A whole number; a whole double is accepted.
#' @eval .returns_rd("acb_player_totals", inline = FALSE, unit = "player-season")
#' @eval .intl_details(.acb_match_header_details, "acb_player_totals(player_id = 20209407)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_player_totals <- function(player_id, competition_id = NULL, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/PlayerProfile/player-stats", list(playerLicenceId = player_id, competitionId = competition_id, season = season), call = rlang::current_env())
  .acb_out("player_totals", raw, "ACB Player Totals from api2.acb.com")
}

#' @title
#' **Get ACB Career Stints**
#' @description
#' A player's club stints, one row per stint.
#'
#' One row per stint: first and last year, the club's team entry for the stint and how many editions it spans
#' (`n_editions`).
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/career`
#' @param player_id (required) ACB licence number (integer): the person id everywhere (box score, play-by-play,
#'   shots, rosters). 20209407 = Edy Tavares, 20212243 = Olek Balcerowski. A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_career_stints", inline = FALSE, unit = "stint")
#' @eval .intl_details(.acb_match_header_details, "acb_career_stints(player_id = 20209407)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_career_stints <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/PlayerProfile/career", list(playerLicenceId = player_id), call = rlang::current_env())
  .acb_out("career_stints", raw, "ACB Career Stints from api2.acb.com")
}

#' @title
#' **Get ACB Career Trophies**
#' @description
#' A player's trophies, one row per competition.
#'
#' One row per competition: times champion and times runner-up.
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/career`
#' @param player_id (required) ACB licence number (integer): the person id everywhere (box score, play-by-play,
#'   shots, rosters). 20209407 = Edy Tavares, 20212243 = Olek Balcerowski. A whole number; a whole double is
#'   accepted.
#' @eval .returns_rd("acb_career_trophies", inline = FALSE, unit = "competition")
#' @eval .intl_details(.acb_match_header_details, "acb_career_trophies(player_id = 20209407)")
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_career_trophies <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/PlayerProfile/career", list(playerLicenceId = player_id), call = rlang::current_env())
  .acb_out("career_trophies", raw, "ACB Career Trophies from api2.acb.com")
}

#' @title
#' **Get ACB Player Matches**
#' @description
#' A player's game log for an edition (default: the current one).
#'
#' One row per game. `has_won` is true when the player's team won; `is_selected_local` is true when it played
#' at home. `play_time` is `'mm:ss'` (`seconds_played` in seconds). Percentages are Float64, the rest counts.
#' Names follow the player-route vocabulary (`rebounds`, `shots_rejected`, `fouls_received`).
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/matches`
#' @param player_id (required) ACB licence number (integer): the person id everywhere (box score, play-by-play,
#'   shots, rosters). 20209407 = Edy Tavares, 20212243 = Olek Balcerowski. A whole number; a whole double is
#'   accepted.
#' @param season (default `NULL`) Season END year (2027 = 2026-27; the first ACB season, 1983-84, is 1984).
#'   `acb_runtime` sends the API's `editionId` = season - 1936. Omitted = the current season. A whole number; a
#'   whole double is accepted.
#' @eval .returns_rd("acb_player_matches", inline = FALSE, unit = "game")
#' @eval .intl_details(.acb_match_header_details)
#' @examples
#' \donttest{
#'   try(acb_player_matches(player_id = 20209407, season = 2027))
#' }
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_player_matches <- function(player_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/PlayerProfile/matches", list(playerLicenceId = player_id, season = season), call = rlang::current_env())
  .acb_out("player_matches", raw, "ACB Player Matches from api2.acb.com")
}

#' @title
#' **Get ACB Search**
#' @description
#' Search players, teams and coaches by name.
#'
#' One row per hit; `kind` is player, team or coach. The sample holds players only (`teams` and `coaches` came
#' back empty), so the team and coach row shapes are unverified. `person_id` is the licence number for players
#' and coaches (a team hit carries its team entry id).
#'
#' Endpoint: `GET https://api2.acb.com/api/seasondata/Search/search`
#' @param search_term (required) Name fragment (accent-insensitive on the player rows); a blank term is
#'   refused.
#' @param limit (default `NULL`) Maximum results per kind (players, teams, coaches). A whole number; a whole
#'   double is accepted.
#' @eval .returns_rd("acb_search", inline = FALSE, unit = "hit")
#' @eval .intl_details(.acb_match_header_details, 'acb_search(limit = 5, search_term = "tavares")')
#' @export
#' @concept ACB Functions
#' @seealso [family_acb] lists every function in this family.
acb_search <- function(search_term, limit = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Search/search", list(searchTerm = search_term, limit = limit), call = rlang::current_env())
  .acb_out("search", raw, "ACB Search from api2.acb.com")
}
