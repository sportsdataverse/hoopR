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

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_season_roster")`) and in the
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
  try(sportpress_season_roster(season = 2026))
#> ── BNXT League Season Roster from Sportpress ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:55:14 UTC
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
