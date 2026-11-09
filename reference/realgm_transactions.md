# **RealGM NBA Transactions Log**

**Get the NBA league transactions log from RealGM
(basketball.realgm.com).**

One row per transaction (signings, waivers, two-way conversions,
G-League assignments/recalls, trades), each tagged with its date. RealGM
publishes the transactions as a dated narrative list rather than a
table, so this parses the page DOM directly.

**Requires a headless browser** (see
[`realgm_players()`](https://hoopR.sportsdataverse.org/reference/realgm_players.md)).

## Usage

``` r
realgm_transactions()
```

## Value

A `hoopR_data` tibble with one row per transaction. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "realgm_transactions")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[family_realgm](https://hoopR.sportsdataverse.org/reference/family_realgm.md)
lists every function in this family.

## Examples

``` r
if (FALSE) { # \dontrun{
  try(realgm_transactions())
} # }
```
