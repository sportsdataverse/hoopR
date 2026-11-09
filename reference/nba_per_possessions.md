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

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
box <- data.frame(team = c("A", "B"), poss = c(98, 102),
                  pts = c(112, 109), tov = c(13, 11))
nba_per_possessions(box, cols = c("pts", "tov"))
#>   team poss pts tov pts_per_100 tov_per_100
#> 1    A   98 112  13    114.2857    13.26531
#> 2    B  102 109  11    106.8627    10.78431
```
