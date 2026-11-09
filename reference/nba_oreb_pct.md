# **Offensive Rebound Percentage**

**Offensive Rebound Percentage**

## Usage

``` r
nba_oreb_pct(oreb, opp_dreb)
```

## Arguments

- oreb, opp_dreb:

  Numeric vectors: offensive rebounds, opponent defensive rebounds.

## Value

A numeric vector (0-100 scale).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_oreb_pct(oreb = 10, opp_dreb = 33)
#> [1] 23.25581
```
