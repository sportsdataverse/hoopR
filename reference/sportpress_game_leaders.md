# **Get BNXT League Game Leaders**

The game leader of each side in every statistic (one row per side and
statistic).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`

## Usage

``` r
sportpress_game_leaders(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble: The game leader of each side in every statistic
(one row per side and statistic). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_game_leaders`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | Game id the overview was asked for (the body does not echo it). |
| team_side | character | Side of the game the row belongs to: home or away (the provider's is_home, or side 1 / 2). |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| stat | character | Statistic the leader leads, in the provider's column name (points, total_rebound, value, ...). |
| player_id | integer | Player id (key space: sportpress persons): stable across seasons and teams, distinct from roster_id. Not a Genius or FIBA person id. |
| first_name | character | Given name of the player as entered in the CMS. |
| last_name | character | Family name of the player as entered in the CMS. |
| nationality_code | character | Nationality code in FIBA style (USA, BEL, NED): DIRTY, with lower-case variants, '/'-joined pairs (USA/BEL), the empty string and 'HOL'; normalise before joining. |
| birth_date | Date | Date of birth as shown on the public player page; null when unknown. |
| value | double | The leader's count (or percentage) in that statistic in this game. |

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
  try(sportpress_game_leaders(game_id = 11295))
#> ── BNXT League Game Leaders from Sportpress ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:09:04 UTC
#> # A tibble: 56 × 12
#>    game_id team_side competition_team_id team    team_short_name stat  player_id
#>      <int> <chr>                   <int> <chr>   <chr>           <chr>     <int>
#>  1   11295 home                      541 Windro… ANT             minu…      5325
#>  2   11295 home                      541 Windro… ANT             foul        228
#>  3   11295 home                      541 Windro… ANT             defe…      5325
#>  4   11295 home                      541 Windro… ANT             dunk…      5683
#>  5   11295 home                      541 Windro… ANT             dunk…      5683
#>  6   11295 home                      541 Windro… ANT             dunk…      5683
#>  7   11295 home                      541 Windro… ANT             two_…       202
#>  8   11295 home                      541 Windro… ANT             two_…       202
#>  9   11295 home                      541 Windro… ANT             two_…      5683
#> 10   11295 home                      541 Windro… ANT             thre…      5325
#> # ℹ 46 more rows
#> # ℹ 5 more variables: first_name <chr>, last_name <chr>,
#> #   nationality_code <chr>, birth_date <date>, value <dbl>
# }
```
