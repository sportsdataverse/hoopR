# **Get men's college basketball NET rankings for the current date from the NCAA website**

**Get men's college basketball NET rankings for the current date from
the NCAA website**

## Usage

``` r
ncaa_mbb_NET_rankings()
```

## Value

Returns a tibble

## Author

Saiem Gilani

## Examples

``` r
# Get current NCAA NET rankings
# \donttest{
  try(ncaa_mbb_NET_rankings())
#> ── NCAA MBB NET Rankings Information from ESPN.com ────────────── hoopR 2.1.1 ──
#> ℹ Data updated: 2026-01-19 16:29:43 UTC
#> # A tibble: 365 × 13
#>     rank school   record conf  road  neutral home  non_div_i  prev quad_1 quad_2
#>    <int> <chr>    <chr>  <chr> <chr> <chr>   <chr> <chr>     <int> <chr>  <chr> 
#>  1     1 Michigan 16-1   Big … 5-0   4-0     7-1   0-0           1 5-0    6-1   
#>  2     2 Duke     17-1   ACC   6-0   3-1     8-0   0-0           2 8-1    2-0   
#>  3     3 Arizona  18-0   Big … 4-0   4-0     10-0  0-0           3 7-0    2-0   
#>  4     4 Gonzaga  19-1   WCC   5-0   5-1     9-0   0-0           4 3-1    5-0   
#>  5     5 Purdue   17-1   Big … 4-0   3-0     10-1  0-0           5 6-1    2-0   
#>  6     6 Nebraska 18-0   Big … 4-0   3-0     11-0  0-0           6 5-0    5-0   
#>  7     7 Illinois 15-3   Big … 4-0   2-2     9-1   0-0           7 4-3    3-0   
#>  8     8 UConn    18-1   Big … 6-0   3-0     9-1   0-0           8 5-1    6-0   
#>  9     9 Houston  17-1   Big … 2-0   5-1     10-0  0-0          10 5-1    3-0   
#> 10    10 Iowa St. 16-2   Big … 2-2   4-0     10-0  0-0           9 4-2    5-0   
#> # ℹ 355 more rows
#> # ℹ 2 more variables: quad_3 <chr>, quad_4 <chr>
# }
```
