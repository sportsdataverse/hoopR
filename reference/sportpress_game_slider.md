# **Get BNXT League Game Slider**

The latest 14 finished games of a competition plus every upcoming game,
with the Genius match id.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/game-slider/{competition_id}`

## Usage

``` r
sportpress_game_slider(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

## Value

A `hoopR_data` tibble: The latest 14 finished games of a competition
plus every upcoming game, with the Genius match id. An empty valid
answer raises `hoopR_no_data`; the columns are always these, in this
order (sdv-py `sportpress_game_slider`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
| genius_id | integer | Genius Sports LiveStats match id (organisation BNXT): the join to the genius family. Upcoming games already carry one; null for the 2020-21 competition. |
| game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
| status | character | Game status: finished, or ready for an upcoming game. |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
| phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
| phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
| home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| home_score | integer | Home side. Final points of the side, including overtime. |
| away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| away_score | integer | Away side. Final points of the side, including overtime. |

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
  (`sportpress_game_slider()`, organisation BNXT). The game routes (box
  score, film, overview) refuse a game that is not finished
  (AssetFetchError).

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
  try(sportpress_game_slider(competition_id = 25))
#> ── BNXT League Game Slider from Sportpress ───────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 16:03:07 UTC
#> # A tibble: 29 × 16
#>    game_id genius_id game_time           status   competition_id season phase_id
#>      <int>     <int> <dttm>              <chr>             <int>  <int>    <int>
#>  1   11291   2873602 2026-10-09 20:30:00 finished             25   2027      183
#>  2   11293   2873617 2026-10-09 20:30:00 finished             25   2027      183
#>  3   11297   2873606 2026-10-10 20:00:00 finished             25   2027      183
#>  4   11295   2873604 2026-10-10 20:30:00 finished             25   2027      183
#>  5   11299   2873610 2026-10-10 20:30:00 finished             25   2027      183
#>  6   11301   2873609 2026-10-10 20:30:00 finished             25   2027      183
#>  7   11303   2873613 2026-10-14 19:30:00 finished             25   2027      183
#>  8   11305   2873614 2026-10-16 20:30:00 finished             25   2027      183
#>  9   11307   2873616 2026-10-16 20:30:00 finished             25   2027      183
#> 10   11309   2873620 2026-10-17 20:00:00 finished             25   2027      183
#> # ℹ 19 more rows
#> # ℹ 9 more variables: phase_name <chr>, home_competition_team_id <int>,
#> #   home_team <chr>, home_team_short_name <chr>, home_score <int>,
#> #   away_competition_team_id <int>, away_team <chr>,
#> #   away_team_short_name <chr>, away_score <int>
# }
```
