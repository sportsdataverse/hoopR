# **Get ESPN men's college basketball current team roster**

**Get ESPN men's college basketball current team roster**

## Usage

``` r
espn_mbb_team_current_roster(team_id)
```

## Arguments

- team_id:

  Either numeric or character (YYYY)

## Value

A teams data frame

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
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_mbb_team_current_roster(team_id = 52))
#> ── ESPN MBB Team Current Roster Information from ESPN.com ─────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-24 04:17:48 UTC
#> # A tibble: 15 × 59
#>    team_id team_uid       team_slug        team_location team_name team_nickname
#>      <int> <chr>          <chr>            <chr>         <chr>     <chr>        
#>  1      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  2      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  3      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  4      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  5      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  6      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  7      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  8      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#>  9      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#> 10      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#> 11      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#> 12      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#> 13      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#> 14      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#> 15      52 s:40~l:41~t:52 florida-state-s… Florida State Seminoles Florida St   
#> # ℹ 53 more variables: team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_name <chr>, team_color <chr>, team_alternate_color <chr>,
#> #   team_is_active <lgl>, standingSummary <chr>, logo <chr>, logo_dark <chr>,
#> #   group_id <int>, parent_group_id <int>, group_is_conference <lgl>,
#> #   conference_id <int>, athlete_id <int>, athlete_uid <chr>,
#> #   athlete_guid <chr>, athlete_type <chr>, athlete_first_name <chr>,
#> #   athlete_last_name <chr>, athlete_full_name <chr>, …
# }
```
