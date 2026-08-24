# Shared column schema: espn mbb player seasons schema

Columns shared verbatim across: espn_mbb_player_seasons,
espn_nba_player_seasons.

## Details

|            |           |                                  |
|------------|-----------|----------------------------------|
| col_name   | types     | description                      |
| league     | character | League slug.                     |
| athlete_id | character | ESPN athlete id.                 |
| season     | integer   | Season year.                     |
| ref        | character | `$ref` URL to the season detail. |
