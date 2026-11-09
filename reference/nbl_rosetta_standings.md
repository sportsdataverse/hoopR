# **NBL Rosetta Standings**

Regular-season ladder: position, record, points for and against, home
and away splits and form.

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/{org}/standings/{season}/regular`

## Usage

``` r
nbl_rosetta_standings(season, org = "nbl", limit = NULL)
```

## Arguments

- season:

  (*integer* required): Season END year (2026 = 2025-26). The runtime
  maps it to Rosetta's year: the START year for the NBL and WNBL from
  1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons
  up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds
  two seasons; the matches frame keeps the one asked for.

- org:

  (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl
  (women's) or nbl1 (the second tier, men's and women's conferences).
  One of `"nbl"`, `"wnbl"`, `"nbl1"`.

- limit:

  (*integer* default `NULL`): Rows to return. Omitted = a page large
  enough for the whole list (a short page cut by Rosetta's path cache is
  refused).

## Value

A `hoopR_data` tibble with one row per ladder entry. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbl_rosetta_standings")`) and in the
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
  try(nbl_rosetta_standings(org = "nbl", season = 2026))
#> ── NBL Rosetta standings from prod.rosetta.nbl.com.au ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:15:59 UTC
#> # A tibble: 10 × 24
#>    org   rosetta_standing_id       position   won  lost played points_percentage
#>    <chr> <chr>                        <int> <int> <int>  <int>             <dbl>
#>  1 nbl   49b90e1d-4806-4142-9e73-…        1    24     9     33             1.14 
#>  2 nbl   469aff8e-afc6-4867-9d5b-…        3    22    11     33             1.09 
#>  3 nbl   f3db1c02-d617-442b-b029-…        4    21    12     33             1.05 
#>  4 nbl   11dc80a4-035b-41e0-b79d-…        2    23    10     33             1.05 
#>  5 nbl   c08140c3-7ce8-4030-b428-…        5    20    13     33             1.05 
#>  6 nbl   0a7b5591-3b70-42f7-a102-…        6    14    19     33             0.996
#>  7 nbl   d923eb2b-1f11-4b4a-8ce6-…        7    13    20     33             0.988
#>  8 nbl   6d5a2929-416e-4885-86d5-…        8    13    20     33             0.959
#>  9 nbl   f57a0e71-c3ff-4acf-b98c-…        9     9    24     33             0.862
#> 10 nbl   d2538239-3147-4ada-a09d-…       10     6    27     33             0.848
#> # ℹ 17 more variables: win_percentage <dbl>, last_5 <chr>, streak <int>,
#> #   points_for <int>, points_against <int>, away_losses <int>, away_wins <int>,
#> #   home_losses <int>, home_wins <int>, team_id <chr>, rosetta_team_id <chr>,
#> #   team_code <chr>, team_name <chr>, season_year <int>, season_type <chr>,
#> #   season_competition_division <chr>, season_end_year <int>
# }
```
