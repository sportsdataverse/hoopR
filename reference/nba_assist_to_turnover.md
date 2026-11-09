# **Assist-to-Turnover Ratio**

**Assist-to-Turnover Ratio**

## Usage

``` r
nba_assist_to_turnover(ast, tov)
```

## Arguments

- ast, tov:

  Numeric vectors: assists, turnovers.

## Value

A numeric vector (`NA` when turnovers are 0).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_assist_to_turnover(ast = 8, tov = 3)
#> [1] 2.666667
```
