# **Get BNXT League Team Player Averages**

Per-game averages of each player of a competition team.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/player-averages/{competition_team_id}`

## Usage

``` r
sportpress_team_player_averages(competition_team_id)
```

## Arguments

- competition_team_id:

  (required) Competition-team id (integer): a team in ONE competition,
  so new every season (e.g. 541 = Antwerp in 2026-27); from
  [`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md).

## Value

A `hoopR_data` tibble: Per-game averages of each player of a competition
team. An empty valid answer raises `hoopR_no_data`; the columns are
always these, in this order (sdv-py `sportpress_team_player_averages`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| played_games | integer | Games the player played in the season. |
| games_started | integer | Games started (a count, not a mean). |
| minute | numeric | Minutes played; for a team total, the sum over its players (200 + 25 per overtime). Per-game mean over the games played (fractional). |
| foul | numeric | Personal fouls committed. Per-game mean over the games played (fractional). |
| defensive_foul | numeric | Fouls DRAWN (suffered), despite the name: equals the opponent's foul count up to scorer corrections. Per-game mean over the games played (fractional). |
| dunk_made | numeric | Dunks made (a subset of the two-point field goals). Per-game mean over the games played (fractional). |
| dunk_all | numeric | Dunks attempted. Per-game mean over the games played (fractional). |
| dunk_percent | numeric | Dunk percentage 0-100; 0 when none were attempted. Per-game mean over the games played (fractional). |
| two_point_made | numeric | Two-point field goals made. Per-game mean over the games played (fractional). |
| two_point_all | numeric | Two-point field goals attempted. Per-game mean over the games played (fractional). |
| two_point_percent | numeric | Two-point percentage 0-100. Per-game mean over the games played (fractional). |
| three_point_made | numeric | Three-point field goals made. Per-game mean over the games played (fractional). |
| three_point_all | numeric | Three-point field goals attempted. Per-game mean over the games played (fractional). |
| three_point_percent | numeric | Three-point percentage 0-100. Per-game mean over the games played (fractional). |
| throw_made | numeric | All field goals made, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
| throw_all | numeric | All field goals attempted, two- plus three-pointers (the provider calls them 'throw'). Per-game mean over the games played (fractional). |
| throw_percent | numeric | Field-goal percentage 0-100. Per-game mean over the games played (fractional). |
| free_throw_made | numeric | Free throws made. Per-game mean over the games played (fractional). |
| free_throw_all | numeric | Free throws attempted. Per-game mean over the games played (fractional). |
| free_throw_percent | numeric | Free-throw percentage 0-100. Per-game mean over the games played (fractional). |
| offensive_rebound | numeric | Offensive rebounds. Per-game mean over the games played (fractional). |
| defensive_rebound | numeric | Defensive rebounds. Per-game mean over the games played (fractional). |
| total_rebound | numeric | Total rebounds (offensive plus defensive). Per-game mean over the games played (fractional). |
| block | numeric | Shots blocked by the player. Per-game mean over the games played (fractional). |
| block_against | numeric | Own shots blocked by an opponent. Per-game mean over the games played (fractional). |
| turnover | numeric | Turnovers committed. Per-game mean over the games played (fractional). |
| steal | numeric | Steals (balls taken from an opponent). Per-game mean over the games played (fractional). |
| assist | numeric | Assists (passes leading directly to a made basket). Per-game mean over the games played (fractional). |
| points | numeric | Points scored (2 x two-pointers + 3 x three-pointers + free throws). Per-game mean over the games played (fractional). |
| value | numeric | Efficiency rating (PIR with fouls drawn): points + rebounds + assists + steals + blocks + fouls drawn - missed field goals - missed free throws - turnovers. Per-game mean over the games played (fractional). |

## Details

- Unofficial and unsupported: the Sportpress API is the JSON backend of
  bnxtleague.com, not a documented public API. Every route needs a
  header key; it is public (hard-coded in the site bundle),
  `bnxt_runtime` reads it from the bundle at run time, falls back to a
  documented value when the bundle cannot be read, and never prints or
  logs it. A 401 raises AssetFetchError (`key rotated?`). robots.txt
  allows everything; requests are spaced at least 1 s apart. Payloads
  are not redistributed as release assets.

- Season key: the END year (`season=2026` is 2025-26), the API's own key
  on the season routes. Every other route is keyed by the competition id
  (one per season: 1 = 2021-22, 2 = 2020-21, 3 = 2022-23, 12 = 2023-24,
  22 = 2024-25, 24 = 2025-26, 25 = 2026-27), the competition-team id
  (new every season; `uu_team_id` is the stable club), the roster id
  (player x team x season) or the game id (unique across seasons).
  `sportpress_phases(season)` maps a season to its competition id.

- Coverage: schedule and rosters from 2021-22 (2020-21 is empty); box
  scores for 2021-22, 2024-25, 2025-26 and 2026-27 (2022-23 and 2023-24
  answer empty); standings and averages for 2021-22 and 2024-25 on;
  play-by-play ('film', with court x/y) for 2021-22 and 2026-27 only:
  for 2022-23 to 2025-26 use Genius play-by-play through `genius_id`
  ([`sportpress_game_slider()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_slider.md),
  organisation BNXT). The game routes (box score, film, overview) refuse
  a game that is not finished (AssetFetchError).

- Data notes: a team's box total can differ from the schedule final
  score on about 18 of 1,246 sampled team boxes (mostly 2024-25, by 2-21
  points); the frames report what the API serves. `nationality_code` is
  dirty (lower case, `USA/BEL` pairs, empty, `HOL`). Names differ by
  language and sponsor: join on ids. Contact and social fields are
  dropped; only a player's public birth date is kept. The sibling
  tenants sopron.sportpress.info and beac.sportpress.info are not
  wrapped.

- Errors are classed conditions: `hoopR_no_data` (HTTP 404, an empty
  `data` list: an unknown id or a season without data, an empty
  ranking), `hoopR_bad_request` (an id or season that is not an integer,
  HTTP 400 / 422) and `hoopR_asset_fetch` (a rejected key after one
  renewal, any other non-200, a non-JSON or empty body, an error or
  changed envelope, a game that is not finished, a body for another
  season, competition, team or game), all inheriting `hoopR_error`.
  Wrappers raise; they never return an empty frame for a failed request.
  Whole doubles (`24`) are accepted for integer arguments.

## See also

Other BNXT League Functions:
[`sportpress_club_seasons()`](https://hoopR.sportsdataverse.org/reference/sportpress_club_seasons.md),
[`sportpress_competition_staff()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_staff.md),
[`sportpress_competition_teams()`](https://hoopR.sportsdataverse.org/reference/sportpress_competition_teams.md),
[`sportpress_game_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_box.md),
[`sportpress_game_film()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_film.md),
[`sportpress_game_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_find.md),
[`sportpress_game_leaders()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_leaders.md),
[`sportpress_game_overview()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_overview.md),
[`sportpress_game_periods()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_periods.md),
[`sportpress_game_slider()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_slider.md),
[`sportpress_game_team_box()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_team_box.md),
[`sportpress_game_top_performers()`](https://hoopR.sportsdataverse.org/reference/sportpress_game_top_performers.md),
[`sportpress_nationality_codes()`](https://hoopR.sportsdataverse.org/reference/sportpress_nationality_codes.md),
[`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md),
[`sportpress_player_career()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_career.md),
[`sportpress_player_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_games.md),
[`sportpress_player_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_player_rankings.md),
[`sportpress_referees()`](https://hoopR.sportsdataverse.org/reference/sportpress_referees.md),
[`sportpress_roster_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_roster_find.md),
[`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md),
[`sportpress_season_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_season_roster.md),
[`sportpress_standings()`](https://hoopR.sportsdataverse.org/reference/sportpress_standings.md),
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)

## Examples

``` r
# \donttest{
  try(sportpress_team_player_averages(competition_team_id = 541))
#> ── BNXT League Team Player Averages from Sportpress ──────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:03:37 UTC
#> # A tibble: 12 × 37
#>    competition_team_id roster_id player_id first_name last_name nationality_code
#>                  <int>     <int>     <int> <chr>      <chr>     <chr>           
#>  1                 541     11443      5683 Jehloni    James     USA             
#>  2                 541     11445       513 Kevin      Tumba     BEL             
#>  3                 541     11447      5255 Noel       Coleman   BEL             
#>  4                 541     11449       228 Niels      De Ridder BEL             
#>  5                 541     11193      4232 Joel       Murray    USA             
#>  6                 541     11451      5685 Nijel      Pack      USA             
#>  7                 541     11453      5325 Enoch      Cheeks    USA             
#>  8                 541     11455       202 Vincent    Kesteloot BEL             
#>  9                 541     11457      5687 Cesare     Edwards   USA             
#> 10                 541     11195      5567 Jacari     White     USA             
#> 11                 541     11459      2612 Letto      Van Drom  BEL             
#> 12                 541     11461      5689 Youssef    Zagdoud   BEL             
#> # ℹ 31 more variables: birth_date <date>, played_games <int>,
#> #   games_started <int>, minute <dbl>, foul <dbl>, defensive_foul <dbl>,
#> #   dunk_made <dbl>, dunk_all <dbl>, dunk_percent <dbl>, two_point_made <dbl>,
#> #   two_point_all <dbl>, two_point_percent <dbl>, three_point_made <dbl>,
#> #   three_point_all <dbl>, three_point_percent <dbl>, throw_made <dbl>,
#> #   throw_all <dbl>, throw_percent <dbl>, free_throw_made <dbl>,
#> #   free_throw_all <dbl>, free_throw_percent <dbl>, offensive_rebound <dbl>, …
# }
```
