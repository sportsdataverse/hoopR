# **Append Advanced Metrics to a Box Score**

Detects the standard hoopR / stats.nba.com box-score columns present in
`df` and appends the advanced metrics it can compute from them
(true-shooting %, effective field-goal %, free-throw rate, turnover %,
assist-to-turnover ratio and Hollinger game score). Columns are matched
case-insensitively against common aliases; metrics whose inputs are
absent are skipped (reported via a message), so it is safe to pass any
box score.

## Usage

``` r
nba_add_advanced_metrics(df)
```

## Arguments

- df:

  A data frame / tibble of player or team box-score rows.

## Value

`df` with the available advanced-metric columns appended.

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
box <- data.frame(player = "A", pts = 30, fgm = 10, fga = 20,
                  fg3m = 4, ftm = 7, fta = 8, oreb = 1, dreb = 6,
                  ast = 8, stl = 2, blk = 1, pf = 2, tov = 3)
nba_add_advanced_metrics(box)
#> Added advanced metrics: ts_pct, efg_pct, ft_rate, tov_pct, ast_to, and
#> game_score.
#>   player pts fgm fga fg3m ftm fta oreb dreb ast stl blk pf tov    ts_pct
#> 1      A  30  10  20    4   7   8    1    6   8   2   1  2   3 0.6377551
#>   efg_pct ft_rate  tov_pct   ast_to game_score
#> 1     0.6     0.4 11.31222 2.666667       26.6
```
