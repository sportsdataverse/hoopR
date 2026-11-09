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

A `hoopR_data` tibble: The competition of a season with its phases
(regular season, playoffs, supercup). An empty valid answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `sportpress_phases`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), the sdv convention and the API's own season key. |
| competition_id | integer | Competition id (key space: sportpress competitions): ONE season of the league (24 = 2025-26, 25 = 2026-27). Not the season number. The key of the standings, ranking, slider and box routes. |
| competition_name | character | Competition name, 'BNXT League 2025-2026'. |
| phase_id | integer | Phase id (key space: sportpress phases); the `{phaseId}` of the standings route. New every season. |
| phase_name | character | Phase name as entered in the CMS; names differ every season. |
| standings_visible | logical | Whether the phase shows standings; false for playoff phases, which answer the standings route empty. |

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
#> ℹ Data updated: 2026-11-09 12:09:08 UTC
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
