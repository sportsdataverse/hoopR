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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| group | integer | The site's menu group (1 Primera FEB, 2 Segunda FEB, 4 Liga Femenina Endesa); not a competition id. |
| season | integer | Season END year (2027 = 2026-27), the site's START-year key plus one. |
| competition | character | Competition name on the page header ('PRIMERA FEB'). |
| comp_id | integer | Competition id (CompID) read from the page; ties the site group to the API (group 1 -\> 115, 2 -\> 118, 4 -\> 210). |
| table | character | live = the in-season league table; final = the final classification once the season is over. |
| position | integer | Rank in the table (Po). |
| team_id | integer | Team-season id (new every season; joins the schedule and game wrappers). |
| team | character | Team name as printed in the table (sponsor name, uppercase). |
| played | integer | Games played (PJ); null in the final classification. |
| won | integer | Games won (PG); null in the final classification. |
| lost | integer | Games lost (PP); null in the final classification. |
| points_for | integer | Points scored (PF); null in the final classification. |
| points_against | integer | Points conceded (PC); null in the final classification. |
| point_diff | integer | Point difference (DIF), signed; null in the final classification. |
| win_pct | double | Win percentage, 0-100 (the page's '100,0%', decimal comma converted). |
| streak | integer | Current streak as a signed integer: +3 = three wins in a row, -2 = two losses. |
| streak_text | character | The streak cell verbatim ('+3'). |

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
#> ℹ Data updated: 2026-10-31 21:29:57 UTC
#> # A tibble: 18 × 17
#>    group season competition comp_id table position team_id team     played   won
#>    <int>  <int> <chr>         <int> <chr>    <int>   <int> <chr>     <int> <int>
#>  1     1   2027 PRIMERA FEB     115 live         1 1008687 HLA ALI…      6     6
#>  2     1   2027 PRIMERA FEB     115 live         2 1010493 MOVISTA…      5     5
#>  3     1   2027 PRIMERA FEB     115 live         3 1010207 IBEROLE…      6     5
#>  4     1   2027 PRIMERA FEB     115 live         4 1008797 CAJASIE…      5     4
#>  5     1   2027 PRIMERA FEB     115 live         5 1009584 GRUPO A…      6     4
#>  6     1   2027 PRIMERA FEB     115 live         6 1009109 COVIRAN…      6     4
#>  7     1   2027 PRIMERA FEB     115 live         7 1009713 PALMER …      5     3
#>  8     1   2027 PRIMERA FEB     115 live         8 1009837 ALIMERK…      5     3
#>  9     1   2027 PRIMERA FEB     115 live         9 1009095 CLUB OU…      6     3
#> 10     1   2027 PRIMERA FEB     115 live        10 1010324 INSOLAC…      6     3
#> 11     1   2027 PRIMERA FEB     115 live        11 1009716 BUENO A…      6     3
#> 12     1   2027 PRIMERA FEB     115 live        12 1009110 CAJASOL…      5     2
#> 13     1   2027 PRIMERA FEB     115 live        13 1008900 CAJA RU…      6     2
#> 14     1   2027 PRIMERA FEB     115 live        14 1008378 INVEREA…      5     1
#> 15     1   2027 PRIMERA FEB     115 live        15 1010494 PARTIZÁ…      6     1
#> 16     1   2027 PRIMERA FEB     115 live        16 1008400 GRUPO U…      6     1
#> 17     1   2027 PRIMERA FEB     115 live        17 1009072 FIBWI M…      6     1
#> 18     1   2027 PRIMERA FEB     115 live        18 1009929 BÀSQUET…      6     0
#> # ℹ 7 more variables: lost <int>, points_for <int>, points_against <int>,
#> #   point_diff <int>, win_pct <dbl>, streak <int>, streak_text <chr>
# }
```
