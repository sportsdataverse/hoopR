# **Get ESPN men's college basketball schedule for a specific year**

**Get ESPN men's college basketball schedule for a specific year**

## Usage

``` r
espn_mbb_scoreboard(season)
```

## Arguments

- season:

  Either numeric or character

## Value

Returns a tibble

|                     |           |
|---------------------|-----------|
| col_name            | types     |
| matchup             | character |
| matchup_short       | character |
| season              | integer   |
| season_type         | integer   |
| season_slug         | character |
| game_id             | integer   |
| game_uid            | character |
| game_date           | Date      |
| attendance          | integer   |
| status_name         | character |
| broadcast_market    | character |
| broadcast_name      | character |
| start_date          | character |
| game_date_time      | POSIXct   |
| home_team_name      | character |
| home_team_logo      | character |
| home_team_abb       | character |
| home_team_id        | integer   |
| home_team_location  | character |
| home_team_full_name | character |
| home_team_color     | character |
| home_score          | integer   |
| home_win            | integer   |
| home_record         | character |
| away_team_name      | character |
| away_team_logo      | character |
| away_team_abb       | character |
| away_team_id        | integer   |
| away_team_location  | character |
| away_team_full_name | character |
| away_team_color     | character |
| away_score          | integer   |
| away_win            | integer   |
| away_record         | character |

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
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Examples

``` r
# Get schedule from date 2022-11-17
# \donttest{
  try(espn_mbb_scoreboard (season = "20221117"))
#> ── ESPN MBB Scoreboard Information from ESPN.com ──────────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 16:28:15 UTC
#> # A tibble: 50 × 36
#>    matchup         matchup_short season season_type season_slug game_id game_uid
#>    <chr>           <chr>          <int>       <int> <chr>         <int> <chr>   
#>  1 South Carolina… SCST @ UK       2023           2 regular-se…  4.01e8 s:40~l:…
#>  2 UC Riverside H… UCR @ CREI      2023           2 regular-se…  4.01e8 s:40~l:…
#>  3 Utah Tech Trai… UTU @ ARIZ      2023           2 regular-se…  4.01e8 s:40~l:…
#>  4 Furman Paladin… FUR VS PSU      2023           2 regular-se…  4.01e8 s:40~l:…
#>  5 Colorado Buffa… COLO VS MASS    2023           2 regular-se…  4.01e8 s:40~l:…
#>  6 Old Dominion M… ODU VS VT       2023           2 regular-se…  4.01e8 s:40~l:…
#>  7 Murray State R… MUR VS TA&M     2023           2 regular-se…  4.01e8 s:40~l:…
#>  8 Colorado State… CSU VS SC       2023           2 regular-se…  4.01e8 s:40~l:…
#>  9 Saint Francis … SFPA @ BUT      2023           2 regular-se…  4.01e8 s:40~l:…
#> 10 Kansas City Ro… KC @ KSU        2023           2 regular-se…  4.01e8 s:40~l:…
#> # ℹ 40 more rows
#> # ℹ 29 more variables: game_date <date>, attendance <int>,
#> #   play_by_play_available <lgl>, status_name <chr>, broadcast_market <chr>,
#> #   broadcast_name <chr>, start_date <chr>, broadcast <chr>,
#> #   game_date_time <dttm>, home_team_name <chr>, home_team_logo <chr>,
#> #   home_team_abb <chr>, home_team_id <int>, home_team_location <chr>,
#> #   home_team_full_name <chr>, home_team_color <chr>, home_score <int>, …
# }
```
