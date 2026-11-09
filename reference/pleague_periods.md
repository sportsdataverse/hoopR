# **Get P. LEAGUE+ Periods**

Points each team scored in each quarter and overtime of one finished
game.

Endpoint: `GET https://pleagueofficial.com/game/{gid}`

## Usage

``` r
pleague_periods(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble with one row per period. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_periods")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(pleague_periods(gid = 197))
#> ── P. LEAGUE+ Periods from pleagueofficial.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:14:19 UTC
#> # A tibble: 4 × 5
#>     gid period period_no home_points away_points
#>   <int> <chr>      <int>       <int>       <int>
#> 1   197 Q1             1          28          19
#> 2   197 Q2             2          21          28
#> 3   197 Q3             3          35          24
#> 4   197 Q4             4          18          23
# }
```
