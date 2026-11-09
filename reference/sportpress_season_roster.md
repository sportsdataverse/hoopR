# **Get BNXT League Season Roster**

Every roster entry of a season: player, team, jersey, height, weight and
position.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/roster/season-players/{season}`

## Usage

``` r
sportpress_season_roster(season)
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26), the API's own key; no
  mapping is applied.

## Value

A `hoopR_data` tibble: Every roster entry of a season: player, team,
jersey, height, weight and position. An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_season_roster`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year the roster was asked for. |
| roster_id | integer | Roster id (key space: sportpress roster entries): one player on one competition team in one season, so a player has a new roster_id for every team and season. player_id is the person. |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| jersey | character | Shirt number as text; the box score sends it as an integer, so a zero-padded '00' is already lost there. |
| weight | integer | Weight in kg; null when unknown. |
| height | integer | Height in cm; null when unknown. |
| active | logical | True for a current roster entry; the lists hold current entries only. |
| position_id | integer | Position id (key space: sportpress positions; 3 = small_forward). |
| position | character | Position code: point_guard, shooting_guard, small_forward, power_forward, center, and the hybrids point_guard-shooting_guard, shooting_guard-small_forward, small_forward-power_forward, power_forward-center. |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |

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
  try(sportpress_season_roster(season = 2026))
#> ── BNXT League Season Roster from Sportpress ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 17:09:25 UTC
#> # A tibble: 312 × 14
#>    season roster_id competition_team_id jersey weight height active position_id
#>     <int>     <int>               <int> <chr>   <int>  <int> <lgl>        <int>
#>  1   2026     10127                 514 ""         83    190 TRUE             3
#>  2   2026     10129                 514 ""         NA    190 TRUE             2
#>  3   2026     10131                 514 ""         NA    183 TRUE             3
#>  4   2026     10133                 514 ""         NA     NA TRUE             2
#>  5   2026     10135                 514 ""         NA    200 TRUE             5
#>  6   2026     10137                 514 ""         NA    197 TRUE             2
#>  7   2026     10139                 514 ""         NA    193 TRUE             3
#>  8   2026     10141                 514 ""         NA    203 TRUE             2
#>  9   2026     10145                 514 ""         NA     NA TRUE             2
#> 10   2026     10147                 514 ""         NA     NA TRUE             2
#> # ℹ 302 more rows
#> # ℹ 6 more variables: position <chr>, player_id <int>, first_name <chr>,
#> #   last_name <chr>, nationality_code <chr>, birth_date <date>
# }
```
