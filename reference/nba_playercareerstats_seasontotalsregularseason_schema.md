# Shared column schema: nba playercareerstats seasontotalsregularseason schema

Columns shared verbatim across: nba_playercareerstats,
nba_playerprofilev2.

## Details

|                   |           |                                          |
|-------------------|-----------|------------------------------------------|
| col_name          | types     | description                              |
| PLAYER_ID         | character | Unique player identifier.                |
| SEASON_ID         | character | Unique season identifier.                |
| LEAGUE_ID         | character | League identifier ('10' = WNBA).         |
| TEAM_ID           | character | Unique team identifier.                  |
| TEAM_ABBREVIATION | character | Short team abbreviation (e.g. 'LAS').    |
| PLAYER_AGE        | character |                                          |
| GP                | character | Games played.                            |
| GS                | character | Games started.                           |
| MIN               | character | Minutes played.                          |
| FGM               | character | Field goals made.                        |
| FGA               | character | Field goal attempts.                     |
| FG_PCT            | character | Field goal percentage (0-1).             |
| FG3M              | character | Three-point field goals made.            |
| FG3A              | character | Three-point field goal attempts.         |
| FG3_PCT           | character | Three-point field goal percentage (0-1). |
| FTM               | character | Free throws made.                        |
| FTA               | character | Free throw attempts.                     |
| FT_PCT            | character | Free throw percentage (0-1).             |
| OREB              | character | Offensive rebounds.                      |
| DREB              | character | Defensive rebounds.                      |
| REB               | character | Total rebounds.                          |
| AST               | character | Assists.                                 |
| STL               | character | Steals.                                  |
| BLK               | character | Blocks.                                  |
| TOV               | character | Turnovers.                               |
| PF                | character | Personal fouls.                          |
| PTS               | character | Points scored.                           |
