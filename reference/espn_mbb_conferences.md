# **Get ESPN conference names and IDs**

**Get ESPN conference names and IDs**

## Usage

``` r
espn_mbb_conferences()
```

## Value

A conferences data frame

|  |  |  |
|----|----|----|
| col_name | types | description |
| group_id | integer | Group identifier (e.g. conference group_id). |
| conference_short_name | character | Conference short name (e.g. 'ACC'). |
| conference_uid | character | ESPN universal conference identifier. |
| conference_name | character | Full conference name. |
| conference_logo | character | Logo image URL for conference. |
| parent_group_id | integer | Unique identifier for parent group. |
| conference_id | integer | Conference identifier. |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
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
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_conferences())
#> ── ESPN MBB Conferences Information from ESPN.com ─────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-05-17 16:09:18 UTC
#> # A tibble: 31 × 7
#>    conference_uid group_id conference_name conference_short_name conference_logo
#>    <chr>             <int> <chr>           <chr>                 <chr>          
#>  1 s:40~l:41~g:3         3 Atlantic 10 Co… A-10                  https://a.espn…
#>  2 s:40~l:41~g:2         2 Atlantic Coast… ACC                   https://a.espn…
#>  3 s:40~l:41~g:1         1 America East C… Am. East              https://a.espn…
#>  4 s:40~l:41~g:62       62 American Confe… American              NA             
#>  5 s:40~l:41~g:46       46 ASUN Conference ASUN                  NA             
#>  6 s:40~l:41~g:8         8 Big 12 Confere… Big 12                https://a.espn…
#>  7 s:40~l:41~g:4         4 Big East Confe… Big East              https://a.espn…
#>  8 s:40~l:41~g:5         5 Big Sky Confer… Big Sky               https://a.espn…
#>  9 s:40~l:41~g:6         6 Big South Conf… Big South             https://a.espn…
#> 10 s:40~l:41~g:7         7 Big Ten Confer… Big Ten               https://a.espn…
#> # ℹ 21 more rows
#> # ℹ 2 more variables: parent_group_id <int>, conference_id <int>
# }
```
