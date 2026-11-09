# **Get ACB Lead Stats**

Lead statistics of a game (best run, maximum lead, time ahead, lead
changes) per side.

One row per statistic and side (`stat` is `best_score_run`,
`max_difference`, `time_ahead` or `lead_changes`; `side` home or away).
`value` is the display value as sent (a count, or `'mm:ss'` for time
ahead); `bar_progress` is the length of the site's comparison bar.

Endpoint: `GET https://api2.acb.com/api/matchdata/Overview/lead-tracker`

## Usage

``` r
acb_lead_stats(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per statistic and side. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_lead_stats")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_lead_stats(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
