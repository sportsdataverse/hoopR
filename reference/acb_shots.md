# **Get ACB Shots**

Every field-goal and free-throw attempt of a game (2016-17 onward) with
its court position.

One row per attempt. Two coordinate systems share `pos_x` / `pos_y`,
told apart by `coord_system`: `mm` (match ids from 2020-21) is
millimetres from the centre of the attacked basket, every shot mirrored
to one basket, `pos_x` towards midcourt and `pos_y` across the court
(negative = the shooter's left); `x_basket_m` / `y_basket_m` are those
in metres. `grid` (up to 2019-20) is a 0-100 percent grid over the full
court, NOT mirrored (teams switch ends at half time), and has no
basket-relative metres (null). Free throws are (0, 0) with a null
`zone`; legacy zones are unreliable. The inference of units and origin
is the refs' (arc and sideline fit), not documented by ACB.
`player_name` comes from the game's shooter list.

Endpoint:
`GET https://api2.acb.com/api/matchdata/MatchShots/match-shots`

## Usage

``` r
acb_shots(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per attempt. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_shots")`) and in the searchable
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
  try(acb_shots(match_id = 105401))
#> ── ACB Shots from api2.acb.com ────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:10:35 UTC
#> # A tibble: 188 × 24
#>    match_id edition_id season shot_id pos_x pos_y coord_system x_basket_m
#>       <int>      <int>  <int>   <int> <int> <int> <chr>             <dbl>
#>  1   105401         91   2027     901  1426  -673 mm                1.43 
#>  2   105401         91   2027    1001   484   698 mm                0.484
#>  3   105401         91   2027    1701  1452  -806 mm                1.45 
#>  4   105401         91   2027    1801  3308   -27 mm                3.31 
#>  5   105401         91   2027    1901  1183   565 mm                1.18 
#>  6   105401         91   2027    2001   538  -592 mm                0.538
#>  7   105401         91   2027    2101  1291   915 mm                1.29 
#>  8   105401         91   2027    2201  2125  -646 mm                2.12 
#>  9   105401         91   2027    2701  4815   -53 mm                4.82 
#> 10   105401         91   2027    2901  8150 -4302 mm                8.15 
#> # ℹ 178 more rows
#> # ℹ 16 more variables: y_basket_m <dbl>, quarter <int>, minute <int>,
#> #   second <int>, clock_seconds <int>, play_type <int>, play_name <chr>,
#> #   is_home <lgl>, score_home <int>, score_away <int>, player_id <int>,
#> #   player_name <chr>, shirt_number <chr>, zone <chr>, made <lgl>, points <int>
# }
```
