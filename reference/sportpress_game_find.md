# **Get BNXT League Game**

One game: teams, scores, phase, venue and the neighbouring game ids.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/find/{game_id}`

## Usage

``` r
sportpress_game_find(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_game_find")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
  try(sportpress_game_find(game_id = 11295))
#> ── BNXT League Game from Sportpress ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:55:04 UTC
#> # A tibble: 1 × 21
#>   game_id game_time           status   competition_id season phase_id phase_name
#>     <int> <dttm>              <chr>             <int>  <int>    <int> <chr>     
#> 1   11295 2026-10-10 20:30:00 finished             25   2027      183 Regular s…
#> # ℹ 14 more variables: round_name <chr>, round_priority <int>,
#> #   period_name <chr>, arena <chr>, home_competition_team_id <int>,
#> #   home_team <chr>, home_team_short_name <chr>, home_score <int>,
#> #   away_competition_team_id <int>, away_team <chr>,
#> #   away_team_short_name <chr>, away_score <int>, last_game_id <int>,
#> #   next_game_id <int>
# }
```
