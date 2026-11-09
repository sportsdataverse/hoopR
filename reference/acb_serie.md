# **Get ACB Playoff Series**

The playoff series a game belongs to, one row per game of the series
(HTTP 204 outside a series).

One row per game of the series: `match_id` is that game and
`requested_match_id` the game asked for (every row repeats it).
`home_team_id` / `away_team_id` are the team entries of THAT game,
`series_home_*` the team with home court. `series_home_wins` /
`series_away_wins` are the series wins, `best_of` the series length as
sent (0 in the 2016-17 final sample: read it as unknown). A game outside
a series answers HTTP 204 (`hoopR_no_data`).

Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/serie`

## Usage

``` r
acb_serie(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per game of the series. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_serie")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_serie(match_id = 17718)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
