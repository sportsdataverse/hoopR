# **Get BBL Transfers**

Latest transfers, one row per move (BBL only).

Endpoint: `GET https://api.basketball-bundesliga.de/transfers`

## Usage

``` r
scb_transfers()
```

## Value

A `hoopR_data` tibble with one row per move. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_transfers")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_transfers()

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
