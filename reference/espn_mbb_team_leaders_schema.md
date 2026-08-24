# Shared column schema: espn mbb team leaders schema

Columns shared verbatim across: espn_mbb_team_leaders,
espn_nba_team_leaders.

## Details

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | character | Unique team identifier. |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| category | character | Category label. |
| display_name | character | Display name. |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_name | character | Athlete display name (ESPN). |
| value | numeric | Numeric or string value field. |
| rank | integer | Rank. |
