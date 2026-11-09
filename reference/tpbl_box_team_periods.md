# **Get TPBL Team Box Score by Quarter**

Per-quarter team lines of both teams: points scored and conceded in the
quarter, running totals and stats.

Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`

## Usage

``` r
tpbl_box_team_periods(game_id)
```

## Arguments

- game_id:

  Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not
  sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 =
  27535-27667). Only a finished game is served.

## Value

A `hoopR_data` tibble with one row per team and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "tpbl_box_team_periods")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md).

     tpbl_box_team_periods(game_id = 6)

## See also

[family_tpbl](https://hoopR.sportsdataverse.org/reference/family_tpbl.md)
lists every function in this family.
