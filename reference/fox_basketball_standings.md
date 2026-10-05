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
#> ── Fox Sports NBA standings ──────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-05 18:41:45 UTC
#> # A tibble: 30 × 11
#>    team_id section   eastern_conference v2      w_l   pct   pf    pa    strk 
#>    <chr>   <chr>     <chr>              <chr>   <chr> <chr> <chr> <chr> <chr>
#>  1 1       PRESEASON 1                  Heat    1-0   1.000 129.0 105.0 W1   
#>  2 1       PRESEASON 2                  Wizards 0-0   -     0.0   0.0   -    
#>  3 1       PRESEASON 3                  Hornets 0-0   -     0.0   0.0   -    
#>  4 1       PRESEASON 4                  Hawks   0-0   -     0.0   0.0   -    
#>  5 1       PRESEASON 5                  Magic   0-0   -     0.0   0.0   -    
#>  6 1       PRESEASON 6                  Knicks  0-0   -     0.0   0.0   -    
#>  7 1       PRESEASON 7                  76ers   0-0   -     0.0   0.0   -    
#>  8 1       PRESEASON 8                  Nets    0-0   -     0.0   0.0   -    
#>  9 1       PRESEASON 9                  Celtics 0-0   -     0.0   0.0   -    
#> 10 1       PRESEASON 10                 Bulls   0-0   -     0.0   0.0   -    
#> # ℹ 20 more rows
#> # ℹ 2 more variables: entity_id <chr>, western_conference <chr>
# }
```
