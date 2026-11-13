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
#> ℹ Data updated: 2026-11-13 12:51:28 UTC
#> # A tibble: 75 × 6
#>    players v2                gp    entity_id min   mpg  
#>    <chr>   <chr>             <chr> <chr>     <chr> <chr>
#>  1 1       K. Caldwell-Pope  13    1838      NA    NA   
#>  2 2       T. Young          13    2490      NA    NA   
#>  3 3       D. Ayton          13    2492      NA    NA   
#>  4 4       A. Simons         13    2516      NA    NA   
#>  5 5       M. Thybulle       13    3262      NA    NA   
#>  6 6       T. Maxey          13    3422      NA    NA   
#>  7 7       S. Mamukelashvili 13    3562      NA    NA   
#>  8 8       W. Kessler        13    3722      NA    NA   
#>  9 9       K. George         13    3985      NA    NA   
#> 10 10      B. Carrington     13    3986      NA    NA   
#> # ℹ 65 more rows
# }
```
