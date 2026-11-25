# **Get Fox Sports Basketball Team Game Log**

**Get Fox Sports Basketball Team Game Log**

**Get Fox Sports Basketball Team Game Log**

## Usage

``` r
fox_nba_team_gamelog(team_id)

fox_mbb_team_gamelog(team_id)
```

## Arguments

- team_id:

  Fox Bifrost team id.

## Value

A `hoopR_data` tibble (long): `team_id`, `season_type`, `category`,
`game_id`, `game_date`, `opponent`, `stat`, `value`.

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
[`fox_basketball_standings`](https://hoopR.sportsdataverse.org/reference/fox_basketball_standings.md),
[`fox_basketball_team_roster`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_roster.md),
[`fox_basketball_team_stats`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_stats.md),
[`fox_basketball_teams`](https://hoopR.sportsdataverse.org/reference/fox_basketball_teams.md),
[`fox_mbb_teams_all()`](https://hoopR.sportsdataverse.org/reference/fox_mbb_teams_all.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(fox_nba_team_gamelog("1"))
#> ── Fox Sports NBA gamelog ─────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-25 06:56:39 UTC
#> # A tibble: 165 × 8
#>    team_id season_type    category game_id game_date opponent stat         value
#>    <chr>   <chr>          <chr>    <chr>   <chr>     <chr>    <chr>        <chr>
#>  1 1       REGULAR SEASON scoring  106791  11/24     @WAS     fgm          46   
#>  2 1       REGULAR SEASON scoring  106791  11/24     @WAS     fga          100  
#>  3 1       REGULAR SEASON scoring  106791  11/24     @WAS     fg_percent   46.0 
#>  4 1       REGULAR SEASON scoring  106791  11/24     @WAS     ftm          17   
#>  5 1       REGULAR SEASON scoring  106791  11/24     @WAS     fta          25   
#>  6 1       REGULAR SEASON scoring  106791  11/24     @WAS     ft_percent   68.0 
#>  7 1       REGULAR SEASON scoring  106791  11/24     @WAS     x3fgm        22   
#>  8 1       REGULAR SEASON scoring  106791  11/24     @WAS     x3fga        51   
#>  9 1       REGULAR SEASON scoring  106791  11/24     @WAS     x3fg_percent 43.1 
#> 10 1       REGULAR SEASON scoring  106791  11/24     @WAS     pts          131  
#> # ℹ 155 more rows
# }
```
