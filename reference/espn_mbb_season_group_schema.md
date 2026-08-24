# Shared column schema: espn mbb season group schema

Columns shared verbatim across: espn_mbb_season_group,
espn_nba_season_group.

## Details

|               |           |                                        |
|---------------|-----------|----------------------------------------|
| col_name      | types     | description                            |
| league        | character | League slug.                           |
| season        | integer   | Season year.                           |
| season_type   | integer   | Season-type id.                        |
| group_id      | character | ESPN group id.                         |
| uid           | character | ESPN UID string.                       |
| name          | character | Full name (e.g. "Eastern Conference"). |
| abbreviation  | character | Short code (e.g. "EAST").              |
| short_name    | character | Short name.                            |
| midsize_name  | character | Mid-size display name.                 |
| is_conference | logical   | Whether this group is a conference.    |
| slug          | character | URL slug.                              |
| parent_ref    | character | `$ref` to parent group (if any).       |
| children_ref  | character | `$ref` to child-groups endpoint.       |
| teams_ref     | character | `$ref` to teams-in-group endpoint.     |
| standings_ref | character | `$ref` to standings endpoint.          |
