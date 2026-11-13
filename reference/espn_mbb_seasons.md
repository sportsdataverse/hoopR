# **Get ESPN Women's College Basketball Seasons**

**Get ESPN Women's College Basketball Seasons**

**Get ESPN Women's College Basketball Seasons**

**Get ESPN NBA Seasons**

**Get ESPN NBA Seasons**

## Usage

``` r
espn_mbb_seasons(...)

espn_nba_seasons(...)
```

## Arguments

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A `hoopR_data` tibble with one row per season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| start_date | character | Start date (YYYY-MM-DD). |
| end_date | character | End date (YYYY-MM-DD). |
| display_name | character | Display name. |
| season_type_count | integer |  |

A `hoopR_data` tibble with one row per season.

|  |  |  |
|----|----|----|
| col_name | types | description |
| season | integer | Season identifier (4-digit year or 'YYYY-YY' string). |
| start_date | character | Start date (YYYY-MM-DD). |
| end_date | character | End date (YYYY-MM-DD). |
| display_name | character | Display name. |
| season_type_count | integer |  |

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
  espn_mbb_seasons()
#> ── ESPN MENS-COLLEGE-BASKETBALL Seasons from ESPN.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:06 UTC
#> # A tibble: 1 × 5
#>   season start_date end_date display_name season_type_count
#>    <int> <chr>      <chr>    <chr>                    <int>
#> 1     NA NA         NA       NA                          NA
# }
# \donttest{
  espn_nba_seasons()
#> ── ESPN NBA Seasons from ESPN.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:54:06 UTC
#> # A tibble: 1 × 5
#>   season start_date end_date display_name season_type_count
#>    <int> <chr>      <chr>    <chr>                    <int>
#> 1     NA NA         NA       NA                          NA
# }
```
