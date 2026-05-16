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
#> Error in mget(setdiff(names(formals()), "...")) : invalid first argument
# }
```
