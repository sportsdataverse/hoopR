# **Get TPBL Team Box Score by Quarter**

Per-quarter team lines of both teams: points scored and conceded in the
quarter, running totals and stats.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`

## Usage

``` r
tpbl_box_team_periods(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble: Per-quarter team lines of both teams: points
scored and conceded in the quarter, running totals and stats. An empty
answer raises `hoopR_no_data`; the columns are always these, in this
order (sportsdataverse-py `tpbl_box_team_periods`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
| side | character | Side of the game: home or away (the API lists the home team first and never infers it from the venue). |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
| team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
| period | integer | Quarter number of the row: 1-4 regulation, 5 = the first overtime, 6 = the second. |
| won_score | integer | Team-row field: points the team scored in this quarter alone. Player stat lines carry no value for it. |
| time_on_court | integer | Seconds on court by the team in this quarter (436 = 7:16). A team quarter sums its five players: 3600 = 5 x 720 s (12-minute quarter), 1500 = 5 x 300 s (5-minute overtime). |
| lost_score | integer | Team-row field: points the team conceded in this quarter alone. Not a player stat. |
| total_won_score | integer | Team-row field: points the team has scored up to and including this quarter (the last quarter's value is the final score). Not a player stat. |
| total_lost_score | integer | Team-row field: points the team has conceded up to and including this quarter. Not a player stat. |
| field_goals_made | integer | Field goals made by the team in this quarter. |
| field_goals_missed | integer | Field goals missed by the team in this quarter. |
| field_goals_attempted | integer | Field goals attempted by the team in this quarter. |
| field_goals_percentage | double | Field goals percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| two_pointers_made | integer | 2-point field goals made by the team in this quarter. |
| two_pointers_missed | integer | 2-point field goals missed by the team in this quarter. |
| two_pointers_attempted | integer | 2-point field goals attempted by the team in this quarter. |
| two_pointers_percentage | double | 2-point field goals percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| three_pointers_made | integer | 3-point field goals made by the team in this quarter. |
| three_pointers_missed | integer | 3-point field goals missed by the team in this quarter. |
| three_pointers_attempted | integer | 3-point field goals attempted by the team in this quarter. |
| three_pointers_percentage | double | 3-point field goals percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| free_throws_made | integer | Free throws made by the team in this quarter. |
| free_throws_missed | integer | Free throws missed by the team in this quarter. |
| free_throws_attempted | integer | Free throws attempted by the team in this quarter. |
| free_throws_percentage | double | Free throws percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| rebounds | integer | Total rebounds by the team in this quarter (offensive + defensive). |
| defensive_rebounds | integer | Defensive rebounds by the team in this quarter. |
| offensive_rebounds | integer | Offensive rebounds by the team in this quarter. |
| defensive_fouls | integer | Fouls committed on defense by the team in this quarter. |
| offensive_fouls | integer | Fouls committed on offense by the team in this quarter. |
| personal_fouls | integer | Personal fouls by the team in this quarter (excludes technical, unsportsmanlike and disqualifying fouls). |
| fouls | integer | Fouls charged by the team in this quarter: personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
| assists | integer | Assists by the team in this quarter. |
| steals | integer | Steals by the team in this quarter. |
| blocks | integer | Blocked shots by the team in this quarter. |
| turnovers | integer | Turnovers committed by the team in this quarter; equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
| points_in_paint | integer | Points scored in the paint by the team in this quarter. |
| second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the team in this quarter. |
| fast_break_points | integer | Points scored on the fast break by the team in this quarter. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_box_team_periods(game_id = 6)

## See also

Other TPBL Functions:
[`tpbl_box_player_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_player_periods.md),
[`tpbl_box_players()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_players.md),
[`tpbl_box_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_teams.md),
[`tpbl_divisions()`](https://hoopR.sportsdataverse.org/reference/tpbl_divisions.md),
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
