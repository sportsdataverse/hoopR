# **Get ACB Player Totals**

A player's career totals, averages and per-40 values.

One row: the same `total_*` / `avg_*` / `per40_*` columns as
`acb_player_stats` over the player's whole ACB career.

Endpoint:
`GET https://api2.acb.com/api/seasondata/PlayerProfile/player-stats`

## Usage

``` r
acb_player_totals(player_id, competition_id = NULL, season = NULL)
```

## Arguments

- player_id:

  (required) ACB licence number (integer): the person id everywhere (box
  score, play-by-play, shots, rosters). 20209407 = Edy Tavares, 20212243
  = Olek Balcerowski. A whole number; a whole double is accepted.

- competition_id:

  (default `NULL`) Competition id: 1 Liga Endesa, 2 Copa del Rey, 3
  Supercopa Endesa, 10 Minicopa Endesa (youth). Omitted = the API's
  default competition. A whole number; a whole double is accepted.

- season:

  (default `NULL`) Season END year used as an UPPER bound for the career
  rows. Omitted = all seasons. A whole number; a whole double is
  accepted.

## Value

A `hoopR_data` tibble with one row per player-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "acb_player_totals")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`acb_match_header()`](https://hoopR.sportsdataverse.org/reference/acb_match_header.md).

     acb_player_totals(player_id = 20209407)

## See also

[family_acb](https://hoopR.sportsdataverse.org/reference/family_acb.md)
lists every function in this family.
