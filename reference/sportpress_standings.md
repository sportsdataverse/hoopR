# **Get BNXT League Standings**

Standings of one phase of a competition: record, points, home/away
split, last five and streak.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/standings/competition/{competition_id}/phase/{phase_id}`

## Usage

``` r
sportpress_standings(competition_id, phase_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- phase_id:

  (required) Phase id (integer) of the competition, from
  [`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  (`phase_id`).

## Value

A `hoopR_data` tibble: Standings of one phase of a competition: record,
points, home/away split, last five and streak. An empty valid answer
raises `hoopR_no_data`; the columns are always these, in this order
(sdv-py `sportpress_standings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| club_id | integer | Country of the team (key space: sportpress clubs): 1 = Belgium, 2 = Netherlands. The provider calls the country a club. |
| club_name | character | Country name in English, Belgium or Netherlands. |
| position | integer | Rank in the table, 1 = first. |
| played | integer | Games played in the phase (win + loss + even). |
| win | integer | Games won in the phase. |
| loss | integer | Games lost in the phase. |
| even | integer | Games drawn; 0 in every sample (basketball has no draws). |
| score | integer | Points scored in the phase. |
| against | integer | Points conceded in the phase. |
| score_difference | integer | score - against. |
| percent | numeric | Win percentage 0-100, rounded to 1 decimal. |
| point | integer | League points: 2 per win plus 1 per loss. |
| point_percent | numeric | Share of the possible league points won, 0-1 rounded to 2 decimals. |
| home_win | integer | Wins in home games. |
| home_loss | integer | Losses in home games. |
| away_win | integer | Wins in away games. |
| away_loss | integer | Losses in away games. |
| last5_win | integer | Wins among the last five games. |
| last5_loss | integer | Losses among the last five games. |
| streak_is_win | logical | True for a winning streak, false for a losing one. |
| streak_count | integer | Length of the current streak in games. |
| group | character | Group label for split phases; null in every sample. |

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
[`sportpress_team_find()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_find.md),
[`sportpress_team_games()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_games.md),
[`sportpress_team_player_averages()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_player_averages.md),
[`sportpress_team_rankings()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_rankings.md),
[`sportpress_team_roster()`](https://hoopR.sportsdataverse.org/reference/sportpress_team_roster.md),
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md)

## Examples

``` r
# \donttest{
  try(sportpress_standings(competition_id = 24, phase_id = 169))
#> ── BNXT League Standings from Sportpress ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 19:46:24 UTC
#> # A tibble: 18 × 27
#>    competition_id phase_id competition_team_id team      team_short_name club_id
#>             <int>    <int>               <int> <chr>     <chr>             <int>
#>  1             24      169                 506 Windrose… ANT                   1
#>  2             24      169                 504 Filou Oo… OOS                   1
#>  3             24      169                 528 Partena … AAL                   1
#>  4             24      169                 536 House of… KOR                   1
#>  5             24      169                 510 Hubo Lim… LIM                   1
#>  6             24      169                 526 Heroes D… DBO                   2
#>  7             24      169                 512 Donar Gr… GRO                   2
#>  8             24      169                 534 Kangoero… MEC                   1
#>  9             24      169                 532 Brussels… BRU                   1
#> 10             24      169                 522 Zorg en … LEI                   2
#> 11             24      169                 502 Val-Dieu… CHA                   1
#> 12             24      169                 530 AB InBev… LEU                   1
#> 13             24      169                 524 Den Held… DHE                   2
#> 14             24      169                 516 Landsted… ZWO                   2
#> 15             24      169                 520 LWD Bask… LWD                   2
#> 16             24      169                 508 Union Mo… MON                   1
#> 17             24      169                 518 Zeeuw & … RCB                   2
#> 18             24      169                 514 PrismaWo… BAL                   2
#> # ℹ 21 more variables: club_name <chr>, position <int>, played <int>,
#> #   win <int>, loss <int>, even <int>, score <int>, against <int>,
#> #   score_difference <int>, percent <dbl>, point <int>, point_percent <dbl>,
#> #   home_win <int>, home_loss <int>, away_win <int>, away_loss <int>,
#> #   last5_win <int>, last5_loss <int>, streak_is_win <lgl>, streak_count <int>,
#> #   group <chr>
# }
```
