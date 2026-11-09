# **Get TPBL Team Shots**

Every field-goal attempt of one team in one division with its court
position (optionally per quarter).

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/teams/{team_id}/shooting-spots`

## Usage

``` r
tpbl_team_shots(division_id, team_id, rounds = NULL)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

- team_id:

  Required. TPBL team id (the franchise, 2-8, stable across seasons);
  `team_id` in tpbl_teams. Not the GoHoops id.

- rounds:

  Quarter filter: a quarter number or a vector of them (1-4, 5 and 6 for
  overtimes); the runtime sends it as the API's repeatable `rounds[]`.
  `NULL` (the default) for all quarters.

## Value

A `hoopR_data` tibble: Every field-goal attempt of one team in one
division with its court position (optionally per quarter). An empty
answer raises `hoopR_no_data`; the columns are always these, in this
order (sportsdataverse-py `tpbl_team_shots`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| rounds | character | The quarter filter asked for, comma-separated ('1' or '1,2'); null when all quarters were asked. |
| is_made | logical | True when the shot went in. |
| point_x | integer | Shot position in MILLIMETRES, 0-28000 along the court length (a 28 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. Verified on 2,971 shots of one team: the made rate within 1.2 m of the hoop is 62-71 %. Which baseline is x = 0 is unverified. |
| point_y | integer | Shot position in MILLIMETRES, 0-15000 across the court (a 15 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. The direction of y is unverified. |
| offense_basket | integer | Basket the team attacked: 0 = the hoop at x = 1575, 1 = the hoop at x = 26425. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_team_shots(division_id = 2, team_id = 4, rounds = 1)

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.
