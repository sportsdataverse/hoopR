# **Get NBA Stats API Live Boxscore**

**Get NBA Stats API Live Boxscore**

**Get NBA Stats API Live Boxscore**

## Usage

``` r
nba_live_boxscore(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: game_details, arena, officials,
home_team_boxscore, away_team_boxscore, home_team_player_boxscore,
away_team_player_boxscore, home_team_linescores, away_team_linescores

**game_details**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| game_time_local | character | Game time local. |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| game_time_home | character | Game time home. |
| game_time_away | character | Game time away. |
| game_et | character | Game et. |
| duration | integer | Duration. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| game_status | integer | Game status label. |
| regulation_periods | integer | Regulation periods. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| game_clock | character | Game clock. |
| attendance | integer | Reported attendance. |
| sellout | character | Sellout. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_city | character | Home team city / location. |
| home_team_tricode | character | Home team three-letter code. |
| home_team_score | integer | Home team's score. |
| home_team_in_bonus | character | Home team's team in bonus. |
| home_team_timeouts_remaining | integer | Home team's team timeouts remaining. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_city | character | Away team city / location. |
| away_team_tricode | character | Away team three-letter code. |
| away_team_score | integer | Away team's score. |
| away_team_in_bonus | character | Away team's team in bonus. |
| away_team_timeouts_remaining | integer | Away team's team timeouts remaining. |

**arena**

|                |           |                              |
|----------------|-----------|------------------------------|
| col_name       | types     | description                  |
| arena_id       | integer   | Unique identifier for arena. |
| arena_name     | character | Arena name.                  |
| arena_city     | character | Arena city.                  |
| arena_state    | character | Arena state.                 |
| arena_country  | character | Arena country.               |
| arena_timezone | character | Arena timezone.              |

**officials**

|             |           |                                          |
|-------------|-----------|------------------------------------------|
| col_name    | types     | description                              |
| person_id   | integer   | Unique player identifier (V3 endpoints). |
| name        | character | Display name.                            |
| name_i      | character | Initialed name (e.g. 'A. Wilson').       |
| first_name  | character | Player's first name.                     |
| family_name | character | Player's family / last name.             |
| jersey_num  | character | Jersey number worn by the player.        |
| assignment  | character | Assignment.                              |

**home_team_boxscore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_score | integer | Team's score / final score. |
| team_in_bonus | character | Team in bonus. |
| team_timeouts_remaining | integer | Team timeouts remaining. |
| assists | integer | Total assists. |
| assists_turnover_ratio | numeric | Assists turnover ratio. |
| bench_points | integer | Points scored by the bench. |
| biggest_lead | integer | Biggest lead. |
| biggest_lead_score | character | Biggest lead score. |
| biggest_scoring_run | integer | Biggest scoring run. |
| biggest_scoring_run_score | character | Biggest scoring run score. |
| blocks | integer | Total blocks. |
| blocks_received | integer | Shots blocked by opponents while attempting. |
| fast_break_points_attempted | integer | Number of fast break points attempted. |
| fast_break_points_made | integer | Number of fast break points made. |
| fast_break_points_percentage | numeric | Fast break points percentage (0-1 decimal). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_effective_adjusted | numeric | Field goals effective adjusted. |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| fouls_offensive | integer | Offensive fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |
| fouls_personal | integer | Personal fouls. |
| fouls_team | integer | Fouls team. |
| fouls_technical | integer | Technical fouls. |
| fouls_team_technical | integer | Fouls team technical. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| lead_changes | integer | Lead changes. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| minutes_calculated | character | Minutes calculated from game-clock differences. |
| points | integer | Points scored. |
| points_against | integer | Points allowed. |
| points_fast_break | integer | Fast-break points scored. |
| points_from_turnovers | integer | Points from turnovers. |
| points_in_the_paint | integer | Points in the paint. |
| points_in_the_paint_attempted | integer | Number of points in the paint attempted. |
| points_in_the_paint_made | integer | Number of points in the paint made. |
| points_in_the_paint_percentage | numeric | Points in the paint percentage (0-1 decimal). |
| points_second_chance | integer | Second-chance points scored. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_personal | integer | Rebounds personal. |
| rebounds_team | integer | Rebounds team. |
| rebounds_team_defensive | integer | Rebounds team defensive. |
| rebounds_team_offensive | integer | Rebounds team offensive. |
| rebounds_total | integer | Total rebounds. |
| second_chance_points_attempted | integer | Number of second chance points attempted. |
| second_chance_points_made | integer | Number of second chance points made. |
| second_chance_points_percentage | numeric | Second chance points percentage (0-1 decimal). |
| steals | integer | Total steals. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| time_leading | character | Time leading. |
| times_tied | integer | Times tied. |
| true_shooting_attempts | numeric | Number of true shooting attempted. |
| true_shooting_percentage | numeric | True shooting percentage (0-1). |
| turnovers | integer | Total turnovers. |
| turnovers_team | integer | Turnovers team. |
| turnovers_total | integer | Turnovers total. |
| two_pointers_attempted | integer | Number of two pointers attempted. |
| two_pointers_made | integer | Number of two pointers made. |
| two_pointers_percentage | numeric | Two pointers percentage (0-1 decimal). |

**away_team_boxscore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_score | integer | Team's score / final score. |
| team_in_bonus | character | Team in bonus. |
| team_timeouts_remaining | integer | Team timeouts remaining. |
| assists | integer | Total assists. |
| assists_turnover_ratio | numeric | Assists turnover ratio. |
| bench_points | integer | Points scored by the bench. |
| biggest_lead | integer | Biggest lead. |
| biggest_lead_score | character | Biggest lead score. |
| biggest_scoring_run | integer | Biggest scoring run. |
| biggest_scoring_run_score | character | Biggest scoring run score. |
| blocks | integer | Total blocks. |
| blocks_received | integer | Shots blocked by opponents while attempting. |
| fast_break_points_attempted | integer | Number of fast break points attempted. |
| fast_break_points_made | integer | Number of fast break points made. |
| fast_break_points_percentage | numeric | Fast break points percentage (0-1 decimal). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_effective_adjusted | numeric | Field goals effective adjusted. |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| fouls_offensive | integer | Offensive fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |
| fouls_personal | integer | Personal fouls. |
| fouls_team | integer | Fouls team. |
| fouls_technical | integer | Technical fouls. |
| fouls_team_technical | integer | Fouls team technical. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| lead_changes | integer | Lead changes. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| minutes_calculated | character | Minutes calculated from game-clock differences. |
| points | integer | Points scored. |
| points_against | integer | Points allowed. |
| points_fast_break | integer | Fast-break points scored. |
| points_from_turnovers | integer | Points from turnovers. |
| points_in_the_paint | integer | Points in the paint. |
| points_in_the_paint_attempted | integer | Number of points in the paint attempted. |
| points_in_the_paint_made | integer | Number of points in the paint made. |
| points_in_the_paint_percentage | numeric | Points in the paint percentage (0-1 decimal). |
| points_second_chance | integer | Second-chance points scored. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_personal | integer | Rebounds personal. |
| rebounds_team | integer | Rebounds team. |
| rebounds_team_defensive | integer | Rebounds team defensive. |
| rebounds_team_offensive | integer | Rebounds team offensive. |
| rebounds_total | integer | Total rebounds. |
| second_chance_points_attempted | integer | Number of second chance points attempted. |
| second_chance_points_made | integer | Number of second chance points made. |
| second_chance_points_percentage | numeric | Second chance points percentage (0-1 decimal). |
| steals | integer | Total steals. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| time_leading | character | Time leading. |
| times_tied | integer | Times tied. |
| true_shooting_attempts | numeric | Number of true shooting attempted. |
| true_shooting_percentage | numeric | True shooting percentage (0-1). |
| turnovers | integer | Total turnovers. |
| turnovers_team | integer | Turnovers team. |
| turnovers_total | integer | Turnovers total. |
| two_pointers_attempted | integer | Number of two pointers attempted. |
| two_pointers_made | integer | Number of two pointers made. |
| two_pointers_percentage | numeric | Two pointers percentage (0-1 decimal). |

**home_team_player_boxscore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_score | integer | Team's score / final score. |
| team_in_bonus | character | Team in bonus. |
| team_timeouts_remaining | integer | Team timeouts remaining. |
| status | character | Status label. |
| order | integer | Display order within the result set. |
| person_id | integer | Unique player identifier (V3 endpoints). |
| jersey_num | character | Jersey number worn by the player. |
| position | character | Listed roster position (G, F, C, etc.). |
| starter | character | TRUE if the player was in the starting lineup; FALSE otherwise. |
| oncourt | character | Oncourt. |
| played | character | Played. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| blocks_received | integer | Shots blocked by opponents while attempting. |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| fouls_offensive | integer | Offensive fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |
| fouls_personal | integer | Personal fouls. |
| fouls_technical | integer | Technical fouls. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| minus | numeric | Minus. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| minutes_calculated | character | Minutes calculated from game-clock differences. |
| plus | numeric | Plus. |
| plus_minus_points | numeric | Plus/minus point differential while on court. |
| points | integer | Points scored. |
| points_fast_break | integer | Fast-break points scored. |
| points_in_the_paint | integer | Points in the paint. |
| points_second_chance | integer | Second-chance points scored. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| steals | integer | Total steals. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| turnovers | integer | Total turnovers. |
| two_pointers_attempted | integer | Number of two pointers attempted. |
| two_pointers_made | integer | Number of two pointers made. |
| two_pointers_percentage | numeric | Two pointers percentage (0-1 decimal). |
| name | character | Display name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| not_playing_reason | character | Not playing reason. |
| not_playing_description | character | Not playing description. |

**away_team_player_boxscore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_score | integer | Team's score / final score. |
| team_in_bonus | character | Team in bonus. |
| team_timeouts_remaining | integer | Team timeouts remaining. |
| status | character | Status label. |
| order | integer | Display order within the result set. |
| person_id | integer | Unique player identifier (V3 endpoints). |
| jersey_num | character | Jersey number worn by the player. |
| position | character | Listed roster position (G, F, C, etc.). |
| starter | character | TRUE if the player was in the starting lineup; FALSE otherwise. |
| oncourt | character | Oncourt. |
| played | character | Played. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| blocks_received | integer | Shots blocked by opponents while attempting. |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| fouls_offensive | integer | Offensive fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |
| fouls_personal | integer | Personal fouls. |
| fouls_technical | integer | Technical fouls. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| minus | numeric | Minus. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| minutes_calculated | character | Minutes calculated from game-clock differences. |
| plus | numeric | Plus. |
| plus_minus_points | numeric | Plus/minus point differential while on court. |
| points | integer | Points scored. |
| points_fast_break | integer | Fast-break points scored. |
| points_in_the_paint | integer | Points in the paint. |
| points_second_chance | integer | Second-chance points scored. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| steals | integer | Total steals. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| turnovers | integer | Total turnovers. |
| two_pointers_attempted | integer | Number of two pointers attempted. |
| two_pointers_made | integer | Number of two pointers made. |
| two_pointers_percentage | numeric | Two pointers percentage (0-1 decimal). |
| name | character | Display name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| not_playing_reason | character | Not playing reason. |
| not_playing_description | character | Not playing description. |

**home_team_linescores**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| period      | integer   | Period of the game (1-4 quarters; 5+ for OT). |
| period_type | character | Period type.                                  |
| score       | integer   | Final score.                                  |

**away_team_linescores**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| period      | integer   | Period of the game (1-4 quarters; 5+ for OT). |
| period_type | character | Period type.                                  |
| score       | integer   | Final score.                                  |

## Details

     nba_live_boxscore(game_id = "0022201086")

## See also

Other NBA Boxscore Functions:
[`nba_boxscoreadvancedv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv2.md),
[`nba_boxscoredefensive()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensive.md),
[`nba_boxscorefourfactorsv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv2.md),
[`nba_boxscorematchups()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchups.md),
[`nba_boxscoremiscv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv2.md),
[`nba_boxscoreplayertrackv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv2.md),
[`nba_boxscorescoringv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv2.md),
[`nba_boxscoresummaryv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv2.md),
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_boxscoreusagev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev2.md),
[`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md),
[`nba_hustlestatsboxscore()`](https://hoopR.sportsdataverse.org/reference/nba_hustlestatsboxscore.md)

Other NBA Live Functions:
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
