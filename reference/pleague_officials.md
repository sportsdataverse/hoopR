# **Get P. LEAGUE+ Officials**

The referee and the two umpires printed under the header of one finished
game (names only).

Endpoint: `GET https://pleagueofficial.com/game/{gid}`

## Usage

``` r
pleague_officials(gid)
```

## Arguments

- gid:

  Required. P. LEAGUE+ game id on the site: ONE global integer sequence
  over every stage and season (197 = the 2022-23 opener, 662 = the
  2025-26 opener), e.g. 197; `gid` in pleague_schedule. Only finished
  games are served.

## Value

A `hoopR_data` tibble: The referee and the two umpires printed under the
header of one finished game (names only). An empty valid answer is a
zero-row tibble with these columns, in this order (sportsdataverse-py
`pleague_officials`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| gid | integer | P. LEAGUE+ game id on the site: ONE global integer sequence over every stage and season (1-12 = 2020-21 pre-season, 13 = the 2020-21 opener, 197 = the 2022-23 opener, 662 = the 2025-26 opener), with gaps; a row id, not a count. The {gid} of /game/{gid}. |
| official_no | integer | 1-based position of the official in the printed line (referee first). |
| role | character | Role translated: referee ((Chinese text), the crew chief), first_umpire ((Chinese text), literally 'first inspector'), second_umpire ((Chinese text)). Null for a role this table does not know. |
| role_zh | character | Official's role as printed: (Chinese text) = referee, (Chinese text) = first umpire, (Chinese text) = second umpire. |
| name_zh | character | Official's name in Traditional Chinese. Names only: the page carries no ids or contact data. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

     pleague_officials(gid = 197)

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.
