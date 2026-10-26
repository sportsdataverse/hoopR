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
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md),
[`bref_teams_stats()`](https://hoopR.sportsdataverse.org/reference/bref_teams_stats.md)

## Examples

``` r
# \donttest{
  try(bref_draft(season = 2024))
#> ── Draft results from basketball-reference.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-26 19:12:56 UTC
#> # A tibble: 60 × 23
#>    ranker pick_overall team  player college_name seasons     g    mp   pts   trb
#>     <dbl>        <dbl> <chr> <chr>  <chr>          <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1      1            1 ATL   Zacch… ""                 3   145  3437  1609   541
#>  2      2            2 WAS   Alex … ""                 3   118  3191  1675   805
#>  3      3            3 HOU   Reed … "Kentucky"         3   136  2847  1361   324
#>  4      4            4 SAS   Steph… "UConn"            3   152  4290  2381   677
#>  5      5            5 DET   Ron H… ""                 3   162  2865  1172   548
#>  6      6            6 CHO   Tidja… ""                 3    99  1852   589   437
#>  7      7            7 POR   Donov… "UConn"            3   146  3459  1389  1436
#>  8      8            8 SAS   Rob D… "Kentucky"         2   114  1486   628   181
#>  9      9            9 MEM   Zach … "Purdue"           3    79  1744   774   689
#> 10     10           10 UTA   Cody … "Colorado"         3   120  2702   818   311
#> # ℹ 50 more rows
#> # ℹ 13 more variables: ast <dbl>, fg_pct <dbl>, fg3_pct <dbl>, ft_pct <dbl>,
#> #   mp_per_g <dbl>, pts_per_g <dbl>, trb_per_g <dbl>, ast_per_g <dbl>,
#> #   ws <dbl>, ws_per_48 <dbl>, bpm <dbl>, vorp <dbl>, season <int>
# }
```
