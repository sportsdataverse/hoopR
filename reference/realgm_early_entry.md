# **RealGM NBA Draft Early Entrants**

**Get the current NBA draft early-entrant and withdrawal list from
RealGM (basketball.realgm.com).**

Stacks RealGM's early-entry candidate tables (college and international
entrants and withdrawals) into one tibble.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_early_entry()
```

## Value

A `hoopR_data` tibble with one row per candidate (`player`, `pos`, `ht`,
`wt`, `birth_date`, `college` / `pre_draft_team`, `class`,
`draft_status`, `yos`, `nationality`).

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_early_entry())
} # }
```
