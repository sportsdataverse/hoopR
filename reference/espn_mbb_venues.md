# **Get ESPN Women's College Basketball Venues**

**Get ESPN Women's College Basketball Venues**

**Get ESPN Women's College Basketball Venues**

**Get ESPN NBA Venues**

**Get ESPN NBA Venues**

## Usage

``` r
espn_mbb_venues(...)

espn_nba_venues(...)
```

## Arguments

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A `hoopR_data` tibble with one row per venue.

|               |           |                          |
|---------------|-----------|--------------------------|
| col_name      | types     | description              |
| venue_id      | character | Unique venue identifier. |
| name          | character | Display name.            |
| full_name     | character | Player's full name.      |
| address_city  | character |                          |
| address_state | character |                          |
| capacity      | integer   |                          |
| indoor        | logical   |                          |
| grass         | logical   |                          |
| images_url    | character |                          |

A `hoopR_data` tibble with one row per venue.

|               |           |                          |
|---------------|-----------|--------------------------|
| col_name      | types     | description              |
| venue_id      | character | Unique venue identifier. |
| name          | character | Display name.            |
| full_name     | character | Player's full name.      |
| address_city  | character |                          |
| address_state | character |                          |
| capacity      | integer   |                          |
| indoor        | logical   |                          |
| grass         | logical   |                          |
| images_url    | character |                          |

## See also

[family_espn_mbb](https://hoopR.sportsdataverse.org/reference/family_espn_mbb.md)
lists every function in this family.

[family_espn_nba](https://hoopR.sportsdataverse.org/reference/family_espn_nba.md)
lists every function in this family.

## Author

Saiem Gilani

## Examples

``` r
# \donttest{
  espn_mbb_venues()
#> ── ESPN MENS-COLLEGE-BASKETBALL Venues from ESPN.com ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:22 UTC
#> # A tibble: 1,003 × 9
#>    venue_id name  full_name address_city address_state capacity indoor grass
#>    <chr>    <chr> <chr>     <chr>        <chr>            <int> <lgl>  <lgl>
#>  1 NA       NA    NA        NA           NA                  NA NA     NA   
#>  2 NA       NA    NA        NA           NA                  NA NA     NA   
#>  3 NA       NA    NA        NA           NA                  NA NA     NA   
#>  4 NA       NA    NA        NA           NA                  NA NA     NA   
#>  5 NA       NA    NA        NA           NA                  NA NA     NA   
#>  6 NA       NA    NA        NA           NA                  NA NA     NA   
#>  7 NA       NA    NA        NA           NA                  NA NA     NA   
#>  8 NA       NA    NA        NA           NA                  NA NA     NA   
#>  9 NA       NA    NA        NA           NA                  NA NA     NA   
#> 10 NA       NA    NA        NA           NA                  NA NA     NA   
#> # ℹ 993 more rows
#> # ℹ 1 more variable: images_url <chr>
# }
# \donttest{
  espn_nba_venues()
#> ── ESPN NBA Venues from ESPN.com ──────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:22 UTC
#> # A tibble: 648 × 9
#>    venue_id name  full_name address_city address_state capacity indoor grass
#>    <chr>    <chr> <chr>     <chr>        <chr>            <int> <lgl>  <lgl>
#>  1 NA       NA    NA        NA           NA                  NA NA     NA   
#>  2 NA       NA    NA        NA           NA                  NA NA     NA   
#>  3 NA       NA    NA        NA           NA                  NA NA     NA   
#>  4 NA       NA    NA        NA           NA                  NA NA     NA   
#>  5 NA       NA    NA        NA           NA                  NA NA     NA   
#>  6 NA       NA    NA        NA           NA                  NA NA     NA   
#>  7 NA       NA    NA        NA           NA                  NA NA     NA   
#>  8 NA       NA    NA        NA           NA                  NA NA     NA   
#>  9 NA       NA    NA        NA           NA                  NA NA     NA   
#> 10 NA       NA    NA        NA           NA                  NA NA     NA   
#> # ℹ 638 more rows
#> # ℹ 1 more variable: images_url <chr>
# }
```
