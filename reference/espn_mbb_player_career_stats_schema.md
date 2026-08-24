# Shared column schema: espn mbb player career stats schema

Columns shared verbatim across: espn_mbb_player_career_stats,
espn_nba_player_career_stats.

## Details

|                  |           |                                                 |
|------------------|-----------|-------------------------------------------------|
| col_name         | types     | description                                     |
| league           | character | League slug.                                    |
| athlete_id       | character | ESPN athlete id.                                |
| stat_type_id     | character | Stat-type code (0 = reg, 1 = post, 2 = career). |
| split_id         | character | Split id.                                       |
| split_name       | character | Split name (typically "All Splits").            |
| split_type       | character | Split type code.                                |
| category_name    | character | Category key (e.g. "defensive").                |
| category_display | character | Category display name.                          |
| category_short   | character | Category short display.                         |
| category_abbrev  | character | Category abbreviation.                          |
| stat_name        | character | Stat key.                                       |
| stat_abbrev      | character | Stat abbreviation.                              |
| stat_display     | character | Stat display name.                              |
| stat_short       | character | Stat short display.                             |
| description      | character | Stat description.                               |
| value            | numeric   | Stat value.                                     |
| display_value    | character | Display-formatted value.                        |
