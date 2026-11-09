# **Net Rating**

**Net Rating**

## Usage

``` r
nba_net_rating(off_rating, def_rating)
```

## Arguments

- off_rating, def_rating:

  Numeric vectors: offensive and defensive ratings.

## Value

A numeric vector (`off_rating - def_rating`).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_net_rating(off_rating = 115, def_rating = 108)
#> [1] 7
```
