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
#> ℹ Data updated: 2026-11-09 19:54:15 UTC
#> # A tibble: 165 × 8
#>    team_id season_type    category game_id game_date opponent stat         value
#>    <chr>   <chr>          <chr>    <chr>   <chr>     <chr>    <chr>        <chr>
#>  1 1       REGULAR SEASON scoring  106675  11/8      @MIL     fgm          45   
#>  2 1       REGULAR SEASON scoring  106675  11/8      @MIL     fga          95   
#>  3 1       REGULAR SEASON scoring  106675  11/8      @MIL     fg_percent   47.4 
#>  4 1       REGULAR SEASON scoring  106675  11/8      @MIL     ftm          9    
#>  5 1       REGULAR SEASON scoring  106675  11/8      @MIL     fta          14   
#>  6 1       REGULAR SEASON scoring  106675  11/8      @MIL     ft_percent   64.3 
#>  7 1       REGULAR SEASON scoring  106675  11/8      @MIL     x3fgm        18   
#>  8 1       REGULAR SEASON scoring  106675  11/8      @MIL     x3fga        48   
#>  9 1       REGULAR SEASON scoring  106675  11/8      @MIL     x3fg_percent 37.5 
#> 10 1       REGULAR SEASON scoring  106675  11/8      @MIL     pts          117  
#> # ℹ 155 more rows
# }
```
