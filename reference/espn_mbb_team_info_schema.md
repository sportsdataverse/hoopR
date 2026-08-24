# Shared column schema: espn mbb team info schema

Columns shared verbatim across: espn_mbb_team, espn_nba_team.

## Details

|                    |           |                                            |
|--------------------|-----------|--------------------------------------------|
| col_name           | types     | description                                |
| id                 | character | Id.                                        |
| uid                | character | ESPN UID string (universal identifier).    |
| slug               | character | URL-safe identifier.                       |
| abbreviation       | character | Short abbreviation.                        |
| display_name       | character | Display name.                              |
| short_display_name | character | Short display name.                        |
| name               | character | Display name.                              |
| nickname           | character | Team or athlete nickname.                  |
| location           | character | Location.                                  |
| color              | character | Primary color (hex without leading '#').   |
| alternate_color    | character | Alternate color (hex without leading '#'). |
| logo               | character | Team or league logo URL.                   |
