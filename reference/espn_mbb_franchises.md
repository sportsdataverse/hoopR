# **Get ESPN MBB Franchises Index**

Returns the full MBB franchises index from
`sports.core.api.espn.com/v2/sports/basketball/leagues/mens-college-basketball/franchises`.
Each row is one franchise with its ID and the canonical `$ref` URL -
pass an ID to
[`espn_mbb_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md)
for full franchise detail.

Returns the full NBA franchises index from
`sports.core.api.espn.com/v2/sports/basketball/leagues/nba/franchises`.
Each row is one franchise with its ID and the canonical `$ref` URL -
pass an ID to
[`espn_nba_franchise()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_franchise.md)
for full franchise detail.

## Usage

``` r
espn_mbb_franchises(...)

espn_nba_franchises(...)
```

## Arguments

- ...:

  Additional arguments; currently unused.

## Value

A `hoopR_data` tibble with one row per franchise.

|              |           |                                            |
|--------------|-----------|--------------------------------------------|
| col_name     | types     | description                                |
| franchise_id | character | ESPN franchise identifier.                 |
| ref          | character | Full `$ref` URL for franchise detail.      |
| league       | character | League slug (`"mens-college-basketball"`). |

A `hoopR_data` tibble with one row per franchise.

|              |           |                                       |
|--------------|-----------|---------------------------------------|
| col_name     | types     | description                           |
| franchise_id | character | ESPN franchise identifier.            |
| ref          | character | Full `$ref` URL for franchise detail. |
| league       | character | League slug (`"nba"`).                |

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
  espn_mbb_franchises()
#> ── ESPN MENS-COLLEGE-BASKETBALL Franchises Index ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:33 UTC
#> # A tibble: 200 × 3
#>    franchise_id ref                                                       league
#>    <chr>        <chr>                                                     <chr> 
#>  1 1            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  2 2            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  3 3            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  4 5            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  5 6            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  6 7            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  7 8            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  8 9            http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#>  9 11           http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#> 10 12           http://sports.core.api.espn.com/v2/sports/basketball/lea… mens-…
#> # ℹ 190 more rows
# }
# \donttest{
  espn_nba_franchises()
#> ── ESPN NBA Franchises Index ──────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:33 UTC
#> # A tibble: 30 × 3
#>    franchise_id ref                                                       league
#>    <chr>        <chr>                                                     <chr> 
#>  1 1            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  2 2            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  3 3            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  4 4            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  5 5            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  6 6            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  7 7            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  8 8            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#>  9 9            http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#> 10 10           http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#> # ℹ 20 more rows
# }
```
