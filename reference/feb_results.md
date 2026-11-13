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
#> ℹ Data updated: 2026-11-13 18:54:47 UTC
#> # A tibble: 18 × 17
#>    group season competition comp_id section    round_title  game_id home_team_id
#>    <int>  <int> <chr>         <int> <chr>      <chr>          <int>        <int>
#>  1     1   2027 PRIMERA FEB     115 results    Resultados … 2535784      1010207
#>  2     1   2027 PRIMERA FEB     115 results    Resultados … 2535782      1010494
#>  3     1   2027 PRIMERA FEB     115 results    Resultados … 2535779      1009716
#>  4     1   2027 PRIMERA FEB     115 results    Resultados … 2535780      1008687
#>  5     1   2027 PRIMERA FEB     115 results    Resultados … 2535786      1009584
#>  6     1   2027 PRIMERA FEB     115 results    Resultados … 2535785      1008797
#>  7     1   2027 PRIMERA FEB     115 results    Resultados … 2535783      1009837
#>  8     1   2027 PRIMERA FEB     115 results    Resultados … 2535787      1010324
#>  9     1   2027 PRIMERA FEB     115 results    Resultados … 2535781      1009072
#> 10     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535791      1008400
#> 11     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535793      1009109
#> 12     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535792      1009110
#> 13     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535788      1008687
#> 14     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535794      1008378
#> 15     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535795      1009095
#> 16     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535796      1008900
#> 17     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535789      1009929
#> 18     1   2027 PRIMERA FEB     115 next_round Próxima Jor… 2535790      1009713
#> # ℹ 9 more variables: home_team <chr>, away_team_id <int>, away_team <chr>,
#> #   result_text <chr>, home_score <int>, away_score <int>, status <chr>,
#> #   date <date>, time <chr>
# }
```
