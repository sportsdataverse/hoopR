# **Get ESPN men's college basketball data (Pbp, Team and Player Box)**

**Get ESPN men's college basketball data (Pbp, Team and Player Box)**

**Get ESPN men's college basketball PBP data**

**Get ESPN men's college basketball team box scores**

**Get ESPN men's college basketball player box scores**

**Get ESPN men's college basketball game rosters**

**Get ESPN MBB's Betting information**

**Get ESPN NBA game data (Pbp, Team and Player Box)**

**Get ESPN NBA PBP data**

**Get ESPN NBA team box scores**

**Get ESPN NBA player box scores**

**Get ESPN NBA game rosters**

**Get ESPN NBA's Betting information**

## Usage

``` r
espn_mbb_game_all(game_id)

espn_mbb_pbp(game_id)

espn_mbb_team_box(game_id)

espn_mbb_player_box(game_id)

espn_mbb_game_rosters(game_id)

espn_mbb_betting(game_id)

espn_nba_game_all(game_id)

espn_nba_pbp(game_id)

espn_nba_team_box(game_id)

espn_nba_player_box(game_id)

espn_nba_game_rosters(game_id)

espn_nba_betting(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

A named list of `hoopR_data` tibbles: `Plays`, `Team`, `Player`.

**Plays**

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
| half | integer | Half (the period number; 3+ is overtime). |
| time | character | Game clock display string, as ESPN ships it. |
| clock_minutes | integer | Minutes on the game clock. |
| clock_seconds | integer | Whole seconds on the game clock. |
| lag_period | integer | Previous play's period number. |
| lead_period | integer | Next play's period number. |
| lag_half | integer | Previous play's half. |
| lead_half | integer | Next play's half. |
| start_period_seconds_remaining | integer | Seconds left in the period at the start of the play. |
| start_game_seconds_remaining | integer | Seconds left in regulation at the start of the play (overtime: in the period). |
| end_period_seconds_remaining | integer | Seconds left in the period at the end of the play (the next play's start; 0 on a period's last play, NA on the game's last). |
| end_game_seconds_remaining | integer | Seconds left in regulation at the end of the play (the next play's start; NA on the game's last). |
| score_source | character | Where this game's home_score/away_score come from: 'rebuilt' (summed from the scoring plays and equal to the official final on the last play) or 'espn' (ESPN's per-play values, kept when the rebuild misses the final or the game has no final). |

**Team**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| team_id | integer | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| team_home_away | character | Team home away. |
| team_score | integer | Team's score / final score. |
| team_winner | logical | TRUE if the team won this game. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| defensive_rebounds | integer | Defensive rebounds. |
| field_goal_pct | numeric | Field goal percentage (0-1). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| flagrant_fouls | integer | Total flagrant fouls. |
| fouls | integer | Personal fouls. |
| free_throw_pct | numeric | Free throw percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| largest_lead | character | Largest lead during the game. |
| offensive_rebounds | integer | Offensive rebounds. |
| steals | integer | Total steals. |
| team_turnovers | integer | Team turnovers (turnovers credited to the team rather than a player). |
| technical_fouls | integer | Total technical fouls. |
| three_point_field_goal_pct | numeric | Three-point field goal percentage (0-1). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| total_rebounds | integer | Total rebounds. |
| total_technical_fouls | integer | Total technical fouls (player + team). |
| total_turnovers | integer | Total turnovers (player + team). |
| turnovers | integer | Total turnovers. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_uid | character | Opponent team uid. |
| opponent_team_slug | character | Opponent team slug. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_short_display_name | character | Opponent team short display name. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_score | integer | Opponent team's score. |

**Player**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_display_name | character | Athlete display name (full). |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_location | character | Team city or location string. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| minutes | numeric | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| offensive_rebounds | integer | Offensive rebounds. |
| defensive_rebounds | integer | Defensive rebounds. |
| rebounds | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls | integer | Personal fouls. |
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| athlete_jersey | character | Athlete jersey number. |
| athlete_short_name | character | Athlete short display name. |
| athlete_headshot_href | character | Athlete headshot image URL. |
| athlete_position_name | character | Athlete position ('Guard', 'Forward', 'Center'). |
| athlete_position_abbreviation | character | Athlete position abbreviation (G / F / C). |
| team_display_name | character | Full team display name. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_logo | character | Team logo image URL. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| home_away | character | Game venue label ('home' or 'away'). |
| team_winner | logical | TRUE if the team won this game. |
| team_score | integer | Team's score / final score. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_score | integer | Opponent team's score. |

A named list of `hoopR_data` tibbles: `Plays`.

**Plays**

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
| half | integer | Half (the period number; 3+ is overtime). |
| time | character | Game clock display string, as ESPN ships it. |
| clock_minutes | integer | Minutes on the game clock. |
| clock_seconds | integer | Whole seconds on the game clock. |
| lag_period | integer | Previous play's period number. |
| lead_period | integer | Next play's period number. |
| lag_half | integer | Previous play's half. |
| lead_half | integer | Next play's half. |
| start_period_seconds_remaining | integer | Seconds left in the period at the start of the play. |
| start_game_seconds_remaining | integer | Seconds left in regulation at the start of the play (overtime: in the period). |
| end_period_seconds_remaining | integer | Seconds left in the period at the end of the play (the next play's start; 0 on a period's last play, NA on the game's last). |
| end_game_seconds_remaining | integer | Seconds left in regulation at the end of the play (the next play's start; NA on the game's last). |
| score_source | character | Where this game's home_score/away_score come from: 'rebuilt' (summed from the scoring plays and equal to the official final on the last play) or 'espn' (ESPN's per-play values, kept when the rebuild misses the final or the game has no final). |

A named list of `hoopR_data` tibbles: `Team`.

**Team**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| team_id | integer | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| team_home_away | character | Team home away. |
| team_score | integer | Team's score / final score. |
| team_winner | logical | TRUE if the team won this game. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| defensive_rebounds | integer | Defensive rebounds. |
| field_goal_pct | numeric | Field goal percentage (0-1). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| flagrant_fouls | integer | Total flagrant fouls. |
| fouls | integer | Personal fouls. |
| free_throw_pct | numeric | Free throw percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| largest_lead | character | Largest lead during the game. |
| offensive_rebounds | integer | Offensive rebounds. |
| steals | integer | Total steals. |
| team_turnovers | integer | Team turnovers (turnovers credited to the team rather than a player). |
| technical_fouls | integer | Total technical fouls. |
| three_point_field_goal_pct | numeric | Three-point field goal percentage (0-1). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| total_rebounds | integer | Total rebounds. |
| total_technical_fouls | integer | Total technical fouls (player + team). |
| total_turnovers | integer | Total turnovers (player + team). |
| turnovers | integer | Total turnovers. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_uid | character | Opponent team uid. |
| opponent_team_slug | character | Opponent team slug. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_short_display_name | character | Opponent team short display name. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_score | integer | Opponent team's score. |

A named list of `hoopR_data` tibbles: `Player`.

**Player**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_display_name | character | Athlete display name (full). |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_location | character | Team city or location string. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| minutes | numeric | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| offensive_rebounds | integer | Offensive rebounds. |
| defensive_rebounds | integer | Defensive rebounds. |
| rebounds | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls | integer | Personal fouls. |
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| athlete_jersey | character | Athlete jersey number. |
| athlete_short_name | character | Athlete short display name. |
| athlete_headshot_href | character | Athlete headshot image URL. |
| athlete_position_name | character | Athlete position ('Guard', 'Forward', 'Center'). |
| athlete_position_abbreviation | character | Athlete position abbreviation (G / F / C). |
| team_display_name | character | Full team display name. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_logo | character | Team logo image URL. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| home_away | character | Game venue label ('home' or 'away'). |
| team_winner | logical | TRUE if the team won this game. |
| team_score | integer | Team's score / final score. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_score | integer | Opponent team's score. |

A `hoopR_data` tibble with one row per athlete on a game roster.

|  |  |  |
|----|----|----|
| col_name | types | description |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_uid | character | ESPN athlete UID (universal identifier). |
| athlete_guid | character | ESPN athlete GUID. |
| athlete_type | character | Athlete type / class. |
| sdr | integer | Sdr. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| full_name | character | Player's full name. |
| athlete_display_name | character | Athlete display name (full). |
| short_name | character | Short display name. |
| weight | integer | Player weight in pounds. |
| display_weight | character | Player weight in display format (e.g. '180 lbs'). |
| height | integer | Player height (string e.g. '6-2' or inches). |
| display_height | character | Player height in display format (e.g. '6-2'). |
| age | integer | Player age (in years). |
| date_of_birth | character | Date of birth (YYYY-MM-DD). |
| birth_place_city | character | Birth place city. |
| birth_place_state | character | Birth place state. |
| birth_place_country | character | Birth place country. |
| slug | character | URL-safe identifier. |
| headshot_href | character | Headshot image URL. |
| headshot_alt | character | Alternative-text label for the headshot. |
| jersey | character | Jersey number worn by the player. |
| hand_type | character | Hand type. |
| hand_abbreviation | character | Hand abbreviation. |
| hand_display_value | character | Hand display value. |
| position_id | integer | Unique position identifier. |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| position_display_name | character | Position display name. |
| position_abbreviation | character | Position abbreviation ('G' / 'F' / 'C'). |
| position_leaf | logical | Position leaf. |
| linked | logical | TRUE if the record is linked to a related entity. |
| experience_years | integer | Experience years. |
| experience_display_value | character | Experience display value. |
| experience_abbreviation | character | Experience abbreviation. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| draft_display_text | character | Draft display text. |
| draft_round | integer | Round of the draft selection. |
| draft_year | integer | Draft year (4-digit). |
| draft_selection | integer | Draft selection. |
| status_id | integer | Status identifier. |
| status_name | character | Status label. |
| status_type | character | Status type. |
| status_abbreviation | character | Status abbreviation. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| valid | logical | Valid. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| display_name | character | Display name. |
| ejected | logical | TRUE if the player was ejected from the game. |
| team_id | integer | Unique team identifier. |
| team_guid | character | ESPN team GUID. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_sdr | integer | ESPN team SDR identifier. |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_nickname | character | Team nickname. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| is_active | logical | Is active. |
| is_all_star | logical | Is all star. |
| logo_href | character | Team or league logo URL. |
| logo_dark_href | character | Logo URL for dark backgrounds. |
| game_id | integer | Unique game identifier. |
| order | integer | Display order within the result set. |
| home_away | character | Game venue label ('home' or 'away'). |
| winner | logical | Winner. |
| roster_href | character | URL for roster. |

A named list of `hoopR_data` tibbles: `pickcenter`, `againstTheSpread`,
`predictor`.

**pickcenter**

|  |  |  |
|----|----|----|
| col_name | types | description |
| details | character | Details. |
| over_under | numeric | Over under. |
| spread | numeric | Spread. |
| provider_id | integer | Unique identifier for provider. |
| provider_name | character | Provider name. |
| provider_priority | integer | Provider priority. |
| away_team_odds_favorite | logical | Away team's team odds favorite. |
| away_team_odds_underdog | logical | Away team's team odds underdog. |
| away_team_odds_money_line | integer | Away team's team odds money line. |
| away_team_odds_spread_odds | numeric | Away team's team odds spread odds. |
| away_team_odds_team_id | integer | Unique identifier for away team odds team. |
| away_team_odds_win_percentage | numeric | Away team odds win percentage (0-1 decimal). |
| away_team_odds_average_score | numeric | Away team's team odds average score. |
| away_team_odds_money_line_odds | numeric | Away team's team odds money line odds. |
| away_team_odds_spread_return | numeric | Away team's team odds spread return. |
| away_team_odds_spread_record_wins | integer | Away team's team odds spread record wins. |
| away_team_odds_spread_record_losses | integer | Away team's team odds spread record losses. |
| away_team_odds_spread_record_pushes | integer | Away team's team odds spread record pushes. |
| away_team_odds_spread_record_summary | character | Away team's team odds spread record summary. |
| home_team_odds_favorite | logical | Home team's team odds favorite. |
| home_team_odds_underdog | logical | Home team's team odds underdog. |
| home_team_odds_money_line | integer | Home team's team odds money line. |
| home_team_odds_spread_odds | numeric | Home team's team odds spread odds. |
| home_team_odds_team_id | integer | Unique identifier for home team odds team. |
| home_team_odds_win_percentage | numeric | Home team odds win percentage (0-1 decimal). |
| home_team_odds_average_score | numeric | Home team's team odds average score. |
| home_team_odds_money_line_odds | numeric | Home team's team odds money line odds. |
| home_team_odds_spread_return | numeric | Home team's team odds spread return. |
| home_team_odds_spread_record_wins | integer | Home team's team odds spread record wins. |
| home_team_odds_spread_record_losses | integer | Home team's team odds spread record losses. |
| home_team_odds_spread_record_pushes | integer | Home team's team odds spread record pushes. |
| home_team_odds_spread_record_summary | character | Home team's team odds spread record summary. |
| game_id | integer | Unique game identifier. |

**againstTheSpread**

|              |           |                                         |
|--------------|-----------|-----------------------------------------|
| col_name     | types     | description                             |
| id           | integer   | Id.                                     |
| uid          | character | ESPN UID string (universal identifier). |
| display_name | character | Display name.                           |
| abbreviation | character | Short abbreviation.                     |
| logo         | character | Team or league logo URL.                |
| logos        | list      | Logos.                                  |
| records      | list      | Records.                                |
| game_id      | integer   | Unique game identifier.                 |
| team_id      | integer   | Unique team identifier.                 |

**predictor**

|                           |         |                                      |
|---------------------------|---------|--------------------------------------|
| col_name                  | types   | description                          |
| game_id                   | integer | Unique game identifier.              |
| home_team_id              | integer | Unique identifier for the home team. |
| away_team_id              | integer | Unique identifier for the away team. |
| away_team_game_projection | numeric | Away team's team game projection.    |
| away_team_chance_loss     | numeric | Away team's team chance loss.        |

A named list of `hoopR_data` tibbles: `Plays`, `Team`, `Player`.

**Plays**

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

**Team**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| team_id | integer | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| team_home_away | character | Team home away. |
| team_score | integer | Team's score / final score. |
| team_winner | logical | TRUE if the team won this game. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| defensive_rebounds | integer | Defensive rebounds. |
| fast_break_points | character | Fast-break points scored. |
| field_goal_pct | numeric | Field goal percentage (0-1). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| flagrant_fouls | integer | Total flagrant fouls. |
| fouls | integer | Personal fouls. |
| free_throw_pct | numeric | Free throw percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| largest_lead | character | Largest lead during the game. |
| offensive_rebounds | integer | Offensive rebounds. |
| points_in_paint | character | Points scored in the paint. |
| steals | integer | Total steals. |
| team_turnovers | integer | Team turnovers (turnovers credited to the team rather than a player). |
| technical_fouls | integer | Total technical fouls. |
| three_point_field_goal_pct | numeric | Three-point field goal percentage (0-1). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| total_rebounds | integer | Total rebounds. |
| total_technical_fouls | integer | Total technical fouls (player + team). |
| total_turnovers | integer | Total turnovers (player + team). |
| turnover_points | character | Turnover points. |
| turnovers | integer | Total turnovers. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_uid | character | Opponent team uid. |
| opponent_team_slug | character | Opponent team slug. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_short_display_name | character | Opponent team short display name. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_score | integer | Opponent team's score. |

**Player**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_display_name | character | Athlete display name (full). |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_location | character | Team city or location string. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| minutes | numeric | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| offensive_rebounds | integer | Offensive rebounds. |
| defensive_rebounds | integer | Defensive rebounds. |
| rebounds | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls | integer | Personal fouls. |
| plus_minus | character | Plus/minus point differential while on court. |
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| reason | character | Reason. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| athlete_jersey | character | Athlete jersey number. |
| athlete_short_name | character | Athlete short display name. |
| athlete_headshot_href | character | Athlete headshot image URL. |
| athlete_position_name | character | Athlete position ('Guard', 'Forward', 'Center'). |
| athlete_position_abbreviation | character | Athlete position abbreviation (G / F / C). |
| team_display_name | character | Full team display name. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_logo | character | Team logo image URL. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| home_away | character | Game venue label ('home' or 'away'). |
| team_winner | logical | TRUE if the team won this game. |
| team_score | integer | Team's score / final score. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_score | integer | Opponent team's score. |

A named list of `hoopR_data` tibbles: `Plays`.

**Plays**

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

A named list of `hoopR_data` tibbles: `Team`.

**Team**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| team_id | integer | Unique team identifier. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_logo | character | Team logo image URL. |
| team_home_away | character | Team home away. |
| team_score | integer | Team's score / final score. |
| team_winner | logical | TRUE if the team won this game. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| defensive_rebounds | integer | Defensive rebounds. |
| fast_break_points | character | Fast-break points scored. |
| field_goal_pct | numeric | Field goal percentage (0-1). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| flagrant_fouls | integer | Total flagrant fouls. |
| fouls | integer | Personal fouls. |
| free_throw_pct | numeric | Free throw percentage (0-1). |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| largest_lead | character | Largest lead during the game. |
| offensive_rebounds | integer | Offensive rebounds. |
| points_in_paint | character | Points scored in the paint. |
| steals | integer | Total steals. |
| team_turnovers | integer | Team turnovers (turnovers credited to the team rather than a player). |
| technical_fouls | integer | Total technical fouls. |
| three_point_field_goal_pct | numeric | Three-point field goal percentage (0-1). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| total_rebounds | integer | Total rebounds. |
| total_technical_fouls | integer | Total technical fouls (player + team). |
| total_turnovers | integer | Total turnovers (player + team). |
| turnover_points | character | Turnover points. |
| turnovers | integer | Total turnovers. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_uid | character | Opponent team uid. |
| opponent_team_slug | character | Opponent team slug. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_short_display_name | character | Opponent team short display name. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_score | integer | Opponent team's score. |

A named list of `hoopR_data` tibbles: `Player`.

**Player**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | integer | Unique game identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| game_date | Date | Game date (YYYY-MM-DD). |
| game_date_time | POSIXct | Game start date/time (ISO 8601). |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_display_name | character | Athlete display name (full). |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_location | character | Team city or location string. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| minutes | numeric | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| three_point_field_goals_made | integer | Three-point field goals made. |
| three_point_field_goals_attempted | integer | Three-point field goal attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_attempted | integer | Free throw attempts. |
| offensive_rebounds | integer | Offensive rebounds. |
| defensive_rebounds | integer | Defensive rebounds. |
| rebounds | integer | Total rebounds. |
| assists | integer | Total assists. |
| steals | integer | Total steals. |
| blocks | integer | Total blocks. |
| turnovers | integer | Total turnovers. |
| fouls | integer | Personal fouls. |
| plus_minus | character | Plus/minus point differential while on court. |
| points | integer | Points scored. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| ejected | logical | TRUE if the player was ejected from the game. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| reason | character | Reason. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| athlete_jersey | character | Athlete jersey number. |
| athlete_short_name | character | Athlete short display name. |
| athlete_headshot_href | character | Athlete headshot image URL. |
| athlete_position_name | character | Athlete position ('Guard', 'Forward', 'Center'). |
| athlete_position_abbreviation | character | Athlete position abbreviation (G / F / C). |
| team_display_name | character | Full team display name. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_logo | character | Team logo image URL. |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| home_away | character | Game venue label ('home' or 'away'). |
| team_winner | logical | TRUE if the team won this game. |
| team_score | integer | Team's score / final score. |
| opponent_team_id | integer | Unique identifier for the opponent team. |
| opponent_team_name | character | Opponent team display name. |
| opponent_team_location | character | Opponent team city / location. |
| opponent_team_display_name | character | Opponent team full display name. |
| opponent_team_abbreviation | character | Opponent team abbreviation. |
| opponent_team_logo | character | Opponent team logo URL. |
| opponent_team_color | character | Opponent team primary color (hex). |
| opponent_team_alternate_color | character | Opponent team alternate color (hex). |
| opponent_team_score | integer | Opponent team's score. |

A `hoopR_data` tibble with one row per athlete on a game roster.

|  |  |  |
|----|----|----|
| col_name | types | description |
| athlete_id | integer | Unique athlete identifier (ESPN). |
| athlete_uid | character | ESPN athlete UID (universal identifier). |
| athlete_guid | character | ESPN athlete GUID. |
| athlete_type | character | Athlete type / class. |
| sdr | integer | Sdr. |
| first_name | character | Player's first name. |
| last_name | character | Player's last name. |
| full_name | character | Player's full name. |
| athlete_display_name | character | Athlete display name (full). |
| short_name | character | Short display name. |
| weight | integer | Player weight in pounds. |
| display_weight | character | Player weight in display format (e.g. '180 lbs'). |
| height | integer | Player height (string e.g. '6-2' or inches). |
| display_height | character | Player height in display format (e.g. '6-2'). |
| age | integer | Player age (in years). |
| date_of_birth | character | Date of birth (YYYY-MM-DD). |
| debut_year | integer | Year of professional debut. |
| birth_place_city | character | Birth place city. |
| birth_place_state | character | Birth place state. |
| birth_place_country | character | Birth place country. |
| slug | character | URL-safe identifier. |
| headshot_href | character | Headshot image URL. |
| headshot_alt | character | Alternative-text label for the headshot. |
| jersey | character | Jersey number worn by the player. |
| position_id | integer | Unique position identifier. |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| position_display_name | character | Position display name. |
| position_abbreviation | character | Position abbreviation ('G' / 'F' / 'C'). |
| position_leaf | logical | Position leaf. |
| linked | logical | TRUE if the record is linked to a related entity. |
| years | integer | Years. |
| active | logical | TRUE if the row represents an active record (player / team / season). |
| contract_bird_status | integer | Contract bird status. |
| contract_active | logical | Contract active. |
| contract_active_1 | logical | Contract active 1. |
| contract_incoming_trade_value | integer | Contract incoming trade value. |
| contract_outgoing_trade_value | integer | Contract outgoing trade value. |
| contract_minimum_salary_exception | logical | Contract minimum salary exception. |
| contract_option_type | integer | Contract option type. |
| contract_salary | integer | Contract salary. |
| contract_salary_remaining | integer | Contract salary remaining. |
| contract_years_remaining | integer | Contract years remaining. |
| contract_trade_kicker_active | logical | Contract trade kicker active. |
| contract_trade_kicker_percentage | integer | Contract trade kicker percentage (0-1 decimal). |
| contract_trade_kicker_value | integer | Contract trade kicker value. |
| contract_trade_kicker_trade_value | integer | Contract trade kicker trade value. |
| contract_trade_restriction | logical | Contract trade restriction. |
| contract_unsigned_foreign_pick | logical | Contract unsigned foreign pick. |
| contract_active_2 | logical | Contract active 2. |
| draft_display_text | character | Draft display text. |
| draft_round | integer | Round of the draft selection. |
| draft_year | integer | Draft year (4-digit). |
| draft_selection | integer | Draft selection. |
| status_id | integer | Status identifier. |
| status_name | character | Status label. |
| status_type | character | Status type. |
| status_abbreviation | character | Status abbreviation. |
| starter | logical | TRUE if the player was in the starting lineup; FALSE otherwise. |
| valid | logical | Valid. |
| did_not_play | logical | TRUE if the player did not appear in the game. |
| display_name | character | Display name. |
| reason | character | Reason. |
| ejected | logical | TRUE if the player was ejected from the game. |
| team_id | integer | Unique team identifier. |
| team_guid | character | ESPN team GUID. |
| team_uid | character | ESPN universal team identifier (UID format 's:40~l:...~t:...'). |
| team_slug | character | URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). |
| team_location | character | Team city or location string. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_abbreviation | character | Short team abbreviation (e.g. 'LAS'). |
| team_display_name | character | Full team display name. |
| team_short_display_name | character | Short team display name (e.g. 'Aces'). |
| team_color | character | Team primary color (hex without leading '#'). |
| team_alternate_color | character | Team alternate color (hex without leading '#'). |
| team_is_active | logical | TRUE if the team is currently active. |
| team_is_all_star | logical | TRUE if the row represents an All-Star team. |
| logo_href | character | Team or league logo URL. |
| logo_dark_href | character | Logo URL for dark backgrounds. |
| logos_href_2 | character | Logos href 2. |
| logos_href_3 | character | Logos href 3. |
| game_id | integer | Unique game identifier. |
| order | integer | Display order within the result set. |
| home_away | character | Game venue label ('home' or 'away'). |
| winner | logical | Winner. |
| citizenship | character | Citizenship. |
| contract_base_year_compensation_active | logical | Contract base year compensation active. |
| contract_base_year_compensation_expiration | character | Contract base year compensation expiration. |
| hand_type | character | Hand type. |
| hand_abbreviation | character | Hand abbreviation. |
| hand_display_value | character | Hand display value. |

A named list of `hoopR_data` tibbles: `pickcenter`, `againstTheSpread`,
`predictor`.

**pickcenter**

|  |  |  |
|----|----|----|
| col_name | types | description |
| details | character | Details. |
| over_under | numeric | Over under. |
| spread | numeric | Spread. |
| provider_id | integer | Unique identifier for provider. |
| provider_name | character | Provider name. |
| provider_priority | integer | Provider priority. |
| away_team_odds_favorite | logical | Away team's team odds favorite. |
| away_team_odds_underdog | logical | Away team's team odds underdog. |
| away_team_odds_money_line | integer | Away team's team odds money line. |
| away_team_odds_spread_odds | numeric | Away team's team odds spread odds. |
| away_team_odds_team_id | integer | Unique identifier for away team odds team. |
| away_team_odds_win_percentage | numeric | Away team odds win percentage (0-1 decimal). |
| away_team_odds_average_score | numeric | Away team's team odds average score. |
| away_team_odds_money_line_odds | numeric | Away team's team odds money line odds. |
| away_team_odds_spread_return | numeric | Away team's team odds spread return. |
| away_team_odds_spread_record_wins | integer | Away team's team odds spread record wins. |
| away_team_odds_spread_record_losses | integer | Away team's team odds spread record losses. |
| away_team_odds_spread_record_pushes | integer | Away team's team odds spread record pushes. |
| away_team_odds_spread_record_summary | character | Away team's team odds spread record summary. |
| home_team_odds_favorite | logical | Home team's team odds favorite. |
| home_team_odds_underdog | logical | Home team's team odds underdog. |
| home_team_odds_money_line | integer | Home team's team odds money line. |
| home_team_odds_spread_odds | numeric | Home team's team odds spread odds. |
| home_team_odds_team_id | integer | Unique identifier for home team odds team. |
| home_team_odds_win_percentage | numeric | Home team odds win percentage (0-1 decimal). |
| home_team_odds_average_score | numeric | Home team's team odds average score. |
| home_team_odds_money_line_odds | numeric | Home team's team odds money line odds. |
| home_team_odds_spread_return | numeric | Home team's team odds spread return. |
| home_team_odds_spread_record_wins | integer | Home team's team odds spread record wins. |
| home_team_odds_spread_record_losses | integer | Home team's team odds spread record losses. |
| home_team_odds_spread_record_pushes | integer | Home team's team odds spread record pushes. |
| home_team_odds_spread_record_summary | character | Home team's team odds spread record summary. |
| game_id | integer | Unique game identifier. |

**againstTheSpread**

|              |           |                                         |
|--------------|-----------|-----------------------------------------|
| col_name     | types     | description                             |
| id           | integer   | Id.                                     |
| uid          | character | ESPN UID string (universal identifier). |
| display_name | character | Display name.                           |
| abbreviation | character | Short abbreviation.                     |
| logo         | character | Team or league logo URL.                |
| logos        | list      | Logos.                                  |
| records      | list      | Records.                                |
| game_id      | integer   | Unique game identifier.                 |
| team_id      | integer   | Unique team identifier.                 |

**predictor**

|                           |         |                                      |
|---------------------------|---------|--------------------------------------|
| col_name                  | types   | description                          |
| game_id                   | integer | Unique game identifier.              |
| home_team_id              | integer | Unique identifier for the home team. |
| away_team_id              | integer | Unique identifier for the away team. |
| away_team_game_projection | numeric | Away team's team game projection.    |
| away_team_chance_loss     | numeric | Away team's team chance loss.        |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
# Interactive only: parsing the whole game summary takes 2-4 s.
try(espn_mbb_game_all(game_id = 401479672))
#> $Plays
#> ── ESPN MBB Play-by-Play Information from ESPN.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:04 UTC
#> # A tibble: 360 × 69
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
#> # ℹ 62 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
#> 
#> $Team
#> ── ESPN MBB Team Box Information from ESPN.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:04 UTC
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
#> ── ESPN MBB Player Box Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:05 UTC
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
# \donttest{
# Same summary request as espn_mbb_game_all() above.
try(espn_mbb_pbp(game_id = 401479672))
#> ── ESPN MBB Play-by-Play Information from ESPN.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:05 UTC
#> # A tibble: 360 × 69
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
#> # ℹ 62 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
# }
# \donttest{
# Same summary request as espn_mbb_game_all() above.
try(espn_mbb_team_box(game_id = 401479672))
#> ── ESPN MBB Team Box Information from ESPN.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:06 UTC
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
# }
# \donttest{
# Same summary request as espn_mbb_game_all() above.
try(espn_mbb_player_box(game_id = 401479672))
#> ── ESPN MBB Player Box Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:06 UTC
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
# }
# \donttest{
# One request per athlete on both rosters.
try(espn_mbb_game_rosters(game_id = 401256760))
#> ── ESPN MBB Game Roster Information from ESPN.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:09 UTC
#> # A tibble: 34 × 151
#>    athlete_id athlete_uid  athlete_guid athlete_type    sdr first_name last_name
#>         <int> <chr>        <chr>        <chr>         <int> <chr>      <chr>    
#>  1    4277850 s:40~l:41~a… 7b156c52-fa… basketball   4.28e6 RaiQuan    Gray     
#>  2    4432829 s:40~l:41~a… 2734604d-09… basketball   4.43e6 Balsa      Koprivica
#>  3    4433134 s:40~l:41~a… dd0bb1da-07… basketball   4.43e6 Scottie    Barnes   
#>  4    4277854 s:40~l:41~a… f44291c9-0d… basketball   4.28e6 MJ         Walker   
#>  5    4277852 s:40~l:41~a… f376da3f-46… basketball   4.28e6 Anthony    Polite   
#>  6    4279098 s:40~l:41~a… 89f097ed-f5… basketball   4.28e6 Malik      Osborne  
#>  7    4701240 s:40~l:41~a… f35c5378-4b… basketball   4.70e6 Tanor      Ngom     
#>  8    4683134 s:40~l:41~a… f878c598-70… basketball   4.68e6 Quincy     Ballard  
#>  9    4701239 s:40~l:41~a… 88820814-39… basketball   4.70e6 Sardaar    Calhoun  
#> 10    4592191 s:40~l:41~a… 066a390d-78… basketball   4.59e6 Nathanael  Jack     
#> # ℹ 24 more rows
#> # ℹ 144 more variables: full_name <chr>, athlete_display_name <chr>,
#> #   short_name <chr>, weight <int>, display_weight <chr>, height <int>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>,
#> #   birth_place_city <chr>, birth_place_state <chr>, birth_place_country <chr>,
#> #   birth_country_alternate_id <chr>, birth_country_abbreviation <chr>,
#> #   slug <chr>, headshot_href <chr>, headshot_alt <chr>, …
# }
# \donttest{
try(espn_mbb_betting(game_id = 401256760))
#> $pickcenter
#> ── ESPN MBB Pickcenter Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:09 UTC
#> # A tibble: 3 × 66
#>   details  over_under spread over_odds under_odds provider_id provider_name
#> * <chr>         <dbl>  <dbl>     <dbl>      <dbl>       <int> <chr>        
#> 1 FSU -1.5       136.   -1.5    -112       -108          1004 consensus    
#> 2 FSU -1.5       134.   -1.5      62.6       37.4        1003 numberfire   
#> 3 FSU -1         134.   -1      -115       -105          1002 teamrankings 
#> # ℹ 59 more variables: provider_priority <int>,
#> #   away_team_odds_win_percentage <dbl>, away_team_odds_favorite <lgl>,
#> #   away_team_odds_underdog <lgl>, away_team_odds_money_line <int>,
#> #   away_team_odds_spread_odds <dbl>, away_team_odds_team_id <int>,
#> #   away_team_odds_average_score <dbl>, away_team_odds_money_line_odds <dbl>,
#> #   away_team_odds_spread_return <dbl>,
#> #   away_team_odds_current_point_spread_alternate_display_value <chr>, …
#> 
#> $againstTheSpread
#> ── ESPN MBB Against the Spread Information from ESPN.com ──────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:09 UTC
#> # A tibble: 2 × 9
#>      id uid        display_name abbreviation logo  logos records game_id team_id
#> * <int> <chr>      <chr>        <chr>        <chr> <lis> <list>    <int>   <int>
#> 1    57 s:40~l:41… Florida Gat… FLA          http… <df>  <list>   4.01e8      57
#> 2    52 s:40~l:41… Florida Sta… FSU          http… <df>  <list>   4.01e8      52
#> 
#> $predictor
#> data frame with 0 columns and 0 rows
#> 
# }
# \donttest{
try(espn_nba_game_all(game_id = 401283399))
#> $Plays
#> ── ESPN NBA Play-by-Play Information from ESPN.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:10 UTC
#> # A tibble: 472 × 75
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4012833… 4               Isai…          0          0 FALSE                  0
#>  2 4012833… 7               Jona…          0          0 FALSE                  0
#>  3 4012833… 8               Dari…          0          0 FALSE                  0
#>  4 4012833… 9               Dill…          0          0 FALSE                  0
#>  5 4012833… 11              Dari…          0          0 FALSE                  0
#>  6 4012833… 12              Ja M…          0          0 FALSE                  0
#>  7 4012833… 13              Gray…          0          0 FALSE                  0
#>  8 4012833… 14              Isai…          0          0 FALSE                  0
#>  9 4012833… 15              Shai…          3          0 TRUE                   3
#> 10 4012833… 16              Theo…          3          0 FALSE                  0
#> # ℹ 462 more rows
#> # ℹ 68 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
#> 
#> $Team
#> ── ESPN NBA Team Box Information from ESPN.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:10 UTC
#> # A tibble: 2 × 57
#>     game_id season season_type game_date  game_date_time      team_id team_uid  
#>       <int>  <int>       <int> <date>     <dttm>                <int> <chr>     
#> 1 401283399   2021           2 2021-02-17 2021-02-17 21:00:00      25 s:40~l:46…
#> 2 401283399   2021           2 2021-02-17 2021-02-17 21:00:00      29 s:40~l:46…
#> # ℹ 50 more variables: team_slug <chr>, team_location <chr>, team_name <chr>,
#> #   team_abbreviation <chr>, team_display_name <chr>,
#> #   team_short_display_name <chr>, team_color <chr>,
#> #   team_alternate_color <chr>, team_logo <chr>, team_home_away <chr>,
#> #   team_score <int>, team_winner <lgl>, assists <int>, blocks <int>,
#> #   defensive_rebounds <int>, fast_break_points <chr>, field_goal_pct <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>, …
#> 
#> $Player
#> ── ESPN NBA Player Box Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:10 UTC
#> # A tibble: 24 × 57
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4066392
#>  2 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4423545
#>  3 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4683027
#>  4 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4278073
#>  5 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4397020
#>  6 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    3138156
#>  7 401283399   2021           2 2021-02-17 2021-02-17 21:00:00       6610
#>  8 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    2490089
#>  9 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    3133626
#> 10 401283399   2021           2 2021-02-17 2021-02-17 21:00:00    4080610
#> # ℹ 14 more rows
#> # ℹ 51 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
#> 
# }

# \donttest{
# The same summary request espn_nba_game_all() makes.
try(espn_nba_pbp(game_id = 401071880))
#> ── ESPN NBA Play-by-Play Information from ESPN.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:11 UTC
#> # A tibble: 475 × 75
#>    id       sequence_number text  away_score home_score scoring_play score_value
#>    <chr>    <chr>           <chr>      <int>      <int> <lgl>              <int>
#>  1 4010718… 4               Jahl…          0          0 FALSE                  0
#>  2 4010718… 7               Nema…          0          3 TRUE                   3
#>  3 4010718… 9               Elfr…          2          3 TRUE                   2
#>  4 4010718… 10              Ian …          2          3 FALSE                  0
#>  5 4010718… 12              Kenr…          2          3 FALSE                  0
#>  6 4010718… 13              Jahl…          4          3 TRUE                   2
#>  7 4010718… 15              Harr…          4          5 TRUE                   2
#>  8 4010718… 16              King…          4          5 FALSE                  0
#>  9 4010718… 17              Ian …          7          5 TRUE                   3
#> 10 4010718… 19              Chri…          7          5 FALSE                  0
#> # ℹ 465 more rows
#> # ℹ 68 more variables: wallclock <chr>, shooting_play <lgl>,
#> #   points_attempted <int>, short_description <chr>, type_id <int>,
#> #   type_text <chr>, period_number <int>, period_display_value <chr>,
#> #   clock_display_value <chr>, team_id <int>, coordinate_x_raw <dbl>,
#> #   coordinate_y_raw <dbl>, coordinate_x <dbl>, coordinate_y <dbl>,
#> #   play_id <chr>, athlete_id_1 <int>, athlete_id_2 <int>, …
# }
# \donttest{
# The same summary request espn_nba_game_all() makes.
try(espn_nba_team_box(game_id = 401071880))
#> ── ESPN NBA Team Box Information from ESPN.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:11 UTC
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
# \donttest{
# The same summary request espn_nba_game_all() makes.
try(espn_nba_player_box(game_id = 401071880))
#> ── ESPN NBA Player Box Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:12 UTC
#> # A tibble: 26 × 57
#>      game_id season season_type game_date  game_date_time      athlete_id
#>        <int>  <int>       <int> <date>     <dttm>                   <int>
#>  1 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3058254
#>  2 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3135048
#>  3 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2489785
#>  4 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2583639
#>  5 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3133626
#>  6 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3919335
#>  7 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2488958
#>  8 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    2585637
#>  9 401071880   2019           2 2019-04-07 2019-04-07 21:00:00       6583
#> 10 401071880   2019           2 2019-04-07 2019-04-07 21:00:00    3064514
#> # ℹ 16 more rows
#> # ℹ 51 more variables: athlete_display_name <chr>, team_id <int>,
#> #   team_name <chr>, team_location <chr>, team_short_display_name <chr>,
#> #   minutes <dbl>, field_goals_made <int>, field_goals_attempted <int>,
#> #   three_point_field_goals_made <int>,
#> #   three_point_field_goals_attempted <int>, free_throws_made <int>,
#> #   free_throws_attempted <int>, offensive_rebounds <int>, …
# }
# \donttest{
# One request per athlete on both rosters.
try(espn_nba_game_rosters(game_id = 401283399))
#> ── ESPN NBA Game Roster Information from ESPN.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:14 UTC
#> # A tibble: 24 × 175
#>    athlete_id athlete_uid  athlete_guid athlete_type    sdr first_name last_name
#>         <int> <chr>        <chr>        <chr>         <int> <chr>      <chr>    
#>  1    2993874 s:40~l:46~a… 0b5e3fdc-79… basketball   2.99e6 Kyle       Anderson 
#>  2    3155526 s:40~l:46~a… 653c07b5-85… basketball   3.16e6 Dillon     Brooks   
#>  3       6477 s:40~l:46~a… 585a3d05-44… basketball   2.56e6 Jonas      Valanciu…
#>  4    3135045 s:40~l:46~a… fedd8adf-a9… basketball   3.14e6 Grayson    Allen    
#>  5    4279888 s:40~l:46~a… de5f87e0-85… basketball   4.28e6 Ja         Morant   
#>  6    3906665 s:40~l:46~a… ac9aa77d-db… basketball   3.91e6 Brandon    Clarke   
#>  7    3908903 s:40~l:46~a… 6445df83-a2… basketball   3.91e6 Sean       McDermott
#>  8    4277964 s:40~l:46~a… 4b87dfe2-26… basketball   4.28e6 Xavier     Tillman  
#>  9    3134932 s:40~l:46~a… d4c8df92-1b… basketball   3.13e6 John       Konchar  
#> 10    3135046 s:40~l:46~a… c4cddbcc-95… basketball   3.14e6 Tyus       Jones    
#> # ℹ 14 more rows
#> # ℹ 168 more variables: full_name <chr>, athlete_display_name <chr>,
#> #   short_name <chr>, weight <int>, display_weight <chr>, height <int>,
#> #   display_height <chr>, age <int>, date_of_birth <chr>, debut_year <int>,
#> #   birth_place_city <chr>, birth_place_state <chr>, birth_place_country <chr>,
#> #   citizenship <chr>, slug <chr>, headshot_href <chr>, headshot_alt <chr>,
#> #   athlete_jersey_number <chr>, position_id <int>, position_name <chr>, …
# }
# \donttest{
try(espn_nba_betting(game_id = 401283399))
#> $pickcenter
#> ── ESPN NBA Pickcenter Information from ESPN.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:14 UTC
#> # A tibble: 3 × 66
#>   details over_under spread over_odds under_odds provider_id provider_name
#> * <chr>        <int>  <int>     <dbl>      <dbl>       <int> <chr>        
#> 1 MEM -7         227     -7    -110       -110          1004 consensus    
#> 2 MEM -7         228     -7      30.9       67.4        1003 numberfire   
#> 3 MEM -7         228     -7    -110       -110          1002 teamrankings 
#> # ℹ 59 more variables: provider_priority <int>,
#> #   away_team_odds_win_percentage <dbl>, away_team_odds_favorite <lgl>,
#> #   away_team_odds_underdog <lgl>, away_team_odds_money_line <int>,
#> #   away_team_odds_spread_odds <dbl>, away_team_odds_team_id <int>,
#> #   away_team_odds_average_score <dbl>, away_team_odds_money_line_odds <dbl>,
#> #   away_team_odds_spread_return <dbl>,
#> #   away_team_odds_current_point_spread_alternate_display_value <chr>, …
#> 
#> $againstTheSpread
#> ── ESPN NBA Against the Spread Information from ESPN.com ──────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:12:14 UTC
#> # A tibble: 2 × 9
#>      id uid        display_name abbreviation logo  logos records game_id team_id
#> * <int> <chr>      <chr>        <chr>        <chr> <lis> <list>    <int>   <int>
#> 1    25 s:40~l:46… Oklahoma Ci… OKC          http… <df>  <list>   4.01e8      25
#> 2    29 s:40~l:46… Memphis Gri… MEM          http… <df>  <list>   4.01e8      29
#> 
#> $predictor
#> data frame with 0 columns and 0 rows
#> 
# }
```
