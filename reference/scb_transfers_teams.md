# **Get BBL Team Transfers**

Per club, the players joining and leaving, one row per move with its
direction (BBL only).

Endpoint: `GET https://api.basketball-bundesliga.de/transfers/teams`

## Usage

``` r
scb_transfers_teams()
```

## Value

A `hoopR_data` tibble with one row per move with its direction. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_transfers_teams")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

     scb_transfers_teams()

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.
