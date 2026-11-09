# **Get TPBL Player Game Log**

A player's game log in one division: one row per game played, with that
game's whole stat line.

Endpoint:
`GET https://api.tpbl.basketball/api/players/{player_id}/games/stats`

## Usage

``` r
tpbl_player_games(player_id, division_id)
```

## Arguments

- player_id:

  Required. TPBL player id (one per person across seasons and teams);
  `player_id` in tpbl_roster. Not the GoHoops person id and not the
  roster id.

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id. Without
  it the API answers HTTP 422; an unknown id answers HTTP 500, which is
  not retried.

## Value

A `hoopR_data` tibble with one row per game played. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_player_games")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_player_games(player_id = 75, division_id = 2)

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.
