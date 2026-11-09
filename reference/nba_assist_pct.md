# **Assist Percentage**

Estimated percentage of teammate field goals a player assisted while on
the floor.

## Usage

``` r
nba_assist_pct(ast, fgm, minutes, team_fgm, team_minutes)
```

## Arguments

- ast, fgm, minutes:

  Player totals: assists, field goals made, minutes.

- team_fgm, team_minutes:

  Team field goals made and minutes for the same game(s).

## Value

A numeric vector of assist percentages (0-100 scale).

## See also

[family_basketball_analytics_utilities](https://hoopR.sportsdataverse.org/reference/family_basketball_analytics_utilities.md)
lists every function in this family.

## Examples

``` r
nba_assist_pct(ast = 8, fgm = 10, minutes = 36, team_fgm = 40, team_minutes = 240)
#> [1] 40
```
