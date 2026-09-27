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
#> ── NCAA MBB NET Rankings Information from NCAA.com ───────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-09-27 21:26:10 UTC
#> # A tibble: 365 × 13
#>     rank school  record conference road  neutral home  non_div_i previous quad_1
#>    <int> <chr>   <chr>  <chr>      <chr> <chr>   <chr> <chr>        <int> <chr> 
#>  1     1 Michig… 37-3   Big Ten    11-0  12-2    14-1  0-0              2 21-3  
#>  2     2 Duke    35-3   ACC        10-1  10-2    15-0  0-0              1 19-3  
#>  3     3 Arizona 36-3   Big 12     9-1   11-1    16-1  0-0              3 19-3  
#>  4     4 Florida 27-8   SEC        8-2   5-5     14-1  0-0              4 12-7  
#>  5     5 Illino… 28-9   Big Ten    8-2   6-4     14-3  0-0              8 10-9  
#>  6     6 Houston 30-7   Big 12     6-3   9-3     15-1  0-0              5 10-7  
#>  7     7 Iowa S… 29-8   Big 12     5-5   8-2     16-1  0-0              6 8-8   
#>  8     8 Purdue  30-9   Big Ten    8-3   10-1    12-5  0-0              9 13-9  
#>  9     9 UConn   34-6   Big East   9-2   10-2    15-2  0-0             10 11-4  
#> 10    10 Gonzaga 31-4   WCC        8-2   8-2     15-0  0-0              7 7-3   
#> # ℹ 355 more rows
#> # ℹ 3 more variables: quad_2 <chr>, quad_3 <chr>, quad_4 <chr>
# }
```
