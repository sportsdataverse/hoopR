# **Get LBA Player**

Player bio with current-season totals, highs and averages (one row).

Endpoint: `GET https://www.legabasket.it/api/players/get-player-by-id`
(`stats=1&id=<player_id>`)

## Usage

``` r
lba_player(player_id)
```

## Arguments

- player_id:

  (required) Player id (player_id in lba_players or a box score),
  e.g. 969. Global: one id for a whole career.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_player")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_player(player_id = 969)

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
