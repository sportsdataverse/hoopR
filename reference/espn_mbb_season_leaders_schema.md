# Shared column schema: espn mbb season leaders schema

Columns shared verbatim across: espn_mbb_season_leaders,
espn_nba_season_leaders.

## Details

|                  |           |                                               |
|------------------|-----------|-----------------------------------------------|
| col_name         | types     | description                                   |
| league           | character | League slug.                                  |
| season           | integer   | Season year.                                  |
| season_type      | integer   | Season-type id.                               |
| category_name    | character | Internal category key (e.g. "pointsPerGame"). |
| category_display | character | Human-readable category name.                 |
| category_short   | character | Short display name.                           |
| category_abbrev  | character | Stat abbreviation (e.g. "PTS").               |
| rank             | integer   | Rank within the category (1 = best).          |
| athlete_id       | character | ESPN athlete id.                              |
| team_id          | character | ESPN team id.                                 |
| display_value    | character | Display-formatted value.                      |
| value            | numeric   | Numeric leader value.                         |
| rel              | character | Comma-joined `rel` tags from ESPN.            |
| athlete_ref      | character | `$ref` URL to the leader's athlete.           |
| team_ref         | character | `$ref` URL to the leader's team.              |
