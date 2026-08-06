# **Basketball-Reference Team Season Stats**

**Get team season statistics from
[Basketball-Reference](https://www.basketball-reference.com).**

Scrapes a team stat table from the league season page. No API key is
required. Basketball-Reference rate-limits aggressive scraping (~20
requests/minute) – space repeated calls with
[`Sys.sleep()`](https://rdrr.io/r/base/Sys.sleep.html).

## Usage

``` r
bref_teams_stats(season = most_recent_nba_season(), table = "per_game")
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

- table:

  (*character* optional): Which team table to return. One of `per_game`
  (default, team per-game), `totals`, `per_poss` (per 100 poss),
  `advanced`, or `opponent` (opponent per-game).

## Value

A `hoopR_data` tibble with one row per team (columns vary by `table`;
common identifying columns shown – names are Basketball-Reference
`data-stat` keys):

|          |           |                                        |
|----------|-----------|----------------------------------------|
| col_name | types     | description                            |
| ranker   | integer   | Row rank.                              |
| team     | character | Team name.                             |
| g        | integer   | Games played.                          |
| mp       | numeric   | Minutes played.                        |
| pts      | numeric   | Points (scaled to the chosen `table`). |
| season   | integer   | Season (echoes the `season` argument). |

## See also

Other Basketball-Reference Functions:
[`bref_awards()`](https://hoopR.sportsdataverse.org/reference/bref_awards.md),
[`bref_draft()`](https://hoopR.sportsdataverse.org/reference/bref_draft.md),
[`bref_injuries()`](https://hoopR.sportsdataverse.org/reference/bref_injuries.md),
[`bref_player_bios()`](https://hoopR.sportsdataverse.org/reference/bref_player_bios.md),
[`bref_player_game_log()`](https://hoopR.sportsdataverse.org/reference/bref_player_game_log.md),
[`bref_players_stats()`](https://hoopR.sportsdataverse.org/reference/bref_players_stats.md),
[`bref_standings()`](https://hoopR.sportsdataverse.org/reference/bref_standings.md),
[`bref_team_roster()`](https://hoopR.sportsdataverse.org/reference/bref_team_roster.md)

## Examples

``` r
# \donttest{
  try(bref_teams_stats(season = 2024, table = "per_game"))
#> ── Team season stats from basketball-reference.com ────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-06 03:58:48 UTC
#> # A tibble: 30 × 26
#>    ranker team        g    mp    fg   fga fg_pct   fg3  fg3a fg3_pct   fg2  fg2a
#>     <dbl> <chr>   <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>   <dbl> <dbl> <dbl>
#>  1      1 Indian…    82  240.  47    92.7  0.507  13.2  35.3   0.374  33.8  57.4
#>  2      2 Boston…    82  242.  43.9  90.2  0.487  16.5  42.5   0.388  27.4  47.7
#>  3      3 Oklaho…    82  242.  44.5  89.3  0.499  13.3  34.2   0.389  31.3  55.1
#>  4      4 Milwau…    82  242.  43.1  88.5  0.487  14.2  38.1   0.373  29    50.4
#>  5      5 Atlant…    82  242.  43    92.5  0.465  13.7  37.7   0.364  29.3  54.8
#>  6      6 Los An…    82  242.  43.7  87.5  0.499  11.8  31.4   0.377  31.8  56.2
#>  7      7 Dallas…    82  240.  43.1  89.7  0.481  14.6  39.5   0.369  28.5  50.1
#>  8      8 Golden…    82  242.  43.7  91.6  0.477  14.8  38.9   0.38   28.9  52.7
#>  9      9 Sacram…    82  242.  43.3  90.9  0.477  14.4  39.3   0.366  29    51.7
#> 10     10 Phoeni…    82  241.  42.5  86.1  0.493  12.4  32.6   0.382  30    53.6
#> # ℹ 20 more rows
#> # ℹ 14 more variables: fg2_pct <dbl>, ft <dbl>, fta <dbl>, ft_pct <dbl>,
#> #   orb <dbl>, drb <dbl>, trb <dbl>, ast <dbl>, stl <dbl>, blk <dbl>,
#> #   tov <dbl>, pf <dbl>, pts <dbl>, season <int>
# }
```
