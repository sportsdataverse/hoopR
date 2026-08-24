# Shared column schema: espn mbb season weeks schema

Columns shared verbatim across: espn_mbb_season_weeks,
espn_nba_season_weeks.

## Details

|             |           |                                 |
|-------------|-----------|---------------------------------|
| col_name    | types     | description                     |
| league      | character | League slug.                    |
| season      | integer   | Season year.                    |
| season_type | integer   | Season-type id.                 |
| week        | integer   | Week number (1-based).          |
| ref         | character | `$ref` URL for the week detail. |
