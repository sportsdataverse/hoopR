# **True Shooting Percentage**

Points per shooting possession: `PTS / (2 * (FGA + 0.44 * FTA))`.

## Usage

``` r
nba_true_shooting_pct(pts, fga, fta)
```

## Arguments

- pts, fga, fta:

  Numeric vectors: points, field-goal attempts, free-throw attempts.

## Value

A numeric vector of true-shooting percentages (0-1 scale).

## See also

Other Basketball Analytics Utilities:
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
[`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md),
[`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md),
[`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md)

## Examples

``` r
nba_true_shooting_pct(pts = 30, fga = 20, fta = 8)
#> [1] 0.6377551
```
