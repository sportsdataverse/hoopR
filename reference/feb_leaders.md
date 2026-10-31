# **FEB Game Leaders**

**Each team's top players of one FEB game by points, rebounds, assists
and fouls.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/Ranking/{game_id}`

One row per team, category and ranked player (`rank` 1 = the leader, in
the order the feed lists them).

## Usage

``` r
feb_leaders(game_id)
```

## Arguments

- game_id:

  (*integer* required): FEB game id, e.g. `2535725`; the `game_id`
  column of
  [`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
  [`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md)
  and
  [`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md).

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
| team_side | character | Side of the game the row belongs to: home or away (the feed's TEAM\[0\] / TEAM\[1\], or its 1/2 and 0/1 side codes, normalised). |
| team_id | integer | Team-season id (key space: FEB team registrations; a NEW id every season, e.g. HLA Alicante = 979989 in 2025-26 and 1008687 in 2026-27). Joins the schedule's home_team_id / away_team_id; not a club or player id. |
| team | character | Team name as registered for the season (sponsor name, uppercase: 'HLA ALICANTE'). |
| category | character | Leader category: points, rebounds, assists or fouls (the feed's Puntos, Rebotes, Asistencias, Faltas). |
| rank | integer | Place in the team's category list, 1 = the leader, in the order the feed lists them. |
| player_id | integer | FEB person id: stable across seasons and clubs (A. Jorda Rodriguez = 1676991 in 2025-26 and 2026-27). Joins the box score, play-by-play, shots and leaders; not the per-season licence_id. |
| shirt_number | character | Shirt number (dorsal) as a string, so '00' and '0' stay distinct. The shot feed names the shooter by this number. |
| player | character | Player name as 'I. SURNAME(S)', uppercase ('V. AGUILAR HERNANDEZ'). |
| starter | logical | True when the player was in the starting five (the page's I column), false when on the bench. |
| captain | logical | True for the team captain. Null on 2020-21 games, where the feed does not send it. |
| value | integer | The player's count in the row's category (points, rebounds, assists or personal fouls). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

     feb_leaders(game_id = 2535725)

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)
