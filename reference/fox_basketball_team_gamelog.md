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
[`fox_basketball_team_stats`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_stats.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(fox_nba_team_gamelog("1"))
#> ── Fox Sports NBA gamelog ─────────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 03:15:53 UTC
#> # A tibble: 165 × 8
#>    team_id season_type category game_id game_date opponent stat         value
#>    <chr>   <chr>       <chr>    <chr>   <chr>     <chr>    <chr>        <chr>
#>  1 1       POSTSEASON  scoring  106426  5/2       PHI      fgm          37   
#>  2 1       POSTSEASON  scoring  106426  5/2       PHI      fga          93   
#>  3 1       POSTSEASON  scoring  106426  5/2       PHI      fg_percent   39.8 
#>  4 1       POSTSEASON  scoring  106426  5/2       PHI      ftm          13   
#>  5 1       POSTSEASON  scoring  106426  5/2       PHI      fta          16   
#>  6 1       POSTSEASON  scoring  106426  5/2       PHI      ft_percent   81.3 
#>  7 1       POSTSEASON  scoring  106426  5/2       PHI      x3fgm        13   
#>  8 1       POSTSEASON  scoring  106426  5/2       PHI      x3fga        49   
#>  9 1       POSTSEASON  scoring  106426  5/2       PHI      x3fg_percent 26.5 
#> 10 1       POSTSEASON  scoring  106426  5/2       PHI      pts          100  
#> # ℹ 155 more rows
# }
```
