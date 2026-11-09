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

A `hoopR_data` tibble: One row per side and played period (overtime
included). An empty valid answer is a zero-row tibble with these
columns, in this order (sportsdataverse-py `cba_period_scores`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
| side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
| period | integer | Period number: 1-4 regulation, 5 and up overtime (the API holds up to seven periods). |
| points | integer | Points the side scored IN this period (not cumulative); overtime periods included. |

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
#> ℹ Data updated: 2026-11-09 12:02:49 UTC
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
