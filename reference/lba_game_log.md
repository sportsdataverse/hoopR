# **Get LBA Game Log**

A player's game log for one season, one row per game.

Endpoint: `GET https://www.legabasket.it/api/players/get-player-matches`
(`cs_id=1&id=<player_id>&s=<season>`)

## Usage

``` r
lba_game_log(player_id, season = NULL)
```

## Arguments

- player_id:

  (required) Player id (player_id in lba_players or a box score),
  e.g. 969. Global: one id for a whole career.

- season:

  Season END year (2027 = 2026-27). Omitted = the site's default season
  (unverified).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "lba_game_log")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`lba_championships()`](https://hoopR.sportsdataverse.org/reference/lba_championships.md).

     lba_game_log(player_id = 969, season = 2027)

## See also

[family_lba](https://hoopR.sportsdataverse.org/reference/family_lba.md)
lists every function in this family.
