# **RealGM NBA Draft Prospect Stats**

**Get current NBA draft-prospect statistics from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_draft_prospects()
```

## Value

A `hoopR_data` tibble with one row per prospect (`player`, `team`
(school/club), `gp`, `mpg`, `ppg`, shooting splits, `rpg`, `apg`, `spg`,
`bpg`).

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_draft_prospects())
} # }
```
