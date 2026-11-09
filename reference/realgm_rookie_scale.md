# **RealGM NBA Rookie Scale**

**Get the current NBA rookie-scale salary table from RealGM
(basketball.realgm.com).**

One row per first-round pick with the four contract-year amounts and the
qualifying-offer percentage. Dollar figures are the formatted strings
RealGM publishes.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_rookie_scale()
```

## Value

A `hoopR_data` tibble with one row per first-round pick (`pick`,
`x1st_year_salary`, `x2nd_year_salary`, `x3rd_year_option_salary`, the
4th-year option increase and qualifying-offer increase).

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_rookie_scale())
} # }
```
