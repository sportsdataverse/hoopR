# **Get VTB Infobasket Play-by-Play**

Play-by-play of a finished game with shot x/y (2022-23 onwards; earlier
games have no plays).

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_pbp(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_pbp")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_pbp(game_id = 921391))
#> ── VTB Infobasket Play-by-Play from org.infobasket.su ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:06:16 UTC
#> # A tibble: 1,152 × 18
#>    game_id play_id parent_play_id play_type_id play_type play_period play_second
#>      <int>   <int>          <int>        <int> <chr>           <int>       <int>
#>  1  921391       0             NA            0 -                   4        6000
#>  2  921391       1             NA           60 Warmup              1           0
#>  3  921391       2             NA           59 (none)              1           0
#>  4  921391       3             NA           21 Start               1           0
#>  5  921391       4              3            8 In                  1           0
#>  6  921391       5              3            8 In                  1           0
#>  7  921391       6              3            8 In                  1           0
#>  8  921391       7              3            8 In                  1           0
#>  9  921391       8              3            8 In                  1           0
#> 10  921391       9              3            8 In                  1           0
#> # ℹ 1,142 more rows
#> # ℹ 11 more variables: play_sort_order <int>, play_flag <int>, start_id <int>,
#> #   team_number <int>, team_id <int>, person_id <int>, play_zone <int>,
#> #   play_x <int>, play_y <int>, video_from <int>, video_to <int>
# }
```
