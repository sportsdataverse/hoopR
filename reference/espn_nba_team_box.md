# **Get ESPN NBA team box scores**

**Get ESPN NBA team box scores**

## Usage

``` r
espn_nba_team_box(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A team boxscore data frame

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
| fast_break_points                 | character |
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
| points_in_paint                   | character |
| steals                            | integer   |
| team_turnovers                    | integer   |
| technical_fouls                   | integer   |
| three_point_field_goal_pct        | numeric   |
| three_point_field_goals_made      | integer   |
| three_point_field_goals_attempted | integer   |
| total_rebounds                    | integer   |
| total_technical_fouls             | integer   |
| total_turnovers                   | integer   |
| turnover_points                   | character |
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
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  try(espn_nba_team_box(game_id = 401071880))
#> ── ESPN NBA Team Box Information from ESPN.com ────────────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 16:28:28 UTC
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401071880   2019           2 2019-04-07 2019-04-07 21:00:00       3 s:40~l:46…
#> 2 401071880   2019           2 2019-04-07 2019-04-07 21:00:00      23 s:40~l:46…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
# }
```
