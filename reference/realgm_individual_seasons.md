# **RealGM NBA Best Individual Seasons**

**Get the all-time best individual NBA seasons leaderboard from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_individual_seasons()
```

## Value

A `hoopR_data` tibble with one row per player-season (`player`,
`season`, `team`, `gp`, `min`, `pts`, shooting splits, `reb`, `ast`,
etc.).

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_individual_seasons())
} # }
```
