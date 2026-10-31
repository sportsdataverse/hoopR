# **Get EASL Player**

One player's biography: names, nationality, birth date, height, weight.

Endpoint: `GET https://easl.joshricha.com/api/v1/players/{player_id}`

## Usage

``` r
easl_player(player_id)
```

## Arguments

- player_id:

  (required) DataCore person UUID v1, e.g.
  '85c99dab-9f67-11f0-8780-a731edb5aad5': the player_id of easl_players,
  the box scores, leaders and play-by-play. A malformed id is
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble: One player's biography: names, nationality, birth
date, height, weight. An empty answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`easl_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_row_id | integer | The sync server's own integer row id of the player (not a DataCore id). |
| player_id | character | playerId: DataCore person UUID v1 (key space: EASL persons, the same id as the box score's `personId`; joins /players, leaders and play-by-play players). Not a team id. |
| name | character | Player display name in 'FAMILY Given' form with the family name upper-cased (OSAKABE Taiki), in Latin script. |
| name_latin | character | Alternative name: equal to nameFullLocal for 257 of 552 players, otherwise null; never non-Latin in the observed data. |
| name_abbreviated | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| nationality | character | ISO 3166-1 alpha-3 code of the player's nationality; 36 codes occur, KOR 119, USA 102, JPN 81, PHL 80, TWN 61, CHN 22, MNG 16, HKG 15, MAC 13 ('PHI' also appears once, a non-ISO spelling of PHL). |
| gender | character | MALE on all 552 rows. |
| dob | Date | Date of birth, 'YYYY-MM-DD' (a public biography field; 1980-10-05 to 2023-10-16 in the data, so the latest values are implausible); 5 players have none. |
| height_cm | integer | Height in centimetres; 43 of 552 players have none. |
| height_feet | character | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (String). |
| weight_kg | integer | Weight in kilograms; many players have none. |
| weight_lbs | integer | Not yet populated upstream: null in every full body observed (2026-10-12), so its meaning is unverified; the 2026-27 bodies start filling some of these columns, so it is typed from its family (Int64). |
| status | character | Registration state of the player in the database: ACTIVE, INACTIVE or UNREGISTERED. |
| jersey_number | character | Jersey number as a string. Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
| position | character | Playing position (G, F, C, PG, SG, SF, PF, GF). Present ONLY in the roster variant of /players (seasonId + teamId) and on `/players/{playerId}`; missing from the unfiltered list. Absent on some rows. |
| organization_id | character | DataCore organisation id: b1e0z (EASL). |
| created_at | character | When the sync server inserted the row, 'YYYY-MM-DD HH:MM:SS' (a different format from updatedAt; zone unstated, UTC assumed). |
| updated_at | character | When the sync server last synced the row, ISO 8601 with milliseconds and Z (UTC). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

     easl_player(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5")

## See also

Other EASL Functions:
[`easl_game()`](https://hoopR.sportsdataverse.org/reference/easl_game.md),
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md),
[`easl_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_leaders.md),
[`easl_pbp()`](https://hoopR.sportsdataverse.org/reference/easl_pbp.md),
[`easl_player_box()`](https://hoopR.sportsdataverse.org/reference/easl_player_box.md),
[`easl_player_stats()`](https://hoopR.sportsdataverse.org/reference/easl_player_stats.md),
[`easl_players()`](https://hoopR.sportsdataverse.org/reference/easl_players.md),
[`easl_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_schedule.md),
[`easl_seasons()`](https://hoopR.sportsdataverse.org/reference/easl_seasons.md),
[`easl_standings()`](https://hoopR.sportsdataverse.org/reference/easl_standings.md),
[`easl_team()`](https://hoopR.sportsdataverse.org/reference/easl_team.md),
[`easl_team_box()`](https://hoopR.sportsdataverse.org/reference/easl_team_box.md),
[`easl_team_box_by_period()`](https://hoopR.sportsdataverse.org/reference/easl_team_box_by_period.md),
[`easl_team_leaders()`](https://hoopR.sportsdataverse.org/reference/easl_team_leaders.md),
[`easl_team_schedule()`](https://hoopR.sportsdataverse.org/reference/easl_team_schedule.md),
[`easl_team_stats()`](https://hoopR.sportsdataverse.org/reference/easl_team_stats.md),
[`easl_teams()`](https://hoopR.sportsdataverse.org/reference/easl_teams.md)
