# **Get P. LEAGUE+ Preciser Lead Flow**

Score at each minute mark of one finished game, with the score
difference (the lead tracker).

Endpoint:
`GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`

## Usage

``` r
pleague_preciser_lead_flow(uuid, gid = NULL)
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

A `hoopR_data` tibble: Score at each minute mark of one finished game,
with the score difference (the lead tracker). An empty valid answer is a
zero-row tibble with these columns, in this order (sportsdataverse-py
`pleague_preciser_lead_flow`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| seq | integer | 1-based position of the minute mark in game order. |
| period | character | Period label: Q1-Q4, then OT1, OT2 (the vendor sends it in lower case). |
| period_no | integer | 1-based position of the period: 1-4 for Q1-Q4, 5 for OT1, 6 for OT2. |
| clock | character | Game clock REMAINING in the period 'mm:ss' (counts down). |
| seconds_left | integer | The clock as whole seconds remaining in the period (08:34 = 514), derived by the parser. |
| home_score | integer | Home score after the event. |
| away_score | integer | Away score after the event. |
| score_difference | integer | home_score minus away_score (positive = home leads). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md).

     pleague_preciser_lead_flow(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.
