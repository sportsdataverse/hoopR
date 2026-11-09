# **Estimated Possessions**

Simple single-team possession estimate: `FGA + 0.44 * FTA - OREB + TOV`.
For a more exact figure use the full possessions formula with opponent
inputs.

## Usage

``` r
nba_possessions(fga, fta, oreb, tov)
```

## Arguments

- fga, fta, oreb, tov:

  Numeric vectors: field-goal attempts, free-throw attempts, offensive
  rebounds, turnovers.

## Value

A numeric vector of estimated possessions.

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_possessions(fga = 88, fta = 25, oreb = 10, tov = 13)
#> [1] 102
```
