# **Scale Box-Score Counting Stats Per N Possessions**

Rescale counting stats to a per-possession basis (defaults to the
familiar per-100). Adds one `"{col}_per_{per}"` column per requested
stat.

## Usage

``` r
nba_per_possessions(df, cols, possessions = "poss", per = 100)
```

## Arguments

- df:

  A data frame / tibble of box-score rows.

- cols:

  Character vector of counting-stat columns to rescale.

- possessions:

  Name of the possessions column. Defaults to `"poss"`.

- per:

  Possessions to scale to. Defaults to `100`.

## Value

`df` with the added per-possession columns.

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
[`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md),
[`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md),
[`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md),
[`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md)

## Examples

``` r
box <- data.frame(team = c("A", "B"), poss = c(98, 102),
                  pts = c(112, 109), tov = c(13, 11))
nba_per_possessions(box, cols = c("pts", "tov"))
#>   team poss pts tov pts_per_100 tov_per_100
#> 1    A   98 112  13    114.2857    13.26531
#> 2    B  102 109  11    106.8627    10.78431
```
