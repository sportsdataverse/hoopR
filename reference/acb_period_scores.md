# **Get ACB Period Scores**

Points each team scored in each period of a game.

One row per period: `quarter` (1-4, 5+ overtime), `home_score` and
`away_score` are the points scored IN that period, not cumulative. Old
games list fewer periods.

Endpoint:
`GET https://api2.acb.com/api/matchdata/MatchHeader/match-header`

## Usage

``` r
acb_period_scores(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_period_scores`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | ACB match id (one global sequence for every competition; legacy ids are below about 20000 up to 2019-20, ids from 2020-21 start around 100000). Taken from the request when the body does not name the game. |
| quarter | integer | Period number: 1-4 quarters, 5+ overtimes (a finished game lists every period played). |
| home_score | integer | Points the home team scored IN this period (not cumulative). |
| away_score | integer | Points the away team scored IN this period (not cumulative). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_period_scores(match_id = 105401))
#> ── ACB Period Scores from api2.acb.com ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:01:59 UTC
#> # A tibble: 4 × 4
#>   match_id quarter home_score away_score
#>      <int>   <int>      <int>      <int>
#> 1   105401       1         19         26
#> 2   105401       2         20         14
#> 3   105401       3         29         20
#> 4   105401       4         21         26
# }
```
