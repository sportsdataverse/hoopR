# **Get EASL Player**

One player's biography: names, nationality, birth date, height, weight.

Endpoint: `GET https://easl.joshricha.com/api/v1/players/{player_id}`

## Usage

``` r
easl_player(player_id)
```

## Arguments

- player_id:

  (required) DataCore person UUID v1, e.g.
  '85c99dab-9f67-11f0-8780-a731edb5aad5': the player_id of easl_players,
  the box scores, leaders and play-by-play. A malformed id is
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_player")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

     easl_player(player_id = "85c99dab-9f67-11f0-8780-a731edb5aad5")

## See also

[family_easl](https://hoopR.sportsdataverse.org/reference/family_easl.md)
lists every function in this family.
