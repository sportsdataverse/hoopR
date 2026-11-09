# **Get ACB Team Comparison**

Team-versus-team comparison bars of a game per period.

One row per period and statistic. `quarter` 0 is the whole game.
`home_value` / `away_value` parse the bar's display value (Spanish
decimal comma, `'79,17%'` becomes 79.17; a count stays a count); for the
shooting statistics `*_made` / `*_attempted` parse the `'19/24'`
subtitle. `*_is_highlighted` marks the side the site highlights.

Endpoint:
`GET https://api2.acb.com/api/matchdata/Overview/match-team-comparison`

## Usage

``` r
acb_team_comparison(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per period and statistic. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_team_comparison")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_team_comparison(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
