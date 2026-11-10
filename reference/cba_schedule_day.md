# **Get CBA Schedule Day**

The games of one day: ids, teams, status, score, round and the data
flags.

Endpoint: `GET https://data-server.cbaleague.com/api/schedules/day`

## Usage

``` r
cba_schedule_day(day)
```

## Arguments

- day:

  (required) Required. Date 'YYYY-MM-DD'. The runtime always sends
  auto=0 (the site's auto mode jumps to the next game day) and refuses
  rows on another date.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_schedule_day")`) and in the
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
  try(cba_schedule_day(day = "2025-12-12"))
#> ── CBA Schedule Day from data-server.cbaleague.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:59:03 UTC
#> # A tibble: 1 × 27
#>   home_team_id home_team_logo      home_team_lose home_team_name home_team_score
#>          <int> <chr>                        <int> <chr>                    <int>
#> 1        29128 https://image.cbal…              0 浙江浙商证券                88
#> # ℹ 22 more variables: home_team_win <int>, is_events <int>, is_report <int>,
#> #   match_order <int>, match_type_id <int>, minutes <int>, quarter <int>,
#> #   round <int>, round_desc <chr>, schedule_id <int>, schedule_num <int>,
#> #   schedule_time <chr>, schedule_type_name <chr>, season <int>, seconds <dbl>,
#> #   status <int>, visiting_team_id <int>, visiting_team_logo <chr>,
#> #   visiting_team_lose <int>, visiting_team_name <chr>,
#> #   visiting_team_score <int>, visiting_team_win <int>
# }
```
