# Shared column schema: espn mbb calendar schema

Columns shared verbatim across: espn_mbb_calendar, espn_nba_calendar.

## Details

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | character | Season identifier (4-digit year or 'YYYY-YY' string). |
| season_type | character | Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
| season_type_label | character |  |
| season_start_date | character | Date in YYYY-MM-DD format. |
| season_end_date | character | Date in YYYY-MM-DD format. |
| label | character |  |
| alternate_label | character |  |
| detail | character |  |
| value | character | Numeric or string value field. |
| start_date | character | Start date (YYYY-MM-DD). |
| end_date | character | End date (YYYY-MM-DD). |
