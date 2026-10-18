# **Get VTB League Matches**

Every match of one league-season (schedule, scores, quarter points,
venue), in one request.

Endpoint:
`GET https://api.vtb-league.com/v2/leagues/{league_slug}/seasons/{season}/matches`

## Usage

``` r
vtb_league_matches(league_slug, season)
```

## Arguments

- league_slug:

  League slug (league in vtb_league_leagues): vtb (VTB United League),
  vtbyouth (youth league) or wbc (WINLINE Basket Cup).

- season:

  Season END year (2026 = 2025-26). The v2 API holds 2025 onwards (vtb:
  2025-2027; wbc: 2026-2027); earlier years answer no rows.

## Value

A `hoopR_data` tibble: Every match of one league-season (schedule,
scores, quarter points, venue), in one request. The columns are always
these, in this order (sdv-py `vtb_league_matches`); an empty valid
answer raises `hoopR_no_data`, a valid body with no rows for this frame
is a zero-row tibble:

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Match id; equals the Infobasket GameID (/Widget/GetOnline/{gameId}). |
| league | character | League slug, echoed. |
| season | integer | Season END year, echoed. |
| competition | character | Competition slug: 'vtb' (league games), 'vtb-supercup', 'vtb-allstars', 'wbc'. |
| phase_id | integer | v2 phase id of the stage (not an Infobasket CompID). |
| phase_name_en | character | The stage name in English. |
| phase_name_ru | character | The stage name in Russian. |
| match_number | character | Game number ('1/2-2' = semi-final 2; regular-season numbers otherwise). |
| match_type | character | Game type: REGULAR, FINALS (any playoff or cup knockout game), ALLSTARS. |
| match_status | character | Status: SCHEDULED, IN_PROGRESS, COMPLETE, POSTPONED, CANCELLED, UNKNOWN (the site filters on the first four). |
| match_time | character | Tip-off in venue local time, ISO 8601 with offset. |
| match_time_msk | character | Tip-off in Moscow time (UTC+3), ISO 8601. |
| match_time_utc | character | Tip-off in UTC, ISO 8601. |
| is_time_set | logical | True when the tip-off time is fixed. |
| time_actual | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| time_end_actual | character | Unobserved: null in every sample, so its type and meaning are unconfirmed. |
| duration | integer | Game duration; 0 in every sample (unverified). |
| periods | integer | Periods played (4 in regulation). |
| extra_periods_used | logical | True when the game went to overtime. |
| attendance | integer | Spectators (null when not recorded). |
| hosting_team_id | integer | Home team id (Infobasket TeamID). |
| venue_id | integer | Venue id; equals the Infobasket arena id (ArenaId). |
| venue_name_en | character | The venue name in English. |
| venue_name_ru | character | The venue name in Russian. |
| venue_region_name_en | character | The venue city in English. |
| venue_region_name_ru | character | The venue city in Russian. |
| home_team_id | integer | Infobasket TeamID of the home team. |
| home_score | integer | Final points of the home team (an integer; 0 for a cancelled match). |
| home_team_name_en | character | The home team's name in English. |
| home_team_name_ru | character | The home team's name in Russian. |
| home_team_code_en | character | The home team's short code in English. |
| home_team_code_ru | character | The home team's short code in Russian. |
| home_region_name_en | character | Region or city of the home team in English. |
| home_region_name_ru | character | Region or city of the home team in Russian. |
| away_team_id | integer | Infobasket TeamID of the away team. |
| away_score | integer | Final points of the away team (an integer; 0 for a cancelled match). |
| away_team_name_en | character | The away team's name in English. |
| away_team_name_ru | character | The away team's name in Russian. |
| away_team_code_en | character | The away team's short code in English. |
| away_team_code_ru | character | The away team's short code in Russian. |
| away_region_name_en | character | Region or city of the away team in English. |
| away_region_name_ru | character | Region or city of the away team in Russian. |
| subtitle_en | character | The site subtitle of the match in English. |
| subtitle_ru | character | The site subtitle of the match in Russian. |
| necessary_label_en | character | The site label of the match in English. |
| necessary_label_ru | character | The site label of the match in Russian. |
| points_by_quarters | character | Points per period as `[home, away]` pairs; null before the game. The home team (isHomeCompetitor true) is listed first in `competitors` on every probed row (vtb seasons 2025 and 2026, wbc 2026: 620 of 620), and the first value of each pair summed to that team's score on every finished one. |
| home_q1 | integer | Points of the home team in period 1. |
| away_q1 | integer | Points of the away team in period 1. |
| home_q2 | integer | Points of the home team in period 2. |
| away_q2 | integer | Points of the away team in period 2. |
| home_q3 | integer | Points of the home team in period 3. |
| away_q3 | integer | Points of the away team in period 3. |
| home_q4 | integer | Points of the home team in period 4. |
| away_q4 | integer | Points of the away team in period 4. |
| home_ot | integer | Points of the home team in all overtimes together (null without overtime). |
| away_ot | integer | Points of the away team in all overtimes together (null without overtime). |

## Details

- Owner flag (sdv-internal-refs/vtb/README.md): the VTB United League is
  run from Russia and several clubs are owned or sponsored by sanctioned
  state companies (the KHL precedent); Infobasket is the Russian
  basketball federation's stats platform. Fetching on your own machine
  is fine. The owner has approved published data releases (2026-10-17),
  though none is scheduled yet. No accounts or payments are involved.

- Unofficial and unsupported: both hosts are keyless public JSON
  backends of vtb-league.com. No terms of use are published; robots.txt
  is a 404 on api.vtb-league.com and org.infobasket.su (no rules;
  vtb-league.com disallows only /wp/wp-admin/). The runtime waits at
  least 1 s before every request, retries included, and honours
  Retry-After on 429 / 503. No key, cookie or proxy is used
  (live-verified direct from the droplet 2026-10-12).

- Seasons are END years (2026 = 2025-26) on both backends. Infobasket
  keys everything by competition id: vtb_infobasket_seasons maps the END
  year to the season-level CompID, and the season-keyed wrappers do that
  mapping for you. CompID means three things: a season (50714), a stage
  below it (50720 regular season, 54281 playoff; stage-level wrappers
  take the stage id from vtb_infobasket_comp_issue) and, in the player
  season stats, an END year.

- Ids: the v2 matchId is the Infobasket GameID, the v2 teamId the
  Infobasket TeamID and the v2 venueId the Infobasket ArenaId. team_id
  is the key on every team route; comp_team_id (a registration in one
  stage) and the club-record id of the team page are other key spaces.
  person_id is one person across clubs and seasons.

- v2 pages: meta.count is the rows returned (not a total), page is
  ignored and the default limit is 20, so the matches wrapper asks for
  1000 and refuses a body whose count reaches its limit. The API lists
  new seasons only (from 2024-25; vtb: 2025-2027, wbc: 2026-2027):
  earlier years answer no rows (`hoopR_no_data`).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, or the host has nothing for the request: an
  empty list, a v2 season with no rows, a season without team totals),
  `hoopR_bad_request` (a malformed id or league slug, a lang other than
  en or ru, or a season the competition tag does not have) and
  `hoopR_asset_fetch` (any other non-2xx, an empty or non-JSON body, an
  error envelope or string, a game that is not final or a stub, a
  partial or possibly truncated page, or a body for another game,
  person, team, competition, league or season). HTTP 500 is retried
  (neither host answers 500 for an unknown id). Wrappers raise; they
  never warn and return empty.

## See also

Other VTB Functions:
[`vtb_infobasket_best_player_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_player_parameters.md),
[`vtb_infobasket_best_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_players.md),
[`vtb_infobasket_best_team_parameters()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_team_parameters.md),
[`vtb_infobasket_best_teams()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_best_teams.md),
[`vtb_infobasket_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_box_score.md),
[`vtb_infobasket_calendar()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_calendar.md),
[`vtb_infobasket_coach()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_coach.md),
[`vtb_infobasket_comp_issue()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_comp_issue.md),
[`vtb_infobasket_cross_table()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_cross_table.md),
[`vtb_infobasket_game()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game.md),
[`vtb_infobasket_game_page()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_page.md),
[`vtb_infobasket_game_staff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_game_staff.md),
[`vtb_infobasket_pbp()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_pbp.md),
[`vtb_infobasket_player()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player.md),
[`vtb_infobasket_player_career_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_career_stats.md),
[`vtb_infobasket_player_game_log()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_game_log.md),
[`vtb_infobasket_player_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_player_season_stats.md),
[`vtb_infobasket_playoff()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff.md),
[`vtb_infobasket_playoff_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_playoff_games.md),
[`vtb_infobasket_roster()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster.md),
[`vtb_infobasket_roster_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_roster_coaches.md),
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md),
[`vtb_infobasket_standings()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_standings.md),
[`vtb_infobasket_team()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team.md),
[`vtb_infobasket_team_box_score()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_box_score.md),
[`vtb_infobasket_team_coach_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_coach_stats.md),
[`vtb_infobasket_team_comps()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_comps.md),
[`vtb_infobasket_team_games()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_games.md),
[`vtb_infobasket_team_player_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_player_stats.md),
[`vtb_infobasket_team_preview()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_preview.md),
[`vtb_infobasket_team_season_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_season_stats.md),
[`vtb_infobasket_team_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_seasons.md),
[`vtb_infobasket_team_stats()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats.md),
[`vtb_infobasket_team_stats_coaches()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_coaches.md),
[`vtb_infobasket_team_stats_players()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_team_stats_players.md),
[`vtb_league_leagues()`](https://hoopR.sportsdataverse.org/reference/vtb_league_leagues.md),
[`vtb_league_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_league_seasons.md)

## Examples

``` r
# \donttest{
  try(vtb_league_matches(league_slug = "vtb", season = 2026))
#> ── VTB League Matches from api.vtb-league.com ────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:44:32 UTC
#> # A tibble: 273 × 57
#>    match_id league season competition  phase_id phase_name_en  phase_name_ru    
#>       <int> <chr>   <int> <chr>           <int> <chr>          <chr>            
#>  1   932510 vtb      2026 vtb-supercup  1213772 1/2 finals (1) 1/2 финала (1)   
#>  2   932509 vtb      2026 vtb-supercup  1213771 1/2 finals (2) 1/2 финала (2)   
#>  3   932511 vtb      2026 vtb-supercup  1213774 Final for 3    Финал за 3 место 
#>  4   945674 vtb      2026 vtb-supercup  1213774 Final for 3    Финал за 3 место 
#>  5   932512 vtb      2026 vtb-supercup  1213773 Final          Финал            
#>  6   945673 vtb      2026 vtb-supercup  1213773 Final          Финал            
#>  7   921391 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#>  8   921390 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#>  9   921392 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#> 10   921394 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#> # ℹ 263 more rows
#> # ℹ 50 more variables: match_number <chr>, match_type <chr>,
#> #   match_status <chr>, match_time <chr>, match_time_msk <chr>,
#> #   match_time_utc <chr>, is_time_set <lgl>, time_actual <chr>,
#> #   time_end_actual <chr>, duration <int>, periods <int>,
#> #   extra_periods_used <lgl>, attendance <int>, hosting_team_id <int>,
#> #   venue_id <int>, venue_name_en <chr>, venue_name_ru <chr>, …
# }
```
