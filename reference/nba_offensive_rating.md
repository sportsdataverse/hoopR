# **Offensive Rating (points per 100 possessions)**

**Offensive Rating (points per 100 possessions)**

## Usage

``` r
nba_offensive_rating(pts, poss)
```

## Arguments

- pts, poss:

  Numeric vectors: points scored, possessions.

## Value

A numeric vector of points per 100 possessions.

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_offensive_rating(pts = 115, poss = 100)
#> [1] 115
```
