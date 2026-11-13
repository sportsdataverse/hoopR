# **Get VTB Infobasket Game**

Header of a finished game: stage, venue, rules, the two teams and their
scores.

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_game(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_game")`) and in the
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
  try(vtb_infobasket_game(game_id = 921391))
#> ── VTB Infobasket Game from org.infobasket.su ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 19:00:02 UTC
#> # A tibble: 1 × 56
#>   is_online game_status max_period from_date game_date  has_time game_time
#>   <lgl>           <int>      <int> <chr>     <chr>      <lgl>    <chr>    
#> 1 FALSE               1          4 NA        2025-09-28 TRUE     14.00    
#> # ℹ 49 more variables: game_time_msk <chr>, has_video <lgl>, tv_ru <chr>,
#> #   tv_en <chr>, comp_name_ru <chr>, comp_name_en <chr>, league_name_ru <chr>,
#> #   league_name_en <chr>, league_short_name_ru <chr>,
#> #   league_short_name_en <chr>, gender <int>, comp_id <int>, is3x3 <lgl>,
#> #   season_comp_id <int>, game_id <int>, game_number <chr>,
#> #   game_date_time <chr>, region_id <int>, arena_id <int>, venue_en <chr>,
#> #   venue_ru <chr>, attendance <int>, period_count <int>, …
# }
```
