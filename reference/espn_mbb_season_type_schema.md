# Shared column schema: espn mbb season type schema

Columns shared verbatim across: espn_mbb_season_type,
espn_nba_season_type.

## Details

|               |           |                                       |
|---------------|-----------|---------------------------------------|
| col_name      | types     | description                           |
| league        | character | League slug.                          |
| season        | integer   | Season year.                          |
| season_type   | integer   | Season-type id.                       |
| type          | integer   | Numeric type code.                    |
| name          | character | Display name (e.g. "Regular Season"). |
| abbreviation  | character | Short code (e.g. "reg").              |
| year          | integer   | Year stamp.                           |
| start_date    | character | ISO 8601 start date.                  |
| end_date      | character | ISO 8601 end date.                    |
| has_groups    | logical   | Whether groups exist for this type.   |
| has_standings | logical   | Whether standings exist.              |
| has_legs      | logical   | Whether playoff legs exist.           |
| slug          | character | URL slug.                             |
| groups_ref    | character | `$ref` to the groups endpoint.        |
| weeks_ref     | character | `$ref` to the weeks endpoint.         |
| leaders_ref   | character | `$ref` to the leaders endpoint.       |
