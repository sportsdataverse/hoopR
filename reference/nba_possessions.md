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

Other Basketball Analytics Utilities:
[`espn_basketball_player_core()`](https://hoopR.sportsdataverse.org/reference/espn_basketball_player_core.md),
[`nba_add_advanced_metrics()`](https://hoopR.sportsdataverse.org/reference/nba_add_advanced_metrics.md),
[`nba_assist_pct()`](https://hoopR.sportsdataverse.org/reference/nba_assist_pct.md),
[`nba_assist_to_turnover()`](https://hoopR.sportsdataverse.org/reference/nba_assist_to_turnover.md),
[`nba_defensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_defensive_rating.md),
[`nba_effective_fg_pct()`](https://hoopR.sportsdataverse.org/reference/nba_effective_fg_pct.md),
[`nba_four_factors()`](https://hoopR.sportsdataverse.org/reference/nba_four_factors.md),
[`nba_ft_rate()`](https://hoopR.sportsdataverse.org/reference/nba_ft_rate.md),
[`nba_game_score()`](https://hoopR.sportsdataverse.org/reference/nba_game_score.md),
[`nba_net_rating()`](https://hoopR.sportsdataverse.org/reference/nba_net_rating.md),
[`nba_offensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_offensive_rating.md),
[`nba_oreb_pct()`](https://hoopR.sportsdataverse.org/reference/nba_oreb_pct.md),
[`nba_pace()`](https://hoopR.sportsdataverse.org/reference/nba_pace.md),
[`nba_per_minutes()`](https://hoopR.sportsdataverse.org/reference/nba_per_minutes.md),
[`nba_per_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_per_possessions.md),
[`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md),
[`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md),
[`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md)

## Examples

``` r
nba_possessions(fga = 88, fta = 25, oreb = 10, tov = 13)
#> [1] 102
```
