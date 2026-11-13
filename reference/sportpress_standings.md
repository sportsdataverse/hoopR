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

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_standings")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
  try(sportpress_standings(competition_id = 24, phase_id = 169))
#> ── BNXT League Standings from Sportpress ──────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:59:23 UTC
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
