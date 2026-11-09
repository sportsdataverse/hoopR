# **Get BNXT League Schedule**

Every game of a season for Belgian and Dutch clubs, with teams, scores,
phase and venue.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/club/{season}`

## Usage

``` r
sportpress_schedule(season, month = -1, phase_id = NULL)
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26), the API's own key; no
  mapping is applied.

- month:

  (default `-1`) Calendar month filter; -1 (default) = the whole season
  in one body.

- phase_id:

  (default `NULL`) Restrict to one phase (integer), from
  [`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md).
  Omitted = every phase.

## Value

A `hoopR_data` tibble: Every game of a season for Belgian and Dutch
clubs, with teams, scores, phase and venue. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_schedule`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id (key space: sportpress games), unique across seasons: the key of every game route. |
| game_time | POSIXct | Tip-off as a naive datetime. The source carries no offset; the league's local time is assumed and unverified. POSIXct in Europe/Brussels (league local time). |
| status | character | Game status: finished, or ready for an upcoming game. |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| season | integer | Season END year of the game's competition. |
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
  try(sportpress_schedule(season = 2026))
#> ── BNXT League Schedule from Sportpress ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:09:24 UTC
#> # A tibble: 347 × 19
#>    game_id game_time           status  competition_id season phase_id phase_name
#>      <int> <dttm>              <chr>            <int>  <int>    <int> <chr>     
#>  1   10569 2026-04-28 20:00:00 finish…             24   2026      169 Regular S…
#>  2   10571 2026-04-08 19:30:00 finish…             24   2026      169 Regular S…
#>  3   10573 2026-03-10 20:00:00 finish…             24   2026      169 Regular S…
#>  4   10575 2026-01-06 20:00:00 finish…             24   2026      169 Regular S…
#>  5   10577 2025-09-26 20:30:00 finish…             24   2026      169 Regular S…
#>  6   10579 2025-09-27 20:00:00 finish…             24   2026      169 Regular S…
#>  7   10581 2025-09-27 20:30:00 finish…             24   2026      169 Regular S…
#>  8   10583 2025-09-27 20:30:00 finish…             24   2026      169 Regular S…
#>  9   10585 2025-09-27 20:45:00 finish…             24   2026      169 Regular S…
#> 10   10587 2025-09-28 14:00:00 finish…             24   2026      169 Regular S…
#> # ℹ 337 more rows
#> # ℹ 12 more variables: round_name <chr>, round_priority <int>,
#> #   period_name <chr>, arena <chr>, home_competition_team_id <int>,
#> #   home_team <chr>, home_team_short_name <chr>, home_score <int>,
#> #   away_competition_team_id <int>, away_team <chr>,
#> #   away_team_short_name <chr>, away_score <int>
# }
```
