# **FIBA GDAP: federation games**

A federation's recent and upcoming national-team games.

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getgdapfederationgamesbyfederationid`

## Usage

``` r
fiba_gdap_federation_games(federation_id, return_parsed = TRUE)
```

## Arguments

- federation_id:

  (integer, required) Required. Federation organisationId, stable across
  competitions (64 = Germany; teamA.organisationId)

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_federation_games")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_federation_games(federation_id = 64)

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
