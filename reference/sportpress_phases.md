# **Get BNXT League Phases**

The competition of a season with its phases (regular season, playoffs,
supercup).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/phase/season/{season}`

## Usage

``` r
sportpress_phases(season)
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26), the API's own key; no
  mapping is applied.

## Value

A `hoopR_data` tibble with one row per phase. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_phases")`) and in the
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
  try(sportpress_phases(season = 2026))
#> ── BNXT League Phases from Sportpress ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:57:45 UTC
#> # A tibble: 6 × 6
#>   season competition_id competition_name   phase_id phase_name standings_visible
#>    <int>          <int> <chr>                 <int> <chr>      <lgl>            
#> 1   2026             24 BNXT League 2025-…      169 "Regular … TRUE             
#> 2   2026             24 BNXT League 2025-…      173 ""         FALSE            
#> 3   2026             24 BNXT League 2025-…      175 "BNXT Sup… FALSE            
#> 4   2026             24 BNXT League 2025-…      177 "NL Super… FALSE            
#> 5   2026             24 BNXT League 2025-…      179 "Playoffs… FALSE            
#> 6   2026             24 BNXT League 2025-…      181 "Playoffs… FALSE            
# }
```
