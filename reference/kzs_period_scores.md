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

A `hoopR_data` tibble with one row per team and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_period_scores")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
#> ℹ Data updated: 2026-11-10 02:02:44 UTC
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
