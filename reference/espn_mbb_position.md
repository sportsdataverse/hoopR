# **Get ESPN MBB Position Detail**

Returns metadata for a single MBB position. Useful for dereferencing
position `$ref` URLs embedded in athlete records, and for navigating
parent/leaf relationships in the position taxonomy.

Returns metadata for a single NBA position. Useful for dereferencing
position `$ref` URLs embedded in athlete records, and for navigating
parent/leaf relationships in the position taxonomy.

## Usage

``` r
espn_mbb_position(position_id, ...)

espn_nba_position(position_id, ...)
```

## Arguments

- position_id:

  ESPN position identifier (character or numeric).

- ...:

  Additional arguments; currently unused.

## Value

A single-row tibble.

A single-row tibble.

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
  espn_mbb_position(position_id = 1)
#> ── ESPN MENS-COLLEGE-BASKETBALL Position from ESPN.com ────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:50:12 UTC
#> # A tibble: 1 × 7
#>   position_id name   display_name abbreviation leaf  parent_ref league          
#>   <chr>       <chr>  <chr>        <chr>        <lgl> <chr>      <chr>           
#> 1 1           Center Center       C            FALSE NA         mens-college-ba…
# }
# \donttest{
  espn_nba_position(position_id = 1)
#> ── ESPN NBA Position from ESPN.com ────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:50:12 UTC
#> # A tibble: 1 × 7
#>   position_id name        display_name abbreviation leaf  parent_ref      league
#>   <chr>       <chr>       <chr>        <chr>        <lgl> <chr>           <chr> 
#> 1 1           Point Guard Point Guard  PG           TRUE  http://sports.… nba   
# }
```
