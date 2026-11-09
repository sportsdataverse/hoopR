# **Get ESPN Women's College Basketball Coaches**

**Get ESPN Women's College Basketball Coaches**

**Get ESPN Women's College Basketball Coaches**

**Get ESPN NBA Coaches**

**Get ESPN NBA Coaches**

## Usage

``` r
espn_mbb_coaches(season = most_recent_mbb_season(), ...)

espn_nba_coaches(season = most_recent_nba_season(), ...)
```

## Arguments

- season:

  Season year (numeric, e.g. 2025). Defaults to the most recent MBB
  season.

- ...:

  Additional arguments; currently unused but retained for forward
  compatibility. Proxy configuration should use
  `options(hoopR.proxy = ...)` – see
  [`?hoopR`](https://hoopR.sportsdataverse.org/reference/hoopR-package.md)
  for details.

## Value

A `hoopR_data` tibble with one row per coach.

|            |           |                                   |
|------------|-----------|-----------------------------------|
| col_name   | types     | description                       |
| coach_id   | character |                                   |
| first_name | character | Player's first name.              |
| last_name  | character | Player's last name.               |
| full_name  | character | Player's full name.               |
| experience | integer   | Years of professional experience. |
| team_id    | character | Unique team identifier.           |

A `hoopR_data` tibble with one row per coach.

|            |           |                                   |
|------------|-----------|-----------------------------------|
| col_name   | types     | description                       |
| coach_id   | character |                                   |
| first_name | character | Player's first name.              |
| last_name  | character | Player's last name.               |
| full_name  | character | Player's full name.               |
| experience | integer   | Years of professional experience. |
| team_id    | character | Unique team identifier.           |

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
  espn_mbb_coaches(season = 2025)
#> ── ESPN MENS-COLLEGE-BASKETBALL Coaches from ESPN.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:10:27 UTC
#> # A tibble: 373 × 6
#>    coach_id first_name last_name full_name experience team_id
#>    <chr>    <chr>      <chr>     <chr>          <int> <chr>  
#>  1 NA       NA         NA        NA                NA NA     
#>  2 NA       NA         NA        NA                NA NA     
#>  3 NA       NA         NA        NA                NA NA     
#>  4 NA       NA         NA        NA                NA NA     
#>  5 NA       NA         NA        NA                NA NA     
#>  6 NA       NA         NA        NA                NA NA     
#>  7 NA       NA         NA        NA                NA NA     
#>  8 NA       NA         NA        NA                NA NA     
#>  9 NA       NA         NA        NA                NA NA     
#> 10 NA       NA         NA        NA                NA NA     
#> # ℹ 363 more rows
# }
# \donttest{
  espn_nba_coaches(season = 2025)
#> ── ESPN NBA Coaches from ESPN.com ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:10:27 UTC
#> # A tibble: 30 × 6
#>    coach_id first_name last_name full_name experience team_id
#>    <chr>    <chr>      <chr>     <chr>          <int> <chr>  
#>  1 NA       NA         NA        NA                NA NA     
#>  2 NA       NA         NA        NA                NA NA     
#>  3 NA       NA         NA        NA                NA NA     
#>  4 NA       NA         NA        NA                NA NA     
#>  5 NA       NA         NA        NA                NA NA     
#>  6 NA       NA         NA        NA                NA NA     
#>  7 NA       NA         NA        NA                NA NA     
#>  8 NA       NA         NA        NA                NA NA     
#>  9 NA       NA         NA        NA                NA NA     
#> 10 NA       NA         NA        NA                NA NA     
#> # ℹ 20 more rows
# }
```
