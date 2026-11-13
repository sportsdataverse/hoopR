# **Get CBA Period Scores**

Points each side scored in each period of a finished game (up to seven
periods).

Endpoint:
`POST https://data-server.cbaleague.com/api/schedule-quarters/getQuarterInfo`
(JSON body)

## Usage

``` r
cba_period_scores(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per side and played period. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_period_scores")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(cba_period_scores(schedule_id = 100105799))
#> ── CBA Period Scores from data-server.cbaleague.com ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:52:27 UTC
#> # A tibble: 8 × 4
#>   schedule_id side  period points
#>         <int> <chr>  <int>  <int>
#> 1   100105799 home       1     25
#> 2   100105799 home       2     26
#> 3   100105799 home       3     23
#> 4   100105799 home       4     14
#> 5   100105799 away       1     19
#> 6   100105799 away       2     22
#> 7   100105799 away       3     12
#> 8   100105799 away       4     21
# }
```
