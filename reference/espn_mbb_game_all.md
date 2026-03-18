# **Get ESPN men's college basketball data (Pbp, Team and Player Box)**

**Get ESPN men's college basketball data (Pbp, Team and Player Box)**

## Usage

``` r
espn_mbb_game_all(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A named list of data frames: Plays, Team, Player

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

**Team**

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| game_id                           | integer   |
| season                            | integer   |
| season_type                       | integer   |
| game_date                         | Date      |
| game_date_time                    | POSIXct   |
| team_id                           | integer   |
| team_uid                          | character |
| team_slug                         | character |
| team_location                     | character |
| team_name                         | character |
| team_abbreviation                 | character |
| team_display_name                 | character |
| team_short_display_name           | character |
| team_color                        | character |
| team_alternate_color              | character |
| team_logo                         | character |
| team_home_away                    | character |
| team_score                        | integer   |
| team_winner                       | logical   |
| assists                           | integer   |
| blocks                            | integer   |
| defensive_rebounds                | integer   |
| field_goal_pct                    | numeric   |
| field_goals_made                  | integer   |
| field_goals_attempted             | integer   |
| flagrant_fouls                    | integer   |
| fouls                             | integer   |
| free_throw_pct                    | numeric   |
| free_throws_made                  | integer   |
| free_throws_attempted             | integer   |
| largest_lead                      | character |
| offensive_rebounds                | integer   |
| steals                            | integer   |
| team_turnovers                    | integer   |
| technical_fouls                   | integer   |
| three_point_field_goal_pct        | numeric   |
| three_point_field_goals_made      | integer   |
| three_point_field_goals_attempted | integer   |
| total_rebounds                    | integer   |
| total_technical_fouls             | integer   |
| total_turnovers                   | integer   |
| turnovers                         | integer   |
| opponent_team_id                  | integer   |
| opponent_team_uid                 | character |
| opponent_team_slug                | character |
| opponent_team_location            | character |
| opponent_team_name                | character |
| opponent_team_abbreviation        | character |
| opponent_team_display_name        | character |
| opponent_team_short_display_name  | character |
| opponent_team_color               | character |
| opponent_team_alternate_color     | character |
| opponent_team_logo                | character |
| opponent_team_score               | integer   |

**Player**

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| game_id                           | integer   |
| season                            | integer   |
| season_type                       | integer   |
| game_date                         | Date      |
| game_date_time                    | POSIXct   |
| athlete_id                        | integer   |
| athlete_display_name              | character |
| team_id                           | integer   |
| team_name                         | character |
| team_location                     | character |
| team_short_display_name           | character |
| minutes                           | numeric   |
| field_goals_made                  | integer   |
| field_goals_attempted             | integer   |
| three_point_field_goals_made      | integer   |
| three_point_field_goals_attempted | integer   |
| free_throws_made                  | integer   |
| free_throws_attempted             | integer   |
| offensive_rebounds                | integer   |
| defensive_rebounds                | integer   |
| rebounds                          | integer   |
| assists                           | integer   |
| steals                            | integer   |
| blocks                            | integer   |
| turnovers                         | integer   |
| fouls                             | integer   |
| points                            | integer   |
| starter                           | logical   |
| ejected                           | logical   |
| did_not_play                      | logical   |
| active                            | logical   |
| athlete_jersey                    | character |
| athlete_short_name                | character |
| athlete_headshot_href             | character |
| athlete_position_name             | character |
| athlete_position_abbreviation     | character |
| team_display_name                 | character |
| team_uid                          | character |
| team_slug                         | character |
| team_logo                         | character |
| team_abbreviation                 | character |
| team_color                        | character |
| team_alternate_color              | character |
| home_away                         | character |
| team_winner                       | logical   |
| team_score                        | integer   |
| opponent_team_id                  | integer   |
| opponent_team_name                | character |
| opponent_team_location            | character |
| opponent_team_display_name        | character |
| opponent_team_abbreviation        | character |
| opponent_team_logo                | character |
| opponent_team_color               | character |
| opponent_team_alternate_color     | character |
| opponent_team_score               | integer   |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
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
try(espn_mbb_game_all(game_id = 401479672))
#> $Plays
#> ── ESPN MBB Play-by-Play Information from ESPN.com ────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 16:18:33 UTC
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
#> 
#> $Team
#> ── ESPN MBB Team Box Information from ESPN.com ────────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 16:18:33 UTC
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401479672   2023           2 2022-11-29 2022-11-29 19:30:00     183 s:40~l:41…
#> 2 401479672   2023           2 2022-11-29 2022-11-29 19:30:00     356 s:40~l:41…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
#> 
#> $Player
#> ── ESPN MBB Player Box Information from ESPN.com ──────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 16:18:34 UTC
#> # A tibble: 30 × 54
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4684627
#>  2 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4575472
#>  3 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4431816
#>  4 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4684729
#>  5 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4431746
#>  6 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4700878
#>  7 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    5105337
#>  8 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4592369
#>  9 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4684746
#> 10 401479672   2023           2 2022-11-29 2022-11-29 19:30:00    4683860
#> # ℹ 20 more rows
#> # ℹ 48 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
#> 
# }
```
