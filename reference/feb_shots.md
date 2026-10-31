# **FEB Shots**

**Every field-goal attempt of one FEB game with its court position
(percent of a full-court image).**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/ShotChart/{game_id}`

Free throws are not in the feed. `x` / `y` are percent (0-100) of a
horizontal full-court image, origin top-left; teams change ends at
half-time. The feed names the shooter by shirt number: `player_id` is
resolved through the game's roster (side + shirt number) and is `NA`
when that pair is not unique.

## Usage

``` r
feb_shots(game_id)
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
| period | integer | Period number of the attempt. |
| clock | character | Game clock REMAINING in the period at the shot, 'mm:ss' (the play-by-play line's time). |
| clock_seconds | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
| team_side | character | Side of the shooter: home (feed code 0) or away (feed code 1; play-by-play uses 1/2). |
| team_id | integer | Team-season id of the shooter's team (from the shot chart's TEAM list); new every season. |
| shirt_number | character | Shirt number (dorsal) as a string, so '00' and '0' stay distinct. The shot feed names the shooter by this number. |
| player_id | integer | FEB person id of the shooter, resolved from side + shirt number in the game's roster; null when that pair is not unique. The feed itself carries no player id. |
| made | logical | True when the shot was made, false when missed. Free throws are not in the feed. |
| x | double | Court x position: percent (0-100) of the length of a horizontal full-court image, origin top-left. Teams change ends at half-time; metres (x/100 x 28) are an unverified inference. |
| y | double | Court y position: percent (0-100) of the width of a horizontal full-court image from the top edge; baskets sit near y = 50. Metres (y/100 x 15) are an unverified inference. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

     feb_shots(game_id = 2535725)

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)
