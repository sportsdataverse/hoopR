# **Get Fox Sports Basketball Team Stat Leaders**

**Get Fox Sports Basketball Team Stat Leaders**

**Get Fox Sports Basketball Team Stat Leaders**

## Usage

``` r
fox_nba_team_stats(team_id)

fox_mbb_team_stats(team_id)
```

## Arguments

- team_id:

  Fox Bifrost team id.

## Value

A `hoopR_data` tibble: `team_id`, `category`, `stat`,
`stat_abbreviation`, `player`, `value`.

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
[`fox_basketball_standings`](https://hoopR.sportsdataverse.org/reference/fox_basketball_standings.md),
[`fox_basketball_team_gamelog`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_gamelog.md),
[`fox_basketball_team_roster`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_roster.md),
[`fox_basketball_teams`](https://hoopR.sportsdataverse.org/reference/fox_basketball_teams.md),
[`fox_mbb_teams_all()`](https://hoopR.sportsdataverse.org/reference/fox_mbb_teams_all.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(fox_nba_team_stats("1"))
#> ── Fox Sports NBA team_stats ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:54:15 UTC
#> # A tibble: 16 × 6
#>    team_id category     stat       stat_abbreviation player        value
#>    <chr>   <chr>        <chr>      <chr>             <chr>         <chr>
#>  1 1       PLAYER STATS SCORING    PPG               Jayson Tatum  27.1 
#>  2 1       PLAYER STATS REBOUNDING RPG               Neemias Queta 6.2  
#>  3 1       PLAYER STATS SHOOTING   FG%               Paul George   46.5 
#>  4 1       PLAYER STATS ASSISTS    APG               Jayson Tatum  7.8  
#>  5 1       PLAYER STATS DEFENSE    STL               Paul George   21   
#>  6 1       PLAYER STATS DEFENSE    BLK               Neemias Queta 13   
#>  7 1       PLAYER STATS MISC       DBL DBL           Jayson Tatum  1    
#>  8 1       PLAYER STATS ADVANCED   MPG               Jayson Tatum  33.8 
#>  9 1       TEAM STATS   SCORING    PPG               NA            115.0
#> 10 1       TEAM STATS   REBOUNDING RPG               NA            45.0 
#> 11 1       TEAM STATS   SHOOTING   FG%               NA            45.4 
#> 12 1       TEAM STATS   ASSISTS    APG               NA            27.2 
#> 13 1       TEAM STATS   DEFENSE    STL               NA            85   
#> 14 1       TEAM STATS   DEFENSE    BLK               NA            45   
#> 15 1       TEAM STATS   MISC       DBL DBL           NA            1    
#> 16 1       TEAM STATS   ADVANCED   NET RTG           NA            -    
# }
```
