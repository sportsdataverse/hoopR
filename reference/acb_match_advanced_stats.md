# **Get ACB Match Advanced Stats**

Team advanced statistics of a game against the team's season and
win/loss splits.

One row per team (`team_side`), statistic group and statistic:
`match_value` is this game, `season_value` the team's season value,
`win_value` / `loss_value` its values in wins / losses, `*_diff` the
game minus that split. Groups: four_factors, game_rhythm, ball_handling,
shooting, points, ratings, rebounds. All are `Float64` (rates are
percentages 0-100 unless the stat is a ratio, such as
`pointsPerPossession`).

Endpoint:
`GET https://api2.acb.com/api/matchdata/AdvancedStats/match-advanced-stats`

## Usage

``` r
acb_match_advanced_stats(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per team, statistic group and
statistic. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_match_advanced_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_match_advanced_stats(match_id = 105401)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
