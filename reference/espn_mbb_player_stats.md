# **Get ESPN men's college basketball player stats data**

**Get ESPN men's college basketball player stats data**

## Usage

``` r
espn_mbb_player_stats(athlete_id, year, season_type = "regular", total = FALSE)
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

|                                                 |           |
|-------------------------------------------------|-----------|
| col_name                                        | types     |
| athlete_id                                      | integer   |
| athlete_uid                                     | character |
| athlete_guid                                    | character |
| athlete_type                                    | character |
| sdr                                             | integer   |
| first_name                                      | character |
| last_name                                       | character |
| full_name                                       | character |
| display_name                                    | character |
| short_name                                      | character |
| weight                                          | numeric   |
| display_weight                                  | character |
| height                                          | numeric   |
| display_height                                  | character |
| age                                             | integer   |
| date_of_birth                                   | character |
| birth_place_city                                | character |
| birth_place_state                               | character |
| birth_place_country                             | character |
| slug                                            | character |
| headshot_href                                   | character |
| headshot_alt                                    | character |
| jersey                                          | character |
| position_id                                     | integer   |
| position_name                                   | character |
| position_display_name                           | character |
| position_abbreviation                           | character |
| position_leaf                                   | logical   |
| linked                                          | logical   |
| experience_years                                | integer   |
| experience_display_value                        | character |
| experience_abbreviation                         | character |
| active                                          | logical   |
| draft_display_text                              | character |
| draft_round                                     | integer   |
| draft_year                                      | integer   |
| draft_selection                                 | integer   |
| status_id                                       | integer   |
| status_name                                     | character |
| status_type                                     | character |
| status_abbreviation                             | character |
| defensive_blocks                                | numeric   |
| defensive_defensive_rebounds                    | numeric   |
| defensive_steals                                | numeric   |
| defensive_turnover_points                       | numeric   |
| defensive_avg_defensive_rebounds                | numeric   |
| defensive_avg_blocks                            | numeric   |
| defensive_avg_steals                            | numeric   |
| general_disqualifications                       | numeric   |
| general_flagrant_fouls                          | numeric   |
| general_fouls                                   | numeric   |
| general_per                                     | numeric   |
| general_ejections                               | numeric   |
| general_technical_fouls                         | numeric   |
| general_rebounds                                | numeric   |
| general_minutes                                 | numeric   |
| general_avg_minutes                             | numeric   |
| general_fantasy_rating                          | numeric   |
| general_plus_minus                              | numeric   |
| general_avg_rebounds                            | numeric   |
| general_avg_fouls                               | numeric   |
| general_avg_flagrant_fouls                      | numeric   |
| general_avg_technical_fouls                     | numeric   |
| general_avg_ejections                           | numeric   |
| general_avg_disqualifications                   | numeric   |
| general_assist_turnover_ratio                   | numeric   |
| general_steal_foul_ratio                        | numeric   |
| general_block_foul_ratio                        | numeric   |
| general_avg_team_rebounds                       | numeric   |
| general_total_rebounds                          | numeric   |
| general_total_technical_fouls                   | numeric   |
| general_steal_turnover_ratio                    | numeric   |
| general_games_played                            | numeric   |
| general_games_started                           | numeric   |
| general_double_double                           | numeric   |
| general_triple_double                           | numeric   |
| offensive_assists                               | numeric   |
| offensive_field_goals                           | numeric   |
| offensive_field_goals_attempted                 | numeric   |
| offensive_field_goals_made                      | numeric   |
| offensive_field_goal_pct                        | numeric   |
| offensive_free_throws                           | numeric   |
| offensive_free_throw_pct                        | numeric   |
| offensive_free_throws_attempted                 | numeric   |
| offensive_free_throws_made                      | numeric   |
| offensive_offensive_rebounds                    | numeric   |
| offensive_points                                | numeric   |
| offensive_turnovers                             | numeric   |
| offensive_three_point_field_goals_attempted     | numeric   |
| offensive_three_point_field_goals_made          | numeric   |
| offensive_total_turnovers                       | numeric   |
| offensive_points_in_paint                       | numeric   |
| offensive_fast_break_points                     | numeric   |
| offensive_avg_field_goals_made                  | numeric   |
| offensive_avg_field_goals_attempted             | numeric   |
| offensive_avg_three_point_field_goals_made      | numeric   |
| offensive_avg_three_point_field_goals_attempted | numeric   |
| offensive_avg_free_throws_made                  | numeric   |
| offensive_avg_free_throws_attempted             | numeric   |
| offensive_avg_points                            | numeric   |
| offensive_avg_offensive_rebounds                | numeric   |
| offensive_avg_assists                           | numeric   |
| offensive_avg_turnovers                         | numeric   |
| offensive_offensive_rebound_pct                 | numeric   |
| offensive_estimated_possessions                 | numeric   |
| offensive_avg_estimated_possessions             | numeric   |
| offensive_points_per_estimated_possessions      | numeric   |
| offensive_avg_team_turnovers                    | numeric   |
| offensive_avg_total_turnovers                   | numeric   |
| offensive_three_point_field_goal_pct            | numeric   |
| offensive_two_point_field_goals_made            | numeric   |
| offensive_two_point_field_goals_attempted       | numeric   |
| offensive_avg_two_point_field_goals_made        | numeric   |
| offensive_avg_two_point_field_goals_attempted   | numeric   |
| offensive_two_point_field_goal_pct              | numeric   |
| offensive_shooting_efficiency                   | numeric   |
| offensive_scoring_efficiency                    | numeric   |
| team_id                                         | integer   |
| team_guid                                       | character |
| team_uid                                        | character |
| team_sdr                                        | integer   |
| team_slug                                       | character |
| team_location                                   | character |
| team_name                                       | character |
| team_nickname                                   | character |
| team_abbreviation                               | character |
| team_display_name                               | character |
| team_short_display_name                         | character |
| team_color                                      | character |
| team_alternate_color                            | character |
| is_active                                       | logical   |
| is_all_star                                     | logical   |
| logo_href                                       | character |
| logo_dark_href                                  | character |

## See also

Other ESPN MBB Functions:
[`espn_mbb_betting()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_betting.md),
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
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
try(espn_mbb_player_stats(athlete_id = 4433134, year = 2021))
#> ── ESPN MBB Player Season Stats from ESPN.com ─────────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-24 01:20:29 UTC
#> # A tibble: 1 × 214
#>   athlete_id athlete_uid   athlete_guid athlete_type    sdr first_name last_name
#>        <int> <chr>         <chr>        <chr>         <int> <chr>      <chr>    
#> 1    4433134 s:40~l:41~a:… dd0bb1da-07… basketball   4.43e6 Scottie    Barnes   
#> # ℹ 207 more variables: full_name <chr>, display_name <chr>, short_name <chr>,
#> #   weight <dbl>, display_weight <chr>, height <dbl>, display_height <chr>,
#> #   age <int>, date_of_birth <chr>, birth_place_city <chr>,
#> #   birth_place_state <chr>, birth_place_country <chr>,
#> #   birth_country_alternate_id <chr>, birth_country_abbreviation <chr>,
#> #   slug <chr>, headshot_href <chr>, headshot_alt <chr>, jersey <chr>,
#> #   flag_href <chr>, flag_alt <chr>, flag_x_country_flag <chr>, …
# }
```
