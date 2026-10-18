# acb.R -- ACB (Liga Endesa, Spain) wrappers over api2.acb.com, at parity with sdv-py
# sportsdataverse/basketball/acb (origin/main e3d232ebc9). 45 wrappers over 33 routes. Transport, key and
# refusals: R/acb_runtime.R; frames: R/acb_parsers.R; field tables: R/acb_schema.R.

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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_match_header`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
#' | start | POSIXct | Tip-off, ISO 8601 UTC |
#' | status | character | Game state: FINALIZED once over; the live and scheduled values are unverified. |
#' | is_on_half_time | logical | At half time (live) |
#' | time_left | character | Period clock remaining as 'mm:ss' ('00:00' once the game is over). |
#' | current_quarter | integer | Current or last quarter (5+ = overtime; 0 for 2005-06 matches) |
#' | home_score | integer | Home points: the final score once the game is over, else the live score. |
#' | away_score | integer | Away points: the final score once the game is over, else the live score. |
#' | home_bonus | integer | Home team-foul bonus counter of the current period (unverified meaning). |
#' | away_bonus | integer | Away team-foul bonus counter of the current period (unverified meaning). |
#' | home_team_id | integer | Home season-team entry id (new every season). |
#' | home_club_id | integer | Home stable club id (2 = Barca, 9 = Real Madrid). |
#' | home_team | character | Team name that season (sponsor names change) |
#' | home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | away_team_id | integer | Away season-team entry id (new every season). |
#' | away_club_id | integer | Away stable club id. |
#' | away_team | character | Team name that season (sponsor names change) |
#' | away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | edition_id | integer | Season id (START year - 1935) read from the home team entry. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | has_overview | logical | True when the site offers the overview panels (lead tracker, lineups, leaders) for the game. |
#' | has_play_by_play | logical | True when the site offers play-by-play (2016-17 onward). |
#' | has_boxscore | logical | True when the site offers a box score for the game. |
#' | has_advanced | logical | True when the site offers advanced statistics for the game. |
#' | highlights_url | character | Highlights video URL; null when none is published. |
#' @details
#' * Legal notice (sdv-internal-refs/acb/README.md, aviso legal of acb.com read 2026-10-12): ACEB, S.A.U.
#'   claims intellectual property in the site's databases (the EU sui generis database right) among its other
#'   content. It authorises viewing and private copies for personal or journalistic use with the source credited,
#'   and requires prior express consent for distribution, reproduction or public communication. These wrappers
#'   fetch on the user's behalf; a published data release or a hosted mirror needs the owner's decision first.
#'   robots.txt allows the paths.
#' * Unofficial and unsupported: api2.acb.com is the .NET API behind acb.com and live.acb.com, not a documented
#'   public API. It needs the header `X-APIKEY`, a public key shipped in acb.com's bundle: the runtime sends the
#'   documented value (`$ACB_API_KEY` overrides it), re-reads the live bundle once on a 401, and never prints the
#'   key.
#' * Seasons: the API keys a season by `editionId` = season START year - 1935 (91 = 2026-27, 48 = 1983-84, the
#'   first). The wrappers take `season`, the END year (2027 = 2026-27), and the runtime sends `editionId = season -
#'   1936`. A route that omits `season` serves the current edition. `team_id` is a season-team entry (new every
#'   season); `club_id` is the stable club.
#' * Coverage: box scores from 1983-84 (old seasons carry only the whole-game period, quarter 0); play-by-play
#'   and shots from 2016-17 (earlier games answer empty lists, which raise `hoopR_no_data`). Shot coordinates
#'   come in two systems, split by match id: millimetres from the attacked basket from 2020-21 (`coord_system`
#'   mm), a 0-100 full-court percent grid before (grid). A game that is not finished (`matchFinished` false)
#'   raises `hoopR_asset_fetch` for the routes that report it.
#' * Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404 / 204, a route
#'   whose rows are empty: an unknown id, a game outside a playoff series, play-by-play or shots before 2016-17,
#'   a club with no games that season), `hoopR_bad_request` (a missing, unknown or non-integer argument or a
#'   season before 1984, raised before any request; HTTP 400 / 422) and `hoopR_asset_fetch` (a key the API still
#'   rejects after one re-read of the bundle, any other non-200 after three attempts, a non-JSON or
#'   `problem+json` body, an error envelope or empty stub, a body for another season, round, club, player or
#'   match, a game that is not finished). Wrappers raise; they never warn and return empty.
#' @examples
#' \donttest{
#'   try(acb_match_header(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_period_scores`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | quarter | integer | Period number: 1-4 quarters, 5+ overtimes (a finished game lists every period played). |
#' | home_score | integer | Points the home team scored IN this period (not cumulative). |
#' | away_score | integer | Points the away team scored IN this period (not cumulative). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_period_scores(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_player_box`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | quarter | integer | Period of the row: 0 = the whole game, 1-4 quarters, 5+ overtimes. |
#' | player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' | on_court | logical | True while the player is on court (false once the game is over). |
#' | play_time | character | Time on court as 'mm:ss' in the row's period. |
#' | seconds_played | integer | Time on court in whole seconds (play_time parsed). |
#' | is_starter | logical | True when the player started the game (the API's isStarted). |
#' | points | integer | Points (player box-score row) |
#' | free_throws_made | integer | Free throws the player made in the row's period (a count; quarter 0 is the whole game). |
#' | free_throws_attempted | integer | Free throws the player attempted in the row's period (a count; quarter 0 is the whole game). |
#' | two_pointers_made | integer | Two-point field goals made |
#' | two_pointers_attempted | integer | Two-point field goals attempted |
#' | three_pointers_made | integer | Three-point field goals made |
#' | three_pointers_attempted | integer | Three-point field goals attempted |
#' | assists | integer | Assists (player box-score row) |
#' | off_rebounds | integer | Offensive rebounds |
#' | def_rebounds | integer | Defensive rebounds |
#' | total_rebounds | integer | Total rebounds (player box-score row) |
#' | steals | integer | Steals (player box-score row) |
#' | turnovers | integer | Turnovers (player box-score row) |
#' | blocks | integer | Shots blocked (by this player or team) |
#' | received_blocks | integer | Own shots blocked by an opponent |
#' | dunks | integer | Dunks (player box-score row) |
#' | personal_fouls | integer | Fouls committed |
#' | fouls_drawn | integer | Fouls received (player box-score row) |
#' | plus_minus | integer | Point differential while on court (+/-) |
#' | rating | integer | Valoracion: ACB's efficiency rating (PIR) = points + rebounds + assists + steals + blocks + fouls received - missed field goals - missed free throws - turnovers - shots blocked by an opponent - fouls committed |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_player_box(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_team_box`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | quarter | integer | Period: 0 = the whole game, 1-4 the quarters, 5+ overtimes (games before about 2010 carry only 0). |
#' | scope | character | total = everything the team did (its players plus the team's own events); team = the part credited to the team itself rather than a player (team rebounds, team turnovers). |
#' | points | integer | Points, team total (players + team) |
#' | free_throws_made | integer | Free throws made, team total (players + team) |
#' | free_throws_attempted | integer | Free throws attempted, team total (players + team) |
#' | two_pointers_made | integer | Two-point field goals made, team total (players + team) |
#' | two_pointers_attempted | integer | Two-point field goals attempted, team total (players + team) |
#' | three_pointers_made | integer | Three-point field goals made, team total (players + team) |
#' | three_pointers_attempted | integer | Three-point field goals attempted, team total (players + team) |
#' | assists | integer | Assists, team total (players + team) |
#' | off_rebounds | integer | Offensive rebounds, team total (players + team) |
#' | def_rebounds | integer | Defensive rebounds, team total (players + team) |
#' | total_rebounds | integer | Total rebounds, team total (players + team) |
#' | steals | integer | Steals, team total (players + team) |
#' | turnovers | integer | Turnovers, team total (players + team) |
#' | blocks | integer | Shots blocked (by this player or team), team total (players + team) |
#' | received_blocks | integer | Own shots blocked by an opponent, team total (players + team) |
#' | dunks | integer | Dunks, team total (players + team) |
#' | personal_fouls | integer | Fouls committed, team total (players + team) |
#' | fouls_drawn | integer | Fouls received, team total (players + team) |
#' | plus_minus | integer | Point differential while on court (+/-), team total (players + team) |
#' | rating | integer | Valoracion: ACB's efficiency rating (PIR) = points + rebounds + assists + steals + blocks + fouls received - missed field goals - missed free throws - turnovers - shots blocked by an opponent - fouls committed, team total (players + team) |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_team_box(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_box_info`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | head_coach | character | Head coach's name. |
#' | assistant_coaches | character | Assistant coaches' names joined with '; '. |
#' | arena | character | Arena where the game was played; repeats on both team rows. |
#' | attendance | integer | Announced attendance; repeats on both team rows. |
#' | referees | character | Referees' names joined with '; '; repeats on both team rows. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_box_info(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_pbp`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | play_index | integer | 1-based position of the event in the feed (the feed's order key is not unique). |
#' | order | integer | Event order key, ascending through the game (10, 301, 401, ...); not contiguous and not unique (the starting five share one). |
#' | quarter | integer | Period of the event: 1-4 quarters, 5+ overtimes. |
#' | minute | integer | Game clock left in the period, minutes part (10 at tip-off; overtimes are 5 minutes). |
#' | second | integer | Game clock left in the period, seconds part. |
#' | clock_seconds | integer | Game clock REMAINING in the period as whole seconds (minute x 60 + second; the clock counts down from 600, overtimes from 300). |
#' | play_type | integer | Event code (acb_codes.PLAY_TYPES decodes it; 599 = starting lineup, one row per starter at 10:00). |
#' | play_name | character | Bundle name of play_type (acb_codes.PLAY_TYPES, e.g. TWO_POINTER_MADE); null for a code outside the enum such as the minute marker 600. |
#' | play_tag | integer | Turnover detail code on turnovers (acb_codes.PLAY_TAGS); null otherwise. |
#' | turnover_type | character | Name of the turnover detail play_tag (acb_codes.PLAY_TAGS, e.g. BAD_PASS); null when there is no tag or the tag is unmapped. |
#' | is_home | logical | True when the event belongs to the home team (the API's local); false for the away team and for neutral events. |
#' | score_home | integer | Home score after the event. |
#' | score_away | integer | Away score after the event. |
#' | license_type | integer | Licence class of the player (202 on every player event); meaning unverified; null on team and clock events. |
#' | player_id | integer | ACB licence number of the player; null on team and clock events. |
#' | player_name | character | Player display name; null on team and clock events. |
#' | shirt_number | character | Shirt number as a string; null on starting-lineup rows and on team events. |
#' | run_points | integer | The acting player's running points AFTER this event (cumulative in the game). |
#' | run_free_throws_made | integer | The acting player's running free throws made AFTER this event (cumulative in the game). |
#' | run_free_throws_attempted | integer | The acting player's running free throws attempted AFTER this event (cumulative in the game). |
#' | run_two_pointers_made | integer | The acting player's running two pointers made AFTER this event (cumulative in the game). |
#' | run_two_pointers_attempted | integer | The acting player's running two pointers attempted AFTER this event (cumulative in the game). |
#' | run_three_pointers_made | integer | The acting player's running three pointers made AFTER this event (cumulative in the game). |
#' | run_three_pointers_attempted | integer | The acting player's running three pointers attempted AFTER this event (cumulative in the game). |
#' | run_assists | integer | The acting player's running assists AFTER this event (cumulative in the game). |
#' | run_off_rebounds | integer | The acting player's running off rebounds AFTER this event (cumulative in the game). |
#' | run_def_rebounds | integer | The acting player's running def rebounds AFTER this event (cumulative in the game). |
#' | run_total_rebounds | integer | The acting player's running total rebounds AFTER this event (cumulative in the game). |
#' | run_steals | integer | The acting player's running steals AFTER this event (cumulative in the game). |
#' | run_turnovers | integer | The acting player's running turnovers AFTER this event (cumulative in the game). |
#' | run_blocks | integer | The acting player's running blocks AFTER this event (cumulative in the game). |
#' | run_personal_fouls | integer | The acting player's running personal fouls AFTER this event (cumulative in the game). |
#' | run_fouls_drawn | integer | The acting player's running fouls drawn AFTER this event (cumulative in the game). |
#' | series_wins | integer | Home team's series wins, on the END_OF_GAME event of a 2016-17 playoff game only. |
#' | series_losses | integer | Home team's series losses, on the same event. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_pbp(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_shots`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | shot_id | integer | Event id of the attempt within one match; joins nothing outside this body. |
#' | pos_x | integer | Court x as sent. mm system: millimetres from the attacked basket towards midcourt (never negative; 0 for free throws and dunks); grid system: 0-100 percent of the court length, not mirrored. |
#' | pos_y | integer | Court y as sent. mm system: millimetres across the court (sidelines at -7500 and +7500, negative = the shooter's left); grid system: 0-100 percent of the width (which sideline is 0 is unverified). Free throws are (0, 0). |
#' | coord_system | character | Shot coordinate system, told by the match id: mm = millimetres from the attacked basket (match ids from 2020-21), grid = 0-100 percent of the full court (up to 2019-20). Null when the match id is unknown. |
#' | x_basket_m | numeric | Shot x in metres from the centre of the attacked basket towards midcourt, when coord_system is mm and the attempt is a field goal; null otherwise. Units and origin are inferred by the refs (arc and sideline fit), not documented by ACB. |
#' | y_basket_m | numeric | Shot y in metres across the court from the basket line, negative = the shooter's left, when coord_system is mm and the attempt is a field goal; null otherwise (inferred by the refs, not documented by ACB). |
#' | quarter | integer | Period of the attempt: 1-4 quarters, 5+ overtimes. |
#' | minute | integer | Game clock left in the period, minutes |
#' | second | integer | Game clock left in the period, seconds part |
#' | clock_seconds | integer | Game clock REMAINING in the period as whole seconds (minute x 60 + second; the clock counts down from 600, overtimes from 300). |
#' | play_type | integer | Event code (92 free throw made, 93 two made, 94 three made, 96 free throw missed, 97 two missed, 98 three missed, 100 dunk, 533 dunk missed). |
#' | play_name | character | Bundle name of play_type (acb_codes.PLAY_TYPES, e.g. TWO_POINTER_MADE); null for a code outside the enum such as the minute marker 600. |
#' | is_home | logical | True when the shooter's team is the home team (the API's local). |
#' | score_home | integer | Home score after the attempt. |
#' | score_away | integer | Away score after the attempt. |
#' | player_id | integer | ACB licence number of the shooter. |
#' | player_name | character | Shooter's short name from the game's shooter list (e.g. 'T. Martin'). |
#' | shirt_number | character | Shooter's shirt number as a string, from the game's shooter list. |
#' | zone | character | Shot zone (acb_codes.SHOT_ZONES: restricted_area, paint, mid_range_*, corner_three_*, wing_three_*, top_three); null on free throws; legacy zones (up to 2019-20) are unreliable. |
#' | made | logical | True when the shot went in; null on some free throws. |
#' | points | integer | Points the attempt scored (2 or 3 on made field goals); null on free throws and misses. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_shots(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_lead_tracker`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | quarter | integer | Period: 1-4, 5+ overtime |
#' | minute | integer | Game clock left in the period, minutes part. |
#' | second | integer | Game clock left in the period, seconds part. |
#' | clock_seconds | integer | Game clock REMAINING in the period as whole seconds (minute x 60 + second; the clock counts down from 600, overtimes from 300). |
#' | home_score | integer | Home score at that moment. |
#' | away_score | integer | Away score at that moment. |
#' | margin | integer | Home score minus away score at that moment (positive = the home team leads). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_lead_tracker(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_lead_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | stat | character | Statistic: best_score_run, max_difference, time_ahead or lead_changes. |
#' | side | character | Side the value belongs to: home or away. |
#' | value | character | Display value as sent: a count, or 'mm:ss' for time_ahead. |
#' | bar_progress | numeric | Length of the site's comparison bar (a drawing value, not a statistic). |
#' | is_highlighted | logical | True for the side whose bar the site highlights as the better value. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_lead_stats(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_lineup`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | lineup_order | integer | 1-based position of the player in the team's list (the feed lists the starters first, then the bench). |
#' | player_id | integer | ACB licence number of the player. |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | short_name | character | Short display name ('T. Martin'). |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | play_time | character | Time on court in the game as 'mm:ss'. |
#' | seconds_played | integer | Time on court in whole seconds (play_time parsed). |
#' | is_playing | logical | True while the player is on court (false once the game is over). |
#' | points | integer | Points scored in the game. |
#' | rebounds | integer | Total rebounds in the game. |
#' | assists | integer | Assists in the game. |
#' | fouls | integer | Personal fouls committed in the game. |
#' | differential | integer | Point differential while the player was on court (plus/minus). |
#' | rating | integer | ACB rating (valoracion) of the game. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_lineup(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_match_leaders`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | metric | character | Leader category in snake_case (the API's key, e.g. rating, points, rebounds, assists). |
#' | rank | integer | Place in the category list, 1 = the leader, in the order the feed lists them. |
#' | value | numeric | The player's count in the category (points, rebounds, assists, rating). |
#' | player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_match_leaders(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_team_comparison`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | quarter | integer | Period of the bar: 0 = the whole game, 1-4 quarters. |
#' | stat | character | Compared statistic (free_throws, two_pointers, three_pointers, field_goals, rebounds, assists, steals, turnovers, personal_fouls, time_outs, points_off_turnover, paint_points, second_chance_points, fast_break_points, bench_points ...). |
#' | home_value | numeric | Home value of the bar: a percentage 0-100 for the shooting statistics (the API's `'79,17%'` decimal comma parsed), a count otherwise. |
#' | away_value | numeric | Away value of the bar, same units as home_value. |
#' | home_made | integer | Home shots made, from the 'made/attempted' subtitle; null for the non-shooting statistics. |
#' | home_attempted | integer | Home shots attempted, from the subtitle; null for the non-shooting statistics. |
#' | away_made | integer | Away shots made, from the subtitle; null for the non-shooting statistics. |
#' | away_attempted | integer | Away shots attempted, from the subtitle; null for the non-shooting statistics. |
#' | home_is_highlighted | logical | True when the site highlights the home bar as the better value. |
#' | away_is_highlighted | logical | True when the site highlights the away bar as the better value. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_team_comparison(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_serie`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | requested_match_id | integer | The match asked for (any game of the series); every row of the series repeats it. |
#' | phase_id | integer | Phase id of the series (111 = Play Off Titulo). |
#' | subphase_id | integer | Sub-phase id of the series (the playoff stage). |
#' | series_home_team_id | integer | Season-team entry of the series' home-court team (new every season). |
#' | series_home_club_id | integer | Stable club id of the series' home-court team. |
#' | series_away_team_id | integer | Season-team entry of the other team of the series. |
#' | series_away_club_id | integer | Stable club id of the other team of the series. |
#' | series_home_wins | integer | Games won by the home-court team in the series (the API's homeScore). |
#' | series_away_wins | integer | Games won by the other team in the series (the API's awayScore). |
#' | series_finished | logical | True once the series is decided. |
#' | best_of | integer | Series length (best of N) as sent; 0 in the 2016-17 final sample, so read 0 as unknown. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | match_id | integer | ACB match id of this game of the series. |
#' | home_team_id | integer | Home season-team entry of THIS game (the series' home-court team is series_home_team_id). |
#' | away_team_id | integer | Away season-team entry of THIS game. |
#' | home_score | integer | Home points of this game. |
#' | away_score | integer | Away points of this game. |
#' | start | POSIXct | Tip-off instant (UTC). |
#' | status | character | Game state: FINALIZED once over. |
#' | is_on_half_time | logical | True during the half-time break of a live game. |
#' | current_quarter | integer | Current or last period of the game (4 for a finished regulation game). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_serie(match_id = 17718))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_quickfacts`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id (new every season). |
#' | club_id | integer | Stable club id (2 = Barca, 9 = Real Madrid). |
#' | team | character | Team name for the season. |
#' | team_abbr | character | Three-letter team abbreviation. |
#' | edition_id | integer | Season id (START year - 1935). |
#' | season | integer | Season END year (edition_id + 1936). |
#' | standing | integer | League position before the game. |
#' | wins | integer | Wins before the game. |
#' | losses | integer | Losses before the game (the API's currentLoses). |
#' | last_results | character | Recent results joined with '; ' (WIN / LOSS), in the order the API sends them. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_quickfacts(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_season_leaders`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | metric | character | Leader category in snake_case (the API's key, e.g. rating, points, rebounds, assists). |
#' | rank | integer | Place in the category list, 1 = the leader, in the order the feed lists them. |
#' | value | numeric | The player's season value in the category before this game (a total or an average depending on the category). |
#' | player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_season_leaders(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_match_advanced_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_side | character | Side of the game the team played: home or away (the feed lists the home team first). |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | group | character | Statistic group in snake_case (four_factors, game_rhythm, ball_handling, shooting, points, ratings, rebounds). |
#' | stat | character | Statistic in snake_case (efg_pct, orb_pct, tov_pct, f_tr = free-throw rate, possessions, pace, points_per_possession, ast_ratio, ..., net_rating, oer, der, trb_pct). |
#' | match_value | numeric | The statistic in this game (the API's partido). |
#' | season_value | numeric | The team's value over the season (the API's temporada). |
#' | win_value | numeric | The team's value in its wins (the API's win). |
#' | loss_value | numeric | The team's value in its losses (the API's loss). |
#' | season_diff | numeric | Game value minus season value (temporadaDiff). |
#' | win_diff | numeric | Game value minus the wins value (winDiff). |
#' | loss_diff | numeric | Game value minus the losses value (lossDiff). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_match_advanced_stats(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_player_advanced_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
#' | player_id | integer | ACB licence number: the person id everywhere (box score, play-by-play, shots, rosters, the player routes). Taken from the request when the body does not name the player. |
#' | group | character | Statistic group in snake_case (four_factors, game_rhythm, ball_handling, shooting, points, ratings, rebounds). |
#' | stat | character | Statistic in snake_case (efg_pct, ts_pct, ast_pct, usage-style ratios, pace ...). |
#' | match_value | numeric | The statistic in this game (the API's partido). |
#' | season_value | numeric | The player's value over the season (temporada). |
#' | win_value | numeric | The player's value in his team's wins. |
#' | loss_value | numeric | The player's value in his team's losses. |
#' | season_diff | numeric | Game value minus season value (temporadaDiff). |
#' | win_diff | numeric | Game value minus the wins value (winDiff). |
#' | loss_diff | numeric | Game value minus the losses value (lossDiff). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_player_advanced_stats(match_id = 105401, player_id = 20212243))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_matchlist`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
#' | round_type | character | Phase code: LR = Liga Regular (regular season), PO = playoffs (a bundle value, not in the samples); null on every row of /Menu/competition-data and /TeamProfile/next-matches |
#' | round_id | integer | Round id: global across seasons, not the round number (6017 = Liga 2026-27 round 3; 2600 = 2016-17 round 1) |
#' | round_number | integer | Round number within the phase |
#' | group_id | integer | Group id in group-stage competitions |
#' | subphase_id | integer | Sub-phase id inside a phase (a playoff round or a cup round, e.g. 291, 292, 293); null in the regular season |
#' | subphase_number | integer | Sub-phase number |
#' | week_id | integer | Week id: global across seasons (2989 = the week of 2026-10-10) |
#' | status | character | Match state (x-match-statuses) |
#' | is_on_half_time | logical | At half time (live) |
#' | current_quarter | integer | Current or last quarter (0 before the match and in some finished rows) |
#' | home_score | integer | Home points (null before the match) |
#' | away_score | integer | Away points (null before the match) |
#' | start | POSIXct | Tip-off, ISO 8601 UTC |
#' | home_wins | integer | Home team's series wins before the game (playoff series only). |
#' | home_losses | integer | Home team's series losses before the game (playoff series only). |
#' | away_wins | integer | Away team's series wins before the game (playoff series only). |
#' | away_losses | integer | Away team's series losses before the game (playoff series only). |
#' | home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | home_team | character | Team name that season (sponsor names change) |
#' | home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | away_team | character | Team name that season (sponsor names change) |
#' | away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
#' | edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | is_selected_local | logical | Null in this list (set only in a club's game list). |
#' | match_grouping | character | How the list was grouped: round or week. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_matchlist(match_id = 105401))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_competition_editions`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | competition_name | character | The API's competition name ('Liga Nacional' for the Liga). |
#' | edition_id | integer | Season id (START year - 1935). |
#' | season_start_year | integer | Calendar year the season starts (2026 for 2026-27). |
#' | season | integer | Season END year (2027 for 2026-27) = seasonEndYear. |
#' | n_rounds | integer | Rounds the edition lists. |
#' | n_weeks | integer | Weeks the edition lists. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_competition_editions())
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_competition_rounds`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | edition_id | integer | Season id the round belongs to (START year - 1935). |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | round_id | integer | Round id: global across seasons, not the round number (6017 = Liga 2026-27 round 3; 2600 = 2016-17 round 1) |
#' | round_number | integer | Round number within the phase |
#' | subphase_id | integer | Sub-phase id inside a phase (a playoff round or a cup round, e.g. 291, 292, 293); null in the regular season |
#' | subphase_number | integer | Sub-phase number; null in the regular season |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_competition_rounds())
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_competition_weeks`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | edition_id | integer | Season id the week belongs to (START year - 1935). |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | week_id | integer | Week id: global across seasons (2989 = the week of 2026-10-10) |
#' | description | character | Spanish week label ('Semana 1'). |
#' | start_date | POSIXct | Monday the week starts (UTC midnight). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_competition_weeks())
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_competition_current`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition the site opens by default. |
#' | edition_id | integer | Edition (season) the site opens by default. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | week_id | integer | Week the site opens by default. |
#' | round_id | integer | Round the site opens by default. |
#' | match_grouping | character | round or week (current pointers) |
#' | match_id | integer | The current match (the featured game). |
#' | status | character | State of the current match. |
#' | start | POSIXct | Tip-off instant (UTC) of the current match. |
#' | home_team_id | integer | Home season-team entry id of the current match. |
#' | home_club_id | integer | Home stable club id of the current match. |
#' | home_team | character | Home team name of the current match. |
#' | home_team_abbr | character | Home team abbreviation of the current match. |
#' | away_team_id | integer | Away season-team entry id of the current match. |
#' | away_club_id | integer | Away stable club id of the current match. |
#' | away_team | character | Away team name of the current match. |
#' | away_team_abbr | character | Away team abbreviation of the current match. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_competition_current())
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_round_matches`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | round_id | integer | Global round id (6017 = Liga 2026-27 round 3); not the round number. |
#' | round_number | integer | Round number within the phase, looked up from the body's round list. |
#' | subphase_id | integer | Sub-phase id of the round (playoff stages); null in the regular season. |
#' | subphase_number | integer | Sub-phase number of the round; null in the regular season. |
#' | week_id | integer | Week selected in the request (the API's selectedFilters.week); null when none. |
#' | match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
#' | home_team_id | integer | Home season-team entry id (new every season; joins the body's team list). |
#' | away_team_id | integer | Away season-team entry id (new every season; joins the body's team list). |
#' | home_score | integer | Home points (null before the match) |
#' | away_score | integer | Away points (null before the match) |
#' | start | POSIXct | Tip-off, ISO 8601 UTC |
#' | status | character | Match state (x-match-statuses) |
#' | is_on_half_time | logical | At half time (live) |
#' | current_quarter | integer | Current or last quarter (5+ = overtime); not reliable after the match (1 in the 2017 series rows) |
#' | home_club_id | integer | Stable club id of the home team (looked up in the body's team list). |
#' | home_team | character | Home team name for the season (looked up in the body's team list). |
#' | home_team_abbr | character | Home team three-letter abbreviation (looked up in the body's team list). |
#' | away_club_id | integer | Stable club id of the away team (looked up in the body's team list). |
#' | away_team | character | Away team name for the season (looked up in the body's team list). |
#' | away_team_abbr | character | Away team three-letter abbreviation (looked up in the body's team list). |
#' | ticketing_link | character | Ticket shop URL; null when none. |
#' | broadcasters | character | Broadcast channel names of the game joined with '; ' (the first is the primary). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_round_matches(round_id = 6017, season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | round_id | integer | Round the table is as of (the selected round). |
#' | total_rounds | integer | Rounds in the phase. |
#' | team_id | integer | Season-team entry id (new every season). |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | position | integer | Table position (standings row) |
#' | position_trend | integer | Change in position since the previous round: positive = up (meaning of the sign unverified). |
#' | played | integer | Games played (standings row) |
#' | wins | integer | Wins (standings row) |
#' | losses | integer | Losses (the key is misspelt by the API) |
#' | win_pct | numeric | Win percentage, 0-100. |
#' | points_for | integer | Points scored (standings row) |
#' | points_against | integer | Points allowed (standings row) |
#' | plus_minus | integer | Point differential (points for minus points against). |
#' | home_wins | integer | Wins at home (the API's localBalanceWins). |
#' | home_losses | integer | Losses at home. |
#' | away_wins | integer | Wins away from home (the API's awayBalanceWins). |
#' | away_losses | integer | Losses away from home (the API's awayBalanceLosses). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_standings(season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_standings_rounds`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | team_id | integer | Season-team entry id: one club in one competition edition, NEW every season (Barca = 4467 in Liga 2026-27). Not the club: use club_id to follow a club across seasons. |
#' | club_id | integer | Stable ACB club id (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the same across seasons and sponsor names, and the club_id request argument. |
#' | team | character | Team name as registered for that season (sponsor names change; the club id does not). |
#' | team_abbr | character | Three-letter team abbreviation (BAR, RMB, VBC). |
#' | round_id | integer | Global round id of the standing. |
#' | round_number | integer | Round number within the phase |
#' | subphase_id | integer | Sub-phase id inside a phase (a playoff round or a cup round, e.g. 291, 292, 293); null in the regular season |
#' | subphase_number | integer | Sub-phase number; null in the regular season |
#' | position | integer | The team's league position after this round. |
#' | match_id | integer | The team's game in this round. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_standings_rounds(season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_bracket`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | stage | character | Bracket stage: quarter_finals, semifinals, final (other_positions when present). |
#' | phase_id | integer | Phase id of the series (111 = Play Off Titulo). |
#' | subphase_id | integer | Sub-phase id (the playoff stage). |
#' | home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | home_team | character | Team name that season (sponsor names change) |
#' | home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | away_team | character | Team name that season (sponsor names change) |
#' | away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | home_wins | integer | Games won by the home-court team in the series. |
#' | away_wins | integer | Games won by the other team in the series. |
#' | finished | logical | True once the series is decided. |
#' | best_of | integer | Series length (best of N). |
#' | n_games | integer | Games listed for the series. |
#' | edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_bracket(season = 2026))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_bracket_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | stage | character | Bracket stage: quarter_finals, semifinals, final, other_positions. |
#' | phase_id | integer | Phase id of the series (111 = Play Off Titulo). |
#' | subphase_id | integer | Sub-phase id of the series (the playoff stage). |
#' | series_home_team_id | integer | Season-team entry of the series' home-court team (new every season). |
#' | series_home_club_id | integer | Stable club id of the series' home-court team. |
#' | series_away_team_id | integer | Season-team entry of the other team of the series. |
#' | series_away_club_id | integer | Stable club id of the other team of the series. |
#' | series_home_wins | integer | Games won by the home-court team in the series (the API's homeScore). |
#' | series_away_wins | integer | Games won by the other team in the series (the API's awayScore). |
#' | series_finished | logical | True once the series is decided. |
#' | best_of | integer | Series length (best of N) as sent; 0 in the 2016-17 final sample, so read 0 as unknown. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
#' | home_team_id | integer | Home team. Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | away_team_id | integer | Away team. Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | home_score | integer | Home points (null before the match) |
#' | away_score | integer | Away points (null before the match) |
#' | start | POSIXct | Tip-off, ISO 8601 UTC |
#' | status | character | Match state (x-match-statuses) |
#' | is_on_half_time | logical | At half time (live) |
#' | current_quarter | integer | Current or last quarter (5+ = overtime); not reliable after the match (1 in the 2017 series rows) |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_bracket_games(season = 2026))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_calendar`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | round_id | integer | Global round id (6017 = Liga 2026-27 round 3); not the round number. |
#' | round_number | integer | Round number within its phase. |
#' | subphase_id | integer | Sub-phase id of the round (playoff stages); null in the regular season. |
#' | subphase_number | integer | Sub-phase number of the round; null in the regular season. |
#' | week_id | integer | Not sent by the calendar route (always null). |
#' | match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
#' | home_team_id | integer | Home season-team entry id (new every season; joins the body's team list). |
#' | away_team_id | integer | Away season-team entry id (new every season; joins the body's team list). |
#' | home_score | integer | Home points (null before the match) |
#' | away_score | integer | Away points (null before the match) |
#' | start | POSIXct | Tip-off, ISO 8601 UTC |
#' | status | character | Match state (x-match-statuses) |
#' | is_on_half_time | logical | At half time (live) |
#' | current_quarter | integer | Current or last quarter (5+ = overtime); not reliable after the match (1 in the 2017 series rows) |
#' | home_club_id | integer | Stable club id of the home team (looked up in the body's team list). |
#' | home_team | character | Home team name for the season (looked up in the body's team list). |
#' | home_team_abbr | character | Home team three-letter abbreviation (looked up in the body's team list). |
#' | away_club_id | integer | Stable club id of the away team (looked up in the body's team list). |
#' | away_team | character | Away team name for the season (looked up in the body's team list). |
#' | away_team_abbr | character | Away team three-letter abbreviation (looked up in the body's team list). |
#' | ticketing_link | character | Ticket shop URL; null when none. |
#' | broadcasters | character | Broadcast channel names of the game joined with '; ' (the first is the primary). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_calendar(season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_league_zones`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | phase_id | integer | Phase the statistics cover; null in the sample (read as all phases, unverified). |
#' | zone | character | Court zone (acb_codes.SHOT_ZONES): restricted_area, paint, mid_range_*, corner_three_*, wing_three_*, top_three. |
#' | attempts | integer | Field-goal attempts in the zone, league-wide. |
#' | made | integer | Field goals made in the zone, league-wide. |
#' | points_scored | integer | Points scored from the zone, league-wide. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_league_zones(season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Season-team entry of the selected edition (new every season). |
#' | club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | team | character | Team name that season (sponsor names change) |
#' | team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | competition_id | integer | Competition of the selected entry. |
#' | edition_id | integer | Season id of the selected entry (START year - 1935). |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | latest_team_id | integer | The club's most recent season-team entry. |
#' | latest_team | character | The club's most recent team name. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_teams(season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_team_matches`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
#' | round_type | character | Phase code: LR = Liga Regular (regular season), PO = playoffs (a bundle value, not in the samples); null on every row of /Menu/competition-data and /TeamProfile/next-matches |
#' | round_id | integer | Round id: global across seasons, not the round number (6017 = Liga 2026-27 round 3; 2600 = 2016-17 round 1) |
#' | round_number | integer | Round number within the phase |
#' | group_id | integer | Group id in group-stage competitions |
#' | subphase_id | integer | Sub-phase id of the round (playoff stages); null in the regular season. |
#' | subphase_number | integer | Sub-phase number of the round; null in the regular season. |
#' | week_id | integer | Week id: global across seasons (2989 = the week of 2026-10-10) |
#' | status | character | Match state (x-match-statuses) |
#' | is_on_half_time | logical | Not sent by this route (always null). |
#' | current_quarter | integer | Not sent by this route (always null). |
#' | home_score | integer | Home points (null before the match) |
#' | away_score | integer | Away points (null before the match) |
#' | start | POSIXct | Tip-off, ISO 8601 UTC |
#' | home_wins | integer | Not sent by this route (series records are in acb_matchlist). |
#' | home_losses | integer | Not sent by this route (series records are in acb_matchlist). |
#' | away_wins | integer | Not sent by this route (series records are in acb_matchlist). |
#' | away_losses | integer | Not sent by this route (series records are in acb_matchlist). |
#' | home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | home_team | character | Team name that season (sponsor names change) |
#' | home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | away_team | character | Team name that season (sponsor names change) |
#' | away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
#' | edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | is_selected_local | logical | True when the requested club played at home. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_team_matches(club_id = 2, season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_next_matches`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id. Legacy ids (seasons up to 2019-20) sit below about 20000 (12559 = 2005-06 final, 17718 = 2016-17 final); from 2020-21 they start at about 100000 (102920 in 2021-22, 105401 in 2026-27). One key space across competitions: the matchId param of every matchdata route. |
#' | round_type | character | Phase code: LR = Liga Regular (regular season), PO = playoffs (a bundle value, not in the samples); null on every row of /Menu/competition-data and /TeamProfile/next-matches |
#' | round_id | integer | Round id: global across seasons, not the round number (6017 = Liga 2026-27 round 3; 2600 = 2016-17 round 1) |
#' | round_number | integer | Round number within the phase |
#' | group_id | integer | Group id in group-stage competitions |
#' | subphase_id | integer | Sub-phase id inside a phase (a playoff round or a cup round, e.g. 291, 292, 293); null in the regular season |
#' | subphase_number | integer | Sub-phase number |
#' | week_id | integer | Week id: global across seasons (2989 = the week of 2026-10-10) |
#' | status | character | Match state (x-match-statuses) |
#' | is_on_half_time | logical | At half time (live) |
#' | current_quarter | integer | Current or last quarter (0 before the match and in some finished rows) |
#' | home_score | integer | Home points (null before the match) |
#' | away_score | integer | Away points (null before the match) |
#' | start | POSIXct | Tip-off, ISO 8601 UTC |
#' | home_wins | integer | Home team's wins so far |
#' | home_losses | integer | Home team's losses so far |
#' | away_wins | integer | Away team's wins so far |
#' | away_losses | integer | Away team's losses so far |
#' | home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | home_team | character | Team name that season (sponsor names change) |
#' | home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | away_team | character | Team name that season (sponsor names change) |
#' | away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
#' | edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | is_selected_local | logical | Not sent by this route (always null). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_next_matches(club_id = 2, number_of_matches = 5))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_club_data`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | team | character | Team name that season (sponsor names change) |
#' | team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
#' | edition_id | integer | Season id (`editionId`) = season START year - 1935 (91 = 2026-27, 81 = 2016-17, 70 = 2005-06, 48 = 1983-84, the first). The sdv season (END year) is editionId + 1936. Season lists also carry `seasonStartYear` / `seasonEndYear` |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | stadium_name | character | Arena name (the club's home venue). |
#' | stadium_address | character | Arena street address. |
#' | stadium_capacity | integer | Arena capacity. |
#' | president | character | Club president's name; null for most clubs. |
#' | foundation_year | integer | Year the club was founded. |
#' | web_url | character | Club website URL. |
#' | ticketing_url | character | Club ticket shop URL. |
#' | merchandising_url | character | Club merchandise shop URL (the API's merchanUrl). |
#' | instagram_url | character | Club Instagram URL. |
#' | twitter_url | character | Club X / Twitter URL. |
#' | facebook_url | character | Club Facebook URL. |
#' | youtube_url | character | Club YouTube URL. |
#' | tiktok_url | character | Club TikTok URL. |
#' | validated | logical | True when the club profile is validated by the league. |
#' | temporary_roster | logical | True while the club's roster is provisional. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_club_data(club_id = 2))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_current_roster`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | club_id | integer | Stable club id asked for (the body names no club). |
#' | role | character | player or staff (head coach and assistants). |
#' | person_id | integer | ACB licence number of the person; a player's player_id elsewhere. |
#' | person_name | character | Display name as the site shows it. |
#' | first_name | character | First name(s); null when the API does not send it. |
#' | last_name | character | Last name(s); null when the API does not send it. |
#' | shirt_number | character | Shirt number as a string; null for staff. |
#' | game_role | character | Position or staff role in Spanish (Base, Escolta, Alero, Ala-pivot, Pivot; Entrenador, Segundo Entrenador). |
#' | licensing | character | Licence code (for example EUR, JFL, CRE); meaning unverified. |
#' | age | integer | Age in years as sent by the roster route. |
#' | nationality | character | Nationality as sent, a Spanish country name ('Serbia', 'EE.UU.'). |
#' | nationality_iso | character | ISO 3166-1 alpha-2 code of nationality, from the 31 observed names; null for an unseen name. |
#' | height_cm | integer | Height in centimetres (players only). |
#' | is_license_active | logical | True when the licence is active in the current season. |
#' | edition_id | integer | Season id the person record was read for (START year - 1935). |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | temporary_roster | logical | True while the roster is provisional. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_current_roster(club_id = 2, season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_team_leaders`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | club_id | integer | Stable club id asked for. |
#' | competition_id | integer | Competition of the selected edition. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | scope | character | all_time = club record holders (the API's leaders); edition = the selected season (seasonLeaders). The assignment is inferred from the values (689 games for J.C. Navarro is a career figure). |
#' | metric | character | Category in snake_case; avg_* are per-game averages, the rest totals. |
#' | rank | integer | Place in the category list, 1 = the leader, in the order the feed lists them. |
#' | value | numeric | The player's value in the category (a total or an average depending on the metric). |
#' | player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_team_leaders(club_id = 2, number_of_players = 3, season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_team_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | club_id | integer | Stable club id of the club asked for (2 = Barca). |
#' | team_id | integer | Season-team entry id of the selected edition. |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' | total_num_games | integer | Season total of games played. |
#' | total_time_played | integer | Season total of time on court in seconds. |
#' | total_starter | integer | Season total of games started. |
#' | total_points | integer | Season total of points. |
#' | total_max_points | integer | Season total of most points in a single game. |
#' | total_three_pointers_made | integer | Season total of three-point field goals made. |
#' | total_three_pointers_attempted | integer | Season total of three-point field goals attempted. |
#' | total_three_pointers_percentage | numeric | Season total of three-point percentage (0-100). |
#' | total_two_pointers_made | integer | Season total of two-point field goals made. |
#' | total_two_pointers_attempted | integer | Season total of two-point field goals attempted. |
#' | total_two_pointers_percentage | numeric | Season total of two-point percentage (0-100). |
#' | total_free_throws_made | integer | Season total of free throws made. |
#' | total_free_throws_attempted | integer | Season total of free throws attempted. |
#' | total_free_throws_percentage | numeric | Season total of free-throw percentage (0-100). |
#' | total_rebounds | integer | Season total of total rebounds. |
#' | total_offensive_rebounds | integer | Season total of offensive rebounds. |
#' | total_defensive_rebounds | integer | Season total of defensive rebounds. |
#' | total_assists | integer | Season total of assists. |
#' | total_steals | integer | Season total of steals. |
#' | total_turnovers | integer | Season total of turnovers. |
#' | total_blocks | integer | Season total of blocks made. |
#' | total_shots_rejected | integer | Season total of own shots blocked. |
#' | total_dunks | integer | Season total of dunks. |
#' | total_personal_fouls | integer | Season total of personal fouls committed. |
#' | total_fouls_received | integer | Season total of fouls drawn. |
#' | total_rating | integer | Season total of ACB rating (valoracion). |
#' | total_plus_minus | integer | Season total of plus/minus. |
#' | total_wins | integer | Season total of team wins in the counted games (meaning unverified). |
#' | total_losses | integer | Season total of team losses in the counted games (meaning unverified). |
#' | avg_num_games | numeric | Per-game average of games played. |
#' | avg_time_played | numeric | Per-game average of time on court in seconds. |
#' | avg_starter | numeric | Per-game average of games started. |
#' | avg_points | numeric | Per-game average of points. |
#' | avg_max_points | numeric | Per-game average of most points in a single game. |
#' | avg_three_pointers_made | numeric | Per-game average of three-point field goals made. |
#' | avg_three_pointers_attempted | numeric | Per-game average of three-point field goals attempted. |
#' | avg_three_pointers_percentage | numeric | Per-game average of three-point percentage (0-100). |
#' | avg_two_pointers_made | numeric | Per-game average of two-point field goals made. |
#' | avg_two_pointers_attempted | numeric | Per-game average of two-point field goals attempted. |
#' | avg_two_pointers_percentage | numeric | Per-game average of two-point percentage (0-100). |
#' | avg_free_throws_made | numeric | Per-game average of free throws made. |
#' | avg_free_throws_attempted | numeric | Per-game average of free throws attempted. |
#' | avg_free_throws_percentage | numeric | Per-game average of free-throw percentage (0-100). |
#' | avg_rebounds | numeric | Per-game average of total rebounds. |
#' | avg_offensive_rebounds | numeric | Per-game average of offensive rebounds. |
#' | avg_defensive_rebounds | numeric | Per-game average of defensive rebounds. |
#' | avg_assists | numeric | Per-game average of assists. |
#' | avg_steals | numeric | Per-game average of steals. |
#' | avg_turnovers | numeric | Per-game average of turnovers. |
#' | avg_blocks | numeric | Per-game average of blocks made. |
#' | avg_shots_rejected | numeric | Per-game average of own shots blocked. |
#' | avg_dunks | numeric | Per-game average of dunks. |
#' | avg_personal_fouls | numeric | Per-game average of personal fouls committed. |
#' | avg_fouls_received | numeric | Per-game average of fouls drawn. |
#' | avg_rating | numeric | Per-game average of ACB rating (valoracion). |
#' | avg_plus_minus | numeric | Per-game average of plus/minus. |
#' | avg_wins | numeric | Per-game average of team wins in the counted games (meaning unverified). |
#' | avg_losses | numeric | Per-game average of team losses in the counted games (meaning unverified). |
#' | per40_num_games | numeric | Per-40-minute rate of games played. |
#' | per40_time_played | numeric | Always null: the per-40 block carries no time played. |
#' | per40_starter | numeric | Per-40-minute rate of games started. |
#' | per40_points | numeric | Per-40-minute rate of points. |
#' | per40_max_points | numeric | Per-40-minute rate of most points in a single game. |
#' | per40_three_pointers_made | numeric | Per-40-minute rate of three-point field goals made. |
#' | per40_three_pointers_attempted | numeric | Per-40-minute rate of three-point field goals attempted. |
#' | per40_three_pointers_percentage | numeric | Per-40-minute rate of three-point percentage (0-100). |
#' | per40_two_pointers_made | numeric | Per-40-minute rate of two-point field goals made. |
#' | per40_two_pointers_attempted | numeric | Per-40-minute rate of two-point field goals attempted. |
#' | per40_two_pointers_percentage | numeric | Per-40-minute rate of two-point percentage (0-100). |
#' | per40_free_throws_made | numeric | Per-40-minute rate of free throws made. |
#' | per40_free_throws_attempted | numeric | Per-40-minute rate of free throws attempted. |
#' | per40_free_throws_percentage | numeric | Per-40-minute rate of free-throw percentage (0-100). |
#' | per40_rebounds | numeric | Per-40-minute rate of total rebounds. |
#' | per40_offensive_rebounds | numeric | Per-40-minute rate of offensive rebounds. |
#' | per40_defensive_rebounds | numeric | Per-40-minute rate of defensive rebounds. |
#' | per40_assists | numeric | Per-40-minute rate of assists. |
#' | per40_steals | numeric | Per-40-minute rate of steals. |
#' | per40_turnovers | numeric | Per-40-minute rate of turnovers. |
#' | per40_blocks | numeric | Per-40-minute rate of blocks made. |
#' | per40_shots_rejected | numeric | Per-40-minute rate of own shots blocked. |
#' | per40_dunks | numeric | Per-40-minute rate of dunks. |
#' | per40_personal_fouls | numeric | Per-40-minute rate of personal fouls committed. |
#' | per40_fouls_received | numeric | Per-40-minute rate of fouls drawn. |
#' | per40_rating | numeric | Per-40-minute rate of ACB rating (valoracion). |
#' | per40_plus_minus | numeric | Per-40-minute rate of plus/minus. |
#' | per40_wins | numeric | Per-40-minute rate of team wins in the counted games (meaning unverified). |
#' | per40_losses | numeric | Per-40-minute rate of team losses in the counted games (meaning unverified). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_team_stats(club_id = 2, season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_team_totals`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | club_id | integer | Stable club id of the club asked for (2 = Barca). |
#' | team_id | integer | Season-team entry id (the API's teamEditionId). |
#' | edition_id | integer | Season id (editionId) = season START year - 1935 (91 = 2026-27). The wrappers take the END year, `season`. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | total_num_games | integer | Season total of games played. |
#' | total_time_played | integer | Season total of time on court in seconds. |
#' | total_starter | integer | Season total of games started. |
#' | total_points | integer | Season total of points. |
#' | total_max_points | integer | Season total of most points in a single game. |
#' | total_three_pointers_made | integer | Season total of three-point field goals made. |
#' | total_three_pointers_attempted | integer | Season total of three-point field goals attempted. |
#' | total_three_pointers_percentage | numeric | Season total of three-point percentage (0-100). |
#' | total_two_pointers_made | integer | Season total of two-point field goals made. |
#' | total_two_pointers_attempted | integer | Season total of two-point field goals attempted. |
#' | total_two_pointers_percentage | numeric | Season total of two-point percentage (0-100). |
#' | total_free_throws_made | integer | Season total of free throws made. |
#' | total_free_throws_attempted | integer | Season total of free throws attempted. |
#' | total_free_throws_percentage | numeric | Season total of free-throw percentage (0-100). |
#' | total_rebounds | integer | Season total of total rebounds. |
#' | total_offensive_rebounds | integer | Season total of offensive rebounds. |
#' | total_defensive_rebounds | integer | Season total of defensive rebounds. |
#' | total_assists | integer | Season total of assists. |
#' | total_steals | integer | Season total of steals. |
#' | total_turnovers | integer | Season total of turnovers. |
#' | total_blocks | integer | Season total of blocks made. |
#' | total_shots_rejected | integer | Season total of own shots blocked. |
#' | total_dunks | integer | Season total of dunks. |
#' | total_personal_fouls | integer | Season total of personal fouls committed. |
#' | total_fouls_received | integer | Season total of fouls drawn. |
#' | total_rating | integer | Season total of ACB rating (valoracion). |
#' | total_plus_minus | integer | Season total of plus/minus. |
#' | total_wins | integer | Season total of team wins in the counted games (meaning unverified). |
#' | total_losses | integer | Season total of team losses in the counted games (meaning unverified). |
#' | avg_num_games | numeric | Per-game average of games played. |
#' | avg_time_played | numeric | Per-game average of time on court in seconds. |
#' | avg_starter | numeric | Per-game average of games started. |
#' | avg_points | numeric | Per-game average of points. |
#' | avg_max_points | numeric | Per-game average of most points in a single game. |
#' | avg_three_pointers_made | numeric | Per-game average of three-point field goals made. |
#' | avg_three_pointers_attempted | numeric | Per-game average of three-point field goals attempted. |
#' | avg_three_pointers_percentage | numeric | Per-game average of three-point percentage (0-100). |
#' | avg_two_pointers_made | numeric | Per-game average of two-point field goals made. |
#' | avg_two_pointers_attempted | numeric | Per-game average of two-point field goals attempted. |
#' | avg_two_pointers_percentage | numeric | Per-game average of two-point percentage (0-100). |
#' | avg_free_throws_made | numeric | Per-game average of free throws made. |
#' | avg_free_throws_attempted | numeric | Per-game average of free throws attempted. |
#' | avg_free_throws_percentage | numeric | Per-game average of free-throw percentage (0-100). |
#' | avg_rebounds | numeric | Per-game average of total rebounds. |
#' | avg_offensive_rebounds | numeric | Per-game average of offensive rebounds. |
#' | avg_defensive_rebounds | numeric | Per-game average of defensive rebounds. |
#' | avg_assists | numeric | Per-game average of assists. |
#' | avg_steals | numeric | Per-game average of steals. |
#' | avg_turnovers | numeric | Per-game average of turnovers. |
#' | avg_blocks | numeric | Per-game average of blocks made. |
#' | avg_shots_rejected | numeric | Per-game average of own shots blocked. |
#' | avg_dunks | numeric | Per-game average of dunks. |
#' | avg_personal_fouls | numeric | Per-game average of personal fouls committed. |
#' | avg_fouls_received | numeric | Per-game average of fouls drawn. |
#' | avg_rating | numeric | Per-game average of ACB rating (valoracion). |
#' | avg_plus_minus | numeric | Per-game average of plus/minus. |
#' | avg_wins | numeric | Per-game average of team wins in the counted games (meaning unverified). |
#' | avg_losses | numeric | Per-game average of team losses in the counted games (meaning unverified). |
#' | per40_num_games | numeric | Per-40-minute rate of games played. |
#' | per40_time_played | numeric | Always null: the per-40 block carries no time played. |
#' | per40_starter | numeric | Per-40-minute rate of games started. |
#' | per40_points | numeric | Per-40-minute rate of points. |
#' | per40_max_points | numeric | Per-40-minute rate of most points in a single game. |
#' | per40_three_pointers_made | numeric | Per-40-minute rate of three-point field goals made. |
#' | per40_three_pointers_attempted | numeric | Per-40-minute rate of three-point field goals attempted. |
#' | per40_three_pointers_percentage | numeric | Per-40-minute rate of three-point percentage (0-100). |
#' | per40_two_pointers_made | numeric | Per-40-minute rate of two-point field goals made. |
#' | per40_two_pointers_attempted | numeric | Per-40-minute rate of two-point field goals attempted. |
#' | per40_two_pointers_percentage | numeric | Per-40-minute rate of two-point percentage (0-100). |
#' | per40_free_throws_made | numeric | Per-40-minute rate of free throws made. |
#' | per40_free_throws_attempted | numeric | Per-40-minute rate of free throws attempted. |
#' | per40_free_throws_percentage | numeric | Per-40-minute rate of free-throw percentage (0-100). |
#' | per40_rebounds | numeric | Per-40-minute rate of total rebounds. |
#' | per40_offensive_rebounds | numeric | Per-40-minute rate of offensive rebounds. |
#' | per40_defensive_rebounds | numeric | Per-40-minute rate of defensive rebounds. |
#' | per40_assists | numeric | Per-40-minute rate of assists. |
#' | per40_steals | numeric | Per-40-minute rate of steals. |
#' | per40_turnovers | numeric | Per-40-minute rate of turnovers. |
#' | per40_blocks | numeric | Per-40-minute rate of blocks made. |
#' | per40_shots_rejected | numeric | Per-40-minute rate of own shots blocked. |
#' | per40_dunks | numeric | Per-40-minute rate of dunks. |
#' | per40_personal_fouls | numeric | Per-40-minute rate of personal fouls committed. |
#' | per40_fouls_received | numeric | Per-40-minute rate of fouls drawn. |
#' | per40_rating | numeric | Per-40-minute rate of ACB rating (valoracion). |
#' | per40_plus_minus | numeric | Per-40-minute rate of plus/minus. |
#' | per40_wins | numeric | Per-40-minute rate of team wins in the counted games (meaning unverified). |
#' | per40_losses | numeric | Per-40-minute rate of team losses in the counted games (meaning unverified). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_team_totals(club_id = 2, season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_team_records`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | club_id | integer | Stable club id asked for. |
#' | stat | character | Record category in snake_case (rating, points, rebounds, assists, steals, ...). |
#' | value | numeric | The record value (a count; Float64 so every category fits). |
#' | game_id | integer | Match id of the record game (legacy sequence for old games). |
#' | game_date | POSIXct | Date of the record game (UTC midnight). |
#' | player_id | integer | ACB licence number: the person id everywhere. A player's box-score `player.id`, his play-by-play and shot `playerLicenseId` and the `playerLicenceId` / `playerLicense` request params hold the same number (all 24 players of match 105401 match). 20209407 = Edy Tavares. Older licences start 2020..., recent ones 3000.... |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' | local_team_id | integer | Home season-team entry of the record game. |
#' | local_club_id | integer | Home stable club id of the record game. |
#' | local_team | character | Home team name in the record game. |
#' | local_team_abbr | character | Home team abbreviation in the record game. |
#' | visitor_team_id | integer | Away season-team entry of the record game. |
#' | visitor_club_id | integer | Away stable club id of the record game. |
#' | visitor_team | character | Away team name in the record game. |
#' | visitor_team_abbr | character | Away team abbreviation in the record game. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_team_records(club_id = 2))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_player_data`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | ACB licence number of the player. |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' | is_license_active | logical | True when the licence is active in the current season. |
#' | licensing | character | Licence code (for example EUR, JFL); meaning unverified. |
#' | birth_date | Date | Birth date (the API sends DD-MM-YYYY). |
#' | birth_place | character | Birth place (town or city) as sent. |
#' | birth_country | character | Birth country as sent, a Spanish name. |
#' | birth_country_iso | character | ISO 3166-1 alpha-2 code of the birth country; null for an unseen name. |
#' | nationality | character | Nationality as sent, a Spanish country name. |
#' | nationality_iso | character | ISO 3166-1 alpha-2 code of nationality; null for an unseen name. |
#' | height_m | numeric | Height in metres (the API sends '2,20', a decimal comma). |
#' | player_number | integer | Current shirt number (integer). |
#' | team_id | integer | Current team's season-team entry id. |
#' | club_id | integer | Current team's stable club id. |
#' | team | character | Current team name for the edition. |
#' | team_abbr | character | Current team abbreviation. |
#' | edition_id | integer | Season id the player record was read for (START year - 1935). |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | instagram | character | Instagram handle; null when none. |
#' | twitter | character | X / Twitter handle; null when none. |
#' | facebook | character | Facebook handle; null when none. |
#' | youtube | character | YouTube handle; null when none. |
#' | tiktok | character | TikTok handle; null when none. |
#' | pronunciation_url | character | URL of an audio clip of the name; null when none. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_player_data(player_id = 20209407))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_player_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | ACB licence number asked for (the body names the player only in the totals block). |
#' | team_id | integer | Season-team entry the row covers (the API's teamEditionId). |
#' | competition_id | integer | Competition of the row. |
#' | edition_id | integer | Season id of the row (START year - 1935). |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | edition_year | character | Season label as sent ('2026-2027'). |
#' | club_id | integer | Stable club id of the team. |
#' | team | character | Team name that season. |
#' | team_abbr | character | Team abbreviation that season. |
#' | total_num_games | integer | Season total of games played. |
#' | total_time_played | integer | Season total of time on court in seconds. |
#' | total_starter | integer | Season total of games started. |
#' | total_points | integer | Season total of points. |
#' | total_max_points | integer | Season total of most points in a single game. |
#' | total_three_pointers_made | integer | Season total of three-point field goals made. |
#' | total_three_pointers_attempted | integer | Season total of three-point field goals attempted. |
#' | total_three_pointers_percentage | numeric | Season total of three-point percentage (0-100). |
#' | total_two_pointers_made | integer | Season total of two-point field goals made. |
#' | total_two_pointers_attempted | integer | Season total of two-point field goals attempted. |
#' | total_two_pointers_percentage | numeric | Season total of two-point percentage (0-100). |
#' | total_free_throws_made | integer | Season total of free throws made. |
#' | total_free_throws_attempted | integer | Season total of free throws attempted. |
#' | total_free_throws_percentage | numeric | Season total of free-throw percentage (0-100). |
#' | total_rebounds | integer | Season total of total rebounds. |
#' | total_offensive_rebounds | integer | Season total of offensive rebounds. |
#' | total_defensive_rebounds | integer | Season total of defensive rebounds. |
#' | total_assists | integer | Season total of assists. |
#' | total_steals | integer | Season total of steals. |
#' | total_turnovers | integer | Season total of turnovers. |
#' | total_blocks | integer | Season total of blocks made. |
#' | total_shots_rejected | integer | Season total of own shots blocked. |
#' | total_dunks | integer | Season total of dunks. |
#' | total_personal_fouls | integer | Season total of personal fouls committed. |
#' | total_fouls_received | integer | Season total of fouls drawn. |
#' | total_rating | integer | Season total of ACB rating (valoracion). |
#' | total_plus_minus | integer | Season total of plus/minus. |
#' | total_wins | integer | Season total of team wins in the counted games (meaning unverified). |
#' | total_losses | integer | Season total of team losses in the counted games (meaning unverified). |
#' | avg_num_games | numeric | Per-game average of games played. |
#' | avg_time_played | numeric | Per-game average of time on court in seconds. |
#' | avg_starter | numeric | Per-game average of games started. |
#' | avg_points | numeric | Per-game average of points. |
#' | avg_max_points | numeric | Per-game average of most points in a single game. |
#' | avg_three_pointers_made | numeric | Per-game average of three-point field goals made. |
#' | avg_three_pointers_attempted | numeric | Per-game average of three-point field goals attempted. |
#' | avg_three_pointers_percentage | numeric | Per-game average of three-point percentage (0-100). |
#' | avg_two_pointers_made | numeric | Per-game average of two-point field goals made. |
#' | avg_two_pointers_attempted | numeric | Per-game average of two-point field goals attempted. |
#' | avg_two_pointers_percentage | numeric | Per-game average of two-point percentage (0-100). |
#' | avg_free_throws_made | numeric | Per-game average of free throws made. |
#' | avg_free_throws_attempted | numeric | Per-game average of free throws attempted. |
#' | avg_free_throws_percentage | numeric | Per-game average of free-throw percentage (0-100). |
#' | avg_rebounds | numeric | Per-game average of total rebounds. |
#' | avg_offensive_rebounds | numeric | Per-game average of offensive rebounds. |
#' | avg_defensive_rebounds | numeric | Per-game average of defensive rebounds. |
#' | avg_assists | numeric | Per-game average of assists. |
#' | avg_steals | numeric | Per-game average of steals. |
#' | avg_turnovers | numeric | Per-game average of turnovers. |
#' | avg_blocks | numeric | Per-game average of blocks made. |
#' | avg_shots_rejected | numeric | Per-game average of own shots blocked. |
#' | avg_dunks | numeric | Per-game average of dunks. |
#' | avg_personal_fouls | numeric | Per-game average of personal fouls committed. |
#' | avg_fouls_received | numeric | Per-game average of fouls drawn. |
#' | avg_rating | numeric | Per-game average of ACB rating (valoracion). |
#' | avg_plus_minus | numeric | Per-game average of plus/minus. |
#' | avg_wins | numeric | Per-game average of team wins in the counted games (meaning unverified). |
#' | avg_losses | numeric | Per-game average of team losses in the counted games (meaning unverified). |
#' | per40_num_games | numeric | Per-40-minute rate of games played. |
#' | per40_time_played | numeric | Always null: the per-40 block carries no time played. |
#' | per40_starter | numeric | Per-40-minute rate of games started. |
#' | per40_points | numeric | Per-40-minute rate of points. |
#' | per40_max_points | numeric | Per-40-minute rate of most points in a single game. |
#' | per40_three_pointers_made | numeric | Per-40-minute rate of three-point field goals made. |
#' | per40_three_pointers_attempted | numeric | Per-40-minute rate of three-point field goals attempted. |
#' | per40_three_pointers_percentage | numeric | Per-40-minute rate of three-point percentage (0-100). |
#' | per40_two_pointers_made | numeric | Per-40-minute rate of two-point field goals made. |
#' | per40_two_pointers_attempted | numeric | Per-40-minute rate of two-point field goals attempted. |
#' | per40_two_pointers_percentage | numeric | Per-40-minute rate of two-point percentage (0-100). |
#' | per40_free_throws_made | numeric | Per-40-minute rate of free throws made. |
#' | per40_free_throws_attempted | numeric | Per-40-minute rate of free throws attempted. |
#' | per40_free_throws_percentage | numeric | Per-40-minute rate of free-throw percentage (0-100). |
#' | per40_rebounds | numeric | Per-40-minute rate of total rebounds. |
#' | per40_offensive_rebounds | numeric | Per-40-minute rate of offensive rebounds. |
#' | per40_defensive_rebounds | numeric | Per-40-minute rate of defensive rebounds. |
#' | per40_assists | numeric | Per-40-minute rate of assists. |
#' | per40_steals | numeric | Per-40-minute rate of steals. |
#' | per40_turnovers | numeric | Per-40-minute rate of turnovers. |
#' | per40_blocks | numeric | Per-40-minute rate of blocks made. |
#' | per40_shots_rejected | numeric | Per-40-minute rate of own shots blocked. |
#' | per40_dunks | numeric | Per-40-minute rate of dunks. |
#' | per40_personal_fouls | numeric | Per-40-minute rate of personal fouls committed. |
#' | per40_fouls_received | numeric | Per-40-minute rate of fouls drawn. |
#' | per40_rating | numeric | Per-40-minute rate of ACB rating (valoracion). |
#' | per40_plus_minus | numeric | Per-40-minute rate of plus/minus. |
#' | per40_wins | numeric | Per-40-minute rate of team wins in the counted games (meaning unverified). |
#' | per40_losses | numeric | Per-40-minute rate of team losses in the counted games (meaning unverified). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_player_stats(player_id = 20209407))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_player_totals`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | ACB licence number of the player. |
#' | player_name | character | Display (sporting) name ('Edy Tavares') |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' | total_num_games | integer | Season total of games played. |
#' | total_time_played | integer | Season total of time on court in seconds. |
#' | total_starter | integer | Season total of games started. |
#' | total_points | integer | Season total of points. |
#' | total_max_points | integer | Season total of most points in a single game. |
#' | total_three_pointers_made | integer | Season total of three-point field goals made. |
#' | total_three_pointers_attempted | integer | Season total of three-point field goals attempted. |
#' | total_three_pointers_percentage | numeric | Season total of three-point percentage (0-100). |
#' | total_two_pointers_made | integer | Season total of two-point field goals made. |
#' | total_two_pointers_attempted | integer | Season total of two-point field goals attempted. |
#' | total_two_pointers_percentage | numeric | Season total of two-point percentage (0-100). |
#' | total_free_throws_made | integer | Season total of free throws made. |
#' | total_free_throws_attempted | integer | Season total of free throws attempted. |
#' | total_free_throws_percentage | numeric | Season total of free-throw percentage (0-100). |
#' | total_rebounds | integer | Season total of total rebounds. |
#' | total_offensive_rebounds | integer | Season total of offensive rebounds. |
#' | total_defensive_rebounds | integer | Season total of defensive rebounds. |
#' | total_assists | integer | Season total of assists. |
#' | total_steals | integer | Season total of steals. |
#' | total_turnovers | integer | Season total of turnovers. |
#' | total_blocks | integer | Season total of blocks made. |
#' | total_shots_rejected | integer | Season total of own shots blocked. |
#' | total_dunks | integer | Season total of dunks. |
#' | total_personal_fouls | integer | Season total of personal fouls committed. |
#' | total_fouls_received | integer | Season total of fouls drawn. |
#' | total_rating | integer | Season total of ACB rating (valoracion). |
#' | total_plus_minus | integer | Season total of plus/minus. |
#' | total_wins | integer | Season total of team wins in the counted games (meaning unverified). |
#' | total_losses | integer | Season total of team losses in the counted games (meaning unverified). |
#' | avg_num_games | numeric | Per-game average of games played. |
#' | avg_time_played | numeric | Per-game average of time on court in seconds. |
#' | avg_starter | numeric | Per-game average of games started. |
#' | avg_points | numeric | Per-game average of points. |
#' | avg_max_points | numeric | Per-game average of most points in a single game. |
#' | avg_three_pointers_made | numeric | Per-game average of three-point field goals made. |
#' | avg_three_pointers_attempted | numeric | Per-game average of three-point field goals attempted. |
#' | avg_three_pointers_percentage | numeric | Per-game average of three-point percentage (0-100). |
#' | avg_two_pointers_made | numeric | Per-game average of two-point field goals made. |
#' | avg_two_pointers_attempted | numeric | Per-game average of two-point field goals attempted. |
#' | avg_two_pointers_percentage | numeric | Per-game average of two-point percentage (0-100). |
#' | avg_free_throws_made | numeric | Per-game average of free throws made. |
#' | avg_free_throws_attempted | numeric | Per-game average of free throws attempted. |
#' | avg_free_throws_percentage | numeric | Per-game average of free-throw percentage (0-100). |
#' | avg_rebounds | numeric | Per-game average of total rebounds. |
#' | avg_offensive_rebounds | numeric | Per-game average of offensive rebounds. |
#' | avg_defensive_rebounds | numeric | Per-game average of defensive rebounds. |
#' | avg_assists | numeric | Per-game average of assists. |
#' | avg_steals | numeric | Per-game average of steals. |
#' | avg_turnovers | numeric | Per-game average of turnovers. |
#' | avg_blocks | numeric | Per-game average of blocks made. |
#' | avg_shots_rejected | numeric | Per-game average of own shots blocked. |
#' | avg_dunks | numeric | Per-game average of dunks. |
#' | avg_personal_fouls | numeric | Per-game average of personal fouls committed. |
#' | avg_fouls_received | numeric | Per-game average of fouls drawn. |
#' | avg_rating | numeric | Per-game average of ACB rating (valoracion). |
#' | avg_plus_minus | numeric | Per-game average of plus/minus. |
#' | avg_wins | numeric | Per-game average of team wins in the counted games (meaning unverified). |
#' | avg_losses | numeric | Per-game average of team losses in the counted games (meaning unverified). |
#' | per40_num_games | numeric | Per-40-minute rate of games played. |
#' | per40_time_played | numeric | Always null: the per-40 block carries no time played. |
#' | per40_starter | numeric | Per-40-minute rate of games started. |
#' | per40_points | numeric | Per-40-minute rate of points. |
#' | per40_max_points | numeric | Per-40-minute rate of most points in a single game. |
#' | per40_three_pointers_made | numeric | Per-40-minute rate of three-point field goals made. |
#' | per40_three_pointers_attempted | numeric | Per-40-minute rate of three-point field goals attempted. |
#' | per40_three_pointers_percentage | numeric | Per-40-minute rate of three-point percentage (0-100). |
#' | per40_two_pointers_made | numeric | Per-40-minute rate of two-point field goals made. |
#' | per40_two_pointers_attempted | numeric | Per-40-minute rate of two-point field goals attempted. |
#' | per40_two_pointers_percentage | numeric | Per-40-minute rate of two-point percentage (0-100). |
#' | per40_free_throws_made | numeric | Per-40-minute rate of free throws made. |
#' | per40_free_throws_attempted | numeric | Per-40-minute rate of free throws attempted. |
#' | per40_free_throws_percentage | numeric | Per-40-minute rate of free-throw percentage (0-100). |
#' | per40_rebounds | numeric | Per-40-minute rate of total rebounds. |
#' | per40_offensive_rebounds | numeric | Per-40-minute rate of offensive rebounds. |
#' | per40_defensive_rebounds | numeric | Per-40-minute rate of defensive rebounds. |
#' | per40_assists | numeric | Per-40-minute rate of assists. |
#' | per40_steals | numeric | Per-40-minute rate of steals. |
#' | per40_turnovers | numeric | Per-40-minute rate of turnovers. |
#' | per40_blocks | numeric | Per-40-minute rate of blocks made. |
#' | per40_shots_rejected | numeric | Per-40-minute rate of own shots blocked. |
#' | per40_dunks | numeric | Per-40-minute rate of dunks. |
#' | per40_personal_fouls | numeric | Per-40-minute rate of personal fouls committed. |
#' | per40_fouls_received | numeric | Per-40-minute rate of fouls drawn. |
#' | per40_rating | numeric | Per-40-minute rate of ACB rating (valoracion). |
#' | per40_plus_minus | numeric | Per-40-minute rate of plus/minus. |
#' | per40_wins | numeric | Per-40-minute rate of team wins in the counted games (meaning unverified). |
#' | per40_losses | numeric | Per-40-minute rate of team losses in the counted games (meaning unverified). |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_player_totals(player_id = 20209407))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_career_stints`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | ACB licence number asked for. |
#' | initial_year | integer | Year the stint starts. |
#' | end_year | integer | Year the stint ends (the season's END year). |
#' | team_id | integer | Team entry of the stint's latest edition. |
#' | club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | team | character | Team name that season (sponsor names change) |
#' | team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | edition_id | integer | Season id of the stint's team entry (START year - 1935). |
#' | n_editions | integer | Editions the stint spans. |
#' | has_no_validated_data | logical | True when the stint has no validated data. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_career_stints(player_id = 20209407))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_career_trophies`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | ACB licence number asked for. |
#' | competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
#' | times_champion | integer | Times the player won the competition. |
#' | times_runner_up | integer | Times the player was runner-up in the competition. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_career_trophies(player_id = 20209407))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_player_matches`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | ACB licence number asked for. |
#' | match_id | integer | ACB match id of the game. |
#' | round_type | character | Phase code of the game (LR regular season, PO playoff). |
#' | round_number | integer | Round number within the phase. |
#' | date | POSIXct | Tip-off instant (UTC). |
#' | home_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | home_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | home_team | character | Team name that season (sponsor names change) |
#' | home_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | away_team_id | integer | Season-team id: one team's entry in one competition edition (4467 = Barca in Liga 2026-27, 4388 = Real Madrid in Liga 2025-26). Changes every season and competition. Joins every `homeTeamId` / `awayTeamId` / `teamId` / `teamEditionId`. Not the club id. |
#' | away_club_id | integer | Club id, stable across seasons and sponsor names (2 = Barca, 9 = Real Madrid, 13 = Valencia Basket): the `clubId` request param and every `homeClubId` / `awayClubId`. |
#' | away_team | character | Team name that season (sponsor names change) |
#' | away_team_abbr | character | Three-letter abbreviation (BAR, RMB) |
#' | edition_id | integer | Season id read from the home team entry (START year - 1935). |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' | is_selected_local | logical | True when the player's team played at home. |
#' | has_won | logical | True when the player's team won the game. |
#' | play_time | character | Time on court as 'mm:ss'. |
#' | seconds_played | integer | Time on court in whole seconds (play_time parsed). |
#' | points | integer | Points (player game-log row) |
#' | three_pointers_made | integer | Three-point field goals made |
#' | three_pointers_attempted | integer | Three-point field goals attempted |
#' | three_pointers_percentage | numeric | Three-point percentage, 0-100 with one decimal; 0 when there was no attempt |
#' | two_pointers_made | integer | Two-point field goals made |
#' | two_pointers_attempted | integer | Two-point field goals attempted |
#' | two_pointers_percentage | numeric | Two-point percentage, 0-100 with one decimal; 0 when there was no attempt |
#' | free_throws_made | integer | Free throws the player made in that match (a count, not a season total). |
#' | free_throws_attempted | integer | Free throws the player attempted in that match (a count, not a season total). |
#' | free_throws_percentage | numeric | Free-throw percentage, 0-100 with one decimal; 0 when there was no attempt |
#' | rebounds | integer | Total rebounds in the game. |
#' | offensive_rebounds | integer | Offensive rebounds the player took in that match (a count; part of the total rebounds). |
#' | defensive_rebounds | integer | Defensive rebounds the player took in that match (a count; part of the total rebounds). |
#' | assists | integer | Assists (player game-log row) |
#' | steals | integer | Steals (player game-log row) |
#' | turnovers | integer | Turnovers (player game-log row) |
#' | blocks | integer | Shots blocked (player game-log row) |
#' | shots_rejected | integer | Shots of the player that were blocked. |
#' | dunks | integer | Dunks (player game-log row) |
#' | personal_fouls | integer | Fouls committed |
#' | fouls_received | integer | Fouls drawn by the player in the game. |
#' | rating | integer | ACB rating (valoracion) of the game. |
#' | plus_minus | integer | Point differential while on court (+/-) |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_player_matches(player_id = 20209407, season = 2027))
#' }
#' @export
#' @family ACB Functions
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
#' @return
#' A `hoopR_data` tibble, one row per record described above; the columns are always these, in this order
#'   (sdv-py `acb_search`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | kind | character | player, team or coach. |
#' | person_id | integer | ACB licence number (players, coaches) or the team entry id (teams). |
#' | name | character | Display name (nickname) of a player or coach; the team name of a team. |
#' | short_name | character | Short display name ('T. Martin'). |
#' | first_name | character | Legal first name(s) |
#' | last_name | character | Legal last name(s) |
#' | shirt_number | character | Shirt number, a string ('' or null when unknown) |
#' | game_role | character | Position or staff role, in Spanish: Base (point guard), Escolta (shooting guard), Alero (small forward), Ala-pivot (power forward), Pivot (centre); Entrenador (head coach), Segundo Entrenador / Entrenador Ayudante (assistant coach). Null or '' in many rows |
#' | is_license_active | logical | The licence is active in the current season |
#' | club_id | integer | Stable club id of a team hit; null for players. |
#' | edition_id | integer | Season id of the record; null in search results. |
#' | season | integer | Season END year (2027 = 2026-27) = edition_id + 1936: the key the wrappers take. |
#' @inherit acb_match_header details
#' @examples
#' \donttest{
#'   try(acb_search(limit = 5, search_term = "tavares"))
#' }
#' @export
#' @family ACB Functions
acb_search <- function(search_term, limit = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .acb_get("/seasondata/Search/search", list(searchTerm = search_term, limit = limit), call = rlang::current_env())
  .acb_out("search", raw, "ACB Search from api2.acb.com")
}
