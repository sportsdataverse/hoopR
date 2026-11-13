# **NBL Rosetta Seasons Current**

The season in progress (empty between seasons: `hoopR_no_data`).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/seasons/current`

## Usage

``` r
nbl_rosetta_seasons_current(org = "nbl")
```

## Arguments

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_seasons_current")`) and in
the searchable [return
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
  try(nbl_rosetta_seasons_current(org = "nbl"))
#> ── NBL Rosetta seasons_current from prod.rosetta.nbl.com.au ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:16:34 UTC
#> # A tibble: 1 × 12
#>   org   season_id     rosetta_season_id name  season_year season_type start_date
#>   <chr> <chr>         <chr>             <chr>       <int> <chr>       <chr>     
#> 1 nbl   1b041b7b-3dd… 67d4a190-40bc-4b… NBL27        2026 regular     2026-09-1…
#> # ℹ 5 more variables: end_date <chr>, competition_name <chr>,
#> #   competition_age_group <chr>, next_match_start_datetime <chr>,
#> #   season_end_year <int>
# }
```
