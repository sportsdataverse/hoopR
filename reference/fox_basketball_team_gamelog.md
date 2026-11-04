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
#> ℹ Data updated: 2026-11-04 10:14:31 UTC
#> # A tibble: 165 × 8
#>    team_id season_type    category game_id game_date opponent stat         value
#>    <chr>   <chr>          <chr>    <chr>   <chr>     <chr>    <chr>        <chr>
#>  1 1       REGULAR SEASON scoring  106633  11/2      @HOU     fgm          32   
#>  2 1       REGULAR SEASON scoring  106633  11/2      @HOU     fga          83   
#>  3 1       REGULAR SEASON scoring  106633  11/2      @HOU     fg_percent   38.6 
#>  4 1       REGULAR SEASON scoring  106633  11/2      @HOU     ftm          17   
#>  5 1       REGULAR SEASON scoring  106633  11/2      @HOU     fta          20   
#>  6 1       REGULAR SEASON scoring  106633  11/2      @HOU     ft_percent   85.0 
#>  7 1       REGULAR SEASON scoring  106633  11/2      @HOU     x3fgm        12   
#>  8 1       REGULAR SEASON scoring  106633  11/2      @HOU     x3fga        42   
#>  9 1       REGULAR SEASON scoring  106633  11/2      @HOU     x3fg_percent 28.6 
#> 10 1       REGULAR SEASON scoring  106633  11/2      @HOU     pts          93   
#> # ℹ 155 more rows
# }
```
