# Shared column schema: nba scoreboard eastconfstandingsbyday schema

Columns shared verbatim across: nba_scoreboard, nba_scoreboardv2.

## Details

|               |           |                                     |
|---------------|-----------|-------------------------------------|
| col_name      | types     | description                         |
| TEAM_ID       | character | Unique team identifier.             |
| LEAGUE_ID     | character | League identifier ('10' = WNBA).    |
| SEASON_ID     | character | Unique season identifier.           |
| STANDINGSDATE | character |                                     |
| CONFERENCE    | character | Conference.                         |
| TEAM          | character | Team-side label or team identifier. |
| G             | character | Games played.                       |
| W             | character | Wins.                               |
| L             | character | Losses.                             |
| W_PCT         | character |                                     |
| HOME_RECORD   | character | Home win-loss record.               |
| ROAD_RECORD   | character |                                     |
