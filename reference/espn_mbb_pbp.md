# **Get ESPN men's college basketball PBP data**

**Get ESPN men's college basketball PBP data**

## Usage

``` r
espn_mbb_pbp(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A play-by-play data frame.

**Plays**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| id                        | character |
| sequence_number           | character |
| text                      | character |
| away_score                | integer   |
| home_score                | integer   |
| scoring_play              | logical   |
| score_value               | integer   |
| wallclock                 | character |
| shooting_play             | logical   |
| type_id                   | integer   |
| type_text                 | character |
| period_number             | integer   |
| period_display_value      | character |
| clock_display_value       | character |
| team_id                   | integer   |
| coordinate_x_raw          | numeric   |
| coordinate_y_raw          | numeric   |
| coordinate_x              | numeric   |
| coordinate_y              | numeric   |
| play_id                   | character |
| athlete_id_1              | integer   |
| athlete_id_2              | integer   |
| home_team_id              | integer   |
| home_team_mascot          | character |
| home_team_name            | character |
| home_team_abbrev          | character |
| home_team_logo            | character |
| home_team_logo_dark       | character |
| home_team_full_name       | character |
| home_team_color           | character |
| home_team_alternate_color | character |
| home_team_score           | integer   |
| home_team_winner          | logical   |
| home_team_record          | character |
| away_team_id              | integer   |
| away_team_mascot          | character |
| away_team_name            | character |
| away_team_abbrev          | character |
| away_team_logo            | character |
| away_team_logo_dark       | character |
| away_team_full_name       | character |
| away_team_color           | character |
| away_team_alternate_color | character |
| away_team_score           | integer   |
| away_team_winner          | logical   |
| away_team_record          | character |
| game_id                   | integer   |
| season                    | integer   |
| season_type               | integer   |
| game_date                 | Date      |
| game_date_time            | POSIXct   |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
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
try(espn_mbb_pbp(game_id = 401479672))
#> ── ESPN MBB Play-by-Play Information from ESPN.com ────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-26 14:50:50 UTC
#> # A tibble: 360 × 53
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4014796… 101799901       Jump…          0          0 FALSE                  0
#>  2 4014796… 101805501       Jess…          0          0 FALSE                  2
#>  3 4014796… 101805502       RJ M…          0          0 FALSE                  0
#>  4 4014796… 101805503       Skyy…          0          0 FALSE                  0
#>  5 4014796… 101808101       Terr…          0          0 FALSE                  3
#>  6 4014796… 101808102       RJ M…          0          0 FALSE                  0
#>  7 4014796… 101809301       RJ M…          0          0 FALSE                  2
#>  8 4014796… 101809302       Benn…          0          0 FALSE                  0
#>  9 4014796… 101809501       Foul…          0          0 FALSE                  0
#> 10 4014796… 101814601       Juda…          0          0 FALSE                  2
#> # ℹ 350 more rows
#> # ℹ 46 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
# }
```
