# **Four Factors**

Dean Oliver's "Four Factors" of winning basketball, as a tidy tibble
(one row per input element): effective field-goal percentage, turnover
percentage, offensive-rebound percentage and free-throw rate.

## Usage

``` r
nba_four_factors(fgm, fg3m, fga, fta, ftm, oreb, tov, opp_dreb)
```

## Arguments

- fgm, fg3m, fga, fta, ftm, oreb, tov:

  Team box-score totals.

- opp_dreb:

  Opponent defensive rebounds (for offensive-rebound percentage).

## Value

A `tibble` with columns `efg_pct`, `tov_pct`, `oreb_pct`, `ft_rate`.

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_four_factors(fgm = 40, fg3m = 12, fga = 88, fta = 25, ftm = 20,
                 oreb = 10, tov = 13, opp_dreb = 33)
#> # A tibble: 1 × 4
#>   efg_pct tov_pct oreb_pct ft_rate
#>     <dbl>   <dbl>    <dbl>   <dbl>
#> 1   0.523    11.6     23.3   0.227
```
