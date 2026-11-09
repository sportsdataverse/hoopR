# **Get ESPN MBB Positions Index**

Returns the MBB position dictionary index. One row per position with its
id and the canonical `$ref` URL - pass an id to
[`espn_mbb_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md)
for full details (display name, abbreviation, leaf flag, parent link).

Returns the NBA position dictionary index. One row per position with its
id and the canonical `$ref` URL - pass an id to
[`espn_nba_position()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_position.md)
for full details (display name, abbreviation, leaf flag, parent link).

## Usage

``` r
espn_mbb_positions(...)

espn_nba_positions(...)
```

## Arguments

- ...:

  Additional arguments; currently unused.

## Value

A tibble with one row per position.

A tibble with one row per position.

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
  espn_mbb_positions()
#> ── ESPN MENS-COLLEGE-BASKETBALL Positions Index ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:59 UTC
#> # A tibble: 14 × 3
#>    position_id ref                                                        league
#>    <chr>       <chr>                                                      <chr> 
#>  1 0           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  2 1           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  3 2           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  4 3           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  5 4           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  6 5           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  7 6           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  8 7           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#>  9 8           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#> 10 9           http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#> 11 10          http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#> 12 11          http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#> 13 12          http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
#> 14 74          http://sports.core.api.espn.com/v2/sports/basketball/leag… mens-…
# }
# \donttest{
  espn_nba_positions()
#> ── ESPN NBA Positions Index ───────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:52:59 UTC
#> # A tibble: 11 × 3
#>    position_id ref                                                        league
#>    <chr>       <chr>                                                      <chr> 
#>  1 0           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  2 1           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  3 2           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  4 3           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  5 4           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  6 5           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  7 6           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  8 7           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#>  9 8           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#> 10 9           http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
#> 11 30          http://sports.core.api.espn.com/v2/sports/basketball/leag… nba   
# }
```
