# **Effective Field Goal Percentage**

Field-goal percentage adjusted for the extra value of the three-pointer:
`(FGM + 0.5 * FG3M) / FGA`.

## Usage

``` r
nba_effective_fg_pct(fgm, fg3m, fga)
```

## Arguments

- fgm, fg3m, fga:

  Numeric vectors: field goals made, three-pointers made, field-goal
  attempts.

## Value

A numeric vector of effective field-goal percentages (0-1 scale).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_effective_fg_pct(fgm = 10, fg3m = 4, fga = 20)
#> [1] 0.6
```
