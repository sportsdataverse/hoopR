# **Get P. LEAGUE+ Player**

One player's profile: names, club, jersey, position, height, weight and
birthplace.

Endpoint: `GET https://pleagueofficial.com/player/{player_page_id}`

## Usage

``` r
pleague_player(player_page_id)
```

## Arguments

- player_page_id:

  Required. The 8-character page id of /player/{id} (e.g. '1JbPozLB' =
  Lai Ting-En); `player_page_id` in pleague_stat_player, `random_id` in
  pleague_box_players from 2022-23 (unreliable before).

## Value

A `hoopR_data` tibble: One player's profile: names, club, jersey,
position, height, weight and birthplace. An empty valid answer is a
zero-row tibble with these columns, in this order (sportsdataverse-py
`pleague_player`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_page_id | character | The 8-character page id of /player/{id} (e.g. '1JbPozLB'). The box random_id on 2022-23+ rows; NOT the box player_id. |
| player_id | integer | P. LEAGUE+ player-team membership id (the box player_id), read from the page's trackPlayer() call, e.g. 40 = Lai Ting-En. NOT the 8-character page id. |
| name_zh | character | Player name as printed (Traditional Chinese, or a transliteration for foreign players). |
| name_en | character | Player name in Latin letters. |
| team_zh | character | Current team's short name in Traditional Chinese. |
| team_en | character | Current team's English name. |
| jersey | character | Shirt number as printed, a string ('0', '00' and '10' differ). |
| position | character | Position letter: G guard, F forward, C centre. |
| nickname | character | Nickname ((Chinese text)); null when blank. |
| tenure | character | Years of service ((Chinese text)) as the page prints it, with a prime character ('0”). |
| height_cm | double | Height in centimetres ((Chinese text)). |
| weight_kg | double | Weight in kilograms ((Chinese text)). |
| birthplace_zh | character | Birthplace in Traditional Chinese ((Chinese text); a country for foreign players). The date of birth is dropped on purpose. |
| status_zh | character | Player status ((Chinese text)): (Chinese text) = import (foreign player), (Chinese text) = local (Taiwanese) player. |
| education | character | Education lines ((Chinese text)) as printed, joined with '; '. |

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

     pleague_player(player_page_id = "1JbPozLB")

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.
