# **Get TPBL Head-to-Head Standings**

Head-to-head record of every team against every other team in one
division.

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/games/standings`

## Usage

``` r
tpbl_standings_against(division_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

## Value

A `hoopR_data` tibble: Head-to-head record of every team against every
other team in one division. An empty answer raises `hoopR_no_data`; the
columns are always these, in this order (sportsdataverse-py
`tpbl_standings_against`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. The ranked team. |
| opponent_team_id | integer | TPBL team id of the opponent (franchise, 2-8). Joins team_id. |
| opponent_gohoops_team_id | integer | GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). The opponent. |
| opponent | character | Opponent name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| won | integer | Games the ranked team won against this opponent in the division. |
| lost | integer | Games the ranked team lost against this opponent in the division. |
| drawn | integer | Games drawn against this opponent (always 0). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_standings_against(division_id = 2)

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.
