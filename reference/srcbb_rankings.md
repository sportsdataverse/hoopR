# **Sports-Reference Men's College Basketball AP Poll**

**Get the men's college basketball AP poll history for a season from
[Sports-Reference](https://www.sports-reference.com/cbb/).**

One row per ranked school with its week-by-week AP poll position
(preseason through final). No account or API key is required.

## Usage

``` r
srcbb_rankings(season = most_recent_mbb_season())
```

## Arguments

- season:

  (*integer* required): Season, 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per ranked school (`school`, `conf`,
and week-by-week poll columns), carrying a `season` column.

## See also

Other Sports-Reference College Basketball Functions:
[`srcbb_school_stats()`](https://hoopR.sportsdataverse.org/reference/srcbb_school_stats.md)

## Examples

``` r
# \donttest{
  try(srcbb_rankings(season = 2024))
#> ── Men's college basketball AP poll from sports-reference.com ─── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 23:00:40 UTC
#> # A tibble: 52 × 24
#>    school     conf  week1 week2 week3 week4 week5 week6 week7 week8 week9 week10
#>    <chr>      <chr> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>
#>  1 UConn      Big …     6     5     5     4     5     5     5     5     4      4
#>  2 Purdue     Big …     3     2     2     1     4     3     1     1     1      1
#>  3 Houston    Big …     7     6     6     6     3     4     3     3     3      2
#>  4 Alabama    SEC      24    22    17    23    NA    NA    NA    NA    NA     NA
#>  5 Tennessee  SEC       9     7     7    10    17    12     8     6     5      5
#>  6 Illinois   Big …    25    23    NA    24    20    16    13    11     9     10
#>  7 UNC        ACC      19    20    14    17     9     9    11     9     8      7
#>  8 Iowa State Big …    NA    NA    NA    NA    NA    NA    NA    NA    NA     NA
#>  9 Duke       ACC       2     9     9     7    22    21    21    16    14     12
#> 10 NC State   ACC      NA    NA    NA    NA    NA    NA    NA    NA    NA     NA
#> # ℹ 42 more rows
#> # ℹ 12 more variables: week11 <dbl>, week12 <dbl>, week13 <dbl>, week14 <dbl>,
#> #   week15 <dbl>, week16 <dbl>, week17 <dbl>, week18 <dbl>, week19 <dbl>,
#> #   week20 <dbl>, week23 <dbl>, season <int>
# }
```
