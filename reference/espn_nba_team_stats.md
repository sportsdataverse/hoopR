# **Get ESPN NBA team stats data**

**Get ESPN NBA team stats data**

## Usage

``` r
espn_nba_team_stats(team_id, year, season_type = "regular", total = FALSE)
```

## Arguments

- team_id:

  Team ID

- year:

  Year

- season_type:

  (character, default: regular): Season type - regular or postseason

- total:

  (boolean, default: FALSE): Totals

## Value

Returns a tibble with the team stats data

|                                                  |           |
|--------------------------------------------------|-----------|
| col_name                                         | types     |
| team_id                                          | integer   |
| team_guid                                        | character |
| team_uid                                         | character |
| team_slug                                        | character |
| team_location                                    | character |
| team_name                                        | character |
| team_abbreviation                                | character |
| team_display_name                                | character |
| team_short_display_name                          | character |
| team_color                                       | character |
| team_alternate_color                             | character |
| team_is_active                                   | logical   |
| team_is_all_star                                 | logical   |
| logo_href                                        | character |
| logo_dark_href                                   | character |
| logos_href_2                                     | character |
| logos_href_3                                     | character |
| defensive_blocks                                 | numeric   |
| defensive_defensive_rebounds                     | numeric   |
| defensive_steals                                 | numeric   |
| defensive_turnover_points                        | numeric   |
| defensive_def_rebound_rate                       | numeric   |
| defensive_avg_defensive_rebounds                 | numeric   |
| defensive_avg_blocks                             | numeric   |
| defensive_avg_steals                             | numeric   |
| defensive_avg48defensive_rebounds                | numeric   |
| defensive_avg48blocks                            | numeric   |
| defensive_avg48steals                            | numeric   |
| general_disqualifications                        | numeric   |
| general_flagrant_fouls                           | numeric   |
| general_fouls                                    | numeric   |
| general_rebound_rate                             | numeric   |
| general_ejections                                | numeric   |
| general_technical_fouls                          | numeric   |
| general_rebounds                                 | numeric   |
| general_minutes                                  | numeric   |
| general_avg_minutes                              | numeric   |
| general_fantasy_rating                           | numeric   |
| general_nba_rating                               | numeric   |
| general_plus_minus                               | numeric   |
| general_avg_rebounds                             | numeric   |
| general_avg_fouls                                | numeric   |
| general_avg_flagrant_fouls                       | numeric   |
| general_avg_technical_fouls                      | numeric   |
| general_avg_ejections                            | numeric   |
| general_avg_disqualifications                    | numeric   |
| general_assist_turnover_ratio                    | numeric   |
| general_steal_foul_ratio                         | numeric   |
| general_block_foul_ratio                         | numeric   |
| general_avg_team_rebounds                        | numeric   |
| general_total_rebounds                           | numeric   |
| general_total_technical_fouls                    | numeric   |
| general_team_assist_turnover_ratio               | numeric   |
| general_team_rebounds                            | numeric   |
| general_steal_turnover_ratio                     | numeric   |
| general_avg48rebounds                            | numeric   |
| general_avg48fouls                               | numeric   |
| general_avg48flagrant_fouls                      | numeric   |
| general_avg48technical_fouls                     | numeric   |
| general_avg48ejections                           | numeric   |
| general_avg48disqualifications                   | numeric   |
| general_r40                                      | numeric   |
| general_games_played                             | numeric   |
| general_games_started                            | numeric   |
| general_double_double                            | numeric   |
| general_triple_double                            | numeric   |
| offensive_assists                                | numeric   |
| offensive_effective_fg_pct                       | numeric   |
| offensive_field_goals                            | numeric   |
| offensive_field_goals_attempted                  | numeric   |
| offensive_field_goals_made                       | numeric   |
| offensive_field_goal_pct                         | numeric   |
| offensive_free_throws                            | numeric   |
| offensive_free_throw_pct                         | numeric   |
| offensive_free_throws_attempted                  | numeric   |
| offensive_free_throws_made                       | numeric   |
| offensive_offensive_rebounds                     | numeric   |
| offensive_points                                 | numeric   |
| offensive_turnovers                              | numeric   |
| offensive_three_point_pct                        | numeric   |
| offensive_three_point_field_goals_attempted      | numeric   |
| offensive_three_point_field_goals_made           | numeric   |
| offensive_true_shooting_pct                      | numeric   |
| offensive_team_turnovers                         | numeric   |
| offensive_total_turnovers                        | numeric   |
| offensive_assist_ratio                           | numeric   |
| offensive_points_in_paint                        | numeric   |
| offensive_off_rebound_rate                       | numeric   |
| offensive_turnover_ratio                         | numeric   |
| offensive_fast_break_points                      | numeric   |
| offensive_possessions                            | numeric   |
| offensive_pace_factor                            | numeric   |
| offensive_avg_field_goals_made                   | numeric   |
| offensive_avg_field_goals_attempted              | numeric   |
| offensive_avg_three_point_field_goals_made       | numeric   |
| offensive_avg_three_point_field_goals_attempted  | numeric   |
| offensive_avg_free_throws_made                   | numeric   |
| offensive_avg_free_throws_attempted              | numeric   |
| offensive_avg_points                             | numeric   |
| offensive_avg_offensive_rebounds                 | numeric   |
| offensive_avg_assists                            | numeric   |
| offensive_avg_turnovers                          | numeric   |
| offensive_offensive_rebound_pct                  | numeric   |
| offensive_estimated_possessions                  | numeric   |
| offensive_avg_estimated_possessions              | numeric   |
| offensive_points_per_estimated_possessions       | numeric   |
| offensive_avg_team_turnovers                     | numeric   |
| offensive_avg_total_turnovers                    | numeric   |
| offensive_three_point_field_goal_pct             | numeric   |
| offensive_two_point_field_goals_made             | numeric   |
| offensive_two_point_field_goals_attempted        | numeric   |
| offensive_avg_two_point_field_goals_made         | numeric   |
| offensive_avg_two_point_field_goals_attempted    | numeric   |
| offensive_two_point_field_goal_pct               | numeric   |
| offensive_shooting_efficiency                    | numeric   |
| offensive_scoring_efficiency                     | numeric   |
| offensive_avg48field_goals_made                  | numeric   |
| offensive_avg48field_goals_attempted             | numeric   |
| offensive_avg48three_point_field_goals_made      | numeric   |
| offensive_avg48three_point_field_goals_attempted | numeric   |
| offensive_avg48free_throws_made                  | numeric   |
| offensive_avg48free_throws_attempted             | numeric   |
| offensive_avg48points                            | numeric   |
| offensive_avg48offensive_rebounds                | numeric   |
| offensive_avg48assists                           | numeric   |
| offensive_avg48turnovers                         | numeric   |
| offensive_p40                                    | numeric   |
| offensive_a40                                    | numeric   |

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
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_nba_team_stats(team_id = 18, year = 2020))
#> ── ESPN NBA Team Season Stats from ESPN.com ───────────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-26 14:51:12 UTC
#> # A tibble: 1 × 213
#>   team_id team_guid team_uid team_slug team_location team_name team_abbreviation
#>     <int> <chr>     <chr>    <chr>     <chr>         <chr>     <chr>            
#> 1      18 61719eb2… s:40~l:… new-york… New York      Knicks    NY               
#> # ℹ 206 more variables: team_display_name <chr>, team_short_display_name <chr>,
#> #   team_color <chr>, team_alternate_color <chr>, team_is_active <lgl>,
#> #   team_is_all_star <lgl>, logo_href <chr>, logo_dark_href <chr>,
#> #   logos_href_2 <chr>, logos_href_3 <chr>, logos_href_4 <chr>,
#> #   logos_width_4 <int>, logos_height_4 <int>, logos_alt_4 <chr>,
#> #   logos_rel_full_4 <chr>, logos_rel_primary_logo_on_white_color <chr>,
#> #   logos_last_updated_4 <chr>, logos_href_5 <chr>, logos_width_5 <int>, …
# }
```
