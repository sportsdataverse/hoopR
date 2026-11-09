# **Get KZS Period Scores**

Points by match part (quarters and overtimes) from the match header.

Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}`

## Usage

``` r
kzs_period_scores(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble: Points by match part (quarters and overtimes)
from the match header. An empty valid answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`kzs_period_scores`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Match id: the federation key of a game, global across seasons (joins kzs_matches and kzs_match). |
| score_id | integer | Period-score row id. |
| match_part | character | Period: QUARTER1-QUARTER4, then OT1 for the first overtime (OT2 and on by the same pattern, unobserved). |
| first_team_score | integer | First (home) team points in the period. |
| second_team_score | integer | Second (away) team points in the period. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_period_scores(match_id = 101839))
#> ── KZS Period Scores from api.kzs.si ──────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:06:22 UTC
#> # A tibble: 5 × 5
#>   match_id score_id match_part first_team_score second_team_score
#>      <int>    <int> <chr>                 <int>             <int>
#> 1   101839   370873 QUARTER1                 25                24
#> 2   101839   370874 QUARTER2                 24                22
#> 3   101839   370875 QUARTER3                 18                18
#> 4   101839   370876 QUARTER4                 19                22
#> 5   101839   370877 OT1                       9                 7
# }
```
