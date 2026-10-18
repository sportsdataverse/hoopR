# **Get Fox Sports Basketball Standings**

**Get Fox Sports Basketball Standings**

**Get Fox Sports Basketball Standings**

## Usage

``` r
fox_nba_standings(team_id)

fox_mbb_standings(team_id)
```

## Arguments

- team_id:

  Fox Bifrost team id (standings of that team's conference/division).

## Value

A `hoopR_data` tibble of standings rows (`team_id`, `section`, the
standings columns, `entity_id`).

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
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
  try(fox_nba_standings("1"))
#> ── Fox Sports NBA standings ───────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-18 20:30:34 UTC
#> # A tibble: 30 × 11
#>    team_id section   eastern_conference v2      w_l   pct   pf    pa    strk 
#>    <chr>   <chr>     <chr>              <chr>   <chr> <chr> <chr> <chr> <chr>
#>  1 1       PRESEASON 1                  Celtics 4-0   1.000 126.8 108.0 W4   
#>  2 1       PRESEASON 2                  Hawks   4-1   .800  122.6 117.2 W4   
#>  3 1       PRESEASON 3                  Pistons 3-1   .750  118.5 113.0 W2   
#>  4 1       PRESEASON 4                  Nets    3-1   .750  124.2 116.0 L1   
#>  5 1       PRESEASON 5                  Magic   3-1   .750  123.8 117.0 W2   
#>  6 1       PRESEASON 6                  Bulls   3-2   .600  122.0 114.8 W2   
#>  7 1       PRESEASON 7                  Heat    3-2   .600  128.0 122.4 L1   
#>  8 1       PRESEASON 8                  Wizards 2-2   .500  113.2 113.8 L2   
#>  9 1       PRESEASON 9                  Bucks   2-3   .400  109.4 119.8 W1   
#> 10 1       PRESEASON 10                 Raptors 2-3   .400  122.4 116.8 L2   
#> # ℹ 20 more rows
#> # ℹ 2 more variables: entity_id <chr>, western_conference <chr>
# }
```
