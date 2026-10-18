# **Get BNXT League Competition Teams**

Every competition team of one competition: ids, names and country.

Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/all`

## Usage

``` r
sportpress_competition_teams(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

## Value

A `hoopR_data` tibble: Every competition team of one competition: ids,
names and country. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sdv-py
`sportpress_competition_teams`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id the team plays in (key space: sportpress competitions); the competition_id the route was asked for. |
| season | integer | Season END year of the team's competition. |
| uu_team_id | integer | Stable club key across seasons (key space: sportpress clubs-as-teams); competition_team_id changes every season, this does not. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
| club_name | character | Country name in English, Belgium or Netherlands. |

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
[`sportpress_team_player_averages()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_player_averages.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)

## Examples

``` r
# \donttest{
  try(sportpress_competition_teams(competition_id = 24))
#> ── BNXT League Competition Teams from Sportpress ─────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:02:53 UTC
#> # A tibble: 18 × 8
#>    competition_id season uu_team_id competition_team_id team     team_short_name
#>             <int>  <int>      <int>               <int> <chr>    <chr>          
#>  1             24   2026          1                 502 Val-Die… CHA            
#>  2             24   2026          2                 504 Filou O… OOS            
#>  3             24   2026          3                 506 Windros… ANT            
#>  4             24   2026          4                 508 Union M… MON            
#>  5             24   2026          5                 510 Hubo Li… LIM            
#>  6             24   2026          7                 512 Donar G… GRO            
#>  7             24   2026          8                 514 PrismaW… BAL            
#>  8             24   2026          9                 516 Landste… ZWO            
#>  9             24   2026         10                 518 Zeeuw &… RCB            
#> 10             24   2026         11                 520 LWD Bas… LWD            
#> 11             24   2026         12                 522 Zorg en… LEI            
#> 12             24   2026         14                 524 Den Hel… DHE            
#> 13             24   2026         18                 526 Heroes … DBO            
#> 14             24   2026         19                 528 Partena… AAL            
#> 15             24   2026         20                 530 AB InBe… LEU            
#> 16             24   2026         21                 532 Brussel… BRU            
#> 17             24   2026         22                 534 Kangoer… MEC            
#> 18             24   2026         32                 536 House o… KOR            
#> # ℹ 2 more variables: club_id <int>, club_name <chr>
# }
```
