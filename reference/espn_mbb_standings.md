# **Get ESPN men's college basketball standings**

**Get ESPN men's college basketball standings**

**Get ESPN NBA's Standings**

## Usage

``` r
espn_mbb_standings(year = most_recent_mbb_season())

espn_nba_standings(year)
```

## Arguments

- year:

  Either numeric or character (YYYY)

## Value

A `hoopR_data` tibble with one row per team in the standings.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team | character | Team-side label or team identifier. |
| conference | character | Conference group name from ESPN standings. |
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

A `hoopR_data` tibble with one row per team in the standings.

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team | character | Team-side label or team identifier. |
| avgpointsagainst | numeric | Avgpointsagainst. |
| avgpointsfor | numeric | Avgpointsfor. |
| clincher | numeric | Clincher. |
| differential | numeric | Differential. |
| divisionwinpercent | numeric | Divisionwinpercent. |
| gamesbehind | numeric | Gamesbehind. |
| leaguewinpercent | numeric | Leaguewinpercent. |
| losses | numeric | Total losses. |
| playoffseed | numeric | Playoffseed. |
| streak | numeric | Current streak (e.g. 'W3' for three-game win streak). |
| winpercent | numeric | Winpercent. |
| wins | numeric | Total wins. |
| leaguestandings | character | Leaguestandings. |
| home | character | Home. |
| road | character | Road. |
| vsdiv | character | Vsdiv. |
| vsconf | character | Vsconf. |
| lasttengames | character | Lasttengames. |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
try(espn_mbb_standings(2021))
#> ── ESPN MBB Standings Information from ESPN.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:56 UTC
#> # A tibble: 302 × 87
#>    team_id team             conference avgpointsagainst avgpointsfor gamesbehind
#>      <int> <chr>            <chr>                 <dbl>        <dbl>       <dbl>
#>  1    2378 UMBC Retrievers  America E…             64.9         69.6         0  
#>  2     261 Vermont Catamou… America E…             63.4         73           1.5
#>  3      42 Hartford Hawks   America E…             63.9         65.4         2  
#>  4     160 New Hampshire W… America E…             66.6         67.3         3.5
#>  5    2349 UMass Lowell Ri… America E…             70.9         68.5         4.5
#>  6     399 UAlbany Great D… America E…             68.7         69.4         5  
#>  7    2619 Stony Brook Sea… America E…             65.6         66.2         5.5
#>  8    2885 NJIT Highlanders America E…             70.2         66.1         6.5
#>  9    2066 Binghamton Bear… America E…             72.3         65.4         9  
#> 10     311 Maine Black Bea… America E…             64.6         53.1         6.5
#> # ℹ 292 more rows
#> # ℹ 81 more variables: leaguewinpercent <dbl>, losses <dbl>, playoffseed <dbl>,
#> #   pointdifferential <chr>, pointsagainst <dbl>, pointsfor <dbl>,
#> #   streak <dbl>, winpercent <dbl>, wins <dbl>, gamesahead <chr>, total <chr>,
#> #   home_avgpointsagainst <dbl>, home_avgpointsfor <dbl>,
#> #   home_gamesbehind <dbl>, home_leaguewinpercent <dbl>, home_losses <dbl>,
#> #   home_playoffseed <dbl>, home_pointdifferential <chr>, …
# }
# \donttest{
try(espn_nba_standings(year = 2021))
#> ── ESPN NBA Standings Information from ESPN.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:14:56 UTC
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
