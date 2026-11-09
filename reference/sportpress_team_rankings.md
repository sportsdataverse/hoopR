# **Get BNXT League Team Rankings**

Team per-game leaders in nine categories (one row per team and
category).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/average-rankings/{competition_id}`

## Usage

``` r
sportpress_team_rankings(competition_id, phase_id = NULL, limit = NULL)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- phase_id:

  (default `NULL`) Restrict to one phase (integer), from
  [`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md).
  Omitted = every phase.

- limit:

  (default `NULL`) Cap each ranking list at this many rows. Omitted =
  the complete lists.

## Value

A `hoopR_data` tibble: Team per-game leaders in nine categories (one row
per team and category). An empty valid answer raises `hoopR_no_data`;
the columns are always these, in this order (sportsdataverse-py
`sportpress_team_rankings`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| category | character | Ranking category: efficiency, points, total_rebound, block, assist, steal, two_point_percent, three_point_percent or free_throw_percent. |
| rank | integer | Place in the category list, 1 = the leader (the list is sorted best first). |
| competition_team_id | integer | Competition-team id (key space: sportpress competition teams): a team in ONE competition, so a club has a new id every season (Antwerp = 3 in 2021-22, 506 in 2025-26, 541 in 2026-27). uu_team_id is the stable club key. |
| team | character | Team display name including the sponsor; varies with language and playoff suffixes: never join on it. |
| team_short_name | character | Three-letter club code (ANT, MON, ...), stable across seasons in the samples. |
| value | double | The team's per-game mean (or percentage 0-100) in the row's category. |

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
  try(sportpress_team_rankings(competition_id = 24))
#> ── BNXT League Team Rankings from Sportpress ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:09:16 UTC
#> # A tibble: 162 × 7
#>    competition_id category  rank competition_team_id team  team_short_name value
#>             <int> <chr>    <int>               <int> <chr> <chr>           <dbl>
#>  1             24 efficie…     1                 506 Wind… ANT              128.
#>  2             24 efficie…     2                 528 Part… AAL              128.
#>  3             24 efficie…     3                 510 Hubo… LIM              126.
#>  4             24 efficie…     4                 504 Filo… OOS              120.
#>  5             24 efficie…     5                 526 Hero… DBO              115.
#>  6             24 efficie…     6                 536 Hous… KOR              113.
#>  7             24 efficie…     7                 522 Zorg… LEI              111.
#>  8             24 efficie…     8                 512 Dona… GRO              110.
#>  9             24 efficie…     9                 532 Brus… BRU              110.
#> 10             24 efficie…    10                 520 LWD … LWD              107.
#> # ℹ 152 more rows
# }
```
