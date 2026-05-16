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
#> ℹ Data updated: 2026-05-16 19:40:59 UTC
#> # A tibble: 362 × 32
#>    abbreviation alternate_color color display_name team_id team  logo  logo_dark
#>    <chr>        <chr>           <chr> <chr>          <int> <chr> <chr> <chr>    
#>  1 ACU          b1b3b3          592d… Abilene Chr…    2000 Abil… http… https://…
#>  2 AF           ffffff          0035… Air Force F…    2005 Air … http… https://…
#>  3 AKR          c5b783          041e… Akron Zips      2006 Akron http… https://…
#>  4 AAMU         ffffff          7900… Alabama A&M…    2010 Alab… http… https://…
#>  5 ALA          ffffff          9e1b… Alabama Cri…     333 Alab… http… https://…
#>  6 ALST         0a0a0a          e9a9… Alabama Sta…    2011 Alab… http… https://…
#>  7 ALCN         46166a          4b00… Alcorn Stat…    2016 Alco… http… https://…
#>  8 AMER         c8102e          c411… American Un…      44 Amer… http… https://…
#>  9 APP          ffcd00          0000… App State M…    2026 App … http… https://…
#> 10 ASU          8c1d40          ffc6… Arizona Sta…       9 Ariz… http… https://…
#> # ℹ 352 more rows
#> # ℹ 24 more variables: logos_href_3 <chr>, logos_href_4 <chr>,
#> #   logos_href_5 <chr>, logos_href_6 <chr>, logos_href_7 <chr>,
#> #   logos_href_8 <chr>, logos_href_9 <chr>, logos_href_10 <chr>,
#> #   logos_href_11 <chr>, logos_href_12 <chr>, logos_href_13 <chr>,
#> #   logos_href_14 <chr>, mascot <chr>, nickname <chr>, short_name <chr>,
#> #   href <chr>, conference_url <chr>, group_id <int>, conference_uid <chr>, …
# }
```
