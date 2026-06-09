# **Basketball-Reference Draft**

**Get NBA draft results with career stats from
[Basketball-Reference](https://www.basketball-reference.com).**

Returns every pick of a draft, paired with the player's career totals
and advanced metrics. No API key is required. Basketball-Reference
rate-limits aggressive scraping (~20 requests/minute) – space repeated
calls with [`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_draft(season = most_recent_nba_season())
```

## Arguments

- season:

  (*integer* required): Draft year (e.g. `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per draft pick (career columns shown
– column names are Basketball-Reference `data-stat` keys):

|              |           |                                            |
|--------------|-----------|--------------------------------------------|
| col_name     | types     | description                                |
| pick_overall | integer   | Overall draft pick number.                 |
| round        | integer   | Draft round.                               |
| team         | character | Drafting team abbreviation.                |
| player       | character | Player name.                               |
| college_name | character | College / pre-draft team.                  |
| seasons      | integer   | NBA seasons played.                        |
| g            | integer   | Career games.                              |
| pts          | numeric   | Career points.                             |
| trb          | numeric   | Career total rebounds.                     |
| ast          | numeric   | Career assists.                            |
| ws           | numeric   | Career win shares.                         |
| bpm          | numeric   | Career box plus/minus.                     |
| vorp         | numeric   | Career value over replacement player.      |
| season       | integer   | Draft year (echoes the `season` argument). |

## See also

Other Basketball-Reference Functions:
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_draft(season = 2024))
#> ── Draft results from basketball-reference.com ────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 13:05:24 UTC
#> # A tibble: 60 × 23
#>    ranker pick_overall team  player college_name seasons     g    mp   pts   trb
#>     <dbl>        <dbl> <chr> <chr>  <chr>          <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1      1            1 ATL   Zacch… ""                 2   142  3346  1583   525
#>  2      2            2 WAS   Alex … ""                 2   115  3119  1652   790
#>  3      3            3 HOU   Reed … "Kentucky"         2   134  2801  1339   316
#>  4      4            4 SAS   Steph… "UConn"            2   149  4200  2323   659
#>  5      5            5 DET   Ron H… ""                 2   159  2817  1162   533
#>  6      6            6 CHO   Tidja… ""                 2    97  1819   575   429
#>  7      7            7 POR   Donov… "UConn"            2   144  3418  1370  1419
#>  8      8            8 SAS   Rob D… "Kentucky"         2   114  1486   628   181
#>  9      9            9 MEM   Zach … "Purdue"           2    77  1700   760   670
#> 10     10           10 UTA   Cody … "Colorado"         2   117  2691   818   311
#> # ℹ 50 more rows
#> # ℹ 13 more variables: ast <dbl>, fg_pct <dbl>, fg3_pct <dbl>, ft_pct <dbl>,
#> #   mp_per_g <dbl>, pts_per_g <dbl>, trb_per_g <dbl>, ast_per_g <dbl>,
#> #   ws <dbl>, ws_per_48 <dbl>, bpm <dbl>, vorp <dbl>, season <int>
# }
```
