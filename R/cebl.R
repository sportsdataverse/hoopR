# cebl.R -- CEBL (Canada) wrappers over the league's own stats API (api.data.cebl.ca, the backend of
# the CEBL Stats Hub), at parity with sdv-py sportsdataverse/basketball/cebl (origin/main e3d232ebc9).
# Transport, key and refusals: R/cebl_runtime.R; frames: R/cebl_parsers.R; columns: R/cebl_schema.R.

# The @details of every cebl topic that shares the cebl_seasons() notes (roxygen @eval .intl_details()).
.cebl_seasons_details <- c(
  "* Unofficial use of the CEBL's own API: these wrappers read the league's own FastAPI service (api.data.cebl.ca,",
  "  the backend of the CEBL Stats Hub) with the X-Api-Key that the hub's own page bundle ships to every browser.",
  "  The key is not issued to third parties and no developer terms were found; cebl.ca's terms of use were not",
  "  reviewed. The runtime reads the key from the bundle at run time, falls back to a documented constant, never",
  "  prints it, and raises `hoopR_asset_fetch` with a 'key rotated?' hint on a persistent 401.",
  "  www.cebl.ca/robots.txt disallows nothing. Requests are spaced at least 1 s apart.",
  "* Season is the calendar year (May to August) = the sdv END year: no mapping. The first season is 2019. An",
  "  unknown season, team or player answers an empty list, which the runtime raises as `hoopR_no_data`. Ids are",
  "  CEBL's own; a relocated franchise has two team ids (cebl_teams lists all 15).",
  "* This API has no box-score, play-by-play or shot route. They live in Genius LiveStats (organisation CEBL, see",
  "  the genius family): cebl_games and cebl_player_gamelog carry the Genius match id as genius_match_id, parsed",
  "  from the stats URLs (derived, not fetched; the match of a cancelled game may have no data). home_team_id is",
  "  Genius team 1 and away_team_id team 2 (checked on match 2600563).",
  "* Some completed schedule rows have null scores (2026), and a cancelled game has status CANELLED (the API's",
  "  spelling) with null or zero scores. The schedule lists unplayed games too, so no wrapper refuses an unfinished",
  "  game. Aggregates are decimal strings upstream and double here. Players' names, nationality and birth date are",
  "  the public bio; no contact data is served.",
  "* Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty list, an all-null profile: an unknown",
  "  season, team or player), `hoopR_bad_request` (a bad argument, HTTP 400 / 422) and `hoopR_asset_fetch` (a key",
  "  the API still refuses after one re-read, any other non-200, a non-JSON body, an error envelope, a body for",
  "  another season, team or player), all inheriting `hoopR_error`. HTTP 500 is the API's answer to a bad id and is",
  "  not retried. Wrappers raise; they never return an empty frame.",
  "* Deliberate divergence: a string column that the API sends as an object, or a list of objects, carries compact",
  "  JSON here (`{\"name\":\"TSN\"}`), where sdv-py's String cast writes Python's `str(dict)` repr (`{'name': 'TSN'}`).",
  "  No string column of the committed fixtures carries an object."
)

#' @title
#' **Get CEBL Seasons**
#' @description
#' Every CEBL season (2019 on), with the active and live flags.
#'
#' Endpoint: `GET https://api.data.cebl.ca/seasons/`
#' @return
#' A `hoopR_data` tibble: Every CEBL season (2019 on), with the active and live flags. An empty valid answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `cebl_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season_id | integer | CEBL season row id (1 = 2019 ... 8 = 2026). No route takes it: routes take `year`. |
#' | season | integer | Season: the calendar year it is played in (May-August) = the sdv END year. The key every route's `season` param takes. |
#' | is_active | logical | True for the current season (one row: 2026 on 2026-10-12). |
#' | is_live | logical | True while the current season is in progress or open for live data (true for 2026 on 2026-10-12, after its last game: the exact meaning is unverified). |
#' @eval .intl_details(.cebl_seasons_details)
#' @examples
#' \donttest{
#'   try(cebl_seasons())
#' }
#' @export
#' @family CEBL Functions
cebl_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "seasons", call = rlang::current_env())
  .cebl_out(.cebl_parse("seasons", raw), "CEBL Seasons from the CEBL Stats API")
}

#' @title
#' **Get CEBL Teams**
#' @description
#' Every franchise identity, past and present (15 team ids; a relocated franchise has a second id).
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/`
#' @return
#' A `hoopR_data` tibble: Every franchise identity, past and present (15 team ids; a relocated franchise has a
#'   second id). An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `cebl_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
#' | name_en | character | Team full name in English ('Niagara River Lions'). |
#' | short_name_en | character | Team short name in English, usually the city ('Niagara'). |
#' | name_fr | character | Team full name in French ('River Lions de Niagara'). |
#' | short_name_fr | character | Team short name in French, usually the city. |
#' | is_active | logical | True for a team in the current league; false for a former identity (Guelph Nighthawks, Hamilton Honey Badgers, Fraser Valley Bandits, Saskatchewan Rattlers, Newfoundland Growlers). |
#' | logo_url | character | Team logo URL (icon with the team name; upstream: 'Should include the icon and team name'). |
#' | icon_url | character | Team icon URL (upstream: 'Should not include the team name'). |
#' @inherit cebl_seasons details
#' @examples
#' \donttest{
#'   try(cebl_teams())
#' }
#' @export
#' @family CEBL Functions
cebl_teams <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "teams", call = rlang::current_env())
  .cebl_out(.cebl_parse("teams", raw), "CEBL Teams from the CEBL Stats API")
}

#' @title
#' **Get CEBL Standings**
#' @description
#' Standings of one season, one row per team: record, home/away splits, games behind, streak.
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/{season}/`
#' @param season (required) Season: the calendar year it is played in (May to August) = the sdv END year (2025 = the
#'   2025 season). The CEBL's first season is 2019. A season with no data answers `hoopR_no_data`.
#' @return
#' A `hoopR_data` tibble: Standings of one season, one row per team: record, home/away splits, games behind, streak.
#'   An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `cebl_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
#' | team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
#' | name_en | character | Team full name in English ('Niagara River Lions'). |
#' | short_name_en | character | Team short name in English, usually the city ('Niagara'). |
#' | name_fr | character | Team full name in French ('River Lions de Niagara'). |
#' | short_name_fr | character | Team short name in French, usually the city. |
#' | conference | character | Conference: EAST or WEST. |
#' | position | integer | Rank in the team's conference standings (1 = first), not a playing position. |
#' | played | integer | Regular-season games played (24 a team in 2025). |
#' | wins | integer | Regular-season games won. |
#' | win_percentage | double | Win fraction, 0-1 (0.583), not a percentage; the API sends a decimal string. |
#' | home_wins | integer | Regular-season home games won. |
#' | away_wins | integer | Regular-season away games won. |
#' | losses | integer | Regular-season games lost. |
#' | home_losses | integer | Regular-season home games lost. |
#' | away_losses | integer | Regular-season away games lost. |
#' | games_behind | double | Games behind the conference leader; the API sends a decimal string ('0.0'). |
#' | points_difference | integer | Points scored minus points allowed over the season. An integer. |
#' | last_five | character | Record in the last 5 games, 'W-L' ('4-1'). |
#' | streak | character | Current streak: W or L and its length ('W4', 'L1'). |
#' | logo_url | character | Team logo URL (icon with the team name) on Google Cloud Storage. |
#' | icon_url | character | Team icon URL (without the team name) on Google Cloud Storage. |
#' | tickets_url_en | character | Ticket-sales page for the team's home games (English). |
#' | tickets_url_fr | character | Ticket-sales page for the team's home games (French). |
#' | website_url_en | character | The team's own website (English). |
#' | website_url_fr | character | The team's own website (French). |
#' | shop_url_en | character | The team's merchandise shop (English). |
#' | shop_url_fr | character | The team's merchandise shop (French). |
#' | stats_url_en | character | The team's stats page on cebl.ca (`https://cebl.ca/stats/{slug}`). |
#' | stats_url_fr | character | The team's stats page on the French cebl.ca (`https://cebl.ca/fr-ca/stats/{slug}`). |
#' @inherit cebl_seasons details
#' @examples
#' \donttest{
#'   try(cebl_standings(season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_standings <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "standings", season = season, call = rlang::current_env())
  .cebl_out(.cebl_parse("standings", raw), "CEBL Standings from the CEBL Stats API")
}

#' @title
#' **Get CEBL Team Roster**
#' @description
#' One team's roster in one season: player, nationality, birth date, position and jersey.
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/{team_id}/roster/{season}/`
#' @param team_id (required) CEBL team id of that season (``team_id`` in cebl_standings), e.g. 20 (Ottawa
#'   BlackJacks).
#' @param season (required) Season: the calendar year it is played in (May to August) = the sdv END year (2025 = the
#'   2025 season). The CEBL's first season is 2019. A season with no data answers `hoopR_no_data`.
#' @return
#' A `hoopR_data` tibble: One team's roster in one season: player, nationality, birth date, position and jersey. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `cebl_roster`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season of the roster asked for (from the request; the body does not echo it). |
#' | team_id | integer | CEBL team id of the roster asked for (from the request; the body does not echo it). |
#' | player_id | integer | CEBL player id (its own key space). Joins /players/\{player_id\}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
#' | full_name | character | Player's full name. |
#' | nationality | character | Nationality: an upper-case English country name ('CANADA', 'UNITED STATES', 'SOUTH SUDAN'); null when unknown. |
#' | birth_date | Date | Date of birth, YYYY-MM-DD (players' public bio field); null when unknown. |
#' | position | character | Playing position: G (guard), F (forward), C (center), or a combination such as 'C/F'; null when unknown. |
#' | jersey_number | character | Jersey number, as a string of up to 2 characters ('0', '00' and '1' are distinct); null when unknown. |
#' | photo_url | character | Player headshot URL on the Genius Sports image CDN (images.statsengine.playbyplay.api.geniussports.com). |
#' @inherit cebl_seasons details
#' @examples
#' \donttest{
#'   try(cebl_roster(team_id = 14, season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_roster <- function(team_id, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "roster", team_id = team_id, season = season, call = rlang::current_env())
  .cebl_out(.cebl_parse("roster", raw), "CEBL Team Roster from the CEBL Stats API")
}

#' @title
#' **Get CEBL Team Statistics**
#' @description
#' Team statistic table (totals or per game) with a league row; filter by season, competition, segment, opponent
#' team or opponent conference.
#'
#' Endpoint: `GET https://api.data.cebl.ca/teams/statistics/aggregated/`
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @param segment (default `NULL`) Game subset: HOME, AWAY, L7D (last 7 days), L5G (last 5 games), L10G (last 10
#'   games), MAY, JUNE, JULY or AUGUST. `NULL` = all games. Values from the CEBL Stats Hub bundle.
#' @param vs_team_id (default `NULL`) CEBL team id of the opponent: only games against that team count.
#' @param vs_conference (default `NULL`) EAST or WEST: only games against that conference's teams count.
#' @return
#' A `hoopR_data` tibble: Team statistic table (totals or per game) with a league row; filter by season,
#'   competition, segment, opponent team or opponent conference. An empty valid answer raises `hoopR_no_data`; the
#'   columns are always these, in this order (sdv-py `cebl_team_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
#' | mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
#' | competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
#' | segment | character | Game-subset filter of the request (HOME, AWAY, L5G, MAY ...); null for all games. The body does not echo it. |
#' | vs_conference | character | Opponent-conference filter of the request (EAST or WEST); null when not asked. The body does not echo it. |
#' | vs_team_id | integer | Opponent team filter of the request (CEBL team id); null when not asked. The body does not echo it. |
#' | team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). Null on the league row. |
#' | is_league_row | logical | True on the one league row of a team table (null team_id and names): the league's own figures, where played counts team-games and, in TOTALS, points equals points_against. |
#' | name_en | character | Team full name in English ('Niagara River Lions'). Null on the league row. |
#' | short_name_en | character | Team short name in English, usually the city ('Niagara'). Null on the league row. |
#' | name_fr | character | Team full name in French ('River Lions de Niagara'). Null on the league row. |
#' | short_name_fr | character | Team short name in French, usually the city. Null on the league row. |
#' | played | integer | Games played (a count in both modes). On the league row: team-games (twice the games). |
#' | wins | integer | Wins (a count in both modes). |
#' | win_percentage | double | Wins / games played, 0-1 with 3 decimals ('0.625'). A string. |
#' | losses | integer | Losses (a count in both modes). |
#' | points | double | Points scored. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | points_against | double | Points allowed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | point_difference | double | Points scored minus points allowed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goals_made | double | Field goals made (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goals_attempted | double | Field goals attempted (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goal_percentage | double | Field-goal percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | three_points_made | double | Three-pointers made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | three_points_attempted | double | Three-pointers attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | three_point_percentage | double | Three-point percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | free_throws_made | double | Free throws made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | free_throws_attempted | double | Free throws attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | free_throw_percentage | double | Free-throw percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | offensive_rebounds | double | Offensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | defensive_rebounds | double | Defensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | rebounds | double | Total rebounds (offensive + defensive). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | assists | double | Assists. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | turn_overs | double | Turnovers. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | steals | double | Steals. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | blocks | double | Shots blocked. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | fouls | double | Personal fouls committed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | fouls_drawn | double | Fouls drawn (committed by opponents). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | efficiency | double | Efficiency rating (EFF); CEBL does not publish its formula (unverified: the usual Genius / FIBA EFF is PTS + REB + AST + STL + BLK - missed FG - missed FT - TO). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | logo_url | character | Team logo URL (icon with the team name) on Google Cloud Storage. Null on the league row. |
#' | icon_url | character | Team icon URL (without the team name) on Google Cloud Storage. Null on the league row. |
#' | stats_url_en | character | The team's stats page on cebl.ca (`https://cebl.ca/stats/{slug}`). Null on the league row. |
#' | stats_url_fr | character | The team's stats page on the French cebl.ca (`https://cebl.ca/fr-ca/stats/{slug}`). Null on the league row. |
#' @eval .intl_details(.cebl_seasons_details, 'cebl_team_stats(mode = "TOTALS", season = 2025, competition = "REGULAR")')
#' @export
#' @family CEBL Functions
cebl_team_stats <- function(
    mode = "PER_GAME",
    season = NULL,
    competition = NULL,
    segment = NULL,
    vs_team_id = NULL,
    vs_conference = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "team_stats", mode = mode, season = season, competition = competition, segment =
    segment, vs_team_id = vs_team_id, vs_conference = vs_conference, call = rlang::current_env())
  .cebl_out(.cebl_parse("team_stats", raw), "CEBL Team Statistics from the CEBL Stats API")
}

#' @title
#' **Get CEBL Games**
#' @description
#' Schedule and results of one season (regular season and finals), with the Genius match id that joins play-by-play
#' and shots; optionally one team's games.
#'
#' Endpoint: `GET https://api.data.cebl.ca/games/{season}/`
#' @param season (required) Season: the calendar year it is played in (May to August) = the sdv END year (2025 = the
#'   2025 season). The CEBL's first season is 2019. A season with no data answers `hoopR_no_data`.
#' @param team_id (default `NULL`) CEBL team id (``team_id`` in cebl_teams): limits the rows to that team; the rows
#'   echo it.
#' @return
#' A `hoopR_data` tibble: Schedule and results of one season (regular season and finals), with the Genius match id
#'   that joins play-by-play and shots; optionally one team's games. An empty valid answer raises `hoopR_no_data`;
#'   the columns are always these, in this order (sdv-py `cebl_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season of the game: the year of start_time_utc (the calendar year = the sdv END year). |
#' | game_id | integer | CEBL game id (its own key space: 568 in 2019, 8 digits from 2025, e.g. 14708701). No route is keyed by it; the Genius match id is in `stats_url_en`. |
#' | genius_match_id | integer | Genius LiveStats match id parsed from the stats URL (the join to the genius family, organisation CEBL, where play-by-play and shots live). Derived from the URL, not fetched; null when the URL is absent. |
#' | start_time_utc | POSIXct | Scheduled tip-off, ISO 8601 in UTC ('2025-05-11T22:00:00Z'). |
#' | competition | character | REGULAR (regular season) or FINALS (playoffs). |
#' | status | character | Game status. Observed: COMPLETE (final) and CANELLED (sic: cancelled; 1 game in 2025, 2 in 2026). The Stats Hub also knows SCHEDULED, IN_PROGRESS, DELAYED and FINISHED. |
#' | period | integer | Last period played when the API sets it (seen only on a cancelled game, which carried period 3); null on a finished game. |
#' | venue_name | character | Arena name ('Edmonton EXPO Centre'). |
#' | home_team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The home team. |
#' | home_team_name | character | Home team full English name. |
#' | home_team_score | integer | Home team final score. On the 3 cancelled games: null, 0 or a partial score; before tip-off unobserved. |
#' | away_team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The away team. |
#' | away_team_name | character | Away team full English name. |
#' | away_team_score | integer | Away team final score. On the 3 cancelled games: null, 0 or a partial score; before tip-off unobserved. |
#' | home_team_logo_url | character | URL of the home team's logo image as the games feed lists it (a team-level asset, the same on every game of that team in the season). |
#' | home_team_stats_url_en | character | Home team's cebl.ca stats page (English). |
#' | home_team_stats_url_fr | character | Home team's cebl.ca stats page (French). |
#' | away_team_logo_url | character | URL of the away team's logo image as the games feed lists it (a team-level asset, the same on every game of that team in the season). |
#' | away_team_stats_url_en | character | Away team's cebl.ca stats page (English). |
#' | away_team_stats_url_fr | character | Away team's cebl.ca stats page (French). |
#' | stats_url_en | character | Genius LiveStats box-score page, `https://fibalivestats.dcd.shared.geniussports.com/u/CEBL/{matchId}/`. The segment after `/u/CEBL/` is the Genius match id: the join to genius-livestats/ (org CEBL), whose `data/{matchId}/data.json` holds the box score, play-by-play and shot chart. Only match 2600563 is banked there; the others are derived, and cancelled (CANELLED) games carry a filled-in URL whose `data.json` is unverified. |
#' | stats_url_fr | character | The same Genius LiveStats page in French (`.../u/CEBL/{matchId}/index_fr_FR.html`). |
#' | cebl_stats_url_en | character | The game page on cebl.ca, `https://www.cebl.ca/game?id={matchId}`: `id` is the Genius match id, not this row's `id`. |
#' | cebl_stats_url_fr | character | The French cebl.ca game page (`https://www.cebl.ca/fr-ca/game?id={matchId}`). |
#' | tickets_url_en | character | Ticket-sales page for the game (English). |
#' | tickets_url_fr | character | Ticket-sales page for the game (French). |
#' | broadcast_partner_logo_urls | character | Logo URLs of the game's broadcasters (TSN+, CEBL+, ...); 2 to 7 per game. |
#' @inherit cebl_seasons details
#' @examples
#' \donttest{
#'   try(cebl_games(season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_games <- function(season, team_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "games", season = season, team_id = team_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("games", raw), "CEBL Games from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Statistics**
#' @description
#' Player statistic table (totals or per game) for a season or all-time; filter by competition, segment or team.
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/statistics/aggregated/`
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @param segment (default `NULL`) Game subset: HOME, AWAY, L7D (last 7 days), L5G (last 5 games), L10G (last 10
#'   games), MAY, JUNE, JULY or AUGUST. `NULL` = all games. Values from the CEBL Stats Hub bundle.
#' @param team_id (default `NULL`) CEBL team id (``team_id`` in cebl_teams): limits the rows to that team; the rows
#'   echo it.
#' @return
#' A `hoopR_data` tibble: Player statistic table (totals or per game) for a season or all-time; filter by
#'   competition, segment or team. An empty valid answer raises `hoopR_no_data`; the columns are always these, in
#'   this order (sdv-py `cebl_player_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
#' | mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
#' | competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
#' | segment | character | Game-subset filter of the request (HOME, AWAY, L5G, MAY ...); null for all games. The body does not echo it. |
#' | player_id | integer | CEBL player id (its own key space). Joins /players/\{player_id\}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
#' | full_name | character | Player's full name. |
#' | nationality | character | Nationality: an upper-case English country name ('CANADA', 'UNITED STATES', 'SOUTH SUDAN'); null when unknown. |
#' | team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
#' | team_name_en | character | Full English name of the player's team. |
#' | team_short_name_en | character | Short English name (city) of the player's team. |
#' | team_name_fr | character | Full French name of the player's team. |
#' | team_short_name_fr | character | Short French name (city) of the player's team. |
#' | team_logo_url | character | Logo URL (icon with the name) of the player's team. |
#' | played | integer | Games played (a count in both modes). |
#' | started | integer | Games started (a count in both modes). |
#' | minutes | double | Minutes played, decimal minutes (not mm:ss). TOTALS: the sum ('1281.7'); PER_GAME: the per-game average ('29.5'). A string. |
#' | points | double | Points scored. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goals_made | double | Field goals made (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goals_attempted | double | Field goals attempted (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goal_percentage | double | Field-goal percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | three_points_made | double | Three-pointers made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | three_points_attempted | double | Three-pointers attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | three_point_percentage | double | Three-point percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | free_throws_made | double | Free throws made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | free_throws_attempted | double | Free throws attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | free_throw_percentage | double | Free-throw percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | offensive_rebounds | double | Offensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | defensive_rebounds | double | Defensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | rebounds | double | Total rebounds (offensive + defensive). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | assists | double | Assists. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | turn_overs | double | Turnovers. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | steals | double | Steals. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | blocks | double | Shots blocked. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | fouls | double | Personal fouls committed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | double_doubles | double | Double-doubles: games with 10 or more in two of points, rebounds, assists, steals, blocks. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | triple_doubles | double | Triple-doubles: games with 10 or more in three of those. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | target_scores | double | Target-score baskets: games in which the player made the basket that reached the Elam Ending target score and ended the game (CEBL has used the Elam Ending since 2020, so 2019 is 0). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' @inherit cebl_seasons details
#' @examples
#' \donttest{
#'   try(cebl_player_stats(mode = "PER_GAME", season = 2025))
#' }
#' @export
#' @family CEBL Functions
cebl_player_stats <- function(
    mode = "PER_GAME",
    season = NULL,
    competition = NULL,
    segment = NULL,
    team_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "player_stats", mode = mode, season = season, competition = competition, segment =
    segment, team_id = team_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("player_stats", raw), "CEBL Player Statistics from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Leaders**
#' @description
#' Top five players per requested statistic (long frame, one row per statistic and leader).
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/statistics/leaders/`
#' @param statistics (default `"POINTS,REBOUNDS,ASSISTS,TARGET_SCORES"`) Comma-separated statistic names; the frame
#'   has one block per name. Names the Stats Hub sends: POINTS, REBOUNDS, ASSISTS, BLOCKS, STEALS, TARGET_SCORES,
#'   FIELD_GOAL_PERCENTAGE, THREE_POINTS_MADE, THREE_POINT_PERCENTAGE, FREE_THROW_PERCENTAGE, FOULS, TURNOVERS,
#'   MINUTES.
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @param team_id (default `NULL`) CEBL team id (``team_id`` in cebl_teams): limits the rows to that team; the rows
#'   echo it.
#' @return
#' A `hoopR_data` tibble: Top five players per requested statistic (long frame, one row per statistic and leader).
#'   An empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `cebl_player_leaders`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | statistic | character | Statistic this leader row ranks, the body's key for the list: POINTS, REBOUNDS, ASSISTS, TARGET_SCORES and the other names the request asked for. |
#' | ranking | integer | Rank in this statistic, 1 = best; ties share a rank and skip the next (1, 1, 1, 4). The list is the top 5 rows, no more. |
#' | season | integer | Season: the calendar year it is played in (May to August) = the sdv END year (2025). Taken from the request (the body does not echo it); null for the all-time table and for a bare body. |
#' | mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
#' | competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
#' | player_id | integer | CEBL player id (its own key space). Joins /players/\{player_id\}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
#' | full_name | character | Player's full name. |
#' | team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). |
#' | team_name_en | character | Full English name of the player's team. |
#' | team_short_name_en | character | Short English name (city) of the player's team. |
#' | team_name_fr | character | Full French name of the player's team. |
#' | team_short_name_fr | character | Short French name (city) of the player's team. |
#' | team_abbreviated_name | character | Three-letter code of the player's team ('OTT', 'VAN'). |
#' | team_logo_url | character | Logo URL (icon with the name) of the player's team. |
#' | value | double | The player's figure for the statistic this list is keyed by, in the requested mode (TOTALS sum or PER_GAME average; percentages 0-100). A decimal string ('25.9'). |
#' | photo_url | character | Player headshot URL on the Genius Sports image CDN (images.statsengine.playbyplay.api.geniussports.com). |
#' @eval .intl_details(.cebl_seasons_details, 'cebl_player_leaders(mode = "PER_GAME", season = 2025)')
#' @export
#' @family CEBL Functions
cebl_player_leaders <- function(
    statistics = "POINTS,REBOUNDS,ASSISTS,TARGET_SCORES",
    mode = "PER_GAME",
    season = NULL,
    competition = NULL,
    team_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "leaders", statistics = statistics, mode = mode, season = season, competition =
    competition, team_id = team_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("player_leaders", raw), "CEBL Player Leaders from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Seasons**
#' @description
#' One player's per-season rows and career row (totals or per game).
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/statistics/`
#' @param player_id (required) CEBL player id (global across seasons and teams), e.g. 570965 (Javonte Smart);
#'   ``player_id`` in cebl_player_stats.
#' @param mode (default `"PER_GAME"`) TOTALS (sums over the selected games) or PER_GAME (per-game averages); the API
#'   requires one.
#' @param career_only (default `FALSE`) `TRUE` returns the career row alone; `FALSE` the per-season rows and the
#'   career row.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @return
#' A `hoopR_data` tibble: One player's per-season rows and career row (totals or per game). An empty valid answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `cebl_player_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | mode | character | Table mode of the request: TOTALS (sums over the selected games) or PER_GAME (per-game averages); the body does not echo it. |
#' | competition | character | Competition filter of the request: REGULAR or FINALS; null when both were asked. The body does not echo it. |
#' | player_id | integer | CEBL player id: the `player_id` of the request, on every row. Joins /players/\{player_id\}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
#' | season | integer | Season (calendar year = sdv END year); null on the career row. |
#' | is_career | logical | True on the career row (null season): the sum or average over every season and team; false on a per-season row. |
#' | team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The player's team that season (on the career row, his latest). |
#' | team_name_en | character | Full English name of the player's team. |
#' | team_short_name_en | character | Short English name (city) of the player's team. |
#' | team_name_fr | character | Full French name of the player's team. |
#' | team_short_name_fr | character | Short French name (city) of the player's team. |
#' | team_logo_url | character | Logo URL (icon with the name) of the player's team. |
#' | played | integer | Games played (a count in both modes). |
#' | started | integer | Games started (a count in both modes). |
#' | minutes | double | Minutes played, decimal minutes (not mm:ss). TOTALS: the sum ('1281.7'); PER_GAME: the per-game average ('29.5'). A string. |
#' | points | double | Points scored. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goals_made | double | Field goals made (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goals_attempted | double | Field goals attempted (2- and 3-pointers). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | field_goal_percentage | double | Field-goal percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | three_points_made | double | Three-pointers made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | three_points_attempted | double | Three-pointers attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | three_point_percentage | double | Three-point percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | free_throws_made | double | Free throws made. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | free_throws_attempted | double | Free throws attempted. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | free_throw_percentage | double | Free-throw percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the selected games (the same in both modes). A string. |
#' | offensive_rebounds | double | Offensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | defensive_rebounds | double | Defensive rebounds. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | rebounds | double | Total rebounds (offensive + defensive). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | assists | double | Assists. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | turn_overs | double | Turnovers. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | steals | double | Steals. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | blocks | double | Shots blocked. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | fouls | double | Personal fouls committed. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | double_doubles | double | Double-doubles: games with 10 or more in two of points, rebounds, assists, steals, blocks. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | triple_doubles | double | Triple-doubles: games with 10 or more in three of those. TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' | target_scores | double | Target-score baskets: games in which the player made the basket that reached the Elam Ending target score and ended the game (CEBL has used the Elam Ending since 2020, so 2019 is 0). TOTALS: the sum over the selected games; PER_GAME: the per-game average, 1 decimal. A decimal sent as a string ('2256.0', '12.7'). |
#' @eval .intl_details(.cebl_seasons_details, 'cebl_player_seasons(player_id = 570965, mode = "PER_GAME")')
#' @export
#' @family CEBL Functions
cebl_player_seasons <- function(player_id, mode = "PER_GAME", career_only = FALSE, competition = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "player_seasons", player_id = player_id, mode = mode, career_only = career_only,
    competition = competition, call = rlang::current_env())
  .cebl_out(.cebl_parse("player_seasons", raw), "CEBL Player Seasons from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player**
#' @description
#' One player's profile and current team: name, nationality, birth date, position, jersey.
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/`
#' @param player_id (required) CEBL player id (global across seasons and teams), e.g. 570965 (Javonte Smart);
#'   ``player_id`` in cebl_player_stats.
#' @return
#' A `hoopR_data` tibble: One player's profile and current team: name, nationality, birth date, position, jersey. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `cebl_player`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | CEBL player id (its own key space). Joins /players/\{player_id\}/ and `id` in the other player rows. Genius LiveStats `data.json` carries no person id, so the join to Genius play-by-play is by name, team and jersey number (unverified). |
#' | full_name | character | Player's full name. |
#' | nationality | character | Nationality: an upper-case English country name ('CANADA', 'UNITED STATES', 'SOUTH SUDAN'); null when unknown. |
#' | birth_date | Date | Date of birth, YYYY-MM-DD (players' public bio field); null when unknown. |
#' | age | integer | Age in whole years on the day of the request (computed by the API); null when the birth date is unknown. |
#' | position | character | Playing position: G (guard), F (forward), C (center), or a combination such as 'C/F'; null when unknown. |
#' | jersey_number | character | Jersey number, as a string of up to 2 characters ('0', '00' and '1' are distinct); null when unknown. |
#' | team_id | integer | CEBL team id (its own key space; not a Genius id). Joins /teams/ `id`, the games' `home_team_id` / `away_team_id`, `team_id` in player rows and the `team_id` / `vs_team_id` params. A relocated or renamed franchise has a second id: the Stats Hub groups 15+56 (Saskatchewan Rattlers, Saskatoon Mamba), 17+53 (Calgary Surge, Guelph Nighthawks), 19+55 (Brampton, Hamilton Honey Badgers) and 16+54 (Vancouver, Fraser Valley Bandits). The player's latest team. |
#' | team_name_en | character | Full English name of the player's team. |
#' | team_short_name_en | character | Short English name (city) of the player's team. |
#' | team_name_fr | character | Full French name of the player's team. |
#' | team_short_name_fr | character | Short French name (city) of the player's team. |
#' | team_icon_url | character | Icon URL (without the name) of the player's team. |
#' | team_stats_url_en | character | cebl.ca stats page of the player's team (English). |
#' | team_stats_url_fr | character | cebl.ca stats page of the player's team (French). |
#' | photo_url | character | Player headshot URL on the Genius Sports image CDN (images.statsengine.playbyplay.api.geniussports.com). |
#' @eval .intl_details(.cebl_seasons_details, "cebl_player(player_id = 570965)")
#' @export
#' @family CEBL Functions
cebl_player <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "player", player_id = player_id, call = rlang::current_env())
  .cebl_out(.cebl_parse("player", raw), "CEBL Player from the CEBL Stats API")
}

#' @title
#' **Get CEBL Player Game Log**
#' @description
#' One player's game log: one row per game played, with the Genius match id of the game.
#'
#' Endpoint: `GET https://api.data.cebl.ca/players/{player_id}/gamelog/`
#' @param player_id (required) CEBL player id (global across seasons and teams), e.g. 570965 (Javonte Smart);
#'   ``player_id`` in cebl_player_stats.
#' @param season (default `NULL`) Season: the calendar year (May to August) = the sdv END year. `NULL` = every
#'   season combined (the Stats Hub's All-Time). An unknown year answers `hoopR_no_data`.
#' @param competition (default `NULL`) REGULAR (regular season) or FINALS (the playoffs). `NULL` = both.
#' @return
#' A `hoopR_data` tibble: One player's game log: one row per game played, with the Genius match id of the game. An
#'   empty valid answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `cebl_player_gamelog`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | CEBL player id of the log asked for (from the request; the body does not echo it). |
#' | season | integer | Season of the game: the year of game_date (the calendar year = the sdv END year). |
#' | game_date | POSIXct | Tip-off of the game, ISO 8601 in UTC (same as the game's `start_time_utc`). |
#' | genius_match_id | integer | Genius LiveStats match id parsed from the stats URL (the join to the genius family, organisation CEBL, where play-by-play and shots live). Derived from the URL, not fetched; null when the URL is absent. |
#' | team_abbreviated_name | character | Three-letter code of the player's team in that game ('OTT'). |
#' | matchup | character | '\{TEAM\} \{team score\} \{vs or @@\} \{opponent score\} \{OPP\}': the player's team code and score first; `vs` = a home game, `@@` = an away game ('OTT 91 @@ 95 BHB'). |
#' | minutes | double | Minutes played as decimal minutes (26.4), not mm:ss; the API sends a string. |
#' | points | integer | Points scored in the game. An integer. |
#' | field_goals_made | integer | Field goals made (2- and 3-pointers) in the game. An integer. |
#' | field_goals_attempted | integer | Field goals attempted (2- and 3-pointers) in the game. An integer. |
#' | field_goal_percentage | double | Field-goal percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the game. A string. |
#' | three_points_made | integer | Three-pointers made in the game. An integer. |
#' | three_points_attempted | integer | Three-pointers attempted in the game. An integer. |
#' | three_point_percentage | double | Three-point percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the game. A string. |
#' | free_throws_made | integer | Free throws made in the game. An integer. |
#' | free_throws_attempted | integer | Free throws attempted in the game. An integer. |
#' | free_throw_percentage | double | Free-throw percentage, 0-100 with 1 decimal ('44.7'): made / attempted over the game. A string. |
#' | offensive_rebounds | integer | Offensive rebounds in the game. An integer. |
#' | defensive_rebounds | integer | Defensive rebounds in the game. An integer. |
#' | rebounds | integer | Total rebounds in the game; the API sends it as a string ('5'), cast to Int64. |
#' | assists | integer | Assists in the game. An integer. |
#' | turn_overs | integer | Turnovers in the game. An integer. |
#' | steals | integer | Steals in the game. An integer. |
#' | blocks | integer | Shots blocked in the game. An integer. |
#' | fouls | integer | Personal fouls committed in the game. An integer. |
#' | is_target_scorer | logical | True when the player made the basket that reached the Elam Ending target score and ended the game. |
#' | game_stats_url_en | character | cebl.ca game page, `https://www.cebl.ca/game?id={matchId}`: `id` is the Genius match id (the join to genius-livestats/). |
#' | game_stats_url_fr | character | French cebl.ca game page (`https://www.cebl.ca/fr-ca/game?id={matchId}`). |
#' | team_stats_url_en | character | cebl.ca stats page of the player's team in that game (English). |
#' | team_stats_url_fr | character | cebl.ca stats page of the player's team in that game (French). |
#' @eval .intl_details(.cebl_seasons_details, "cebl_player_gamelog(player_id = 570965, season = 2025)")
#' @export
#' @family CEBL Functions
cebl_player_gamelog <- function(player_id, season = NULL, competition = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "gamelog", player_id = player_id, season = season, competition = competition, call =
    rlang::current_env())
  .cebl_out(.cebl_parse("player_gamelog", raw), "CEBL Player Game Log from the CEBL Stats API")
}

#' @title
#' **Get CEBL News**
#' @description
#' News articles in one language. The API answered an empty list on every probe, so this raises `hoopR_no_data`.
#'
#' Endpoint: `GET https://api.data.cebl.ca/news/articles/{language}/`
#' @param language (required) Language code, e.g. ``en``; every language tried answered an empty list.
#' @param team_source_id (default `NULL`) CEBL team id: only that team's articles.
#' @return
#' A `hoopR_data` tibble: News articles in one language. The API answered an empty list on every probe, so this
#'   raises `hoopR_no_data`. An empty valid answer raises `hoopR_no_data`; the columns are always these, in this
#'   order (sdv-py `cebl_news`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | news_id | integer | CEBL news article id; null when the API gives none. Unobserved: the route answered an empty list on every probe. |
#' | language | character | Language code of the request ('en'); the body does not echo it. |
#' | title | character | Article headline (upstream schema; unobserved, the route answered an empty list on every probe). |
#' | published_at_utc | POSIXct | Publication time in UTC (upstream schema; unobserved, no article was ever served). |
#' | image_url | character | Article image URL (upstream schema; unobserved, no article was ever served). |
#' | html_content | character | Article body as HTML (upstream schema; unobserved, no article was ever served). |
#' @eval .intl_details(.cebl_seasons_details, 'cebl_news(language = "en")')
#' @export
#' @family CEBL Functions
cebl_news <- function(language, team_source_id = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cebl_get(kind = "news", language = language, team_source_id = team_source_id, call =
    rlang::current_env())
  .cebl_out(.cebl_parse("news", raw), "CEBL News from the CEBL Stats API")
}
