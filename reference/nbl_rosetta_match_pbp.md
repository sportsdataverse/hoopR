# **NBL Rosetta Match Play-by-Play**

One match's play-by-play with shot x/y, oldest first (NBL 2025-26
included, which ESPN's nbl feed lacks).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match_pbp(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble with one row per event. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_match_pbp")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md).

## See also

[family_nbl_rosetta](https://hoopR.sportsdataverse.org/reference/family_nbl_rosetta.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(nbl_rosetta_match_pbp(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#> ── NBL Rosetta match_pbp from prod.rosetta.nbl.com.au ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:18:37 UTC
#> # A tibble: 982 × 29
#>    match_id     rosetta_match_id match_status action_id period period_type clock
#>    <chr>        <chr>            <chr>            <int>  <int> <chr>       <chr>
#>  1 b217a699-4b… 08bccaee-57ee-4… complete             1      1 regular     NA   
#>  2 b217a699-4b… 08bccaee-57ee-4… complete             1      1 regular     NA   
#>  3 b217a699-4b… 08bccaee-57ee-4… complete             2      1 regular     10:00
#>  4 b217a699-4b… 08bccaee-57ee-4… complete             2      1 regular     NA   
#>  5 b217a699-4b… 08bccaee-57ee-4… complete             3      1 regular     10:00
#>  6 b217a699-4b… 08bccaee-57ee-4… complete             4      1 regular     09:59
#>  7 b217a699-4b… 08bccaee-57ee-4… complete             5      1 regular     10:00
#>  8 b217a699-4b… 08bccaee-57ee-4… complete             6      1 regular     09:59
#>  9 b217a699-4b… 08bccaee-57ee-4… complete             7      1 regular     10:00
#> 10 b217a699-4b… 08bccaee-57ee-4… complete             9      1 regular     09:38
#> # ℹ 972 more rows
#> # ℹ 22 more variables: clock_seconds <dbl>, shot_clock <chr>,
#> #   shot_clock_seconds <dbl>, score_home <int>, score_away <int>,
#> #   action_type <chr>, sub_type <chr>, sub_type_key <chr>, success <lgl>,
#> #   team_id <chr>, team_code <chr>, team_name <chr>, is_home <lgl>,
#> #   player_id <chr>, player_name <chr>, jersey_number <chr>, x <dbl>, y <dbl>,
#> #   readable_action_type <chr>, system_action_type <chr>, timestamp <chr>, …
# }
```
