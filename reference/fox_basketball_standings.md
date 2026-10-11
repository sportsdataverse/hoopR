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
#> ℹ Data updated: 2026-10-11 15:01:28 UTC
#> # A tibble: 30 × 11
#>    team_id section   eastern_conference v2      w_l   pct   pf    pa    strk 
#>    <chr>   <chr>     <chr>              <chr>   <chr> <chr> <chr> <chr> <chr>
#>  1 1       PRESEASON 1                  Celtics 2-0   1.000 134.0 109.5 W2   
#>  2 1       PRESEASON 2                  Wizards 2-0   1.000 112.5 108.5 W2   
#>  3 1       PRESEASON 3                  Nets    2-0   1.000 119.0 99.0  W2   
#>  4 1       PRESEASON 4                  Magic   1-0   1.000 122.0 118.0 W1   
#>  5 1       PRESEASON 5                  Heat    2-1   .667  127.0 116.0 L1   
#>  6 1       PRESEASON 6                  Hawks   2-1   .667  121.7 121.7 W2   
#>  7 1       PRESEASON 7                  Pacers  1-1   .500  120.0 115.5 L1   
#>  8 1       PRESEASON 8                  Bulls   1-1   .500  112.0 110.5 L1   
#>  9 1       PRESEASON 9                  Pistons 1-1   .500  108.5 110.5 L1   
#> 10 1       PRESEASON 10                 Bucks   1-1   .500  112.5 121.0 W1   
#> # ℹ 20 more rows
#> # ℹ 2 more variables: entity_id <chr>, western_conference <chr>
# }
```
