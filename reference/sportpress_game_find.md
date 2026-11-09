# **Get BNXT League Game**

One game: teams, scores, phase, venue and the neighbouring game ids.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/find/{game_id}`

## Usage

``` r
sportpress_game_find(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: One game: teams, scores, phase, venue and the
neighbouring game ids. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`sportpress_game_find`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
| game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
| status | character | Game status: finished, or ready for an upcoming game. |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
| phase_id | integer | Phase id (key space: sportpress phases), a stage of one competition such as the regular season or the playoffs; new every season. |
| phase_name | character | Phase name as entered in the CMS ('Regular season 2026-27'). |
| round_name | character | Round label as entered in the CMS; often empty. |
| round_priority | integer | Sort order of the round within the phase (provider's priority); meaning of the values is unverified. |
| period_name | character | Name of the period the game is in or ended in; 'Extra2' means the second overtime. |
| arena | character | Name of the arena where the game is played. |
| home_competition_team_id | integer | Home side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| home_team | character | Home side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| home_team_short_name | character | Home side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| home_score | integer | Home side. Final points of the side, including overtime. |
| away_competition_team_id | integer | Away side. Competition-team id (key space: sportpress competition teams): a team in ONE competition, so the same club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). Joins competitors, rosters, box scores, film and standings. The stable club key across seasons is `uu_team_id`. |
| away_team | character | Away side. Display name incl. the sponsor. Teams of the playoff phases carry a ' playoff' suffix (2025-26), and standings names vary with X-Localization ('Partena Professional Okapi Aalst Playoff' (en) vs 'Okapi Aalst Playoff' (nl, fr)): never join on it. |
| away_team_short_name | character | Away side. Three-letter club code (CHA, OOS, ANT, MON, LIM, ...), stable across seasons in the samples. |
| away_score | integer | Away side. Final points of the side, including overtime. |
| last_game_id | integer | Latest finished meeting of the same two teams in the competition, which can be LATER than this game; null when none. |
| next_game_id | integer | Next meeting of the same two teams; null in every sample. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportpress_game_find(game_id = 11295))
#> ── BNXT League Game from Sportpress ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:09:03 UTC
#> # A tibble: 1 × 21
#>   game_id game_time           status   competition_id season phase_id phase_name
#>     <int> <dttm>              <chr>             <int>  <int>    <int> <chr>     
#> 1   11295 2026-10-10 20:30:00 finished             25   2027      183 Regular s…
#> # ℹ 14 more variables: round_name <chr>, round_priority <int>,
#> #   period_name <chr>, arena <chr>, home_competition_team_id <int>,
#> #   home_team <chr>, home_team_short_name <chr>, home_score <int>,
#> #   away_competition_team_id <int>, away_team <chr>,
#> #   away_team_short_name <chr>, away_score <int>, last_game_id <int>,
#> #   next_game_id <int>
# }
```
