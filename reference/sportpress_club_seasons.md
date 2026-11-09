# **Get BNXT League Club Seasons**

Seasons (END years) in which Belgian and Dutch clubs have teams.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/competition-team/club/seasons`

## Usage

``` r
sportpress_club_seasons()
```

## Value

A `hoopR_data` tibble: Seasons (END years) in which Belgian and Dutch
clubs have teams. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`sportpress_club_seasons`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year in which the clubs (countries) have teams; includes 2021 = 2020-21. |

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
#> ℹ Data updated: 2026-11-09 12:09:00 UTC
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
