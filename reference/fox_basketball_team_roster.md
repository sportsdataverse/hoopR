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
#> ── Fox Sports NBA roster ─────────────────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-05 18:41:46 UTC
#> # A tibble: 21 × 9
#>    team_id position_group player       pos   age   ht    wt    school athlete_id
#>    <chr>   <chr>          <chr>        <chr> <chr> <chr> <chr> <chr>  <chr>     
#>  1 1       GUARD          Devin Carter PG    24    "6'2… 195 … Provi… 3999      
#>  2 1       GUARD          Mike Conley  PG    38    "6'1… 175 … Ohio … 1441      
#>  3 1       GUARD          Hugo Gonzál… SG    20    "6'6… 200 … -      4141      
#>  4 1       GUARD          Hayden Gray  SG    23    "6'4… 190 … UC Sa… 6318      
#>  5 1       GUARD          Payton Prit… PG    28    "6'1… 195 … Oregon 3414      
#>  6 1       GUARD          Baylor Sche… SG    26    "6'6… 205 … Creig… 3981      
#>  7 1       GUARD          Milos Uzan   G     23    "6'3… 175 … Houst… 6436      
#>  8 1       GUARD          Derrick Whi… SG    32    "6'4… 190 … Color… 2373      
#>  9 1       FORWARD        Chris Cenac… PF    19    "6'1… 240 … Houst… 6319      
#> 10 1       FORWARD        Tucker DeVr… F     23    "6'7… 210 … India… 6437      
#> # ℹ 11 more rows
# }
```
