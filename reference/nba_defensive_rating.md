# **Defensive Rating (points allowed per 100 possessions)**

**Defensive Rating (points allowed per 100 possessions)**

## Usage

``` r
nba_defensive_rating(opp_pts, poss)
```

## Arguments

- opp_pts, poss:

  Numeric vectors: opponent points, possessions.

## Value

A numeric vector of points allowed per 100 possessions.

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_defensive_rating(opp_pts = 108, poss = 100)
#> [1] 108
```
