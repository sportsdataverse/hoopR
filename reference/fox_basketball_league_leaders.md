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
#> ℹ Data updated: 2026-11-06 07:20:51 UTC
#> # A tibble: 75 × 6
#>    players v2               gp    entity_id min   mpg  
#>    <chr>   <chr>            <chr> <chr>     <chr> <chr>
#>  1 1       K. Durant        9     1467      NA    NA   
#>  2 2       K. Thompson      9     1680      NA    NA   
#>  3 3       D. Schröder      9     1821      NA    NA   
#>  4 4       K. Caldwell-Pope 9     1838      NA    NA   
#>  5 5       G. Antetokounmpo 9     1851      NA    NA   
#>  6 6       T. Hardaway Jr.  9     1859      NA    NA   
#>  7 7       C. McCollum      9     1881      NA    NA   
#>  8 8       A. Wiggins       9     1903      NA    NA   
#>  9 9       B. Bogdanovic    9     1928      NA    NA   
#> 10 10      T. Lyles         9     2061      NA    NA   
#> # ℹ 65 more rows
# }
```
