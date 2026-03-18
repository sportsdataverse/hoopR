# **Get ESPN NBA player stats data**

**Get ESPN NBA player stats data**

## Usage

``` r
espn_nba_player_stats(athlete_id, year, season_type = "regular", total = FALSE)
```

## Arguments

- athlete_id:

  Athlete ID

- year:

  Year

- season_type:

  (character, default: regular): Season type - regular or postseason

- total:

  (boolean, default: FALSE): Totals

## Value

Returns a tibble with the player stats data

|                                                  |           |
|--------------------------------------------------|-----------|
| col_name                                         | types     |
| athlete_id                                       | integer   |
| athlete_uid                                      | character |
| athlete_guid                                     | character |
| athlete_type                                     | character |
| sdr                                              | integer   |
| first_name                                       | character |
| last_name                                        | character |
| full_name                                        | character |
| display_name                                     | character |
| short_name                                       | character |
| weight                                           | numeric   |
| display_weight                                   | character |
| height                                           | numeric   |
| display_height                                   | character |
| age                                              | integer   |
| date_of_birth                                    | character |
| slug                                             | character |
| headshot_href                                    | character |
| headshot_alt                                     | character |
| jersey                                           | character |
| position_id                                      | integer   |
| position_name                                    | character |
| position_display_name                            | character |
| position_abbreviation                            | character |
| position_leaf                                    | logical   |
| linked                                           | logical   |
| years                                            | integer   |
| active                                           | logical   |
| contract_x_ref                                   | character |
| contract_bird_status                             | integer   |
| contract_active                                  | logical   |
| contract_active_1                                | logical   |
| contract_incoming_trade_value                    | integer   |
| contract_outgoing_trade_value                    | integer   |
| contract_minimum_salary_exception                | logical   |
| contract_option_type                             | integer   |
| contract_salary                                  | integer   |
| contract_salary_remaining                        | integer   |
| contract_years_remaining                         | integer   |
| contract_x_ref_1                                 | character |
| contract_x_ref_2                                 | character |
| contract_trade_kicker_active                     | logical   |
| contract_trade_kicker_percentage                 | numeric   |
| contract_trade_kicker_value                      | integer   |
| contract_trade_kicker_trade_value                | integer   |
| contract_trade_restriction                       | logical   |
| contract_unsigned_foreign_pick                   | logical   |
| contract_active_2                                | logical   |
| draft_display_text                               | character |
| draft_round                                      | integer   |
| draft_year                                       | integer   |
| draft_selection                                  | integer   |
| draft_x_ref                                      | character |
| draft_x_ref_1                                    | character |
| status_id                                        | integer   |
| status_name                                      | character |
| status_type                                      | character |
| status_abbreviation                              | character |
| defensive_blocks                                 | numeric   |
| defensive_defensive_rebounds                     | numeric   |
| defensive_steals                                 | numeric   |
| defensive_def_rebound_rate                       | numeric   |
| defensive_avg_defensive_rebounds                 | numeric   |
| defensive_avg_blocks                             | numeric   |
| defensive_avg_steals                             | numeric   |
| defensive_avg48defensive_rebounds                | numeric   |
| defensive_avg48blocks                            | numeric   |
| defensive_avg48steals                            | numeric   |
| defensive_drpm                                   | numeric   |
| general_disqualifications                        | numeric   |
| general_flagrant_fouls                           | numeric   |
| general_fouls                                    | numeric   |
| general_per                                      | numeric   |
| general_rebound_rate                             | numeric   |
| general_ejections                                | numeric   |
| general_technical_fouls                          | numeric   |
| general_rebounds                                 | numeric   |
| general_vorp                                     | numeric   |
| general_warp                                     | numeric   |
| general_rpm                                      | numeric   |
| general_minutes                                  | numeric   |
| general_avg_minutes                              | numeric   |
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
| offensive_total_turnovers                        | numeric   |
| offensive_assist_ratio                           | numeric   |
| offensive_points_in_paint                        | numeric   |
| offensive_off_rebound_rate                       | numeric   |
| offensive_turnover_ratio                         | numeric   |
| offensive_brick_index                            | numeric   |
| offensive_usage_rate                             | numeric   |
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
| offensive_orpm                                   | numeric   |
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

## See also

Other ESPN NBA Functions:
[`espn_nba_betting()`](https://hoopR.sportsdataverse.org/reference/espn_nba_betting.md),
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
try(espn_nba_player_stats(athlete_id = 4433134, year = 2022))
#> ── ESPN NBA Player Season Stats from ESPN.com ─────────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 18:14:46 UTC
#> # A tibble: 1 × 271
#>   athlete_id athlete_uid   athlete_guid athlete_type    sdr first_name last_name
#>        <int> <chr>         <chr>        <chr>         <int> <chr>      <chr>    
#> 1    4433134 s:40~l:46~a:… dd0bb1da-07… basketball   4.43e6 Scottie    Barnes   
#> # ℹ 264 more variables: full_name <chr>, display_name <chr>, short_name <chr>,
#> #   weight <dbl>, display_weight <chr>, height <dbl>, display_height <chr>,
#> #   age <int>, date_of_birth <chr>, slug <chr>, headshot_href <chr>,
#> #   headshot_alt <chr>, jersey <chr>, position_id <int>, position_name <chr>,
#> #   position_display_name <chr>, position_abbreviation <chr>,
#> #   position_leaf <lgl>, linked <lgl>, years <int>, active <lgl>,
#> #   contract_x_ref <chr>, contract_bird_status <int>, contract_active <lgl>, …
# }
```
