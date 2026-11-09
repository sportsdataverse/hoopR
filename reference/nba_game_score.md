# **Game Score**

John Hollinger's single-game player rating, roughly scaled like points
(a Game Score of 40 is outstanding, 10 is an average starter).

## Usage

``` r
nba_game_score(pts, fgm, fga, fta, ftm, oreb, dreb, stl, ast, blk, pf, tov)
```

## Arguments

- pts, fgm, fga, fta, ftm, oreb, dreb, stl, ast, blk, pf, tov:

  Numeric vectors of box-score totals.

## Value

A numeric vector of game scores.

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_game_score(pts = 30, fgm = 10, fga = 20, fta = 8, ftm = 7,
               oreb = 1, dreb = 6, stl = 2, ast = 8, blk = 1, pf = 2, tov = 3)
#> [1] 26.6
```
