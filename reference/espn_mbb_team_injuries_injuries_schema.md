# Shared column schema: espn mbb team injuries injuries schema

Columns shared verbatim across: espn_mbb_team_injuries,
espn_nba_team_injuries.

## Details

|               |           |                                                   |
|---------------|-----------|---------------------------------------------------|
| col_name      | types     | description                                       |
| team_id       | character | Unique team identifier.                           |
| athlete_id    | character | Unique athlete identifier (ESPN).                 |
| athlete_name  | character | Athlete display name (ESPN).                      |
| position      | character | Listed roster position (G, F, C, etc.).           |
| status        | character | Status label.                                     |
| date          | character | Date in YYYY-MM-DD format.                        |
| type          | character | Record type / category.                           |
| side          | character | Side label (e.g. 'home', 'away', or 'overUnder'). |
| returns_at    | character |                                                   |
| short_comment | character |                                                   |
| long_comment  | character | Long-form play / event comment.                   |
