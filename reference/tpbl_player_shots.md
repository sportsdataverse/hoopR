# **Get TPBL Player Shots**

Every field-goal attempt of one player in one division with its court
position.

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/players/{player_id}/shooting-spots`

## Usage

``` r
tpbl_player_shots(division_id, player_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

- player_id:

  Required. TPBL player id (one per person across seasons and teams);
  `player_id` in tpbl_roster. Not the GoHoops person id and not the
  roster id.

## Value

A `hoopR_data` tibble: Every field-goal attempt of one player in one
division with its court position. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `tpbl_player_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
| is_made | logical | True when the shot went in. |
| point_x | integer | Shot position in MILLIMETRES, 0-28000 along the court length (a 28 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. Same frame as the team list, where it was verified; here it is only checked to stay on the court. |
| point_y | integer | Shot position in MILLIMETRES, 0-15000 across the court (a 15 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. The direction of y is unverified. |
| offense_basket | integer | Basket the player's team attacked: 0 = the hoop at x = 1575, 1 = the hoop at x = 26425. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_player_shots(division_id = 2, player_id = 75)

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.
