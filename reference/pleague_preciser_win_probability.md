# **Get P. LEAGUE+ Preciser Win Probability**

The vendor's home-team win probability by minute for one finished game.

Endpoint:
`GET https://api.preciser.io/post/game/summary/o/plg/gameId/{uuid}`

## Usage

``` r
pleague_preciser_win_probability(uuid, gid = NULL)
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

A `hoopR_data` tibble: The vendor's home-team win probability by minute
for one finished game. An empty valid answer is a zero-row tibble with
these columns, in this order (sportsdataverse-py
`pleague_preciser_win_probability`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_uuid | character | Preciser game uuid (key space: the vendor's games, a version-1 uuid), the uuid asked for; `uuid` of pleague_game. |
| minute | integer | Minute mark: 0 is the tip-off (50 percent); 49 entries for a 48-minute game. |
| home_win_pct | double | The home team's win probability in percent (0-100) at that minute; the vendor documents no method. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_preciser_shots()`](https://hoopR.sportsdataverse.org/reference/pleague_preciser_shots.md).

     pleague_preciser_win_probability(uuid = "e6f98675-3e5b-11ed-949e-5d17350689cf")

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.
