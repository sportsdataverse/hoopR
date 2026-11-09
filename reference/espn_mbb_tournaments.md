# **Get ESPN MBB Tournaments Index**

Returns the index of men's college basketball tournaments tracked by
ESPN - including the NCAA Tournament, NIT, conference tournaments, and
other in-season events. Pass an ID to
[`espn_mbb_tournament()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_tournament.md)
for the human-readable name and seasons-list ref.

Returns the index of NBA-branded tournaments tracked by ESPN (e.g. the
in-season tournament). Each row is one tournament with its ID and the
`$ref` URL.

## Usage

``` r
espn_mbb_tournaments(...)

espn_nba_tournaments(...)
```

## Arguments

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per tournament.

|               |           |                                            |
|---------------|-----------|--------------------------------------------|
| col_name      | types     | description                                |
| tournament_id | character | ESPN tournament identifier.                |
| ref           | character | Full `$ref` URL for the detail.            |
| league        | character | League slug (`"mens-college-basketball"`). |

A tibble with one row per tournament.

|               |           |                                 |
|---------------|-----------|---------------------------------|
| col_name      | types     | description                     |
| tournament_id | character | ESPN tournament identifier.     |
| ref           | character | Full `$ref` URL for the detail. |
| league        | character | League slug (`"nba"`).          |

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
  espn_mbb_tournaments()
#> ── ESPN MENS-COLLEGE-BASKETBALL Tournaments Index ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:40 UTC
#> # A tibble: 38 × 3
#>    tournament_id ref                                                      league
#>    <chr>         <chr>                                                    <chr> 
#>  1 3             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  2 1             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  3 39            http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  4 2             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  5 4             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  6 5             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  7 6             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  8 7             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#>  9 8             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#> 10 9             http://sports.core.api.espn.com/v2/sports/basketball/le… mens-…
#> # ℹ 28 more rows
# }
# \donttest{
  espn_nba_tournaments()
#> ── ESPN NBA Tournaments Index ─────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 12:04:41 UTC
#> # A tibble: 2 × 3
#>   tournament_id ref                                                       league
#>   <chr>         <chr>                                                     <chr> 
#> 1 1             http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
#> 2 2             http://sports.core.api.espn.com/v2/sports/basketball/lea… nba   
# }
```
