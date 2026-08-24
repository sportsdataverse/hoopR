# Shared column schema: espn mbb season ranking schema

Columns shared verbatim across: espn_mbb_season_ranking,
espn_nba_season_ranking.

## Details

|             |           |                                             |
|-------------|-----------|---------------------------------------------|
| col_name    | types     | description                                 |
| league      | character | League slug.                                |
| season      | integer   | Season year.                                |
| ranking_id  | character | ESPN ranking id.                            |
| name        | character | Ranking name (e.g. "AP Top 25").            |
| short_name  | character | Short name (e.g. "AP Poll").                |
| type        | character | Ranking type code (e.g. "ap").              |
| season_type | integer   | Season-type id of this snapshot.            |
| week        | integer   | Week number of this snapshot.               |
| ref         | character | `$ref` URL for the per-week ranking detail. |
