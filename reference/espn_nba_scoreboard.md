# **Get ESPN NBA schedule for a specific year**

**Get ESPN NBA schedule for a specific year**

## Usage

``` r
espn_nba_scoreboard(season)
```

## Arguments

- season:

  Either numeric or character (YYYYMMDD)

## Value

Returns a tibble with scoreboard data

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
| notes               | logical   |
| status_name         | character |
| broadcasts          | logical   |
| start_date          | character |
| geo_broadcasts      | logical   |
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

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Examples

``` r
# Get schedule from date 2022-11-17 (returns 1000 results, max allowable.)
# \donttest{
try(espn_nba_scoreboard(season = 20230423))
#> ── ESPN NBA Scoreboard Information from ESPN.com ──────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-24 01:20:48 UTC
#> # A tibble: 4 × 37
#>   matchup          matchup_short season season_type season_slug game_id game_uid
#>   <chr>            <chr>          <int>       <int> <chr>         <int> <chr>   
#> 1 Cleveland Caval… CLE @ NY        2023           3 post-season  4.02e8 s:40~l:…
#> 2 Sacramento King… SAC @ GS        2023           3 post-season  4.02e8 s:40~l:…
#> 3 Boston Celtics … BOS @ ATL       2023           3 post-season  4.02e8 s:40~l:…
#> 4 Denver Nuggets … DEN @ MIN       2023           3 post-season  4.02e8 s:40~l:…
#> # ℹ 30 more variables: game_date <date>, attendance <int>,
#> #   play_by_play_available <lgl>, status_name <chr>, broadcast_market <chr>,
#> #   broadcast_name <chr>, start_date <chr>, broadcast <chr>, highlights <lgl>,
#> #   game_date_time <dttm>, home_team_name <chr>, home_team_logo <chr>,
#> #   home_team_abb <chr>, home_team_id <int>, home_team_location <chr>,
#> #   home_team_full_name <chr>, home_team_color <chr>, home_score <int>,
#> #   home_win <int>, home_record <chr>, away_team_name <chr>, …
# }
```
