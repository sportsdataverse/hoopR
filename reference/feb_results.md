# **FEB Results**

**Latest round's results and the next round's fixtures of a FEB
competition season.**

Endpoint:
`GET https://baloncestoenvivo.feb.es/resultados.aspx?g={group}&t={season - 1}`

`section` is `results` (the LATEST round of the shown phase; for a
finished season the last playoff round) or `next_round` (empty once the
season is over). `comp_id` ties the site group to the API's competition
id (group 1 -\> 115, 2 -\> 118, 4 -\> 210).

## Usage

``` r
feb_results(group, season)
```

## Arguments

- group:

  (*integer* required): The site's menu group: 1 Primera FEB, 2 Segunda
  FEB, 4 Liga Femenina Endesa, 9 and 10 LF-2, 67 LF Challenge, 73 Copa
  de Espana, 74 Liga U. A group is not a competition id (see `comp_id`).

- season:

  (*integer* required): Season END year (`2027` = 2026-27), sent to the
  site as its START-year key `t = season - 1`.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "feb_results")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_results(group = 1, season = 2027))
#> ── FEB results from baloncestoenvivo.feb.es ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-24 20:42:38 UTC
#> # A tibble: 18 × 17
#>    group season competition comp_id section    round_title  game_id home_team_id
#>    <int>  <int> <chr>         <int> <chr>      <chr>          <int>        <int>
#>  1     1   2027 PRIMERA FEB     115 results    Resultados … 2535800      1010494
#>  2     1   2027 PRIMERA FEB     115 results    Resultados … 2535802      1010207
#>  3     1   2027 PRIMERA FEB     115 results    Resultados … 2535797      1009716
#>  4     1   2027 PRIMERA FEB     115 results    Resultados … 2535799      1010493
#>  5     1   2027 PRIMERA FEB     115 results    Resultados … 2535801      1009837
#>  6     1   2027 PRIMERA FEB     115 results    Resultados … 2535804      1009584
#>  7     1   2027 PRIMERA FEB     115 results    Resultados … 2535805      1010324
#>  8     1   2027 PRIMERA FEB     115 results    Resultados … 2535803      1008797
#>  9     1   2027 PRIMERA FEB     115 results    Resultados … 2535798      1009072
#> 10     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535809      1008400
#> 11     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535814      1008900
#> 12     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535813      1009095
#> 13     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535808      1009929
#> 14     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535806      1008687
#> 15     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535810      1009109
#> 16     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535811      1008378
#> 17     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535807      1009072
#> 18     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535812      1010493
#> # ℹ 9 more variables: home_team <chr>, away_team_id <int>, away_team <chr>,
#> #   result_text <chr>, home_score <int>, away_score <int>, status <chr>,
#> #   date <date>, time <chr>
# }
```
