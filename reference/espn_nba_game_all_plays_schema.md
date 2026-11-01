# Shared column schema: espn nba game all plays schema

Columns shared verbatim across: espn_nba_game_all, espn_nba_pbp.

## Details

|  |  |  |
|----|----|----|
| col_name | types | description |
| id | character | ESPN play id. Character so the 18-digit MBB ids stay exact (a double cannot hold them). |
| sequence_number | character | Sequence number representing a shot-possession (V3 PBP). |
| text | character | Text description of the play / record. |
| away_score | integer | Away team score after the play. Rebuilt from the scoring plays in feed order when that reaches the official final (score_source 'rebuilt'), otherwise ESPN's per-play value (score_source 'espn'). |
| home_score | integer | Home team score after the play. Rebuilt from the scoring plays in feed order when that reaches the official final (score_source 'rebuilt'), otherwise ESPN's per-play value (score_source 'espn'). |
| scoring_play | logical | TRUE if the play resulted in points scored. |
| score_value | integer | Point value of the play (2 / 3 / 1). |
| wallclock | character | Wallclock. |
| shooting_play | logical | TRUE if the play was a shooting attempt. |
| type_id | integer | Type identifier (numeric). |
| type_text | character | Display text for the type field. |
| period_number | integer | Numeric period (1-4 for quarters; 5+ for OT). |
| period_display_value | character | Period display label (e.g. '1st Quarter', 'OT'). |
| clock_display_value | character | Game clock display string (e.g. '8:32'). |
| team_id | integer | Unique team identifier. |
| coordinate_x_raw | numeric | X coordinate as returned by the API before any adjustment. |
| coordinate_y_raw | numeric | Y coordinate as returned by the API before any adjustment. |
| coordinate_x | numeric | X coordinate on the court (half-court layout). |
| coordinate_y | numeric | Y coordinate on the court (half-court layout). |
| play_id | character | Unique play identifier within a game. |
| athlete_id_1 | integer | Primary athlete identifier (e.g. shooter). |
| athlete_id_2 | integer | Secondary athlete identifier (e.g. assister / fouler). |
| athlete_id_3 | integer | Athlete id 3. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_mascot | character | Home team mascot. |
| home_team_name | character | Home team name. |
| home_team_abbrev | character | Home team three-letter abbreviation. |
| home_team_logo | character | Home team logo URL. |
| home_team_logo_dark | character | Home team logo URL for dark backgrounds. |
| home_team_full_name | character | Full home team name (e.g. 'Las Vegas Aces'). |
| home_team_color | character | Home team primary color (hex). |
| home_team_alternate_color | character | Home team alternate color (hex). |
| home_team_score | integer | Home team's score. |
| home_team_winner | logical | TRUE if the home team won this game. |
| home_team_record | character | Home team's win-loss record. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_mascot | character | Away team mascot. |
| away_team_name | character | Away team name. |
| away_team_abbrev | character | Away team three-letter abbreviation. |
| away_team_logo | character | Away team logo URL. |
| away_team_logo_dark | character | Away team logo URL for dark backgrounds. |
| away_team_full_name | character | Full away team name (e.g. 'Las Vegas Aces'). |
| away_team_color | character | Away team primary color (hex). |
| away_team_alternate_color | character | Away team alternate color (hex). |
| away_team_score | integer | Away team's score. |
| away_team_winner | logical | TRUE if the away team won this game. |
| away_team_record | character | Away team's win-loss record. |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| game_play_number | integer | 1-based position of the play in the game's play array. |
| home_timeout_called | logical | TRUE on a team timeout the home team called (the play's team_id; a play without one, a home team name as a whole word in the text). |
| away_timeout_called | logical | TRUE on a team timeout the away team called (the play's team_id; a play without one, an away team name as a whole word in the text). |
| qtr | integer | Quarter (the period number; 5+ is overtime). |
| time | character | Game clock as MM:SS (a bare sub-minute clock such as '23.4' reads 0:23.4). |
| clock_minutes | integer | Minutes on the game clock. |
| clock_seconds | numeric | Seconds on the game clock, tenths included. |
| half | integer | Half: 1 for quarters 1-2, 2 after. |
| game_half | integer | Same as half. |
| lag_qtr | integer | Previous play's quarter. |
| lead_qtr | integer | Next play's quarter. |
| lag_half | integer | Previous play's half. |
| lead_half | integer | Next play's half. |
| start_quarter_seconds_remaining | numeric | Seconds left in the quarter at the start of the play. |
| start_half_seconds_remaining | numeric | Seconds left in the half at the start of the play (overtime: in the period). |
| start_game_seconds_remaining | numeric | Seconds left in regulation at the start of the play (overtime: in the period). |
| end_quarter_seconds_remaining | numeric | Seconds left in the quarter at the end of the play (the next play's start; 0 on a quarter's last play, NA on the game's last). |
| end_half_seconds_remaining | numeric | Seconds left in the half at the end of the play (the next play's start: Q1's last play ends at 720, Q2's at 0; NA on the game's last). |
| end_game_seconds_remaining | numeric | Seconds left in regulation at the end of the play (NA on the game's last). |
| period | integer | Same as qtr. |
| score_source | character | Where this game's home_score/away_score come from: 'rebuilt' (summed from the scoring plays and equal to the official final on the last play) or 'espn' (ESPN's per-play values, kept when the rebuild misses the final or the game has no final). |
