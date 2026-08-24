# Shared column schema: espn mbb week rankings schema

Columns shared verbatim across: espn_mbb_week_rankings,
espn_nba_week_rankings.

## Details

|             |           |                                         |
|-------------|-----------|-----------------------------------------|
| col_name    | types     | description                             |
| league      | character | League slug.                            |
| season      | integer   | Season year.                            |
| season_type | integer   | Season-type id.                         |
| week        | integer   | Week number.                            |
| ranking_id  | character | ESPN ranking id.                        |
| ref         | character | `$ref` URL for the ranked-teams detail. |
