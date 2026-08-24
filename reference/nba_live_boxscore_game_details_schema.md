# Shared column schema: nba live boxscore game details schema

Columns shared verbatim across: nba_live_boxscore, nbagl_live_boxscore.

## Details

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
