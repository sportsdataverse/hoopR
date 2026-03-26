# **Get ESPN NBA's Standings**

**Get ESPN NBA's Standings**

## Usage

``` r
espn_nba_standings(year)
```

## Arguments

- year:

  Either numeric or character (YYYY)

## Value

A standings data frame

|                    |           |
|--------------------|-----------|
| col_name           | types     |
| team_id            | integer   |
| team               | character |
| avgpointsagainst   | numeric   |
| avgpointsfor       | numeric   |
| clincher           | numeric   |
| differential       | numeric   |
| divisionwinpercent | numeric   |
| gamesbehind        | numeric   |
| leaguewinpercent   | numeric   |
| losses             | numeric   |
| playoffseed        | numeric   |
| streak             | numeric   |
| winpercent         | numeric   |
| wins               | numeric   |
| leaguestandings    | character |
| home               | character |
| road               | character |
| vsdiv              | character |
| vsconf             | character |
| lasttengames       | character |

## See also

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Examples

``` r
# \donttest{
try(espn_nba_standings(year = 2021))
#> ── ESPN NBA Standings Information from ESPN.com ───────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-26 14:51:11 UTC
#> # A tibble: 30 × 25
#>    team_id team              avgpointsagainst avgpointsfor clincher differential
#>  *   <int> <chr>                        <dbl>        <dbl>    <dbl>        <dbl>
#>  1      26 Utah Jazz                     107.         116.        5         9.2 
#>  2      21 Phoenix Suns                  109.         115.        2         5.8 
#>  3      20 Philadelphia 76e…             108.         114.        3         5.5 
#>  4      17 Brooklyn Nets                 114.         119.        1         4.5 
#>  5       7 Denver Nuggets                110.         115.        1         5   
#>  6      12 LA Clippers                   108.         114.        1         6.2 
#>  7      15 Milwaukee Bucks               114.         120.        2         5.90
#>  8       6 Dallas Mavericks              110.         112.        2         2.2 
#>  9      13 Los Angeles Lake…             107.         110.        7         2.7 
#> 10      22 Portland Trail B…             114.         116.        1         1.8 
#> # ℹ 20 more rows
#> # ℹ 19 more variables: divisionwinpercent <dbl>, gamesbehind <dbl>,
#> #   leaguewinpercent <dbl>, losses <dbl>, playoffseed <dbl>,
#> #   pointdifferential <chr>, points <chr>, pointsagainst <chr>,
#> #   pointsfor <chr>, streak <dbl>, winpercent <dbl>, wins <dbl>,
#> #   gamesahead <chr>, leaguestandings <chr>, home <chr>, road <chr>,
#> #   vsdiv <chr>, vsconf <chr>, lasttengames <chr>
# }
```
