# **FIBA GDAP: gateway federation ranking**

FIBA world ranking from the server-side gateway (same items as
fiba_gdap_federation_ranking).

Endpoint:
`GET https://digital-api.fiba.basketball/hapi/getcustomgateway`

## Usage

``` r
fiba_gdap_gateway_federation_ranking(
  gender = "men",
  zone_id = 1L,
  as_of_date = NULL,
  return_parsed = TRUE
)
```

## Arguments

- gender:

  (character, default `"men"`) federationRanking: men or women (=
  gdapCategory)

- zone_id:

  (integer, default `1L`) federationRanking: ranking zone id (=
  zoneRankingId)

- as_of_date:

  (character, optional) Ranking as of this date, ISO 8601: the latest
  ranking published on or before it (2026-03-10 answers the 2026-03-03
  ranking). Omitted = the latest ranking

- return_parsed:

  Parse the payload into a tibble (default `TRUE`); `FALSE` returns the
  raw JSON list.

## Value

A `hoopR_data` tibble with one row per ranked federation. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "fiba_gdap_gateway_federation_ranking")`)
and in the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`fiba_gdap_awards()`](https://hoopR.sportsdataverse.org/reference/fiba_gdap_awards.md).

     fiba_gdap_gateway_federation_ranking(gender = "men", zone_id = 1, as_of_date = "2025-09-15")

## See also

[family_fiba](https://hoopR.sportsdataverse.org/reference/family_fiba.md)
lists every function in this family.
