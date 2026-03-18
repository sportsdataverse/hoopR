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
#> ── NCAA MBB NET Rankings Information from ESPN.com ────────────── hoopR 3.0.0 ──
#> ℹ Data updated: 2026-03-18 18:16:14 UTC
#> # A tibble: 365 × 13
#>     rank school   record conf  road  neutral home  non_div_i  prev quad_1 quad_2
#>    <int> <chr>    <chr>  <chr> <chr> <chr>   <chr> <chr>     <int> <chr>  <chr> 
#>  1     1 Duke     32-2   ACC   10-1  7-1     15-0  0-0           1 17-2   6-0   
#>  2     2 Michigan 31-3   Big … 11-0  6-2     14-1  0-0           2 17-3   5-0   
#>  3     3 Arizona  32-2   Big … 9-1   7-0     16-1  0-0           3 16-2   8-0   
#>  4     4 Florida  26-7   SEC   8-2   4-4     14-1  0-0           4 12-6   6-1   
#>  5     5 Houston  28-6   Big … 6-3   7-2     15-1  0-0           5 10-6   9-0   
#>  6     6 Iowa St. 27-7   Big … 5-5   6-1     16-1  0-0           7 8-7    10-0  
#>  7     7 Gonzaga  30-3   WCC   8-2   7-1     15-0  0-0           6 7-2    4-0   
#>  8     8 Illinois 24-8   Big … 8-2   2-3     14-3  0-0           8 7-8    5-0   
#>  9     9 Purdue   27-8   Big … 8-3   7-0     12-5  0-0           9 11-8   6-0   
#> 10    10 UConn    29-5   Big … 9-2   5-1     15-2  0-0          10 7-3    11-1  
#> # ℹ 355 more rows
#> # ℹ 2 more variables: quad_3 <chr>, quad_4 <chr>
# }
```
