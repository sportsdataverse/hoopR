# **Get P. LEAGUE+ Player Seasons**

One player's season totals and per-game averages, league and East Asia
Super League, with a career row.

Endpoint: `GET https://pleagueofficial.com/player/{player_page_id}`

## Usage

``` r
pleague_player_seasons(player_page_id)
```

## Arguments

- player_page_id:

  Required. The 8-character page id of /player/{id} (e.g. '1JbPozLB' =
  Lai Ting-En); `player_page_id` in pleague_stat_player, `random_id` in
  pleague_box_players from 2022-23 (unreliable before).

## Value

A `hoopR_data` tibble with one row per player-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "pleague_player_seasons")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`pleague_schedule()`](https://hoopR.sportsdataverse.org/reference/pleague_schedule.md).

     pleague_player_seasons(player_page_id = "1JbPozLB")

## See also

[family_p_league](https://hoopR.sportsdataverse.org/reference/family_p_league.md)
lists every function in this family.
