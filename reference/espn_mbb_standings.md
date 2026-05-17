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

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team | character | Team-side label or team identifier. |
| avgpointsagainst | numeric | Avgpointsagainst. |
| avgpointsfor | numeric | Avgpointsfor. |
| gamesbehind | numeric | Gamesbehind. |
| leaguewinpercent | numeric | Leaguewinpercent. |
| losses | numeric | Total losses. |
| playoffseed | numeric | Playoffseed. |
| pointsagainst | numeric | Pointsagainst. |
| pointsfor | numeric | Pointsfor. |
| streak | numeric | Current streak (e.g. 'W3' for three-game win streak). |
| winpercent | numeric | Winpercent. |
| wins | numeric | Total wins. |
| total | character | Total. |
| home_avgpointsagainst | numeric | Home team's avgpointsagainst. |
| home_avgpointsfor | numeric | Home team's avgpointsfor. |
| home_gamesbehind | numeric | Home team's gamesbehind. |
| home_leaguewinpercent | numeric | Home team's leaguewinpercent. |
| home_losses | numeric | Home team's losses. |
| home_playoffseed | numeric | Home team's playoffseed. |
| home_pointsagainst | numeric | Home team's pointsagainst. |
| home_pointsfor | numeric | Home team's pointsfor. |
| home_streak | numeric | Home team's streak. |
| home_winpercent | numeric | Home team's winpercent. |
| home_wins | numeric | Home team's wins. |
| home | character | Home. |
| road_avgpointsagainst | numeric | Road avgpointsagainst. |
| road_avgpointsfor | numeric | Road avgpointsfor. |
| road_gamesbehind | numeric | Road gamesbehind. |
| road_leaguewinpercent | numeric | Road leaguewinpercent. |
| road_losses | numeric | Road losses. |
| road_playoffseed | numeric | Road playoffseed. |
| road_pointsagainst | numeric | Road pointsagainst. |
| road_pointsfor | numeric | Road pointsfor. |
| road_streak | numeric | Road streak. |
| road_winpercent | numeric | Road winpercent. |
| road_wins | numeric | Road wins. |
| road | character | Road. |
| vsaprankedteams_avgpointsagainst | numeric | Vsaprankedteams avgpointsagainst. |
| vsaprankedteams_avgpointsfor | numeric | Vsaprankedteams avgpointsfor. |
| vsaprankedteams_gamesbehind | numeric | Vsaprankedteams gamesbehind. |
| vsaprankedteams_leaguewinpercent | numeric | Vsaprankedteams leaguewinpercent. |
| vsaprankedteams_losses | numeric | Vsaprankedteams losses. |
| vsaprankedteams_playoffseed | numeric | Vsaprankedteams playoffseed. |
| vsaprankedteams_pointsagainst | numeric | Vsaprankedteams pointsagainst. |
| vsaprankedteams_pointsfor | numeric | Vsaprankedteams pointsfor. |
| vsaprankedteams_streak | numeric | Vsaprankedteams streak. |
| vsaprankedteams_winpercent | numeric | Vsaprankedteams winpercent. |
| vsaprankedteams_wins | numeric | Vsaprankedteams wins. |
| vsaprankedteams | character | Vsaprankedteams. |
| vsusarankedteams_avgpointsagainst | numeric | Vsusarankedteams avgpointsagainst. |
| vsusarankedteams_avgpointsfor | numeric | Vsusarankedteams avgpointsfor. |
| vsusarankedteams_gamesbehind | numeric | Vsusarankedteams gamesbehind. |
| vsusarankedteams_leaguewinpercent | numeric | Vsusarankedteams leaguewinpercent. |
| vsusarankedteams_losses | numeric | Vsusarankedteams losses. |
| vsusarankedteams_playoffseed | numeric | Vsusarankedteams playoffseed. |
| vsusarankedteams_pointsagainst | numeric | Vsusarankedteams pointsagainst. |
| vsusarankedteams_pointsfor | numeric | Vsusarankedteams pointsfor. |
| vsusarankedteams_streak | numeric | Vsusarankedteams streak. |
| vsusarankedteams_winpercent | numeric | Vsusarankedteams winpercent. |
| vsusarankedteams_wins | numeric | Vsusarankedteams wins. |
| vsusarankedteams | character | Vsusarankedteams. |
| vsconf_avgpointsagainst | numeric | Vsconf avgpointsagainst. |
| vsconf_avgpointsfor | numeric | Vsconf avgpointsfor. |
| vsconf_gamesbehind | numeric | Vsconf gamesbehind. |
| vsconf_leaguewinpercent | numeric | Vsconf leaguewinpercent. |
| vsconf_losses | numeric | Vsconf losses. |
| vsconf_playoffseed | numeric | Vsconf playoffseed. |
| vsconf_pointsagainst | numeric | Vsconf pointsagainst. |
| vsconf_pointsfor | numeric | Vsconf pointsfor. |
| vsconf_streak | numeric | Vsconf streak. |
| vsconf_winpercent | numeric | Vsconf winpercent. |
| vsconf_wins | numeric | Vsconf wins. |
| vsconf | character | Vsconf. |

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
#> ── ESPN MBB Standings Information from ESPN.com ───────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:09:26 UTC
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
