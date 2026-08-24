# Shared column schema: espn mbb season group children schema

Columns shared verbatim across: espn_mbb_season_group_children,
espn_nba_season_group_children.

## Details

|                 |           |                               |
|-----------------|-----------|-------------------------------|
| col_name        | types     | description                   |
| league          | character | League slug.                  |
| season          | integer   | Season year.                  |
| season_type     | integer   | Season-type id.               |
| parent_group_id | character | Parent group id (queried).    |
| child_group_id  | character | Child group id.               |
| ref             | character | `$ref` to child group detail. |
