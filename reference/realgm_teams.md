# **RealGM NBA Teams Index**

**Get the NBA team index, with division and conference, from RealGM
(basketball.realgm.com).**

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_teams()
```

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_teams())
} # }
```
