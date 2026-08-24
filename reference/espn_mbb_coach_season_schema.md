# Shared column schema: espn mbb coach season schema

Columns shared verbatim across: espn_mbb_coach_season,
espn_nba_coach_season.

## Details

|               |           |                            |
|---------------|-----------|----------------------------|
| col_name      | types     | description                |
| league        | character | League slug.               |
| season        | integer   | Season year.               |
| coach_id      | character | ESPN coach id.             |
| uid           | character | ESPN UID string.           |
| first_name    | character | First name.                |
| last_name     | character | Last name.                 |
| date_of_birth | character | Date of birth.             |
| birth_city    | character | Birth city.                |
| birth_state   | character | Birth state / region.      |
| n_records     | integer   | Count of records entries.  |
| person_ref    | character | `$ref` to person resource. |
| college_ref   | character | `$ref` to college.         |
| team_ref      | character | `$ref` to team-in-season.  |
