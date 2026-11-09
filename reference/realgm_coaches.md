# **RealGM NBA Head Coaches**

**Get the current NBA head coaches from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_coaches()
```

## Value

A `hoopR_data` tibble with one row per coach. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_coaches")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_coaches())
} # }
```
