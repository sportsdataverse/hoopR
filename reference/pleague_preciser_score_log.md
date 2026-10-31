# **Get P. LEAGUE+ Preciser Score Log**

Scoring log of one finished game (scoring events only, with the running
score).

Endpoint:
`GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`

## Usage

``` r
pleague_preciser_score_log(uuid, gid = NULL)
```

## Arguments

- uuid:

  Required. The Preciser game uuid the site's game page embeds (`uuid`
  of pleague_game; empty before 2022-23, which have no vendor data),
  e.g. 'e6f98675-3e5b-11ed-949e-5d17350689cf' (gid 197).

- gid:

  Optional. The site's game id for this uuid. When given the runtime
  also fetches the site's game page and box (cached) and checks the
  vendor body against them (uuid, final score, made shots, roster and
  minutes); the uuid must be the game page's. Without it only the checks
  the body allows by itself run.

## Value

A `hoopR_data` tibble: Scoring log of one finished game (scoring events
only, with the running score). An empty valid answer is a zero-row
tibble with these columns, in this order (sportsdataverse-py
`pleague_preciser_score_log`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| seq | integer | 1-based position of the scoring event in game order. |
| period | character | Period label: Q1-Q4, then OT1, OT2 (the vendor sends it in lower case). |
| period_no | integer | 1-based position of the period: 1-4 for Q1-Q4, 5 for OT1, 6 for OT2. |
| clock | character | Game clock REMAINING in the period 'mm:ss' (counts down). |
| seconds_left | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
| home_score | integer | Home score after the event. |
| away_score | integer | Away score after the event. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md).

     pleague_preciser_score_log(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")

## See also

Other P. LEAGUE+ Functions:
[`pleague_box_players()`](https://hoopR.sportsdataverse.org/reference/pleague_box_players.md),
[`pleague_box_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_box_teams.md),
[`pleague_game()`](https://hoopR.sportsdataverse.org/reference/pleague_game.md),
[`pleague_officials()`](https://hoopR.sportsdataverse.org/reference/pleague_officials.md),
[`pleague_pbp()`](https://hoopR.sportsdataverse.org/reference/pleague_pbp.md),
[`pleague_periods()`](https://hoopR.sportsdataverse.org/reference/pleague_periods.md),
[`pleague_player()`](https://hoopR.sportsdataverse.org/reference/pleague_player.md),
[`pleague_player_seasons()`](https://hoopR.sportsdataverse.org/reference/pleague_player_seasons.md),
[`pleague_preciser_injury()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_injury.md),
[`pleague_preciser_lead_flow()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_lead_flow.md),
[`pleague_preciser_rotation()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_rotation.md),
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md),
[`pleague_preciser_summary_teams()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_summary_teams.md),
[`pleague_preciser_win_probability()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_win_probability.md),
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md),
[`pleague_standings()`](https://hoopR.sportsdataverse.org/reference/pleague_standings.md),
[`pleague_stat_player()`](https://hoopR.sportsdataverse.org/reference/pleague_stat_player.md),
[`pleague_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/pleague_team_crosswalk.md)
