# **Get TPBL Divisions**

The divisions (preseason, regular season, play-in, playoffs, finals) of
one season.

Endpoint:
`GET https://api.tpbl.basketball/api/events/{season}/divisions`

## Usage

``` r
tpbl_divisions(season)
```

## Arguments

- season:

  Required. Season END year (2026 = the 2025-26 season; 2025 is the
  first). The API keys a season by its own small integer (1, 2, 3 =
  2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the
  same number): the runtime reads /seasons once and sends that id, so
  the example URL shows the year. A year the list lacks raises
  `hoopR_no_data`.

## Value

A `hoopR_data` tibble: The divisions (preseason, regular season,
play-in, playoffs, finals) of one season. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order
(sportsdataverse-py `tpbl_divisions`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
| season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
| gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
| gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. |
| name | character | Division name (Traditional Chinese: preseason (warm-up games), regular season, postseason challenge (play-in round), playoffs, finals). |
| status | character | Division status: COMPLETED or IN_PROGRESS. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_divisions(season = 2026)

## See also

Other TPBL Functions:
[`tpbl_box_player_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_player_periods.md),
[`tpbl_box_players()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_players.md),
[`tpbl_box_team_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_team_periods.md),
[`tpbl_box_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_teams.md),
[`tpbl_game()`](https://hoopR.sportsdataverse.org/reference/tpbl_game.md),
[`tpbl_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_games.md),
[`tpbl_player_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_games.md),
[`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md),
[`tpbl_referees()`](https://hoopR.sportsdataverse.org/reference/tpbl_referees.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)
