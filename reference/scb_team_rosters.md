# **Get BBL Team Rosters**

Per club, the current roster, one row per player (BBL only).

Endpoint: `GET https://api.basketball-bundesliga.de/transfers/teams`

## Usage

``` r
scb_team_rosters()
```

## Value

A `hoopR_data` tibble: Per club, the current roster, one row per player
(BBL only). An empty valid answer raises `hoopR_no_data`; the columns
are always these, in this order (sportsdataverse-py `scb_team_rosters`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| league | character | League the row belongs to: `bbl` (men) or `dbbl` (women); BBL and DBBL game ids overlap, so a game is (league, game_id). |
| team_id | character | Club id, a string; equal to `season_team_id` in every sample. Joins to `scb_team` and `scb_season_teams`. |
| season | integer | Season END year (2026 = 2025-26), the sdv key; the API's `season_id` plus one. |
| season_id | integer | Season, START year (2026 = 2026-27). |
| season_team_id | character | Season-team id; equal to the club `teamId` in every sample (BBL 2005-2026, DBBL 2024-2026). |
| season_player_id | character | Season-player id: one player's engagement with one club (kept across seasons while he stays, new after a move). Joins box-score lines, actions, records and `scb_season_player`. |
| real_player_id | integer | Global person id: the same across clubs and seasons. Joins to `realPlayerId` everywhere. |
| first_name | character | Player's given name. |
| last_name | character | Player's family name. |
| birth_date | character | Date of birth, YYYY-MM-DD. |
| position | character | Position: POINT_GUARD, SHOOTING_GUARD, SMALL_FORWARD, POWER_FORWARD, CENTER. |
| shirt_number | character | Jersey number as sent (a string: it can be `00`). |
| height | double | Height in metres (float32 noise: 1.77 arrives as 1.7699999809265137). |
| weight | integer | Weight in kg; 0 when unknown. |
| nationalities | character | Nationalities, ISO 3166-1 alpha-2 codes. |
| is_all_star | logical | All-Star selection flag. |
| is_young | logical | Young-player flag (German-trained youth rule; inferred). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_team_rosters()

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
