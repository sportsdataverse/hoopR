# **NBL Rosetta Seasons Current**

The season in progress (empty between seasons: `hoopR_no_data`).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/seasons/current`

## Usage

``` r
nbl_rosetta_seasons_current(org = "nbl")
```

## Arguments

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

## Value

A `hoopR_data` tibble (one row: the season in progress):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| season_id | character | DataCore season id (UUID v1); accepted as `{season_id}`. |
| rosetta_season_id | character | Rosetta season id (UUID v4; v5 on NBL1); the `{season_id}` route key. |
| name | character | Season name as Rosetta spells it (NBL26, WNBL 2024/25); names drift, key on season_year. |
| season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
| season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
| start_date | character | First day of the season, ISO date-time without offset. |
| end_date | character | Last day of the season, ISO date-time without offset; null on older seasons. |
| competition_name | character | Name of the competition the season belongs to (e.g. NBL). |
| competition_age_group | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| next_match_start_datetime | character | Tip-off of the season's next match, UTC; null when none. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |

Columns the body adds beyond these follow, in body order
(sportsdataverse-py keeps them too).

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(nbl_rosetta_seasons_current(org = "nbl"))
#> ── NBL Rosetta seasons_current from prod.rosetta.nbl.com.au ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:08:02 UTC
#> # A tibble: 1 × 12
#>   org   season_id     rosetta_season_id name  season_year season_type start_date
#>   <chr> <chr>         <chr>             <chr>       <int> <chr>       <chr>     
#> 1 nbl   1b041b7b-3dd… 67d4a190-40bc-4b… NBL27        2026 regular     2026-09-1…
#> # ℹ 5 more variables: end_date <chr>, competition_name <chr>,
#> #   competition_age_group <chr>, next_match_start_datetime <chr>,
#> #   season_end_year <int>
# }
```
