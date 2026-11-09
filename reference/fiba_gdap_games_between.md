# **FIBA GDAP: games between**

Games of EVERY FIBA competition in a local-time window (how competitions
and games are discovered).

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapgamesbetweentwodates`

## Usage

``` r
fiba_gdap_games_between(date_from, date_to, return_parsed = TRUE)
```

## Arguments

- date_from:

  (character, required) Required. Window start as YYYY-MM-DD, compared
  with the venue-local gameDateTime (not UTC).

- date_to:

  (character, required) Required. Window end as YYYY-MM-DD, EXCLUSIVE
  (date_from = date_to returns nothing).

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_games_between")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_games_between(date_from = "2023-09-08", date_to = "2023-09-11")

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
