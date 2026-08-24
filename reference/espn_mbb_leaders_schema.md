# Shared column schema: espn mbb leaders schema

Columns shared verbatim across: espn_mbb_leaders, espn_nba_leaders.

## Details

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | integer | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| category | character | Category label. |
| abbreviation | character | Short abbreviation. |
| athlete_id | character | Unique athlete identifier (ESPN). |
| athlete_name | character | Athlete display name (ESPN). |
| team_id | character | Unique team identifier. |
| team_abbrev | character |  |
| value | numeric | Numeric or string value field. |
| rank | integer | Rank. |
| display_value | character | Human-readable display value. |
