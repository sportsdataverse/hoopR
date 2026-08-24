# Shared column schema: espn mbb team odds records schema

Columns shared verbatim across: espn_mbb_team_odds_records,
espn_nba_team_odds_records.

## Details

|                  |           |                                               |
|------------------|-----------|-----------------------------------------------|
| col_name         | types     | description                                   |
| league           | character | League slug.                                  |
| team_id          | character | ESPN team identifier.                         |
| season           | integer   | Season year.                                  |
| season_type      | integer   | Season-type id.                               |
| category_type    | character | Category type code (e.g. "moneyLineOverall"). |
| category_abbrev  | character | Category abbreviation (e.g. "ML").            |
| category_short   | character | Short display.                                |
| category_display | character | Full category name.                           |
| stat_type        | character | Stat type code (e.g. "win", "loss").          |
| stat_abbrev      | character | Stat abbreviation (e.g. "W", "L").            |
| stat_display     | character | Stat display name.                            |
| value            | numeric   | Numeric stat value.                           |
| display_value    | character | Display-formatted value.                      |
