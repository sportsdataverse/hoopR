# Shared column schema: espn mbb season groups schema

Columns shared verbatim across: espn_mbb_season_groups,
espn_nba_season_groups.

## Details

|             |           |                                  |
|-------------|-----------|----------------------------------|
| col_name    | types     | description                      |
| league      | character | League slug.                     |
| season      | integer   | Season year.                     |
| season_type | integer   | Season-type id.                  |
| group_id    | character | ESPN group id.                   |
| ref         | character | `$ref` URL for the group detail. |
