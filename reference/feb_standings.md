# **FEB Standings**

**League table of a FEB competition season (live standings, or the final
classification once it is over).**

Endpoint:
`GET https://baloncestoenvivo.feb.es/resultados.aspx?g={group}&t={season - 1}`

`table` is `live` (the in-season table) or `final` (the final
classification: only `position` and the team, every other statistic is
`NA`); the page shows one of the two. Only the first phase of the group
is shown.

## Usage

``` r
feb_standings(group, season)
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

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "feb_standings")`) and in the searchable
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
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_standings(group = 1, season = 2027))
#> ── FEB standings from baloncestoenvivo.feb.es ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 13:58:40 UTC
#> # A tibble: 18 × 17
#>    group season competition comp_id table position team_id team     played   won
#>    <int>  <int> <chr>         <int> <chr>    <int>   <int> <chr>     <int> <int>
#>  1     1   2027 PRIMERA FEB     115 live         1 1008687 HLA ALI…      7     7
#>  2     1   2027 PRIMERA FEB     115 live         2 1010493 MOVISTA…      7     6
#>  3     1   2027 PRIMERA FEB     115 live         3 1010207 IBEROLE…      7     6
#>  4     1   2027 PRIMERA FEB     115 live         4 1008797 CAJASIE…      7     5
#>  5     1   2027 PRIMERA FEB     115 live         5 1009584 GRUPO A…      7     5
#>  6     1   2027 PRIMERA FEB     115 live         6 1009095 CLUB OU…      7     4
#>  7     1   2027 PRIMERA FEB     115 live         7 1009713 PALMER …      7     4
#>  8     1   2027 PRIMERA FEB     115 live         8 1009109 COVIRAN…      7     4
#>  9     1   2027 PRIMERA FEB     115 live         9 1009837 ALIMERK…      7     4
#> 10     1   2027 PRIMERA FEB     115 live        10 1010324 INSOLAC…      7     3
#> 11     1   2027 PRIMERA FEB     115 live        11 1008900 CAJA RU…      7     3
#> 12     1   2027 PRIMERA FEB     115 live        12 1009716 BUENO A…      7     3
#> 13     1   2027 PRIMERA FEB     115 live        13 1009110 CAJASOL…      7     2
#> 14     1   2027 PRIMERA FEB     115 live        14 1008400 GRUPO U…      7     2
#> 15     1   2027 PRIMERA FEB     115 live        15 1008378 INVEREA…      7     2
#> 16     1   2027 PRIMERA FEB     115 live        16 1010494 PARTIZÁ…      7     1
#> 17     1   2027 PRIMERA FEB     115 live        17 1009929 BÀSQUET…      7     1
#> 18     1   2027 PRIMERA FEB     115 live        18 1009072 FIBWI M…      7     1
#> # ℹ 7 more variables: lost <int>, points_for <int>, points_against <int>,
#> #   point_diff <int>, win_pct <dbl>, streak <int>, streak_text <chr>
# }
```
