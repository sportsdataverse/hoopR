# **Get Fox Sports Basketball Statistical Leaders**

**Get Fox Sports Basketball Statistical Leaders**

**Get Fox Sports Basketball Statistical Leaders**

## Usage

``` r
fox_nba_league_leaders(category = "scoring", who = "player", page = 0)

fox_mbb_league_leaders(category = "scoring", who = "player", page = 0)
```

## Arguments

- category:

  Stat category (default `"scoring"`).

- who:

  `"player"` or `"team"` (default `"player"`).

- page:

  0-based page index (default `0`).

## Value

A `hoopR_data` tibble of leaderboard rows (`entity_id` + stat columns).

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
[`fox_basketball_standings`](https://hoopR.sportsdataverse.org/reference/fox_basketball_standings.md),
[`fox_basketball_team_gamelog`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_gamelog.md),
[`fox_basketball_team_roster`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_roster.md),
[`fox_basketball_team_stats`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_stats.md),
[`fox_basketball_teams`](https://hoopR.sportsdataverse.org/reference/fox_basketball_teams.md),
[`fox_mbb_teams_all()`](https://hoopR.sportsdataverse.org/reference/fox_mbb_teams_all.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(fox_nba_league_leaders("scoring"))
#> ── Fox Sports NBA league_leaders ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:45:35 UTC
#> # A tibble: 75 × 6
#>    players v2                  gp    entity_id min   mpg  
#>    <chr>   <chr>               <chr> <chr>     <chr> <chr>
#>  1 1       K. Durant           7     1467      NA    NA   
#>  2 2       D. Schröder         7     1821      NA    NA   
#>  3 3       K. Caldwell-Pope    7     1838      NA    NA   
#>  4 4       C. McCollum         7     1881      NA    NA   
#>  5 5       B. Bogdanovic       7     1928      NA    NA   
#>  6 6       T. Lyles            7     2061      NA    NA   
#>  7 7       R. O'Neale          7     2434      NA    NA   
#>  8 8       G. Allen            7     2511      NA    NA   
#>  9 9       A. Simons           7     2516      NA    NA   
#> 10 10      N. Alexander-Walker 7     3260      NA    NA   
#> # ℹ 65 more rows
# }
```
