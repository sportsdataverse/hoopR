# Shared column schema: espn mbb week ranking schema

Columns shared verbatim across: espn_mbb_week_ranking,
espn_nba_week_ranking.

## Details

|                   |           |                                              |
|-------------------|-----------|----------------------------------------------|
| col_name          | types     | description                                  |
| league            | character | League slug.                                 |
| season            | integer   | Season year.                                 |
| season_type       | integer   | Season-type id.                              |
| week              | integer   | Week number.                                 |
| ranking_id        | character | ESPN ranking id.                             |
| name              | character | Ranking name (e.g. "AP Top 25").             |
| short_name        | character | Short name.                                  |
| type              | character | Ranking type code.                           |
| headline          | character | Full headline.                               |
| date              | character | Date of the ranking.                         |
| current           | integer   | Current rank.                                |
| previous          | integer   | Previous-week rank.                          |
| points            | numeric   | Voting points.                               |
| first_place_votes | integer   | First-place vote count.                      |
| trend             | character | Trend indicator (e.g. "+3", "-2", "-").      |
| record_summary    | character | Team's record at time of poll (e.g. "20-2"). |
| team_id           | character | ESPN team id.                                |
| team_ref          | character | `$ref` to the team-in-season resource.       |
| last_updated      | character | Last-updated timestamp.                      |
