# Shared column schema: espn mbb game probabilities schema

Columns shared verbatim across: espn_mbb_game_probabilities,
espn_nba_game_probabilities.

## Details

|  |  |  |
|----|----|----|
| col_name | types | description |
| event_id | character | Unique event / game identifier (ESPN). |
| sequence_number | character | Sequence number representing a shot-possession (V3 PBP). |
| play_id | character | Unique play identifier within a game. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| clock | character | Game clock value. |
| home_win_percentage | numeric | Home win percentage (0-1 decimal). |
| away_win_percentage | numeric | Away win percentage (0-1 decimal). |
| tie_percentage | numeric | Tie percentage (0-1 decimal). |
| secs_to_end_of_period | numeric |  |
| secs_to_end_of_game | numeric |  |
