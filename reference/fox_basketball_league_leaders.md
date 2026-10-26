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
#> ℹ Data updated: 2026-10-26 19:16:04 UTC
#> # A tibble: 75 × 6
#>    players v2               gp    entity_id min   mpg  
#>    <chr>   <chr>            <chr> <chr>     <chr> <chr>
#>  1 1       K. Caldwell-Pope 4     1838      NA    NA   
#>  2 2       J. Brown         4     2206      NA    NA   
#>  3 3       A. Simons        4     2516      NA    NA   
#>  4 4       T. Maxey         4     3422      NA    NA   
#>  5 5       A. Bona          4     4018      NA    NA   
#>  6 6       L. James         3     1120      NA    NA   
#>  7 7       K. Durant        3     1467      NA    NA   
#>  8 8       B. Lopez         3     1512      NA    NA   
#>  9 9       K. Thompson      3     1680      NA    NA   
#> 10 10      N. Vucevic       3     1718      NA    NA   
#> # ℹ 65 more rows
# }
```
