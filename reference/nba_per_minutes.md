# **Scale Box-Score Counting Stats Per N Minutes**

Rescale counting stats to a per-minute basis (defaults to the familiar
per-36). Adds one `"{col}_per_{per}"` column per requested stat; the
original columns are left untouched.

## Usage

``` r
nba_per_minutes(df, cols, minutes = "min", per = 36)
```

## Arguments

- df:

  A data frame / tibble of box-score rows.

- cols:

  Character vector of counting-stat columns to rescale (e.g.
  `c("pts", "reb", "ast")`).

- minutes:

  Name of the minutes column. Defaults to `"min"`.

- per:

  Minutes to scale to. Defaults to `36`.

## Value

`df` with the added per-minute columns.

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
[`nba_per_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_per_possessions.md),
[`nba_possessions()`](https://hoopR.sportsdataverse.org/reference/nba_possessions.md),
[`nba_true_shooting_pct()`](https://hoopR.sportsdataverse.org/reference/nba_true_shooting_pct.md),
[`nba_turnover_pct()`](https://hoopR.sportsdataverse.org/reference/nba_turnover_pct.md),
[`nba_usage_rate()`](https://hoopR.sportsdataverse.org/reference/nba_usage_rate.md)

## Examples

``` r
box <- data.frame(player = c("A", "B"), min = c(36, 24),
                  pts = c(18, 8), reb = c(9, 6), ast = c(7, 2))
nba_per_minutes(box, cols = c("pts", "reb", "ast"))
#>   player min pts reb ast pts_per_36 reb_per_36 ast_per_36
#> 1      A  36  18   9   7         18          9          7
#> 2      B  24   8   6   2         12          9          3
```
