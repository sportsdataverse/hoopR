# **Turnover Percentage**

Turnovers per 100 plays: `100 * TOV / (FGA + 0.44 * FTA + TOV)`.

## Usage

``` r
nba_turnover_pct(tov, fga, fta)
```

## Arguments

- tov, fga, fta:

  Numeric vectors: turnovers, field-goal attempts, free-throw attempts.

## Value

A numeric vector (0-100 scale).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_turnover_pct(tov = 13, fga = 88, fta = 25)
#> [1] 11.60714
```
