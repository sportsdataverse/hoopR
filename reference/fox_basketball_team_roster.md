# **Get Fox Sports Basketball Team Roster**

**Get Fox Sports Basketball Team Roster**

**Get Fox Sports Basketball Team Roster**

## Usage

``` r
fox_nba_team_roster(team_id)

fox_mbb_team_roster(team_id)
```

## Arguments

- team_id:

  Fox Bifrost team id (e.g. `"1"`). Discover via the league team
  directory.

## Value

A `hoopR_data` tibble, one row per player: `team_id`, `position_group`,
`player`, position/age/etc. columns, `athlete_id`.

## See also

Other Fox Basketball Functions:
[`fox_basketball_boxscore`](https://hoopR.sportsdataverse.org/reference/fox_basketball_boxscore.md),
[`fox_basketball_league_leaders`](https://hoopR.sportsdataverse.org/reference/fox_basketball_league_leaders.md),
[`fox_basketball_odds`](https://hoopR.sportsdataverse.org/reference/fox_basketball_odds.md),
[`fox_basketball_pbp`](https://hoopR.sportsdataverse.org/reference/fox_basketball_pbp.md),
[`fox_basketball_standings`](https://hoopR.sportsdataverse.org/reference/fox_basketball_standings.md),
[`fox_basketball_team_gamelog`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_gamelog.md),
[`fox_basketball_team_stats`](https://hoopR.sportsdataverse.org/reference/fox_basketball_team_stats.md),
[`fox_basketball_teams`](https://hoopR.sportsdataverse.org/reference/fox_basketball_teams.md),
[`fox_mbb_teams_all()`](https://hoopR.sportsdataverse.org/reference/fox_mbb_teams_all.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(fox_nba_team_roster("1"))
#> ── Fox Sports NBA roster ──────────────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-08-26 19:09:19 UTC
#> # A tibble: 16 × 9
#>    team_id position_group player       pos   age   ht    wt    school athlete_id
#>    <chr>   <chr>          <chr>        <chr> <chr> <chr> <chr> <chr>  <chr>     
#>  1 1       GUARD          Mike Conley  PG    38    "6'1… 175 … Ohio … 1441      
#>  2 1       GUARD          Hugo Gonzál… SG    20    "6'6… 200 … -      4141      
#>  3 1       GUARD          Payton Prit… PG    28    "6'1… 195 … Oregon 3414      
#>  4 1       GUARD          Baylor Sche… SG    25    "6'6… 205 … Creig… 3981      
#>  5 1       GUARD          Derrick Whi… SG    32    "6'4… 190 … Color… 2373      
#>  6 1       FORWARD        Chris Cenac… PF    19    "6'1… 240 … Houst… 6319      
#>  7 1       FORWARD        Paul George  PF    36    "6'8… 230 … Fresn… 1611      
#>  8 1       FORWARD        Ron Harper … SF    26    "6'5… 233 … Rutge… 3690      
#>  9 1       FORWARD        Sam Hauser   PF    28    "6'7… 217 … Virgi… 3603      
#> 10 1       FORWARD        Dillon Mitc… SF    22    "6'8… 210 … St. J… 6349      
#> 11 1       FORWARD        Jayson Tatum PF    28    "6'8… 210 … Duke   2343      
#> 12 1       FORWARD        Jordan Walsh PF    22    "6'6… 205 … Arkan… 3863      
#> 13 1       FORWARD        Amari Willi… PF    24    "6'1… 250 … Kentu… 4171      
#> 14 1       CENTER         Luka Garza   C     27    "6'1… 243 … Iowa   3557      
#> 15 1       CENTER         Neemias Que… C     27    "7'0… 248 … Utah … 3574      
#> 16 1       CENTER         Mitchell Ro… C     28    "7'0… 240 … Chalm… 2529      
# }
```
