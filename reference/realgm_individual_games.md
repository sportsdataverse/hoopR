# **RealGM NBA Best Individual Games**

**Get the all-time best individual NBA games leaderboard from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_individual_games()
```

## Value

A `hoopR_data` tibble with one row per player-game (`player`, `date`,
`team`, `min`, `pts`, `fgm`, `fga`, `reb`, `ast`, `stl`, `blk`, etc.).

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_individual_games())
} # }
```
