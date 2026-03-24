# **Get ESPN men's college basketball standings**

**Get ESPN men's college basketball standings**

## Usage

``` r
espn_mbb_standings(year = most_recent_mbb_season())
```

## Arguments

- year:

  Either numeric or character (YYYY)

## Value

A standings data frame

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| team_id                           | integer   |
| team                              | character |
| avgpointsagainst                  | numeric   |
| avgpointsfor                      | numeric   |
| gamesbehind                       | numeric   |
| leaguewinpercent                  | numeric   |
| losses                            | numeric   |
| playoffseed                       | numeric   |
| pointsagainst                     | numeric   |
| pointsfor                         | numeric   |
| streak                            | numeric   |
| winpercent                        | numeric   |
| wins                              | numeric   |
| total                             | character |
| home_avgpointsagainst             | numeric   |
| home_avgpointsfor                 | numeric   |
| home_gamesbehind                  | numeric   |
| home_leaguewinpercent             | numeric   |
| home_losses                       | numeric   |
| home_playoffseed                  | numeric   |
| home_pointsagainst                | numeric   |
| home_pointsfor                    | numeric   |
| home_streak                       | numeric   |
| home_winpercent                   | numeric   |
| home_wins                         | numeric   |
| home                              | character |
| road_avgpointsagainst             | numeric   |
| road_avgpointsfor                 | numeric   |
| road_gamesbehind                  | numeric   |
| road_leaguewinpercent             | numeric   |
| road_losses                       | numeric   |
| road_playoffseed                  | numeric   |
| road_pointsagainst                | numeric   |
| road_pointsfor                    | numeric   |
| road_streak                       | numeric   |
| road_winpercent                   | numeric   |
| road_wins                         | numeric   |
| road                              | character |
| vsaprankedteams_avgpointsagainst  | numeric   |
| vsaprankedteams_avgpointsfor      | numeric   |
| vsaprankedteams_gamesbehind       | numeric   |
| vsaprankedteams_leaguewinpercent  | numeric   |
| vsaprankedteams_losses            | numeric   |
| vsaprankedteams_playoffseed       | numeric   |
| vsaprankedteams_pointsagainst     | numeric   |
| vsaprankedteams_pointsfor         | numeric   |
| vsaprankedteams_streak            | numeric   |
| vsaprankedteams_winpercent        | numeric   |
| vsaprankedteams_wins              | numeric   |
| vsaprankedteams                   | character |
| vsusarankedteams_avgpointsagainst | numeric   |
| vsusarankedteams_avgpointsfor     | numeric   |
| vsusarankedteams_gamesbehind      | numeric   |
| vsusarankedteams_leaguewinpercent | numeric   |
| vsusarankedteams_losses           | numeric   |
| vsusarankedteams_playoffseed      | numeric   |
| vsusarankedteams_pointsagainst    | numeric   |
| vsusarankedteams_pointsfor        | numeric   |
| vsusarankedteams_streak           | numeric   |
| vsusarankedteams_winpercent       | numeric   |
| vsusarankedteams_wins             | numeric   |
| vsusarankedteams                  | character |
| vsconf_avgpointsagainst           | numeric   |
| vsconf_avgpointsfor               | numeric   |
| vsconf_gamesbehind                | numeric   |
| vsconf_leaguewinpercent           | numeric   |
| vsconf_losses                     | numeric   |
| vsconf_playoffseed                | numeric   |
| vsconf_pointsagainst              | numeric   |
| vsconf_pointsfor                  | numeric   |
| vsconf_streak                     | numeric   |
| vsconf_winpercent                 | numeric   |
| vsconf_wins                       | numeric   |
| vsconf                            | character |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Examples

``` r
# \donttest{
try(espn_mbb_standings(2021))
#> ── ESPN MBB Standings Information from ESPN.com ───────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-24 04:17:47 UTC
#> # A tibble: 348 × 86
#>    team_id team       avgpointsagainst avgpointsfor gamesbehind leaguewinpercent
#>  *   <int> <chr>                 <dbl>        <dbl>       <dbl>            <dbl>
#>  1    2250 Gonzaga B…             69.7         91.0         0              1    
#>  2     239 Baylor Be…             65.5         82.9         0              0.929
#>  3    2737 Winthrop …             67.0         78.9         0              0.944
#>  4     248 Houston C…             58.2         76.1         1              0.824
#>  5    2142 Colgate R…             69.6         85.2         0              0.917
#>  6    2057 Belmont B…             69.1         81.3        -0.5            0.9  
#>  7    2350 Loyola Ch…             56.1         71.0        -5              0.889
#>  8    2181 Drake Bul…             64.5         75.9         0              0.833
#>  9     253 Southern …             69.5         84.2        -3              0.857
#> 10    2426 Navy Mids…             67           71.5         0              0.923
#> # ℹ 338 more rows
#> # ℹ 80 more variables: losses <dbl>, playoffseed <dbl>,
#> #   pointdifferential <chr>, pointsagainst <dbl>, pointsfor <dbl>,
#> #   streak <dbl>, winpercent <dbl>, wins <dbl>, gamesahead <chr>, total <chr>,
#> #   home_avgpointsagainst <dbl>, home_avgpointsfor <dbl>,
#> #   home_gamesbehind <dbl>, home_leaguewinpercent <dbl>, home_losses <dbl>,
#> #   home_playoffseed <dbl>, home_pointdifferential <chr>, …
# }
```
