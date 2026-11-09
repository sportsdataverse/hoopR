# **Free Throw Rate**

Free-throw attempts per field-goal attempt: `FTA / FGA`.

## Usage

``` r
nba_ft_rate(fta, fga)
```

## Arguments

- fta, fga:

  Numeric vectors: free-throw attempts, field-goal attempts.

## Value

A numeric vector.

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_ft_rate(fta = 8, fga = 20)
#> [1] 0.4
```
