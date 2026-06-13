# **Get Fox Sports Basketball Boxscore**

**Get Fox Sports Basketball Boxscore**

**Get Fox Sports Basketball Boxscore**

## Usage

``` r
fox_nba_boxscore(game_id)

fox_mbb_boxscore(game_id)
```

## Arguments

- game_id:

  Fox Bifrost event id.

## Value

A `hoopR_data` tibble (long), one row per (player, stat): `game_id`,
`team`, `stat_group`, `player`, `athlete_id`, `stat`, `value`.

## See also

Other Fox Basketball Functions:
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
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
  try(fox_nba_boxscore("106422"))
#> ── Fox Sports NBA boxscore ────────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-13 04:20:28 UTC
#> # A tibble: 326 × 7
#>    game_id team    stat_group player   athlete_id stat  value
#>    <chr>   <chr>   <chr>      <chr>    <chr>      <chr> <chr>
#>  1 106422  CELTICS STARTERS   J. Tatum 2343       min   42   
#>  2 106422  CELTICS STARTERS   J. Tatum 2343       off   0    
#>  3 106422  CELTICS STARTERS   J. Tatum 2343       def   5    
#>  4 106422  CELTICS STARTERS   J. Tatum 2343       reb   5    
#>  5 106422  CELTICS STARTERS   J. Tatum 2343       ast   7    
#>  6 106422  CELTICS STARTERS   J. Tatum 2343       stl   1    
#>  7 106422  CELTICS STARTERS   J. Tatum 2343       blk   0    
#>  8 106422  CELTICS STARTERS   J. Tatum 2343       to    1    
#>  9 106422  CELTICS STARTERS   J. Tatum 2343       pf    1    
#> 10 106422  CELTICS STARTERS   J. Tatum 2343       pts   25   
#> # ℹ 316 more rows
# }
```
