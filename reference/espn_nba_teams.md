# **Get ESPN NBA team names and IDs**

**Get ESPN NBA team names and IDs**

## Usage

``` r
espn_nba_teams()
```

## Value

A teams data frame

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| team_id         | integer   |
| abbreviation    | character |
| display_name    | character |
| short_name      | character |
| mascot          | character |
| nickname        | character |
| team            | character |
| color           | character |
| alternate_color | character |
| logo            | character |
| logo_dark       | character |
| logos_href_3    | character |
| logos_href_4    | character |

## See also

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(espn_nba_teams())
#> ── ESPN NBA Teams Information from ESPN.com ───────────────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 16:28:29 UTC
#> # A tibble: 30 × 21
#>    team_id abbreviation display_name      short_name mascot nickname team  color
#>      <int> <chr>        <chr>             <chr>      <chr>  <chr>    <chr> <chr>
#>  1       1 ATL          Atlanta Hawks     Hawks      Hawks  Atlanta  Atla… c810…
#>  2       2 BOS          Boston Celtics    Celtics    Celti… Boston   Bost… 0083…
#>  3      17 BKN          Brooklyn Nets     Nets       Nets   Brooklyn Broo… 0000…
#>  4      30 CHA          Charlotte Hornets Hornets    Horne… Charlot… Char… 008c…
#>  5       4 CHI          Chicago Bulls     Bulls      Bulls  Chicago  Chic… ce11…
#>  6       5 CLE          Cleveland Cavali… Cavaliers  Caval… Clevela… Clev… 8600…
#>  7       6 DAL          Dallas Mavericks  Mavericks  Maver… Dallas   Dall… 0064…
#>  8       7 DEN          Denver Nuggets    Nuggets    Nugge… Denver   Denv… 0e22…
#>  9       8 DET          Detroit Pistons   Pistons    Pisto… Detroit  Detr… 1d42…
#> 10       9 GS           Golden State War… Warriors   Warri… Golden … Gold… fdb9…
#> # ℹ 20 more rows
#> # ℹ 13 more variables: alternate_color <chr>, logo <chr>, logo_dark <chr>,
#> #   logos_href_3 <chr>, logos_href_4 <chr>, logos_href_5 <chr>,
#> #   logos_href_6 <chr>, logos_href_7 <chr>, logos_href_8 <chr>,
#> #   logos_href_9 <chr>, logos_href_10 <chr>, logos_href_11 <chr>,
#> #   logos_href_12 <chr>
# }
```
