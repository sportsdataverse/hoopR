# **Get BBL Referees**

Current referees and commissioners (BBL only).

Endpoint: `GET https://api.basketball-bundesliga.de/referees`

## Usage

``` r
scb_referees(page_size = 100)
```

## Arguments

- page_size:

  (default `100`) Rows per page. 100 returns all current officials in
  one page; a result that needs more pages is refused.

## Value

A `hoopR_data` tibble with one row per official. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_referees")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_referees()

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
