# Shared column schema: espn mbb team roster schema

Columns shared verbatim across: espn_mbb_team_roster,
espn_nba_team_roster.

## Details

|  |  |  |
|----|----|----|
| col_name | types | description |
| athlete_id | character | Unique athlete identifier (ESPN). |
| full_name | character | Player's full name. |
| jersey | character | Jersey number worn by the player. |
| position_abbrev | character |  |
| position_name | character | Listed roster position ('Guard', 'Forward', 'Center'). |
| height | character | Player height (string e.g. '6-2' or inches). |
| weight | character | Player weight in pounds. |
| age | character | Player age (in years). |
| birth_date | character | Date of birth (YYYY-MM-DD). |
| birth_place | character | Place of birth. |
| headshot | character | Headshot image URL. |
| link_web | character | Web link / URL. |
| status | character | Status label. |
| team_id | character | Unique team identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
