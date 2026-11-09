# **Get BNXT League Club Seasons**

Seasons (END years) in which Belgian and Dutch clubs have teams.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/club/seasons`

## Usage

``` r
sportpress_club_seasons()
```

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_club_seasons")`) and in the
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
  try(sportpress_club_seasons())
#> ── BNXT League Club Seasons from Sportpress ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:15:07 UTC
#> # A tibble: 6 × 1
#>   season
#>    <int>
#> 1   2022
#> 2   2023
#> 3   2024
#> 4   2025
#> 5   2026
#> 6   2027
# }
```
