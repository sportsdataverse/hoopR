# **Get ACB Player Box**

Per-player box score of a game, per period (quarter 0 = the whole game).

One row per team, period and player. `quarter` 0 is the whole game, 1-4
the periods, 5+ overtime (games before about 2010 carry only quarter 0).
`team_side` is home or away (the feed lists the home team first).
`play_time` is `'mm:ss'` and `seconds_played` the same in seconds;
counts are `Int64`. `player_id` is the ACB licence number; `game_role`
is the Spanish position.

Endpoint: `GET https://api2.acb.com/api/matchdata/Result/boxscores`

## Usage

``` r
acb_player_box(match_id)
```

## Arguments

- match_id:

  (required) ACB match id (integer), one global sequence for every
  competition: legacy ids (seasons up to 2019-20) sit below about 20000
  (12559 = the 2005-06 final); ids from 2020-21 start around 100000
  (105401 = Barca 89-86 Valencia Basket, Liga 2026-27 round 3). A whole
  number; a whole double is accepted.

## Value

A `hoopR_data` tibble with one row per player and period. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_player_box")`) and in the searchable
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
  try(acb_player_box(match_id = 105401))
#> ── ACB Player Box from api2.acb.com ───────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:10:29 UTC
#> # A tibble: 120 × 39
#>    match_id edition_id season team_side team_id club_id team  team_abbr quarter
#>       <int>      <int>  <int> <chr>       <int>   <int> <chr> <chr>       <int>
#>  1   105401         91   2027 home         4467       2 Barça BAR             0
#>  2   105401         91   2027 home         4467       2 Barça BAR             0
#>  3   105401         91   2027 home         4467       2 Barça BAR             0
#>  4   105401         91   2027 home         4467       2 Barça BAR             0
#>  5   105401         91   2027 home         4467       2 Barça BAR             0
#>  6   105401         91   2027 home         4467       2 Barça BAR             0
#>  7   105401         91   2027 home         4467       2 Barça BAR             0
#>  8   105401         91   2027 home         4467       2 Barça BAR             0
#>  9   105401         91   2027 home         4467       2 Barça BAR             0
#> 10   105401         91   2027 home         4467       2 Barça BAR             0
#> # ℹ 110 more rows
#> # ℹ 30 more variables: player_id <int>, player_name <chr>, first_name <chr>,
#> #   last_name <chr>, shirt_number <chr>, game_role <chr>, on_court <lgl>,
#> #   play_time <chr>, seconds_played <int>, is_starter <lgl>, points <int>,
#> #   free_throws_made <int>, free_throws_attempted <int>,
#> #   two_pointers_made <int>, two_pointers_attempted <int>,
#> #   three_pointers_made <int>, three_pointers_attempted <int>, assists <int>, …
# }
```
