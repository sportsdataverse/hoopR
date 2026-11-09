# **Usage Rate**

Percentage of team plays a player used while on the floor.

## Usage

``` r
nba_usage_rate(
  fga,
  fta,
  tov,
  minutes,
  team_fga,
  team_fta,
  team_tov,
  team_minutes
)
```

## Arguments

- fga, fta, tov, minutes:

  Player box-score totals: field-goal attempts, free-throw attempts,
  turnovers, minutes.

- team_fga, team_fta, team_tov, team_minutes:

  Team totals for the same game(s).

## Value

A numeric vector of usage percentages (0-100 scale).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_usage_rate(fga = 20, fta = 8, tov = 3, minutes = 36,
               team_fga = 88, team_fta = 25, team_tov = 13, team_minutes = 240)
#> [1] 31.57143
```
