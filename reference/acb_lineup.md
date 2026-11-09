# **Get ACB Lineup**

Players of a game with their game line, starters first.

One row per team and player in feed order; `lineup_order` is the 1-based
position (the feed lists the starters first, then the bench).
`is_playing` is true while the player is on court (false once the game
is over). `rebounds` is total rebounds, `fouls` personal fouls
committed, `differential` the plus/minus.

Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/lineup`

## Usage

``` r
acb_lineup(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per team and player. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_lineup")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_lineup(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
