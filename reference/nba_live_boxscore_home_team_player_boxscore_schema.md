# Shared column schema: nba live boxscore home team player boxscore schema

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
