# **Get ACB Player Advanced Stats**

One player's advanced statistics in a game against his season and
win/loss splits.

One row per statistic group and statistic, with the same value columns
as `acb_match_advanced_stats`. `player_id` is the requested licence (the
body names no player).

Endpoint:
`GET https://api2.acb.com/api/matchdata/AdvancedStats/player-advanced-stats`

## Usage

``` r
acb_player_advanced_stats(match_id, player_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per statistic group and statistic.
Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_player_advanced_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_player_advanced_stats(match_id = 105401, player_id = 20212243)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
