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
#> ── Fox Sports NBA league_leaders ──────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-25 01:42:12 UTC
#> # A tibble: 75 × 6
#>    players v2            gp    entity_id min   mpg  
#>    <chr>   <chr>         <chr> <chr>     <chr> <chr>
#>  1 1       K. Dunn       82    2211      NA    NA   
#>  2 2       M. Bridges    82    2498      NA    NA   
#>  3 3       D. DiVincenzo 82    2503      NA    NA   
#>  4 4       B. Brown      82    2526      NA    NA   
#>  5 5       K. Johnson    82    3282      NA    NA   
#>  6 6       J. Green      82    3328      NA    NA   
#>  7 7       D. Bane       82    3415      NA    NA   
#>  8 8       J. Huff       82    3613      NA    NA   
#>  9 9       J. LaRavia    82    3733      NA    NA   
#> 10 10      J. Champagnie 82    3767      NA    NA   
#> # ℹ 65 more rows
# }
```
