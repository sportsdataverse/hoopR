# **Get TPBL Player Shots**

Every field-goal attempt of one player in one division with its court
position.

Endpoint:
`GET https://api.tpbl.basketball/api/divisions/{division_id}/players/{player_id}/shooting-spots`

## Usage

``` r
tpbl_player_shots(division_id, player_id)
```

## Arguments

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id.

- player_id:

  Required. TPBL player id (one per person across seasons and teams);
  `player_id` in tpbl_roster. Not the GoHoops person id and not the
  roster id.

## Value

A `hoopR_data` tibble with one row per shot. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_player_shots")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_player_shots(division_id = 2, player_id = 75)

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.
