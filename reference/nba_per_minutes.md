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

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
box <- data.frame(player = c("A", "B"), min = c(36, 24),
                  pts = c(18, 8), reb = c(9, 6), ast = c(7, 2))
nba_per_minutes(box, cols = c("pts", "reb", "ast"))
#>   player min pts reb ast pts_per_36 reb_per_36 ast_per_36
#> 1      A  36  18   9   7         18          9          7
#> 2      B  24   8   6   2         12          9          3
```
