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

Other Basketball Analytics Utilities:
[`espn_basketball_player_core()`](https://hoopR.sportsdataverse.org/reference/espn_basketball_player_core.md),
[`nba_add_advanced_metrics()`](https://hoopR.sportsdataverse.org/reference/nba_add_advanced_metrics.md),
[`nba_assist_pct()`](https://hoopR.sportsdataverse.org/reference/nba_assist_pct.md),
[`nba_assist_to_turnover()`](https://hoopR.sportsdataverse.org/reference/nba_assist_to_turnover.md),
[`nba_defensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_defensive_rating.md),
[`nba_effective_fg_pct()`](https://hoopR.sportsdataverse.org/reference/nba_effective_fg_pct.md),
[`nba_ft_rate()`](https://hoopR.sportsdataverse.org/reference/nba_ft_rate.md),
[`nba_game_score()`](https://hoopR.sportsdataverse.org/reference/nba_game_score.md),
[`nba_net_rating()`](https://hoopR.sportsdataverse.org/reference/nba_net_rating.md),
[`nba_offensive_rating()`](https://hoopR.sportsdataverse.org/reference/nba_offensive_rating.md),
[`nba_oreb_pct()`](https://hoopR.sportsdataverse.org/reference/nba_oreb_pct.md),
[`nba_pace()`](https://hoopR.sportsdataverse.org/reference/nba_pace.md),
[`nba_per_minutes()`](https://hoopR.sportsdataverse.org/reference/nba_per_minutes.md),
[`nba_per_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_per_possessions.md),
[`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md),
[`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md),
[`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md),
[`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md)

## Examples

``` r
nba_four_factors(fgm = 40, fg3m = 12, fga = 88, fta = 25, ftm = 20,
                 oreb = 10, tov = 13, opp_dreb = 33)
#> # A tibble: 1 × 4
#>   efg_pct tov_pct oreb_pct ft_rate
#>     <dbl>   <dbl>    <dbl>   <dbl>
#> 1   0.523    11.6     23.3   0.227
```
