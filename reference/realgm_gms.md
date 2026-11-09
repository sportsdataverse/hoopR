# **RealGM NBA General Managers**

**Get the current NBA general managers from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_gms()
```

## Value

A `hoopR_data` tibble with one row per general manager (`staff`, `team`,
`start_season`, `years_in_role`, `birth_date`, `nationality`).

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_gms())
} # }
```
