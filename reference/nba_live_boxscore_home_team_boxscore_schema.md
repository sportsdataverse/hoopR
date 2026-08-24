# Shared column schema: nba live boxscore home team boxscore schema

Columns shared verbatim across: nba_live_boxscore, nbagl_live_boxscore.

## Details

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
