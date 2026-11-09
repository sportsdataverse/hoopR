# **RealGM NBA Standings**

**Get the current NBA standings (both conferences) from RealGM
(basketball.realgm.com).**

One row per team with record, win pct, games back, streak, last-ten,
scoring margin and home/away/division/conference splits. The Eastern and
Western conference tables are stacked and labelled by a `conference`
column.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_standings()
```

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_standings")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_standings())
} # }
```
