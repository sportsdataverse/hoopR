# **Get KZS Player Profile**

Player profile: names, year of birth, nationality and positions.

Endpoint: `GET https://api.kzs.si/api/v1/public/players/{player_id}`

## Usage

``` r
kzs_player(player_id)
```

## Arguments

- player_id:

  (required) Player registry id (player_id in a box score or roster),
  e.g. 106285. Not the person id.

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_player")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

     kzs_player(player_id = 106285)

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.
