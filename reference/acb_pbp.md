# **Get ACB Play-by-Play**

Play-by-play of a game (2016-17 onward): every shot, rebound, foul,
turnover, substitution and time-out.

One row per event. `play_type` is the API's event code and `play_name`
its bundle name (`acb_codes.PLAY_TYPES`; a code outside the table, such
as the minute marker 600, has no name); `turnover_type` decodes
`play_tag`. The clock counts DOWN: `minute` / `second` are the time left
in the period and `clock_seconds` the same in seconds. `order` is not
unique (the starting five share one); `play_index` is the 1-based
position in the feed. `is_home` is true for the home team's events (the
feed's `local`). `run_*` columns are the acting player's running box
score AFTER the event. Games before 2016-17 answer no events (the
wrapper raises `hoopR_no_data`).

Endpoint:
`GET https://api2.acb.com/api/matchdata/PlayByPlay/play-by-play`

## Usage

``` r
acb_pbp(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per event. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(acb_pbp(match_id = 105401))
#> ── ACB Play-by-Play from api2.acb.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:12:26 UTC
#> # A tibble: 735 × 38
#>    match_id edition_id season play_index order quarter minute second
#>       <int>      <int>  <int>      <int> <int>   <int>  <int>  <int>
#>  1   105401         91   2027          1    10       1     10      0
#>  2   105401         91   2027          2    10       1     10      0
#>  3   105401         91   2027          3    10       1     10      0
#>  4   105401         91   2027          4    10       1     10      0
#>  5   105401         91   2027          5    10       1     10      0
#>  6   105401         91   2027          6    10       1     10      0
#>  7   105401         91   2027          7    10       1     10      0
#>  8   105401         91   2027          8    10       1     10      0
#>  9   105401         91   2027          9    10       1     10      0
#> 10   105401         91   2027         10    10       1     10      0
#> # ℹ 725 more rows
#> # ℹ 30 more variables: clock_seconds <int>, play_type <int>, play_name <chr>,
#> #   play_tag <int>, turnover_type <chr>, is_home <lgl>, score_home <int>,
#> #   score_away <int>, license_type <int>, player_id <int>, player_name <chr>,
#> #   shirt_number <chr>, run_points <int>, run_free_throws_made <int>,
#> #   run_free_throws_attempted <int>, run_two_pointers_made <int>,
#> #   run_two_pointers_attempted <int>, run_three_pointers_made <int>, …
# }
```
