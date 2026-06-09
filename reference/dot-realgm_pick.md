# Internal: pick the best data table from a list of RealGM tables

Chooses the table containing all `must_have` columns (when supplied)
with the most rows; otherwise the table with the most rows.

## Usage

``` r
.realgm_pick(tables, must_have = NULL)
```

## Arguments

- tables:

  A list of `data.frame`s, e.g. from
  [`.realgm_tables()`](https://hoopR.sportsdataverse.org/reference/dot-realgm_tables.md).

- must_have:

  Optional character vector of required column names.

## Value

A single `data.frame`, or `NULL` if `tables` is empty.
