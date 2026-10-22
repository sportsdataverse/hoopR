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

The Spanish Basketball Federation (FEB) wrappers cover Primera FEB,
Segunda FEB and Liga Femenina Endesa (plus the federation's other groups
on the same routes). They mirror sdv-py's
`sportsdataverse.basketball.feb` wrappers of the same names: same
arguments, the same snake_case columns and types, one row per sdv-py
row.

**Legal notice.** The FEB's aviso legal (legal notice) asserts
intellectual-property rights over the site's content and its databases
(the EU database right). It has no explicit scraping clause, and
robots.txt answers 404 on both hosts. Fetching for your own use on your
own machine is how these wrappers are meant to be used; check the notice
before you republish the data.

**Unofficial and unsupported.** The LiveStats API (`intrafeb.feb.es`) is
the federation's own widget backend, not a documented public API. It
needs a bearer token, which is public: it is read from the home page of
`baloncestoenvivo.feb.es` at run time, kept in memory for the R session
(24 h validity, renewed once on an HTTP 401) and never printed, logged
or written. Requests are spaced at least one second apart per host; 429
and 5xx answers are retried (three attempts).

**Coverage.** The game routes answer from 2020-21 (Liga Femenina Endesa
from its first game; Primera FEB from 2021-03-12, so its earlier 2020-21
games and every earlier season answer 404). 2020-21 play-by-play is text
only. The schedule pages go back to 1996-97 (`season = 1997`).

**Seasons** are END years (`season = 2027` is 2026-27); the site's own
`t` key is the START year, so the request sends `t = season - 1`.

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (HTTP 404, an unknown group, a schedule page with no
games, an empty overview window), `hoopR_bad_request` (HTTP 400 / 422,
or a `game_id`, `group` or `season` that is not a non-negative integer)
and `hoopR_asset_fetch` (any other failure: another status, a transport
error, a token the API still rejects after one renewal, a non-JSON or
non-HTML body, an error or changed envelope, a play-by-play of another
game, a page for another group or season, or layout drift). All inherit
`hoopR_error`.

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
#> ℹ Data updated: 2026-10-22 02:37:26 UTC
#> # A tibble: 18 × 17
#>    group season competition comp_id table position team_id team     played   won
#>    <int>  <int> <chr>         <int> <chr>    <int>   <int> <chr>     <int> <int>
#>  1     1   2027 PRIMERA FEB     115 live         1 1010493 MOVISTA…      4     4
#>  2     1   2027 PRIMERA FEB     115 live         2 1008687 HLA ALI…      4     4
#>  3     1   2027 PRIMERA FEB     115 live         3 1009584 GRUPO A…      4     4
#>  4     1   2027 PRIMERA FEB     115 live         4 1008797 CAJASIE…      4     3
#>  5     1   2027 PRIMERA FEB     115 live         5 1010207 IBEROLE…      4     3
#>  6     1   2027 PRIMERA FEB     115 live         6 1009713 PALMER …      4     3
#>  7     1   2027 PRIMERA FEB     115 live         7 1009095 CLUB OU…      4     2
#>  8     1   2027 PRIMERA FEB     115 live         8 1009110 CAJASOL…      4     2
#>  9     1   2027 PRIMERA FEB     115 live         9 1009109 COVIRAN…      4     2
#> 10     1   2027 PRIMERA FEB     115 live        10 1010324 INSOLAC…      4     2
#> 11     1   2027 PRIMERA FEB     115 live        11 1009716 BUENO A…      4     2
#> 12     1   2027 PRIMERA FEB     115 live        12 1009837 ALIMERK…      4     2
#> 13     1   2027 PRIMERA FEB     115 live        13 1009072 FIBWI M…      4     1
#> 14     1   2027 PRIMERA FEB     115 live        14 1008900 CAJA RU…      4     1
#> 15     1   2027 PRIMERA FEB     115 live        15 1008378 INVEREA…      4     1
#> 16     1   2027 PRIMERA FEB     115 live        16 1010494 PARTIZÁ…      4     0
#> 17     1   2027 PRIMERA FEB     115 live        17 1008400 GRUPO U…      4     0
#> 18     1   2027 PRIMERA FEB     115 live        18 1009929 BÀSQUET…      4     0
#> # ℹ 7 more variables: lost <int>, points_for <int>, points_against <int>,
#> #   point_diff <int>, win_pct <dbl>, streak <int>, streak_text <chr>
# }
```
