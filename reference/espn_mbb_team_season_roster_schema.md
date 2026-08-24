# Shared column schema: espn mbb team season roster schema

Columns shared verbatim across: espn_mbb_team_season_roster,
espn_nba_team_season_roster.

## Details

|            |           |                                         |
|------------|-----------|-----------------------------------------|
| col_name   | types     | description                             |
| league     | character | League slug.                            |
| team_id    | character | ESPN team id.                           |
| season     | integer   | Season year.                            |
| athlete_id | character | ESPN athlete id.                        |
| ref        | character | `$ref` URL to athlete-in-season detail. |
