# **Get ACB Career Trophies**

A player's trophies, one row per competition.

One row per competition: times champion and times runner-up.

Endpoint: `GET https://api2.acb.com/api/seasondata/PlayerProfile/career`

## Usage

``` r
acb_career_trophies(player_id)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble, one row per record described above; the columns
are always these, in this order (sportsdataverse-py
`acb_career_trophies`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | ACB licence number asked for. |
| competition_id | integer | Competition id: 1 Liga Endesa, 2 Copa del Rey, 3 Supercopa Endesa, 10 Minicopa Endesa (x-competitions) |
| times_champion | integer | Times the player won the competition. |
| times_runner_up | integer | Times the player was runner-up in the competition. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_career_trophies(player_id = 20209407)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
