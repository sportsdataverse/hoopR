# **Get CBA Game Team Shots**

Shot-zone profile of the two teams of a game. NOT game data: the teams'
current season table.

Endpoint:
`POST https://data-server.cbaleague.com/api/team-match-datas/schedule-shoot-list`
(JSON body)

## Usage

``` r
cba_game_team_shots(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_game_team_shots")`) and in the
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
  try(cba_game_team_shots(schedule_id = 100105799))
#> ── CBA Game Team Shots from data-server.cbaleague.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:52:24 UTC
#> # A tibble: 2 × 50
#>   bout_no_points_sort bout_point_sort bout_subtract_points_sort
#>                 <dbl>           <dbl>                     <dbl>
#> 1                  NA              NA                        NA
#> 2                  NA              NA                        NA
#> # ℹ 47 more variables: guard_field_goals_at_rim <dbl>,
#> #   guard_field_goals_at_rim_rank <dbl>, guard_field_goals_at_rim_sort <dbl>,
#> #   guard_hit_at_rim_made_rate <dbl>, guard_hit_at_rim_made_rate_rank <dbl>,
#> #   guard_hit_at_rim_made_rate_sort <dbl>, guard_hit_middle_rate <dbl>,
#> #   guard_hit_middle_rate_rank <dbl>, guard_hit_middle_rate_sort <dbl>,
#> #   guard_middle_rate <dbl>, guard_middle_rate_rank <dbl>,
#> #   guard_middle_rate_sort <dbl>, guard_real_point <dbl>, …
# }
```
