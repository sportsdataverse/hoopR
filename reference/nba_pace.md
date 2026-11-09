# **Pace (possessions per 48 minutes)**

**Pace (possessions per 48 minutes)**

## Usage

``` r
nba_pace(poss, minutes)
```

## Arguments

- poss:

  Numeric vector of possessions (e.g. from
  [`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md)).

- minutes:

  Numeric vector of total team minutes played (player-minutes; 240 for a
  regulation game).

## Value

A numeric vector of pace (possessions per 48 minutes).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_pace(poss = 100, minutes = 240)
#> [1] 100
```
