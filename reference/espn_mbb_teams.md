# **Get ESPN men's college basketball team names and IDs**

**Get ESPN men's college basketball team names and IDs**

## Usage

``` r
espn_mbb_teams(year = most_recent_mbb_season())
```

## Arguments

- year:

  Either numeric or character (YYYY)

## Value

A teams data frame

|                       |           |
|-----------------------|-----------|
| col_name              | types     |
| team_id               | integer   |
| abbreviation          | character |
| display_name          | character |
| short_name            | character |
| mascot                | character |
| nickname              | character |
| team                  | character |
| color                 | character |
| alternate_color       | character |
| logo                  | character |
| logo_dark             | character |
| href                  | character |
| conference_url        | character |
| group_id              | integer   |
| conference_short_name | character |
| conference_uid        | character |
| conference_name       | character |
| conference_logo       | character |
| parent_group_id       | integer   |
| conference_id         | integer   |

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
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_teams())
#> ── ESPN MBB Teams Information from ESPN.com ───────────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 16:18:51 UTC
#> # A tibble: 362 × 32
#>    team_id abbreviation display_name      short_name mascot nickname team  color
#>      <int> <chr>        <chr>             <chr>      <chr>  <chr>    <chr> <chr>
#>  1    2000 ACU          Abilene Christia… Abilene C… Wildc… Abilene… Abil… 592d…
#>  2    2005 AF           Air Force Falcons Air Force  Falco… Air For… Air … 0035…
#>  3    2006 AKR          Akron Zips        Akron      Zips   Akron    Akron 041e…
#>  4    2010 AAMU         Alabama A&M Bull… Alabama A… Bulld… Alabama… Alab… 7900…
#>  5     333 ALA          Alabama Crimson … Alabama    Crims… Alabama  Alab… 9e1b…
#>  6    2011 ALST         Alabama State Ho… Alabama St Horne… Alabama… Alab… e9a9…
#>  7    2016 ALCN         Alcorn State Bra… Alcorn St  Braves Alcorn … Alco… 4b00…
#>  8      44 AMER         American Univers… American   Eagles American Amer… c411…
#>  9    2026 APP          App State Mounta… App State  Mount… App Sta… App … 0000…
#> 10       9 ASU          Arizona State Su… Arizona St Sun D… Arizona… Ariz… ffc6…
#> # ℹ 352 more rows
#> # ℹ 24 more variables: alternate_color <chr>, logo <chr>, logo_dark <chr>,
#> #   logos_href_3 <chr>, logos_href_4 <chr>, logos_href_5 <chr>,
#> #   logos_href_6 <chr>, logos_href_7 <chr>, logos_href_8 <chr>,
#> #   logos_href_9 <chr>, logos_href_10 <chr>, logos_href_11 <chr>,
#> #   logos_href_12 <chr>, logos_href_13 <chr>, logos_href_14 <chr>, href <chr>,
#> #   conference_url <chr>, group_id <int>, conference_uid <chr>, …
# }
```
