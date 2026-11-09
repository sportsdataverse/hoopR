# **Get P. LEAGUE+ Preciser Rotation**

On-court stints of every player of one finished game (the rotation
chart).

Endpoint:
`GET https://api.preciser.io/game/rotation/chart/o/plg/gameId/{uuid}`

## Usage

``` r
pleague_preciser_rotation(uuid, gid = NULL)
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

A `hoopR_data` tibble: On-court stints of every player of one finished
game (the rotation chart). An empty valid answer is a zero-row tibble
with these columns, in this order (sportsdataverse-py
`pleague_preciser_rotation`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| side | character | Which team the row belongs to: home or away. |
| name_zh | character | Player name (Traditional Chinese); equals the site box name_zh, which is how the runtime checks the roster. |
| jersey | integer | Shirt number (an integer here; the box prints it as a string). |
| started | logical | True when the player started the game. |
| stint_no | integer | 1-based position of the stint among the player's stints, in game order. |
| start_period | character | Period in which the stint starts (Q1-Q4, OT1, ...). |
| start_clock | character | Clock REMAINING in start_period when the stint starts, 'm:ss'. |
| start_seconds | integer | Seconds elapsed on the game clock when the stint starts (cumulative across periods). |
| end_period | character | Period in which the stint ends. |
| end_clock | character | Clock REMAINING in end_period when the stint ends, 'm:ss'. |
| end_seconds | integer | Seconds elapsed on the game clock when the stint ends (cumulative across periods). |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md).

     pleague_preciser_rotation(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.
