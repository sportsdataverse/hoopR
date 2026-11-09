# **FIBA GDAP: game officials**

Officials nominated to one game (referees, table officials,
commissioner).

Endpoint: `GET https://digital-api.fiba.basketball/hapi/getgdapgamebyid`

## Usage

``` r
fiba_gdap_game_officials(game_id, return_parsed = TRUE)
```

## Arguments

- game_id:

  (integer, required) Required. FIBA game id (global GDAP key space):
  gameId of a schedule row; the `<gameId>` of a game page URL

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per official. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_game_officials")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_game_officials(game_id = 100720)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
