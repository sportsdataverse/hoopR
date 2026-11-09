# **RealGM NBA Salary Cap History**

**Get the NBA salary-cap history (and projections) from RealGM
(basketball.realgm.com).**

One row per season with the cap, luxury-tax line, both aprons, bi-annual
exception and the mid-level exception tiers. Dollar figures are returned
as the formatted strings RealGM publishes (e.g. `"$140,588,000"`).

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_salary_cap()
```

## Value

A `hoopR_data` tibble with one row per season. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_salary_cap")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_salary_cap())
} # }
```
