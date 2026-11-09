# **True Shooting Percentage**

Points per shooting possession: `PTS / (2 * (FGA + 0.44 * FTA))`.

## Usage

``` r
nba_true_shooting_pct(pts, fga, fta)
```

## Arguments

- pts, fga, fta:

  Numeric vectors: points, field-goal attempts, free-throw attempts.

## Value

A numeric vector of true-shooting percentages (0-1 scale).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_true_shooting_pct(pts = 30, fga = 20, fta = 8)
#> [1] 0.6377551
```
