# genius.R -- Genius Sports LiveStats wrappers (exported). Generated once from sdv-py
# sportsdataverse/basketball/genius/genius.py + basketball_crosswalk.py (origin/main e3d232e);
# maintained by hand from here. Transport, page records and parsers: R/genius_runtime.R.

#' Wrap a Genius frame as a `hoopR_data` tibble.
#' @noRd
.genius_data <- function(df, what) make_hoopR_data(df, paste("Genius LiveStats", what), Sys.time())

#' @title
#' **Genius Game**
#' @description
#' One row per finished game: period and clock state, both teams' names, codes and scores, officials.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' `team1` is the team listed first. `referee1` ... `commissioner` read `officials.<role>` (current feeds) or the flat `officials_refereeN` strings (older feeds); NA when absent.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
#' | period | integer | Current (or last) period number; restarts at 1 in overtime |
#' | period_type | character | Current period type: REGULAR or OVERTIME |
#' | in_ot | integer | 1 when the game is (or ended) in overtime, else 0 |
#' | clock | character | Clock of the current period at capture time, 'mm:ss' remaining ('00:00' once the game is over) |
#' | periods_max | integer | Number of regulation periods (4) |
#' | period_length_regular | integer | Length of a regulation period, minutes (10 under FIBA rules, 12 in some leagues) |
#' | period_length_overtime | integer | Length of an overtime period, minutes |
#' | attendance | integer | Attendance as entered by the org; 0 when not entered |
#' | disable_match | integer | 1 when the org disabled the public feed for this game, else 0 |
#' | total_time_added | integer | Clock time added by corrections, seconds (unverified; 0 in every sample) |
#' | team1_name | character | Full name of team 1, the team listed first (the home team on the hosted schedule and widget). |
#' | team1_code | character | Short code of team 1, in the competition's own script when the org enters one. |
#' | team1_score | integer | Final points of team 1 (cast to an integer; the 2014-15 feed sends a string). |
#' | team2_name | character | Full name of team 2, the team listed second. |
#' | team2_code | character | Short code of team 2, in the competition's own script when the org enters one. |
#' | team2_score | integer | Final points of team 2 (cast to an integer; the 2014-15 feed sends a string). |
#' | referee1 | character | First referee's name, from officials.referee1 (international form) or the flat officials_referee1 text. |
#' | referee2 | character | Second referee's name, from officials.referee2 (international form) or the flat officials_referee2 text. |
#' | referee3 | character | Third referee's name when the feed lists one; null otherwise. |
#' | commissioner | character | Commissioner (game supervisor) name when the feed lists one; null otherwise. |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_game(match_id = 2902690))
#' }
genius_game <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_game(raw), "game")
}

#' @title
#' **Genius Team Box Score**
#' @description
#' Team box score of a finished game: score by period, fouls, timeouts and the team totals.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' One row per team (`tno` 1 and 2; the feed has no team id). Percentages are numeric 0-100. `ot_score` is the points in overtime (NA without overtime).
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_team_box(match_id = 2902690)
#' ```
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
#' | tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
#' | name | character | Team name as the org enters it |
#' | name_international | character | Team name in Latin script |
#' | short_name | character | Short team name (shortName in the feed), in the competition's own script when the org enters one. |
#' | code | character | Team code, three letters as entered (may be in the local script, e.g. Greek 'AEK' in Greek script) |
#' | code_international | character | Team code in Latin script |
#' | coach | character | Head coach display name |
#' | score | integer | Team points (current or final); a numeric string in the 2014-15 era sample (WBBL 12248), an integer since |
#' | full_score | integer | Team points including overtime; equal to score in every sample (a numeric string in the 2014-15 era) |
#' | p1_score | integer | Points scored in period 1 (a numeric string in the 2014-15 era) |
#' | p2_score | integer | Points scored in period 2 (a numeric string in the 2014-15 era) |
#' | p3_score | integer | Points scored in period 3 (a numeric string in the 2014-15 era) |
#' | p4_score | integer | Points scored in period 4 (a numeric string in the 2014-15 era) |
#' | ot_score | integer | Points the team scored in overtime; null without overtime. Whether several overtimes are summed is unverified. |
#' | fouls | integer | Team fouls in the current (last) period |
#' | timeouts | integer | Timeouts counter of the current period (unverified: remaining vs taken); 0 in every sampled (finished) game |
#' | minutes | character | Minutes as the feed prints them, an 'mm:ss' text (can exceed 59 for a team; '199:60' happens); the text of an integer when the feed sends one. |
#' | seconds_played | integer | Seconds played parsed from the printed mm:ss text as minutes * 60 + seconds (so '224:60' gives 13500); null when the feed sent an integer, whose unit is unknown. |
#' | field_goals_made | integer | Team total: field goals made |
#' | field_goals_attempted | integer | Team total: field goals attempted |
#' | field_goals_percentage | double | Team total: field-goal percentage, 0-100, rounded to an integer by the feed |
#' | three_pointers_made | integer | Team total: three-pointers made |
#' | three_pointers_attempted | integer | Team total: three-pointers attempted |
#' | three_pointers_percentage | double | Team total: three-point percentage, 0-100, rounded to an integer |
#' | two_pointers_made | integer | Team total: two-pointers made |
#' | two_pointers_attempted | integer | Team total: two-pointers attempted |
#' | two_pointers_percentage | double | Team total: two-point percentage, 0-100, rounded to an integer |
#' | free_throws_made | integer | Team total: free throws made |
#' | free_throws_attempted | integer | Team total: free throws attempted |
#' | free_throws_percentage | double | Team total: free-throw percentage, 0-100, rounded to an integer |
#' | rebounds_defensive | integer | Team total: defensive rebounds |
#' | rebounds_offensive | integer | Team total: offensive rebounds |
#' | rebounds_total | integer | Team total: total rebounds |
#' | assists | integer | Team total: assists |
#' | turnovers | integer | Team total: turnovers |
#' | steals | integer | Team total: steals |
#' | blocks | integer | Team total: blocks made |
#' | blocks_received | integer | Team total: own shots blocked by an opponent |
#' | fouls_personal | integer | Team total: personal fouls committed |
#' | fouls_on | integer | Team total: fouls drawn |
#' | points | integer | Team total: points |
#' | points_from_turnovers | integer | Team total: points off turnovers |
#' | points_second_chance | integer | Team total: second-chance points |
#' | points_fast_break | integer | Team total: fast-break points |
#' | points_in_the_paint | integer | Team total: points in the paint |
#' | eff_1 | integer | Genius efficiency formula 1. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#' | eff_2 | integer | Genius efficiency formula 2. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Team tot_eff_2 is 2 in every 2016+ sample (a constant, not a stat). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#' | eff_3 | double | Genius efficiency formula 3. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#' | eff_4 | double | Genius efficiency formula 4. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#' | eff_5 | integer | Genius efficiency formula 5. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#' | eff_6 | integer | Genius efficiency formula 6. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#' | eff_7 | integer | Genius efficiency formula 7. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site (team total). Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#' | bench_points | integer | Team total: points scored by non-starters |
#' | biggest_lead | integer | Team total: biggest lead, points |
#' | biggest_scoring_run | integer | Team total: biggest unanswered scoring run, points |
#' | lead_changes | integer | Team total: lead changes in the game (same value on both teams) |
#' | times_scores_level | integer | Team total: times the score was tied (same value on both teams) |
#' | time_leading | double | Team total: minutes the team led, decimal minutes (33.58 = 33 min 35 s) |
#' | fouls_team | integer | Team total: team (bench) fouls |
#' | fouls_total | integer | Team total: all fouls committed (personal + technical + team bench) |
#' | rebounds_team | integer | Team total: team rebounds (credited to no player) |
#' | rebounds_team_defensive | integer | Team total: team defensive rebounds |
#' | rebounds_team_offensive | integer | Team total: team offensive rebounds |
#' | turnovers_team | integer | Team total: team turnovers (credited to no player, e.g. shot clock) |
#'
#' @family Genius Functions
#' @export
genius_team_box <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_team_box(raw), "team box score")
}

#' @title
#' **Genius Player Box Score**
#' @description
#' Player box score of a finished game: minutes, shooting, rebounds, assists and the efficiency formulas.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' Rows keyed by (`tno`, `pno`), both in-game numbers; `pno` is not the shirt number and the feed has no global player id (join across games on name, team code and `shirt_number`). Percentages are numeric 0-100; `minutes` is the printed `mm:ss` and `seconds_played` its seconds.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
#' | tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
#' | pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
#' | name | character | Display name ('T. Nichols') |
#' | first_name | character | Given name in the competition's own script and spelling (Greek, Hebrew, Czech, ... as entered) |
#' | family_name | character | Family name in the competition's own script |
#' | international_first_name | character | Given name in Latin script |
#' | international_family_name | character | Family name in Latin script (often upper case) |
#' | scoreboard_name | character | Short display name ('T. Nichols'), in the local script when the org enters one |
#' | shirt_number | character | Shirt number as a string ('0' and '00' differ) |
#' | playing_position | character | Playing position code (PG, SG, SF, PF, C, G, F, ...); empty string when not entered |
#' | starter | integer | 1 when the player started the game, else 0 |
#' | captain | integer | 1 for the team captain, else 0; absent in some orgs |
#' | active | integer | 1 when the player is on court now (at game end: on court at the final whistle), else 0 |
#' | minutes | character | Minutes as the feed prints them, an 'mm:ss' text (can exceed 59 for a team; '199:60' happens); the text of an integer when the feed sends one. |
#' | seconds_played | integer | Seconds played parsed from the printed mm:ss text as minutes * 60 + seconds (so '224:60' gives 13500); null when the feed sent an integer, whose unit is unknown. |
#' | field_goals_made | integer | Field goals the player made in the game (two- and three-pointers together; a count). |
#' | field_goals_attempted | integer | Field goals the player attempted in the game (two- and three-pointers together; a count). |
#' | field_goals_percentage | double | Field-goal percentage, 0-100, rounded to an integer by the feed |
#' | three_pointers_made | integer | Three-pointers made |
#' | three_pointers_attempted | integer | Three-pointers attempted |
#' | three_pointers_percentage | double | Three-point percentage, 0-100, rounded to an integer |
#' | two_pointers_made | integer | Two-pointers made |
#' | two_pointers_attempted | integer | Two-pointers attempted |
#' | two_pointers_percentage | double | Two-point percentage, 0-100, rounded to an integer |
#' | free_throws_made | integer | Free throws the player made in the game (a count). |
#' | free_throws_attempted | integer | Free throws the player attempted in the game (a count). |
#' | free_throws_percentage | double | Free-throw percentage, 0-100, rounded to an integer |
#' | rebounds_defensive | integer | Defensive rebounds |
#' | rebounds_offensive | integer | Offensive rebounds |
#' | rebounds_total | integer | Total rebounds (offensive plus defensive) the player collected in the game. |
#' | assists | integer | Assists credited to the player in the game. |
#' | turnovers | integer | Turnovers committed by the player in the game. |
#' | steals | integer | Steals credited to the player in the game. |
#' | blocks | integer | Shots the player blocked in the game (blocks made, not received). |
#' | blocks_received | integer | Own shots blocked by an opponent |
#' | fouls_personal | integer | Personal fouls committed |
#' | fouls_on | integer | Fouls drawn: personal fouls committed against the player in the game. |
#' | points | integer | Points the player scored in the game, free throws included. |
#' | points_from_turnovers | integer | Points off turnovers |
#' | points_second_chance | integer | Second-chance points |
#' | points_fast_break | integer | Fast-break points |
#' | points_in_the_paint | integer | Points the player scored in the paint in the game (the feed's sPointsInThePaint). |
#' | plus_minus_points | integer | Plus/minus: team point margin while the player was on court |
#' | eff_1 | integer | Genius efficiency formula 1. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
#' | eff_2 | integer | Genius efficiency formula 2. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
#' | eff_3 | double | Genius efficiency formula 3. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
#' | eff_4 | double | Genius efficiency formula 4. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
#' | eff_5 | integer | Genius efficiency formula 5. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
#' | eff_6 | integer | Genius efficiency formula 6. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site |
#' | eff_7 | integer | Genius efficiency formula 7. The feed carries seven formulas (eff_1..eff_7) with no labels; the definitions are not published. In samples eff_1/eff_6/eff_7 often agree (an index-rating style total), eff_3/eff_4 are decimals. Unverified: do not treat any as PIR/EFF without checking against a league site. Absent in the 2014-15 era sample (WBBL 12248), which carries eff_1..eff_6 on players and no team tot_eff_* |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_player_box(match_id = 2902690))
#' }
genius_player_box <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_player_box(raw), "player box score")
}

#' @title
#' **Genius Play-by-Play**
#' @description
#' Play-by-play of a finished game, newest action first, with the running score and lead.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' Rows in the feed's order: newest first by game time, so `row_index` 0 is the last action (normally the `game` `end` row); sort on `action_number` for entry order. `score_1` / `score_2` are always integer. `qualifier` joins the qualifier codes with commas. `clock`, `action_number` and `previous_action` are NA in the 2014-15 feed. Overtime restarts `period` at 1: read it with `period_type`.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
#' | row_index | integer | Position of the action in the feed order, 0 = the newest action by game time (normally the game end row). The feed is not strictly sorted by action_number, so sort on action_number for entry order. |
#' | action_number | integer | Action sequence number, unique within the game (gaps where actions were deleted); a shot joins its play-by-play row on it. Null in the 2014-15 feed. |
#' | previous_action | integer | action_number of the linked earlier action (the shot an assist or rebound belongs to); null when the feed sends an empty string. |
#' | period | integer | Period number; restarts at 1 for the first overtime (read it with period_type). |
#' | period_type | character | Period type: REGULAR or OVERTIME. |
#' | gt | character | Game clock, 'mm:ss' remaining in the period |
#' | clock | character | Game clock with hundredths, 'mm:ss:cc' remaining in the period; absent in older feeds (the 2014-15 WBBL sample has gt only) |
#' | tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
#' | pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
#' | player | character | Player display name; '' when no player |
#' | shirt_number | character | Player shirt number (string); '' when no player |
#' | first_name | character | Given name in the competition's own script and spelling (Greek, Hebrew, Czech, ... as entered) |
#' | family_name | character | Family name in the competition's own script |
#' | international_first_name | character | Given name in Latin script |
#' | international_family_name | character | Family name in Latin script (often upper case) |
#' | scoreboard_name | character | Short display name ('T. Nichols'), in the local script when the org enters one |
#' | action_type | character | Action type: 2pt, 3pt, freethrow, rebound, assist, turnover, steal, block, foul, foulon (foul drawn), substitution, timeout, jumpball, period, game, headcoachchallenge |
#' | sub_type | character | Action subtype, free-text code per actionType: shot type for 2pt/3pt (layup, drivinglayup, jumpshot, pullupjumpshot, turnaroundjumpshot, ...), 'in'/'out' for substitutions, 'start'/'end' for period and game, foul kind for fouls; empty string when none |
#' | qualifier | character | Qualifier codes of the action joined with commas (pointsinthepaint, fromturnover, 2ndchance, fastbreak, blocked, ...); null when none. |
#' | success | integer | 1 = made / successful, 0 = missed (shots, free throws); 1 for other actions |
#' | scoring | integer | 1 when the action is a scoring attempt (shot or free throw), else 0 |
#' | score_1 | integer | Team 1 score after the action, always an integer (the feed sends a string in most games). |
#' | score_2 | integer | Team 2 score after the action, always an integer (the feed sends a string in most games). |
#' | lead | integer | Score margin after the action, team 1 minus team 2 (negative when team 2 leads) |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_pbp(match_id = 2902690))
#' }
genius_pbp <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_pbp(raw), "play-by-play")
}

#' @title
#' **Genius Shot Chart**
#' @description
#' Shot chart of a finished game: court x/y (percent of the full court), result and shooter.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`
#'
#' `x` and `y` are percentages (0-100) of the full court length and width, NOT normalised to one basket (a team attacks one end in periods 1-2 and the other in 3-4); the origin corner is unverified. `result` is 1 for a made shot, 0 for a miss; `action_number` joins the play-by-play row.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_shots(match_id = 2902690)
#' ```
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
#' | tno | integer | Team number within this game: 1 = the team listed first (home on the hosted schedule and widget), 2 = the other, 0 = no team. In-game only: not a team id. |
#' | pno | integer | Player number within this game, the key of the team's player map; 0 = no player. In-game only: not a person id and not the shirt number. |
#' | action_number | integer | Action sequence number, unique within the game (gaps where actions were deleted); a shot joins its play-by-play row on it. Null in the 2014-15 feed. |
#' | period | integer | Period number; restarts at 1 for the first overtime (read it with period_type). |
#' | period_type | character | Period type: REGULAR or OVERTIME. |
#' | action_type | character | Shot value: 2pt or 3pt |
#' | sub_type | character | Shot type (layup, drivinglayup, jumpshot, pullupjumpshot, dunk, ...) |
#' | result | integer | Shot result: 1 = made, 0 = missed. |
#' | x | double | Court x, PERCENT of the full court length (0-100, float), along the long axis. Not normalised to one basket: a team attacks one end in periods 1-2 and the other end in periods 3-4 (ESAKE 2902690: team 1 mean x 90 and 86 in P1-P2, 11 and 19 in P3-P4). Which end x = 0 is, and which end team 1 starts at, are unverified |
#' | y | double | Court y, PERCENT of the full court width (0-100, float), across the court (observed 1.7-97.2). Origin side unverified |
#' | player | character | Shooter's display name as the org enters it, in the local script when it uses one. |
#' | shirt_number | character | Shooter's shirt number (string) |
#'
#' @family Genius Functions
#' @export
genius_shots <- function(match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/", match_id, "/data.json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_shots(raw), "shot chart")
}

#' @title
#' **Genius Competition Games**
#' @description
#' The recent-games window of a competition, with the global Genius team ids.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/data/competition/{comp_id}.json`
#'
#' A few recent or upcoming games, not the season. Scores are cast to integer (NA before tip-off). `match_time` is local (zone not stated), `match_time_utc` UTC.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param comp_id Genius competition id: one per org competition-season (`comp_id` of
#'   [genius_competitions()]), e.g. 49915.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | league_id | integer | Genius league id of the org (ESAKE = 115); the leagueId column of the hosted chooser |
#' | competition_id | integer | Genius competition id (compId): one per org competition-season; the \{compId\} of hosted and data/competition paths |
#' | match_id | integer | Genius match id: the \{matchId\} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
#' | match_status | character | Match status: COMPLETE, SCHEDULED, IN_PROGRESS, ... (upper case) |
#' | match_time | character | Local tip-off time, 'YYYY-MM-DD HH:MM:SS' (venue time zone, not stated) |
#' | match_time_utc | character | Tip-off time in UTC, 'YYYY-MM-DD HH:MM:SS' |
#' | live | integer | 1 while the game is live, else 0 |
#' | period | integer | Current period of a live or finished game (present on some rows only) |
#' | period_type | character | Current period type: REGULAR or OVERTIME (present on some rows only) |
#' | clock | character | Period clock of a live or finished game, 'mm:ss' remaining (present on some rows only) |
#' | home_team_id | integer | Home team: Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | home_name | character | Home team full name, in the competition's own script when the org enters one. |
#' | home_name_international | character | Home team name in Latin script |
#' | home_code | character | Home team short code, in the competition's own script when the org enters one. |
#' | home_score | integer | Home points: a string on most rows, an integer on some ('' before tip-off); cast it |
#' | away_team_id | integer | Away team: Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | away_name | character | Away team full name, in the competition's own script when the org enters one. |
#' | away_name_international | character | Away team name in Latin script |
#' | away_code | character | Away team short code, in the competition's own script when the org enters one. |
#' | away_score | integer | Away points: a string on most rows, an integer on some ('' before tip-off); cast it |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_competition_games(comp_id = 49915))
#' }
genius_competition_games <- function(comp_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/data/competition/", comp_id, ".json"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_competition_games(raw), "competition games")
}

#' @title
#' **Genius Match Competition**
#' @description
#' The competition (comp_id and name) a game belongs to, from its LiveStats HTML shell.
#'
#' Endpoint: `GET https://fibalivestats.dcd.shared.geniussports.com/u/{org}/{match_id}/`
#'
#' A one-row tibble: the only way to map a `data.json` game to its competition (`comp_id`) and, through [genius_competitions()], to a season. `org` is the ORG the request used.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_match_competition(org = "ESAKE", match_id = 2902690)
#' ```
#' @param org LiveStats ORG of the game's shell (can differ from the hosted ORG: NZN vs NZNBL).
#' @param match_id Genius match id (`match_id` of [genius_schedule()], [genius_widget_games()] or
#'   [genius_competition_games()]), e.g. 2902690.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | Match id from the page's hidden input #matchId (equals the \{matchId\} asked for). Genius match id: the \{matchId\} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
#' | comp_id | integer | Competition id from the hidden input #compId. Genius competition id (compId): one per org competition-season; the \{compId\} of hosted and data/competition paths. The way to map a data.json game to its competition and season |
#' | competition_name | character | Competition label from #competitionName, free text ('Stoiximan GBL 2026-2027'); carries the season only when the org writes it in |
#' | org_label | character | First item of og:description: the org's display code (ESAKE) |
#' | og_description | character | The page's og:description: `<ORG> , <competition>, Check out the full statistics here` |
#' | org | character | ORG code the request used (the hosted ORG, or the LiveStats ORG for the /u/ shell). |
#'
#' @family Genius Functions
#' @export
genius_match_competition <- function(org, match_id, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_LIVE, "/u/", org, "/", match_id, "/"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_match_competition(raw), "match competition")
}

#' @title
#' **Genius Competitions**
#' @description
#' Every competition of an org from the hosted WebStats chooser, with its END-year season.
#'
#' Endpoint: `GET https://hosted.dcd.shared.geniussports.com/{org}/en/schedule`
#'
#' One row per competition-season. `year` is the Genius year (START year for a two-year org, the year itself for a calendar org) and `season` the sdv END year: a two-year span in the label wins (`2019 - 20` is 2020), else the Genius year plus one for a split org, else the year itself; `season_rule` names the rule (NA season when none applies). `selected` marks the competition the chooser pre-selects.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param org Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see [genius_competitions()].
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | org | character | ORG code the request used (the hosted ORG, or the LiveStats ORG for the /u/ shell). |
#' | comp_id | integer | Genius competition id (compId): one per org competition-season; the \{compId\} of hosted and data/competition paths |
#' | label | character | Competition label as the org typed it, free text in any language: may or may not carry a season ('BASKET LEAGUE 2019 - 20', '1st division', 'Kypello Elladas' (in Greek script) = Greek Cup, 'Mavroskoufeia' (in Greek script) = Mavroskoufeia youth tournament) |
#' | league_id | integer | Genius league id of the org (ESAKE = 115; IBBA has two: 187 and 549) |
#' | year | integer | Genius season year of the competition: the START year of a two-year season (BNXT '2023-2024' = 2023), the year itself for a calendar season. null when the page gives none |
#' | season | integer | sdv END-year season of the competition (2026 = 2025-26) from the label span, else the Genius year; null when no rule applies. See season_rule. |
#' | season_rule | character | Which rule produced season: 'label span', 'genius year + 1 (split)', 'genius year (calendar)', 'label year (calendar)' or 'unknown'. |
#' | selected | logical | True for the competition the hosted chooser pre-selects (the org's default, not always the newest). |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_competitions(org = "ESAKE"))
#' }
genius_competitions <- function(org, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_HOSTED, "/", org, "/en/schedule"))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_competitions(raw), "competitions")
}

#' @title
#' **Genius Schedule**
#' @description
#' Every match of a competition (hosted WebStats): ids, status, venue, teams and scores.
#'
#' Endpoint: `GET https://hosted.dcd.shared.geniussports.com/{org}/en/competition/{comp_id}/schedule?roundNumber={round_number}`
#'
#' One row per match in page order. Scores are NA before tip-off and for some completed games whose score the page does not print. `date_time` is the page's text (local time, zone not stated). `link_match_id` is NA for orgs that hide match pages (FFBB); `venue_id` is NA when the venue is plain text. An unfilled play-off slot ('To be determined', no team or match link) takes the scope the page's other blocks prove; a page of nothing but such slots is refused.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#' @param org Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see [genius_competitions()].
#' @param comp_id Genius competition id: one per org competition-season (`comp_id` of
#'   [genius_competitions()]), e.g. 49915.
#' @param round_number Round to list; -1 (default) lists every round of the competition.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | From the block id `extfix_<id>`. Genius match id: the \{matchId\} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
#' | link_match_id | integer | Match id of the block's `/match/<id>/summary` link; equals match_id (the capture refuses a page where it does not); null when the org hides match pages (FFBB) |
#' | comp_id | integer | CompId of the match link, or of the team links when the org hides match pages (FFBB); equals the \{compId\} asked for. A 'To be determined' slot (no team or match link) takes the \{compId\} the page's other blocks prove |
#' | org | character | ORG code of the match link (or the team links, as comp_id) |
#' | status | character | Status from the block class STATUS_*: COMPLETE, SCHEDULED, POSTPONED, ... |
#' | date_time | character | Tip-off as displayed, 'Mon D, YYYY, h:mm AM' (local time, zone not stated); null when unscheduled |
#' | venue_id | integer | Genius venue id (the /venue/\{id\} of hosted pages); null when the venue is plain text (FFBB) |
#' | venue_name | character | Venue name as entered (local script) |
#' | home_team_id | integer | Home team: Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | home_team_name | character | Home team full name |
#' | home_team_code | character | Home team code (local script possible) |
#' | home_score | integer | Home points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
#' | away_team_id | integer | Away team: Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | away_team_name | character | Away team full name |
#' | away_team_code | character | Away team code (local script possible) |
#' | away_score | integer | Away points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   try(genius_schedule(org = "CEBL", comp_id = 47852))
#' }
genius_schedule <- function(org, comp_id, round_number = -1, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_HOSTED, "/", org, "/en/competition/", comp_id, "/schedule"), query = list(roundNumber = round_number))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_matches(raw, "schedule"), "schedule")
}

#' @title
#' **Genius Schedule (Embed)**
#' @description
#' Every match of a competition from the JSON-wrapped embed page (orgs whose plain pages answer 500).
#'
#' Endpoint: `GET https://hosted.dcd.shared.geniussports.com/embednf/{org}/en/competition/{comp_id}/schedule?roundNumber={round_number}`
#'
#' The same columns and rules as [genius_schedule()], read from the `/embednf/` `{css, js, html}` envelope.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_schedule_embed(org = "HKS", comp_id = 49946)
#' ```
#' @param org Genius ORG code of the league (ESAKE, CEBL, BNXT, SLB, ...); see [genius_competitions()].
#' @param comp_id Genius competition id: one per org competition-season (`comp_id` of
#'   [genius_competitions()]), e.g. 49915.
#' @param round_number Round to list; -1 (default) lists every round of the competition.
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | From the block id `extfix_<id>`. Genius match id: the \{matchId\} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
#' | link_match_id | integer | Match id of the block's `/match/<id>/summary` link; equals match_id (the capture refuses a page where it does not); null when the org hides match pages (FFBB) |
#' | comp_id | integer | CompId of the match link, or of the team links when the org hides match pages (FFBB); equals the \{compId\} asked for. A 'To be determined' slot (no team or match link) takes the \{compId\} the page's other blocks prove |
#' | org | character | ORG code of the match link (or the team links, as comp_id) |
#' | status | character | Status from the block class STATUS_*: COMPLETE, SCHEDULED, POSTPONED, ... |
#' | date_time | character | Tip-off as displayed, 'Mon D, YYYY, h:mm AM' (local time, zone not stated); null when unscheduled |
#' | venue_id | integer | Genius venue id (the /venue/\{id\} of hosted pages); null when the venue is plain text (FFBB) |
#' | venue_name | character | Venue name as entered (local script) |
#' | home_team_id | integer | Home team: Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | home_team_name | character | Home team full name |
#' | home_team_code | character | Home team code (local script possible) |
#' | home_score | integer | Home points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
#' | away_team_id | integer | Away team: Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | away_team_name | character | Away team full name |
#' | away_team_code | character | Away team code (local script possible) |
#' | away_score | integer | Away points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
#'
#' @family Genius Functions
#' @export
genius_schedule_embed <- function(org, comp_id, round_number = -1, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_HOSTED, "/embednf/", org, "/en/competition/", comp_id, "/schedule"), query = list(roundNumber = round_number))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_matches(raw, "schedule"), "embed schedule")
}

#' @title
#' **Genius Widget Games**
#' @description
#' The latest games a league site's results widget shows (needs no proxy).
#'
#' Endpoint: `GET https://widget.wh.geniussports.com/widget/?{widget_key}`
#'
#' About 5 to 50 games, newest competition first. `webcast_org` is the LiveStats ORG of the webcast link (`NZN` for the hosted `NZNBL`); a known widget key must return its own ORG's games.
#' @details
#' **Access.** The Genius hosts publish no robots.txt and no terms. CloudFront refuses
#' datacenter IPs on the LiveStats and hosted hosts: from a server set
#' `options(hoopR.proxy = ...)` or the `GENIUS_PROXY` environment variable to an http(s)
#' proxy URL (never printed or logged). Requests are spaced at least one second apart
#' per host; keep crawls slow and incremental. Some league sites (the NZ NBL) forbid AI
#' crawlers in their own robots.txt, which does not cover these hosts. Unofficial use of a
#' public source: payloads are not redistributed as release assets.
#'
#' **Org and season.** Every competition is an ORG code plus a competition id
#' (`comp_id`): [genius_competitions()] lists an org's competitions with the sdv END-year
#' `season` (a START-year org lists 2025-26 as season 2026), [genius_match_competition()]
#' maps a game to its competition, and `data.json` itself names no date, competition or
#' season. The hosted ORG can differ from the LiveStats ORG of `/u/` (NZNBL vs NZN). Match
#' ids are one global sequence across every Genius customer. `data.json` carries no global
#' team or player id: `tno` (1 or 2) and `pno` are in-game numbers; only finished games
#' are read.
#'
#' **Errors** (classed conditions, all inheriting `hoopR_error`): `hoopR_no_data` when
#' Genius has nothing for the request (HTTP 404, the S3 `AccessDenied` 403, an empty 200
#' from the hosted host, an empty recent-games window, a schedule or widget with no
#' matches); `hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius route
#' (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is unknown: the CloudFront
#' "Request blocked" 403, a rate limit or 5xx, the intermittent HTTP 500 "A website error
#' has occurred" page (`transient = TRUE`: retry later), a dead connection, an error
#' envelope, a cut-off page, an unfinished game, or a body for another match, competition
#' or ORG.
#'
#' ```r
#'  genius_widget_games(widget_key = "RFJIN037I07QV520B7WEXKV1GYNA31")
#' ```
#' @param widget_key The league site's public widget key (the bare query string of
#'   `widget.wh.geniussports.com/widget/`), e.g. `"RFJIN037I07QV520B7WEXKV1GYNA31"` (ESAKE).
#' @param return_parsed Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body or
#'   page record (a list): `data.json` as served plus `_request` (the ids asked for), or the
#'   sdv-internal-refs capture shape of a page.
#' @return A `hoopR_data` tibble (a zero-row tibble with these columns when Genius answers
#'   an empty valid page), or the raw list when `return_parsed = FALSE`:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | match_id | integer | From the webcast link. Genius match id: the \{matchId\} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
#' | webcast_org | character | ORG code of the webcast link; can differ from the hosted ORG (NZNBL games link /webcast/NZN/) |
#' | competition_name | character | Competition label, free text |
#' | status | character | Status text as shown ('Final', 'Live', a tip-off time) |
#' | date | character | Date as shown, 'DD/MM/YYYY' in samples (format follows the widget locale; unverified for others) |
#' | home_team_id | integer | Home team from the `tid<N>` class. Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | home_team_code | character | Home team short code from the widget, in the local script when the org enters one. |
#' | home_score | integer | Home points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
#' | away_team_id | integer | Away team from the `tid<N>` class. Genius team id (warehouse key space, global across orgs and seasons; the /team/\{id\} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
#' | away_team_code | character | Away team short code from the widget, in the local script when the org enters one. |
#' | away_score | integer | Away points; null before tip-off (typed integer only on a route whose 3 sampled rows were all played) |
#'
#' @family Genius Functions
#' @export
genius_widget_games <- function(widget_key, return_parsed = TRUE) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .genius_get(paste0("https://", .GENIUS_WIDGET, "/widget/?", widget_key))
  if (!isTRUE(return_parsed)) return(raw)
  .genius_data(.genius_parse_matches(raw, "widget_games"), "widget games")
}

#' @title
#' **Genius Game Crosswalk**
#' @description
#' Provider game key <-> Genius LiveStats match id, from a frame that carries both.
#'
#' Reads a frame you already have (no request is made), checks the id types and returns
#' the distinct id pairs, one-to-one both ways. Rows without a Genius id (older seasons,
#' upcoming games) are dropped.
#' @details
#' Sources: `sportpress` (BNXT `sportpress_game_slider`: `game_id` / `genius_id`), `cebl`
#' (`game_id` / `genius_match_id`), `tbf` (`match_id` / `genius_id`), `kzs` (`match_id` /
#' `genius_match_id`) and `sportality` (`game_uuid` / `game_id`, the Genius match id). The
#' provider key is integer for every source but `sportality` (a character uuid); the
#' Genius id is integer. A wrong source, a missing column, a wrong id type or a key that
#' maps to two ids raises `hoopR_bad_request`.
#' @param df A data frame from the wrapper named for `source`.
#' @param source One of `"sportpress"`, `"cebl"`, `"tbf"`, `"kzs"`, `"sportality"`.
#' @return A `hoopR_data` tibble, one row per game:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_key | integer or character | Provider's own game key: the BNXT, CEBL, TBF or KZS integer game id, or the Sportality platform game uuid (a string) for source sportality. |
#' | genius_match_id | integer | Genius Sports LiveStats match id of the same game (the match_id every genius_* wrapper takes). |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   slider <- data.frame(game_id = c(1L, 2L), genius_id = c(2902690L, NA))
#'   genius_game_crosswalk(slider, "sportpress")
#' }
genius_game_crosswalk <- function(df, source) {
  src <- .GENIUS_GAME_SOURCES[[source %||% ""]]
  if (is.null(src)) {
    choices <- names(.GENIUS_GAME_SOURCES)
    .abort_bad_request("Unknown source {.val {source}}; choose from {.val {choices}}.")
  }
  out <- .genius_pairs(df, src[1], src[3], c(src[2], "integer"), paste0("genius_game_crosswalk[", source, "]"))
  names(out) <- c("game_key", "genius_match_id")
  .genius_data(out, "game crosswalk")
}

#' @title
#' **Genius Team Crosswalk**
#' @description
#' Sportality platform team uuid <-> Genius team id, from a Sportality frame that carries both.
#'
#' The Genius ids are the ones the genius schedule frames call `home_team_id` /
#' `away_team_id`. No request is made.
#' @details
#' Sources: `sportality_standings` (`team_uuid` / `team_id`), `sportality_teams`
#' (`info_uuid` / `info_team_id`) and `sportality_players` (`info_team_uuid` /
#' `info_team_id`). A wrong source, a missing column, a wrong id type or a key that maps
#' to two ids raises `hoopR_bad_request`.
#' @param df A Sportality data frame.
#' @param source One of `"sportality_standings"`, `"sportality_teams"`, `"sportality_players"`.
#' @return A `hoopR_data` tibble, one row per team:
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_uuid | character | Sportality platform team uuid. |
#' | genius_team_id | integer | Genius team id of the same team (home_team_id / away_team_id of the genius schedule frames). |
#'
#' @family Genius Functions
#' @export
#' @examples
#' \donttest{
#'   standings <- data.frame(team_uuid = c("a1", "b2"), team_id = c(101L, 102L))
#'   genius_team_crosswalk(standings, "sportality_standings")
#' }
genius_team_crosswalk <- function(df, source) {
  src <- .GENIUS_TEAM_SOURCES[[source %||% ""]]
  if (is.null(src)) {
    choices <- names(.GENIUS_TEAM_SOURCES)
    .abort_bad_request("Unknown source {.val {source}}; choose from {.val {choices}}.")
  }
  out <- .genius_pairs(df, src[1], src[2], c("character", "integer"), paste0("genius_team_crosswalk[", source, "]"))
  names(out) <- c("team_uuid", "genius_team_id")
  .genius_data(out, "team crosswalk")
}

# source -> c(provider key column, its type, Genius match id column)
.GENIUS_GAME_SOURCES <- list(
  sportpress = c("game_id", "integer", "genius_id"),
  cebl = c("game_id", "integer", "genius_match_id"),
  tbf = c("match_id", "integer", "genius_id"),
  kzs = c("match_id", "integer", "genius_match_id"),
  sportality = c("game_uuid", "character", "game_id")
)

# source -> c(platform team uuid column, Genius team id column), on Sportality frames
.GENIUS_TEAM_SOURCES <- list(
  sportality_standings = c("team_uuid", "team_id"),
  sportality_teams = c("info_uuid", "info_team_id"),
  sportality_players = c("info_team_uuid", "info_team_id")
)

#' Distinct non-NA `(left, right)` pairs; types asserted; one-to-one both ways (sdv-py `_pairs`).
#' @noRd
.genius_pairs <- function(df, left, right, types, label, call = rlang::caller_env()) {
  if (!is.data.frame(df)) {
    cls <- class(df)[1]
    .abort_bad_request("{label}: expected a data frame, got {cls}.", call = call)
  }
  if (nrow(df) == 0L) return(.empty_tibble(rlang::set_names(types, c(left, right))))
  missing <- setdiff(c(left, right), names(df))
  if (length(missing)) .abort_bad_request("{label}: the frame has no column {.val {missing}}.", call = call)
  for (i in 1:2) {
    col <- c(left, right)[i]
    got <- class(df[[col]])[1]
    if (!identical(got, types[i])) {
      want <- types[i]
      .abort_bad_request("{label}: {col} is {got}, expected {want} (no float or string id casts).", call = call)
    }
  }
  out <- dplyr::as_tibble(df[, c(left, right)])
  out <- out[!is.na(out[[left]]) & !is.na(out[[right]]), ]
  out <- out[!duplicated(out), ]
  for (k in list(c(left, right), c(right, left))) {
    a <- k[1]
    n <- tapply(out[[k[2]]], out[[a]], function(v) length(unique(v)))
    dup <- names(n)[n > 1]
    if (length(dup)) {
      other <- k[2]
      .abort_bad_request("{label}: {a} maps to more than one {other}: {.val {utils::head(dup, 3)}}.", call = call)
    }
  }
  out
}
